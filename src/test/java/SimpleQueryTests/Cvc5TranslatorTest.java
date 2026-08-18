package SimpleQueryTests;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import io.github.cvc5.Result;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * End-to-end tests for the SQL to cvc5 translation.
 *
 * <p>Every test states a fact about SQL and asks the translator to prove or refute it, so a
 * failure means the encoding disagrees with SQL rather than merely that it changed. Two shapes
 * are used:
 *
 * <ul>
 *   <li>{@link #assertEquivalent} — the two queries denote the same table for every database,
 *       so the solver must answer {@code unsat}. This pins down what a construct computes: to
 *       check that {@code SUM} over {2, 3} is 5, compare it against the literal table {(1, 5)}.
 *   <li>{@link #assertNotEquivalent} — some database distinguishes the queries, so the solver
 *       must answer {@code sat}. These are the regression tests for the soundness bugs: each
 *       one used to return {@code unsat}, a bogus proof of equivalence.
 * </ul>
 *
 * <p>All inputs are literal {@code VALUES} tables rather than {@code EMP}/{@code DEPT}, which
 * keeps every query ground and therefore fast; the solver's 10 s per-query limit is never
 * close to being hit.
 */
public class Cvc5TranslatorTest
{
  /** Calcite rejects a bare NULL in VALUES, so a typed one is needed. */
  private static final String NULL_INT = "CAST(NULL AS INTEGER)";

  private PrintStream stdout;

  @Before
  public void silenceTranslator()
  {
    // the translator echoes the whole SMT-LIB problem to stdout
    stdout = System.out;
    System.setOut(new PrintStream(new ByteArrayOutputStream()));
  }

  @After
  public void restoreStdout()
  {
    System.setOut(stdout);
  }

  // ------------------------------------------------------------------
  // helpers
  // ------------------------------------------------------------------

  private static Result check(String sql1, String sql2, boolean isSetSemantics) throws Exception
  {
    PrintWriter writer = new PrintWriter(new StringWriter());
    Result result = Cvc5Analysis.verify(sql1, sql2, "unitTest", writer, isSetSemantics);
    assertNotNull("query was filtered out before translation", result);
    return result;
  }

  private static void assertEquivalent(String message, String sql1, String sql2) throws Exception
  {
    Result result = check(sql1, sql2, false);
    assertTrue(message + " -- expected unsat (equivalent) but got " + result, result.isUnsat());
  }

  private static void assertNotEquivalent(String message, String sql1, String sql2) throws Exception
  {
    Result result = check(sql1, sql2, false);
    assertTrue(message + " -- expected sat (inequivalent) but got " + result, result.isSat());
  }

  private static void assertRejected(String message, String sql) throws Exception
  {
    try
    {
      check(sql, sql, false);
      fail(message + " -- expected UnsupportedOperationException, but the query was translated");
    }
    catch (UnsupportedOperationException expected)
    {
      // the translator refused rather than emitting a wrong encoding
    }
  }

  /** {@code SELECT ... FROM (VALUES rows) AS t GROUP BY t.EXPR$0}. */
  private static String groupBy(String selectList, String rows)
  {
    return "SELECT " + selectList + " FROM (VALUES " + rows + ") AS t GROUP BY t.EXPR$0";
  }

  private static String values(String rows)
  {
    return "SELECT * FROM (VALUES " + rows + ") AS v";
  }

  // ------------------------------------------------------------------
  // VALUES and duplicates
  // ------------------------------------------------------------------

  @Test
  public void valuesKeepsDuplicates() throws Exception
  {
    assertEquivalent("VALUES with a repeated row is a bag of multiplicity 2",
        values("(1),(1)"),
        "SELECT * FROM (VALUES (1)) AS a UNION ALL SELECT * FROM (VALUES (1)) AS b");
  }

  @Test
  public void oneRowIsNotTwoRows() throws Exception
  {
    assertNotEquivalent("bag semantics must distinguish multiplicities",
        values("(1)"), values("(1),(1)"));
  }

  // ------------------------------------------------------------------
  // set operations: the ALL forms keep multiplicities, the others do not
  // ------------------------------------------------------------------

  @Test
  public void unionAllAddsMultiplicities() throws Exception
  {
    assertEquivalent("UNION ALL is multiset sum",
        "SELECT * FROM (VALUES (1)) AS a UNION ALL SELECT * FROM (VALUES (1)) AS b",
        values("(1),(1)"));
  }

  @Test
  public void unionRemovesDuplicates() throws Exception
  {
    assertEquivalent("UNION returns distinct rows",
        "SELECT * FROM (VALUES (1),(1)) AS a UNION SELECT * FROM (VALUES (1)) AS b",
        values("(1)"));
  }

  @Test
  public void unionIsNotUnionAll() throws Exception
  {
    // regression: UNION used bag.union_max, which does not deduplicate
    assertNotEquivalent("UNION must differ from UNION ALL when inputs share a row",
        "SELECT * FROM (VALUES (1),(1)) AS a UNION SELECT * FROM (VALUES (1)) AS b",
        values("(1),(1)"));
  }

  @Test
  public void unionIsCommutative() throws Exception
  {
    assertEquivalent("UNION is commutative",
        "SELECT * FROM (VALUES (1),(2)) AS a UNION SELECT * FROM (VALUES (2),(3)) AS b",
        "SELECT * FROM (VALUES (2),(3)) AS b UNION SELECT * FROM (VALUES (1),(2)) AS a");
  }

  @Test
  public void unionEqualsDistinctOfUnionAll() throws Exception
  {
    assertEquivalent("UNION = DISTINCT of UNION ALL",
        "SELECT * FROM (VALUES (1),(2)) AS a UNION SELECT * FROM (VALUES (2),(3)) AS b",
        "SELECT DISTINCT w.EXPR$0 FROM (SELECT * FROM (VALUES (1),(2)) AS a "
            + "UNION ALL SELECT * FROM (VALUES (2),(3)) AS b) AS w");
  }

  @Test
  public void exceptAllSubtractsMultiplicities() throws Exception
  {
    assertEquivalent("EXCEPT ALL subtracts multiplicities",
        "SELECT * FROM (VALUES (1),(1),(1)) AS a EXCEPT ALL SELECT * FROM (VALUES (1)) AS b",
        values("(1),(1)"));
  }

  @Test
  public void exceptRemovesDuplicates() throws Exception
  {
    // regression: EXCEPT used a bare bag.difference_remove, keeping the left multiplicity
    assertEquivalent("EXCEPT returns distinct rows",
        "SELECT * FROM (VALUES (1),(1),(2)) AS a EXCEPT SELECT * FROM (VALUES (99)) AS b",
        "SELECT DISTINCT v.EXPR$0 FROM (VALUES (1),(1),(2)) AS v");
  }

  @Test
  public void exceptIsNotExceptAll() throws Exception
  {
    assertNotEquivalent("EXCEPT must differ from EXCEPT ALL on a duplicated row",
        "SELECT * FROM (VALUES (1),(1)) AS a EXCEPT SELECT * FROM (VALUES (2)) AS b",
        values("(1),(1)"));
  }

  @Test
  public void intersectAllTakesMinimumMultiplicity() throws Exception
  {
    assertEquivalent("INTERSECT ALL takes the pointwise minimum",
        "SELECT * FROM (VALUES (1),(1),(1)) AS a INTERSECT ALL SELECT * FROM (VALUES (1),(1)) AS b",
        values("(1),(1)"));
  }

  @Test
  public void intersectIsNotIntersectAll() throws Exception
  {
    // regression: translate(LogicalIntersect) ignored the `all` flag entirely
    assertNotEquivalent("INTERSECT must differ from INTERSECT ALL",
        "SELECT * FROM (VALUES (1),(1)) AS a INTERSECT SELECT * FROM (VALUES (1),(1)) AS b",
        "SELECT * FROM (VALUES (1),(1)) AS a INTERSECT ALL SELECT * FROM (VALUES (1),(1)) AS b");
  }

  @Test
  public void intersectWithItselfIsDistinct() throws Exception
  {
    assertEquivalent("A INTERSECT A = DISTINCT A",
        "SELECT * FROM (VALUES (1),(1),(2)) AS a INTERSECT SELECT * FROM (VALUES (1),(1),(2)) AS b",
        "SELECT DISTINCT v.EXPR$0 FROM (VALUES (1),(1),(2)) AS v");
  }

  // ------------------------------------------------------------------
  // SELECT DISTINCT
  // ------------------------------------------------------------------

  @Test
  public void selectDistinctRemovesDuplicates() throws Exception
  {
    // regression: DISTINCT became a bare table.project, which sums multiplicities in bags
    assertNotEquivalent("SELECT DISTINCT must drop the duplicate row",
        "SELECT DISTINCT v.EXPR$0 FROM (VALUES (1),(1)) AS v",
        "SELECT v.EXPR$0 FROM (VALUES (1),(1)) AS v");
  }

  @Test
  public void selectDistinctEqualsGroupBy() throws Exception
  {
    assertEquivalent("SELECT DISTINCT = GROUP BY with no aggregates",
        "SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t",
        "SELECT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t GROUP BY t.EXPR$0");
  }

  @Test
  public void distinctIsIdempotent() throws Exception
  {
    assertEquivalent("DISTINCT of DISTINCT is DISTINCT",
        "SELECT DISTINCT w.EXPR$0 FROM (SELECT DISTINCT v.EXPR$0 FROM (VALUES (1),(1),(2)) AS v) AS w",
        "SELECT DISTINCT v.EXPR$0 FROM (VALUES (1),(1),(2)) AS v");
  }

  // ------------------------------------------------------------------
  // aggregates: each compared against the literal table it should produce
  // ------------------------------------------------------------------

  @Test
  public void sumAddsValues() throws Exception
  {
    // regression: a missing `break` made SUM emit MAX, giving 3 instead of 5
    assertEquivalent("SUM over {2,3} is 5",
        groupBy("t.EXPR$0, SUM(t.EXPR$1)", "(1,2),(1,3)"), values("(1,5)"));
  }

  @Test
  public void sumCountsDuplicateRowsTwice() throws Exception
  {
    assertEquivalent("SUM folds over every copy in the bag",
        groupBy("t.EXPR$0, SUM(t.EXPR$1)", "(1,2),(1,2),(1,3)"), values("(1,7)"));
  }

  @Test
  public void minTakesSmallest() throws Exception
  {
    // regression: MIN also fell through to MAX
    assertEquivalent("MIN over {2,3} is 2",
        groupBy("t.EXPR$0, MIN(t.EXPR$1)", "(1,2),(1,3)"), values("(1,2)"));
  }

  @Test
  public void maxTakesLargest() throws Exception
  {
    assertEquivalent("MAX over {2,3} is 3",
        groupBy("t.EXPR$0, MAX(t.EXPR$1)", "(1,2),(1,3)"), values("(1,3)"));
  }

  @Test
  public void minOverNegativesIsNegative() throws Exception
  {
    // regression: the accumulator was seeded with 0, so MIN over negatives returned 0
    assertEquivalent("MIN over {-5,-3} is -5",
        groupBy("t.EXPR$0, MIN(t.EXPR$1)", "(1,-5),(1,-3)"), values("(1,-5)"));
  }

  @Test
  public void maxOverNegativesIsNegative() throws Exception
  {
    assertEquivalent("MAX over {-5,-3} is -3",
        groupBy("t.EXPR$0, MAX(t.EXPR$1)", "(1,-5),(1,-3)"), values("(1,-3)"));
  }

  @Test
  public void minIsOrderIndependent() throws Exception
  {
    assertEquivalent("MIN does not depend on the order rows are folded in",
        groupBy("t.EXPR$0, MIN(t.EXPR$1)", "(1,2),(1,3)"),
        groupBy("t.EXPR$0, MIN(t.EXPR$1)", "(1,3),(1,2)"));
  }

  @Test
  public void minAndMaxOnStringsUseTheStringOrdering() throws Exception
  {
    // regression: string operands went through the integer LT
    assertEquivalent("MIN over {'pear','apple'} is 'apple'",
        groupBy("t.EXPR$0, MIN(t.EXPR$1)", "(1,'pear'),(1,'apple')"),
        groupBy("t.EXPR$0, MIN(t.EXPR$1)", "(1,'apple'),(1,'apple')"));
  }

  @Test
  public void countCountsRows() throws Exception
  {
    assertEquivalent("COUNT(*) over 3 rows is 3",
        groupBy("t.EXPR$0, COUNT(*)", "(1,2),(1,2),(1,3)"), values("(1,3)"));
  }

  @Test
  public void countIgnoresNulls() throws Exception
  {
    // regression: COUNT(x) incremented on null rows too
    assertEquivalent("COUNT(x) skips nulls",
        groupBy("t.EXPR$0, COUNT(t.EXPR$1)", "(1," + NULL_INT + "),(1,3)"), values("(1,1)"));
  }

  @Test
  public void countStarDoesNotIgnoreNulls() throws Exception
  {
    assertEquivalent("COUNT(*) counts every row, nulls included",
        groupBy("t.EXPR$0, COUNT(*)", "(1," + NULL_INT + "),(1,3)"), values("(1,2)"));
  }

  @Test
  public void countOfAllNullsIsZero() throws Exception
  {
    assertEquivalent("COUNT(x) over an all-null group is 0",
        groupBy("t.EXPR$0, COUNT(t.EXPR$1)", "(1," + NULL_INT + "),(1," + NULL_INT + ")"),
        values("(1,0)"));
  }

  @Test
  public void sumIgnoresNulls() throws Exception
  {
    assertEquivalent("SUM skips nulls",
        groupBy("t.EXPR$0, SUM(t.EXPR$1)", "(1," + NULL_INT + "),(1,3)"), values("(1,3)"));
  }

  @Test
  public void minIgnoresNulls() throws Exception
  {
    assertEquivalent("MIN skips nulls",
        groupBy("t.EXPR$0, MIN(t.EXPR$1)", "(1," + NULL_INT + "),(1,3)"), values("(1,3)"));
  }

  @Test
  public void sumOfAllNullsIsNull() throws Exception
  {
    assertEquivalent("SUM over an all-null group is NULL",
        groupBy("t.EXPR$0, SUM(t.EXPR$1)", "(1," + NULL_INT + "),(1," + NULL_INT + ")"),
        values("(1," + NULL_INT + ")"));
  }

  @Test
  public void minOfAllNullsIsNull() throws Exception
  {
    assertEquivalent("MIN over an all-null group is NULL",
        groupBy("t.EXPR$0, MIN(t.EXPR$1)", "(1," + NULL_INT + "),(1," + NULL_INT + ")"),
        values("(1," + NULL_INT + ")"));
  }

  @Test
  public void countDistinctDeduplicates() throws Exception
  {
    // regression: COUNT(DISTINCT x) was translated as plain COUNT(x)
    assertEquivalent("COUNT(DISTINCT x) over {2,2,3} is 2",
        groupBy("t.EXPR$0, COUNT(DISTINCT t.EXPR$1)", "(1,2),(1,2),(1,3)"), values("(1,2)"));
  }

  @Test
  public void countDistinctIsNotCount() throws Exception
  {
    assertNotEquivalent("COUNT(DISTINCT x) must differ from COUNT(x) on a duplicated value",
        groupBy("t.EXPR$0, COUNT(DISTINCT t.EXPR$1)", "(1,2),(1,2)"),
        groupBy("t.EXPR$0, COUNT(t.EXPR$1)", "(1,2),(1,2)"));
  }

  @Test
  public void countDistinctOfTheGroupingColumnItself() throws Exception
  {
    // edge case of the de-duplication rewrite: the argument column is also a group key, so
    // the projection it builds names the same column twice
    assertEquivalent("COUNT(DISTINCT x) grouped by x is 1 per group",
        groupBy("t.EXPR$0, COUNT(DISTINCT t.EXPR$0)", "(1,7),(1,8),(2,9)"),
        values("(1,1),(2,1)"));
  }

  @Test
  public void globalAggregateWithoutGroupBy() throws Exception
  {
    // edge case: an empty group set, so table.aggr gets no indices
    assertEquivalent("COUNT(*) with no GROUP BY folds the whole table",
        "SELECT COUNT(*) FROM (VALUES (1),(2),(3)) AS v", values("(3)"));
  }

  @Test
  public void globalSumWithoutGroupBy() throws Exception
  {
    assertEquivalent("SUM with no GROUP BY folds the whole table",
        "SELECT SUM(v.EXPR$0) FROM (VALUES (1),(2),(3)) AS v", values("(6)"));
  }

  @Test
  public void severalAggregatesInOneGroupBy() throws Exception
  {
    assertEquivalent("COUNT, SUM, MIN and MAX together, over two groups",
        groupBy("t.EXPR$0, COUNT(*), SUM(t.EXPR$1), MIN(t.EXPR$1), MAX(t.EXPR$1)",
            "(1,2),(1,5),(9,7)"),
        values("(1,2,7,2,5),(9,1,7,7,7)"));
  }

  @Test
  public void groupByKeepsGroupsSeparate() throws Exception
  {
    assertEquivalent("two groups produce two rows",
        groupBy("t.EXPR$0, SUM(t.EXPR$1)", "(1,2),(2,3)"), values("(1,2),(2,3)"));
  }

  // ------------------------------------------------------------------
  // filters, projections and row expressions
  // ------------------------------------------------------------------

  @Test
  public void whereFiltersRows() throws Exception
  {
    assertEquivalent("WHERE keeps only matching rows",
        "SELECT * FROM (VALUES (1),(2),(3)) AS v WHERE v.EXPR$0 > 1", values("(2),(3)"));
  }

  @Test
  public void whereKeepsDuplicates() throws Exception
  {
    assertEquivalent("WHERE does not deduplicate",
        "SELECT * FROM (VALUES (2),(2)) AS v WHERE v.EXPR$0 > 1", values("(2),(2)"));
  }

  @Test
  public void arithmeticInProjection() throws Exception
  {
    assertEquivalent("projection evaluates arithmetic",
        "SELECT v.EXPR$0 + 10 FROM (VALUES (1),(2)) AS v", values("(11),(12)"));
  }

  @Test
  public void caseExpression() throws Exception
  {
    assertEquivalent("CASE picks the right branch",
        "SELECT CASE WHEN v.EXPR$0 > 1 THEN 100 ELSE 200 END FROM (VALUES (1),(2)) AS v",
        values("(200),(100)"));
  }

  @Test
  public void stringConcatenationAndUpper() throws Exception
  {
    assertEquivalent("|| and UPPER",
        "SELECT UPPER(v.EXPR$0 || 'x') FROM (VALUES ('ab')) AS v", values("('ABX')"));
  }

  @Test
  public void substringIsOneBased() throws Exception
  {
    assertEquivalent("SQL SUBSTRING counts from 1",
        "SELECT SUBSTRING(v.EXPR$0 FROM 2 FOR 3) FROM (VALUES ('abcdef')) AS v",
        values("('bcd')"));
  }

  @Test
  public void isNullAndIsNotNull() throws Exception
  {
    assertEquivalent("IS NULL selects the null row",
        "SELECT v.EXPR$0 FROM (VALUES (1," + NULL_INT + "),(2,7)) AS v WHERE v.EXPR$1 IS NULL",
        values("(1)"));
  }

  @Test
  public void comparisonWithNullIsNotTrue() throws Exception
  {
    assertEquivalent("a comparison against NULL never passes a WHERE clause",
        "SELECT v.EXPR$0 FROM (VALUES (1," + NULL_INT + "),(2,7)) AS v WHERE v.EXPR$1 > 0",
        values("(2)"));
  }

  // ------------------------------------------------------------------
  // three-valued logic
  // ------------------------------------------------------------------

  @Test
  public void andIsFalseWhenAnyConjunctIsFalse() throws Exception
  {
    // regression: only the first two operands were inspected, so a FALSE in a later one was
    // missed and the whole conjunction came out NULL. Calcite flattens a AND b AND c into a
    // single 3-ary call, so this is reachable from ordinary SQL.
    assertEquivalent("NULL AND NULL AND FALSE is FALSE, so the row is dropped",
        "SELECT v.EXPR$0 FROM (VALUES (1," + NULL_INT + ",5)) AS v "
            + "WHERE v.EXPR$1 > 0 AND v.EXPR$1 > 0 AND v.EXPR$2 > 9",
        "SELECT v.EXPR$0 FROM (VALUES (1," + NULL_INT + ",5)) AS v WHERE FALSE");
  }

  @Test
  public void orIsTrueWhenAnyDisjunctIsTrue() throws Exception
  {
    assertEquivalent("NULL OR NULL OR TRUE is TRUE, so the row is kept",
        "SELECT v.EXPR$0 FROM (VALUES (1," + NULL_INT + ",5)) AS v "
            + "WHERE v.EXPR$1 > 0 OR v.EXPR$1 > 0 OR v.EXPR$2 > 1",
        values("(1)"));
  }

  @Test
  public void nullConjunctAloneFiltersTheRow() throws Exception
  {
    assertEquivalent("NULL AND TRUE is NULL, which does not pass a WHERE clause",
        "SELECT v.EXPR$0 FROM (VALUES (1," + NULL_INT + ",5)) AS v "
            + "WHERE v.EXPR$1 > 0 AND v.EXPR$2 > 1",
        "SELECT v.EXPR$0 FROM (VALUES (1," + NULL_INT + ",5)) AS v WHERE FALSE");
  }

  @Test
  public void multiBranchCase() throws Exception
  {
    // regression: CASE(c1,v1,c2,v2,else) was handed to a 3-argument ite
    assertEquivalent("a CASE with two WHENs picks each branch in turn",
        "SELECT CASE WHEN v.EXPR$0 = 1 THEN 10 WHEN v.EXPR$0 = 2 THEN 20 ELSE 30 END "
            + "FROM (VALUES (1),(2),(3)) AS v",
        values("(10),(20),(30)"));
  }

  // ------------------------------------------------------------------
  // joins
  // ------------------------------------------------------------------

  @Test
  public void innerJoinMatchesRows() throws Exception
  {
    assertEquivalent("inner join keeps only matching pairs",
        "SELECT a.EXPR$0, b.EXPR$1 FROM (VALUES (1),(2)) AS a "
            + "INNER JOIN (VALUES (1,10),(3,30)) AS b ON a.EXPR$0 = b.EXPR$0",
        values("(1,10)"));
  }

  @Test
  public void crossJoinMultipliesRows() throws Exception
  {
    assertEquivalent("a cross join of 2x2 rows has 4 rows",
        "SELECT a.EXPR$0, b.EXPR$0 FROM (VALUES (1),(2)) AS a, (VALUES (3),(4)) AS b",
        values("(1,3),(1,4),(2,3),(2,4)"));
  }

  @Test
  public void leftJoinPadsUnmatchedRowsWithNull() throws Exception
  {
    assertEquivalent("an unmatched left row survives with nulls on the right",
        "SELECT a.EXPR$0, b.EXPR$1 FROM (VALUES (1),(2)) AS a "
            + "LEFT JOIN (VALUES (1,10)) AS b ON a.EXPR$0 = b.EXPR$0",
        values("(1,10),(2," + NULL_INT + ")"));
  }

  @Test
  public void leftJoinIsNotInnerJoin() throws Exception
  {
    assertNotEquivalent("LEFT JOIN keeps the unmatched row that INNER JOIN drops",
        "SELECT a.EXPR$0, b.EXPR$1 FROM (VALUES (1),(2)) AS a "
            + "LEFT JOIN (VALUES (1,10)) AS b ON a.EXPR$0 = b.EXPR$0",
        "SELECT a.EXPR$0, b.EXPR$1 FROM (VALUES (1),(2)) AS a "
            + "INNER JOIN (VALUES (1,10)) AS b ON a.EXPR$0 = b.EXPR$0");
  }

  @Test
  public void rightJoinIsMirroredLeftJoin() throws Exception
  {
    assertEquivalent("RIGHT JOIN is LEFT JOIN with the inputs swapped",
        "SELECT a.EXPR$0, b.EXPR$0 FROM (VALUES (1)) AS a "
            + "RIGHT JOIN (VALUES (1),(2)) AS b ON a.EXPR$0 = b.EXPR$0",
        values("(1,1),(" + NULL_INT + ",2)"));
  }

  // ------------------------------------------------------------------
  // set semantics differs from bag semantics
  // ------------------------------------------------------------------

  @Test
  public void setSemanticsIgnoresMultiplicity() throws Exception
  {
    String oneRow = values("(1)");
    String twoRows = values("(1),(1)");
    assertTrue("under set semantics duplicates collapse, so these are equivalent",
        check(oneRow, twoRows, true).isUnsat());
    assertTrue("under bag semantics they are not",
        check(oneRow, twoRows, false).isSat());
  }

  // ------------------------------------------------------------------
  // constructs the translator refuses rather than mistranslating
  // ------------------------------------------------------------------

  @Test
  public void averageIsRejected() throws Exception
  {
    assertRejected("AVG is not encodable over integers",
        groupBy("t.EXPR$0, AVG(t.EXPR$1)", "(1,2),(1,3)"));
  }

  @Test
  public void distinctAggregateAlongsideAnotherIsRejected() throws Exception
  {
    assertRejected("a DISTINCT aggregate needs its own de-duplicated input",
        groupBy("t.EXPR$0, COUNT(DISTINCT t.EXPR$1), SUM(t.EXPR$1)", "(1,2),(1,3)"));
  }

  @Test
  public void aggregateFilterIsRejected() throws Exception
  {
    assertRejected("the aggregate FILTER clause is ignored by the encoding, so it is refused",
        groupBy("t.EXPR$0, SUM(t.EXPR$1) FILTER (WHERE t.EXPR$1 > 2)", "(1,2),(1,3)"));
  }

  @Test
  public void unsupportedTypeIsRejected() throws Exception
  {
    assertRejected("DATE has no encoding",
        "SELECT * FROM (VALUES (DATE '2020-01-01')) AS v");
  }

  // ------------------------------------------------------------------
  // the batch driver's own filter
  // ------------------------------------------------------------------

  @Test
  public void orderByIsFilteredOutBeforeTranslation() throws Exception
  {
    PrintWriter writer = new PrintWriter(new StringWriter());
    assertEquals("ORDER BY is excluded upstream by isSupported", null,
        Cvc5Analysis.verify("SELECT * FROM (VALUES (2),(1)) AS v ORDER BY v.EXPR$0",
            "SELECT * FROM (VALUES (1),(2)) AS v", "unitTest", writer, false));
  }
}
