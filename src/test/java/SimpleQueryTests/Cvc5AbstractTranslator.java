package SimpleQueryTests;
import com.google.common.collect.ImmutableList;
import io.github.cvc5.*;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import org.apache.calcite.adapter.enumerable.EnumerableTableScan;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.core.AggregateCall;
import org.apache.calcite.rel.logical.LogicalAggregate;
import org.apache.calcite.rel.logical.LogicalFilter;
import org.apache.calcite.rel.logical.LogicalIntersect;
import org.apache.calcite.rel.logical.LogicalJoin;
import org.apache.calcite.rel.logical.LogicalMinus;
import org.apache.calcite.rel.logical.LogicalProject;
import org.apache.calcite.rel.logical.LogicalUnion;
import org.apache.calcite.rel.logical.LogicalValues;
import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeFactoryImpl;
import org.apache.calcite.rel.type.RelDataTypeField;
import org.apache.calcite.rex.RexCall;
import org.apache.calcite.rex.RexInputRef;
import org.apache.calcite.rex.RexLiteral;
import org.apache.calcite.rex.RexNode;
import org.apache.calcite.sql.type.BasicSqlType;
import org.apache.calcite.util.ImmutableBitSet;

public abstract class Cvc5AbstractTranslator
{
  protected final PrintWriter writer;
  private StringBuilder prologue = new StringBuilder();
  public HashMap<EnumerableTableScan, Term> tables = new HashMap<>();
  public HashMap<String, Term> declaredFunctions = new HashMap<>();
  protected Solver solver;
  protected int functionIndex = 0;
  protected Term zero;
  protected Term one;
  protected Term trueTerm;
  protected Term falseTerm;
  protected final long startTime;
  public static long totalTime = 0;
  public static int unsatAnswers = 0;
  public static int satAnswers = 0;
  public static int unknownAnswers = 0;

  public Cvc5AbstractTranslator(PrintWriter writer)
  {
    this.writer = writer;
    startTime = System.currentTimeMillis();
  }

  protected abstract boolean isSetSemantics();

  public void reset() throws CVC5ApiException
  {
    tables.clear();
    declaredFunctions.clear();
    functionIndex = 0;
    Context.deletePointers();
    solver = new Solver();
    solver.setLogic("HO_ALL");
    prologue.append("(set-logic HO_ALL)\n");
    setOption("produce-models", "true");
    setOption("check-models", "true");
    setOption("dag-thresh", "0");
    setOption("uf-lazy-ll", "true");
    setOption("fmf-bound", "true");
    setOption("tlimit-per", "10000");
    setOption("strings-exp", "true");
    // setOption("simplification", "none");
    zero = solver.mkInteger(0);
    one = solver.mkInteger(1);
    trueTerm = solver.mkBoolean(true);
    falseTerm = solver.mkBoolean(false);
  }

  private void setOption(String option, String value)
  {
    solver.setOption(option, value);
    prologue.append("(set-option :" + option + " " + value + ")\n");
  }

  public Result translate(String name, RelNode n1, String sql1, RelNode n2, String sql2)
      throws CVC5ApiException
  {
    reset();
    println(";-----------------------------------------------------------");
    println("; test name: " + name);
    Term q1Term = translate(n1, sql1);
    Term q2Term = translate(n2, sql2);
    // declare a variable for q1, q2.
    Term q1 = defineFun(new Term[0], q1Term.getSort(), q1Term, "q1", false);
    Term q2 = defineFun(new Term[0], q2Term.getSort(), q2Term, "q2", false);
    solver.assertFormula(q1.eqTerm(q2).notTerm());
    printSmtProblem();
    //solver.assertFormula(falseTerm);
    Result result = solver.checkSat();
    long stopTime = System.currentTimeMillis();
    long duration = stopTime - startTime;
    totalTime += duration;
    println(";answer: " + result);
    println("; duration: " + duration + " ms.");
    if (result.isSat())
    {
      satAnswers++;
      println("(get-model)");
      Term[] terms = tables.values().toArray(new Term[0]);
      String model = solver.getModel(new Sort[0], terms);
      for (String line : model.split("\n"))
      {
        println("; " + line);
      }

      println("; q1");
      println("(get-value (" + q1 + "))");
      println("; " + solver.getValue(q1));
      println("; q2");
      println("(get-value (" + q2 + "))");
      println("; " + solver.getValue(q2));

      String url = "jdbc:postgresql://localhost/spes?user=postgres&password=abc";
      try (Connection connection = DriverManager.getConnection(url))
      {
        Statement statement = connection.createStatement();
        String query1 = postgres(sql1);
        String query2 = postgres(sql2);
        if (!tables.isEmpty())
        {
          statement.execute("TRUNCATE TABLE EMP");
          statement.execute("TRUNCATE TABLE DEPT");
          statement.execute("TRUNCATE TABLE ACCOUNT");
          for (Map.Entry<EnumerableTableScan, Term> entry : tables.entrySet())
          {
            String table = getTableName(entry.getKey());
            Term tableValue = solver.getValue(entry.getValue());
            List<List<Object>> rows = getTableRows(tableValue);
            if (!rows.isEmpty())
            {
              String insertStatement = "insert into " + table + " values";
              for (int i = 0; i < rows.size(); i++)
              {
                insertStatement += "(";
                List<Object> row = rows.get(i);
                for (int j = 0; j < row.size(); j++)
                {
                  Object fieldValue = row.get(j);
                  if (fieldValue == null)
                  {
                    insertStatement += "NULL";
                  }
                  else if (fieldValue instanceof BigInteger)
                  {
                    insertStatement += fieldValue;
                  }
                  else if (fieldValue instanceof String)
                  {
                    insertStatement += "'" + fieldValue + "'";
                  }
                  if (j < row.size() - 1)
                  {
                    insertStatement += ",";
                  }
                }
                insertStatement += ")";
                if (i < rows.size() - 1)
                {
                  insertStatement += ",";
                }
              }
              println("; " + insertStatement);
              statement.execute(insertStatement);
            }
          }
        }
        String query1MinusQuery2 =
            "SELECT * FROM (" + query1 + ") AS q1 EXCEPT ALL SELECT * FROM (" + query2 + ") AS q2;";
        ResultSet rs1 = statement.executeQuery(query1MinusQuery2);
        boolean isModelSound = checkModelSoundness(rs1, query1MinusQuery2);

        String query2MinusQuery1 =
            "SELECT * FROM (" + query2 + ") AS q2 EXCEPT ALL SELECT * FROM (" + query1 + ") AS q1;";
        ResultSet rs2 = statement.executeQuery(query2MinusQuery1);
        isModelSound |= checkModelSoundness(rs2, query2MinusQuery1);

        println(";Model soundness: " + isModelSound);
        connection.close();
      }
      catch (SQLException e)
      {
        e.printStackTrace();
      }
    }
    if (result.isUnsat())
    {
      unsatAnswers++;
      Cvc5Analysis.cvc5ProvenTests.add(name);
    }
    if (result.isUnknown())
    {
      unknownAnswers++;
      Cvc5Analysis.cvc5ProvenTests.add(name);
    }
    print("(reset)\n");
    return result;
  }

  protected abstract List<List<Object>> getTableRows(Term tableValue) throws CVC5ApiException;

  protected abstract Kind getEmptyKind();

  protected List<Object> getTupleValues(Term tuple)
  {
    List<Object> tupleValues = new ArrayList<>();
    Term[] fields = tuple.getTupleValue();
    for (int i = 0; i < fields.length; i++)
    {
      if (fields[i].getSort().isNullable())
      {
        Term isSome = solver.simplify(solver.mkNullableIsSome(fields[i]));
        if (isSome.getBooleanValue())
        {
          Term cvc5Value = solver.simplify(solver.mkNullableVal(fields[i]));
          Object javaValue = getFieldValue(cvc5Value);
          tupleValues.add(javaValue);
        }
        else
        {
          tupleValues.add(null);
        }
      }
      else
      {
        Object javaValue = getFieldValue(fields[i]);
        tupleValues.add(javaValue);
      }
    }
    return tupleValues;
  }

  private Object getFieldValue(Term field)
  {
    if (field.isIntegerValue())
    {
      return field.getIntegerValue();
    }
    else if (field.isStringValue())
    {
      return field.getStringValue();
    }
    throw new RuntimeException("Unsupported type: " + field.getSort());
  }

  private String postgres(String sql1)
  {
    String query = sql1.replaceAll("EXPR\\$0", "column1")
                       .replaceAll("EXPR\\$1", "column2")
                       .replaceAll("EXPR\\$2", "column3")
                       .replaceAll("EXPR\\$3", "column4")
                       .replaceAll("EXPR\\$4", "column5")
                       .replaceAll("EXPR\\$5", "column6")
                       .replaceAll("EXPR\\$6", "column7")
                       .replaceAll("EXPR\\$7", "column8")
                       .replaceAll("EXPR\\$8", "column9")
                       .replaceAll("EXPR\\$9", "column10");
    return query;
  }

  private boolean checkModelSoundness(ResultSet rs, String query) throws SQLException
  {
    ResultSetMetaData rsMeta = rs.getMetaData();
    int count = rsMeta.getColumnCount();
    StringBuilder builder = new StringBuilder();
    boolean isSound = false;
    while (rs.next())
    {
      builder.append(";(");
      for (int i = 1; i <= count; i++)
      {
        Object value = rs.getObject(i);
        if (value == null)
        {
          builder.append("NULL");
        }
        else
        {
          builder.append(rs.getObject(i).toString());
        }
        if (i < count)
        {
          builder.append(",");
        }
      }
      builder.append(")\n");
      isSound = true;
    }
    println("; " + query);
    println(builder.toString());
    return isSound;
  }

  protected void println(Object object)
  {
    writer.println(object);
    System.out.println(object);
    writer.flush();
  }
  protected void print(Object object)
  {
    writer.print(object);
    System.out.print(object);
    writer.flush();
  }

  protected void printSmtProblem()
  {
    println(prologue.toString());

    Term[] terms = tables.values().toArray(new Term[0]);
    for (Term term : terms)
    {
      print("(declare-const ");
      print(term + " ");
      println(term.getSort() + ")");
    }
    for (Map.Entry<String, Term> entry : declaredFunctions.entrySet())
    {
      print("(declare-const ");
      print(entry.getKey() + " ");
      println(entry.getValue().getSort() + ")");
    }
    for (Term term : solver.getAssertions())
    {
      print("(assert ");
      print(term);
      println(")");
    }
    println("(check-sat)");
  }

  public Term translate(RelNode n, String sql) throws CVC5ApiException
  {
    println(";Translating sql query: " + sql);
    return translate(n);
  }

  public Term translate(RelNode n) throws CVC5ApiException
  {
    if (n instanceof EnumerableTableScan)
    {
      return translate((EnumerableTableScan) n);
    }
    if (n instanceof LogicalAggregate)
    {
      return translate((LogicalAggregate) n);
    }
    if (n instanceof LogicalProject)
    {
      return translate((LogicalProject) n);
    }
    if (n instanceof LogicalFilter)
    {
      return translate((LogicalFilter) n);
    }
    if (n instanceof LogicalJoin)
    {
      return translate((LogicalJoin) n);
    }
    if (n instanceof LogicalUnion)
    {
      return translate((LogicalUnion) n);
    }
    if (n instanceof LogicalMinus)
    {
      return translate((LogicalMinus) n);
    }
    if (n instanceof LogicalIntersect)
    {
      return translate((LogicalIntersect) n);
    }
    if (n instanceof LogicalValues)
    {
      return translate((LogicalValues) n);
    }
    return null;
  }

  private Term translate(LogicalIntersect intersect) throws CVC5ApiException
  {
    Term a = translate(intersect.getInput(0));
    Term b = translate(intersect.getInput(1));
    Term difference = solver.mkTerm(getIntersectionKind(), a, b);
    return difference;
  }

  protected abstract Kind getIntersectionKind();

  protected abstract Term translate(LogicalMinus minus) throws CVC5ApiException;

  private Term translate(LogicalAggregate aggregate) throws CVC5ApiException
  {
    Term child = translate(aggregate.getInput());
    // get the indices of the group set
    ImmutableBitSet bitSet = aggregate.getGroupSet();
    int[] indices = getGroupIndices(bitSet);
    if (aggregate.getAggCallList().isEmpty())
    {
      // it is similar to duplicate removal of a projection

      // ((_ table.project indices) child)
      Op op = solver.mkOp(getProjectKind(), indices);
      Term ret = solver.mkTerm(op, child);
      return ret;
    }

    List<AggregateCall> calls = aggregate.getAggCallList();
    // construct a lambda function that handles all aggregate functions
    Sort xTupleSort = getElementSort(child.getSort());
    Term x = solver.mkVar(xTupleSort, "x");
    String name = String.join("_", calls.stream().map(s -> s.getAggregation().getName()).toList())
                      .toLowerCase();
    Sort yTupleSort = getSort(aggregate.getRowType());
    Term y = solver.mkVar(yTupleSort, "y");
    int yTupleLength = yTupleSort.getTupleLength();
    Sort[] yTupleSorts = yTupleSort.getTupleSorts();
    Term[] tupleElements = new Term[yTupleLength];
    Term[] initialValues = new Term[yTupleLength];
    // add grouping elements
    int yIndex = 0;
    for (int index : indices)
    {
      Term tupleSelect = mkTupleSelect(xTupleSort, x, index);
      tupleElements[yIndex] = tupleSelect;
      // initial value is needed for grouping fields
      initialValues[yIndex] = solver.mkNullableNull(yTupleSorts[yIndex]);
      yIndex++;
    }

    // add aggregate functions
    for (int j = 0; j < calls.size(); j++)
    {
      AggregateCall call = calls.get(j);
      List<Integer> argList = call.getArgList();
      Term yTupleSelect = mkTupleSelect(yTupleSort, y, yIndex);
      if (yTupleSelect.getSort().isNullable())
      {
        yTupleSelect = solver.mkNullableVal(yTupleSelect);
      }
      if (argList.isEmpty())
      {
        mkCountFun(tupleElements, initialValues, yIndex, yTupleSelect);
      }
      else
      {
        mkAggregateFun(
            xTupleSort, x, yTupleSort, yTupleSelect, y, tupleElements, initialValues, yIndex, call);
      }
      yIndex++;
    }

    Term body = solver.mkTuple(tupleElements);
    Term initialValue = solver.mkTuple(initialValues);
    Term f = defineFun(new Term[] {x, y}, yTupleSort, body, name, true);
    Op op = solver.mkOp(getAggregateKind(), indices);
    Term ret = solver.mkTerm(op, new Term[] {f, initialValue, child});
    return ret;
  }

  private void mkAggregateFun(Sort xTupleSort,
      Term x,
      Sort yTupleSort,
      Term yTupleSelect,
      Term y,
      Term[] tupleElements,
      Term[] initialValues,
      int yIndex,
      AggregateCall call)
  {
    int xIndex = call.getArgList().get(0);
    Term xTupleSelect = mkTupleSelect(xTupleSort, x, xIndex);
    switch (call.getAggregation().kind)
    {
      case COUNT:
      {
        mkCountFun(tupleElements, initialValues, yIndex, yTupleSelect);
      }
      break;
      case SUM:
      {
        if (xTupleSelect.getSort().isNullable())
        {
          Term isNull = solver.mkNullableIsNull(xTupleSelect);
          Term val = solver.mkNullableVal(xTupleSelect);
          Term ite = solver.mkTerm(Kind.ITE, isNull, zero, val);
          Term result = solver.mkTerm(Kind.ADD, ite, yTupleSelect);
          tupleElements[yIndex] = solver.mkNullableSome(result);
          initialValues[yIndex] = solver.mkNullableSome(zero);
        }
      }
      case MIN:
      {
        if (xTupleSelect.getSort().isNullable())
        {
          Term isNull = solver.mkNullableIsNull(xTupleSelect);
          Term val = solver.mkNullableVal(xTupleSelect);
          Term ite = solver.mkTerm(Kind.ITE, isNull, yTupleSelect, val);
          Term lt = solver.mkTerm(Kind.LT, ite, yTupleSelect);
          Term result = solver.mkTerm(Kind.ITE, lt, ite, yTupleSelect);
          tupleElements[yIndex] = solver.mkNullableSome(result);
          initialValues[yIndex] = solver.mkNullableSome(zero);
        }
      }
      case MAX:
      {
        if (xTupleSelect.getSort().isNullable())
        {
          Term isNull = solver.mkNullableIsNull(xTupleSelect);
          Term val = solver.mkNullableVal(xTupleSelect);
          Term ite = solver.mkTerm(Kind.ITE, isNull, yTupleSelect, val);
          Term gt = solver.mkTerm(Kind.GT, ite, yTupleSelect);
          Term result = solver.mkTerm(Kind.ITE, gt, ite, yTupleSelect);
          tupleElements[yIndex] = solver.mkNullableSome(result);
          initialValues[yIndex] = solver.mkNullableSome(zero);
        }
      }
      break;
      default: break;
    }
  }

  private void mkCountFun(Term[] tupleElements, Term[] initialValues, int yIndex, Term yTupleSelect)
  {
    Term result = solver.mkTerm(Kind.ADD, yTupleSelect, one);
    tupleElements[yIndex] = solver.mkNullableSome(result);
    initialValues[yIndex] = solver.mkNullableSome(zero);
  }

  private Term mkTupleSelect(Sort tupleSort, Term t, int index)
  {
    Datatype datatype = tupleSort.getDatatype();
    DatatypeConstructor constructor = datatype.getConstructor(0);
    Term selectorTerm = constructor.getSelector(index).getTerm();
    Term selectedTerm = solver.mkTerm(Kind.APPLY_SELECTOR, new Term[] {selectorTerm, t});
    return selectedTerm;
  }

  protected abstract Kind getAggregateKind();

  private int[] getGroupIndices(ImmutableBitSet bitSet)
  {
    int[] indices = new int[bitSet.asList().size()];
    int index = 0;
    for (int i = 0; i < indices.length; i++)
    {
      if (bitSet.get(i))
      {
        indices[index] = i;
        index++;
      }
    }
    return indices;
  }

  protected abstract Term translate(LogicalUnion n) throws CVC5ApiException;

  protected abstract Kind getProjectKind();

  protected Term translate(LogicalValues values)
  {
    ImmutableList<ImmutableList<RexLiteral>> sqlTuples = values.getTuples();
    Term[] smtTuples = new Term[sqlTuples.size()];
    for (int i = 0; i < sqlTuples.size(); i++)
    {
      ImmutableList<RexLiteral> tuple = sqlTuples.get(i);
      Term[] terms = new Term[tuple.size()];
      for (int j = 0; j < tuple.size(); j++)
      {
        terms[j] = translate(tuple.get(j));
      }
      Term smtTuple = solver.mkTuple(terms);
      Term singleton = mkSingleton(smtTuple);
      smtTuples[i] = singleton;
    }
    if (smtTuples.length == 0)
    {
      Sort sort = getSort(values.getRowType());
      Term empty = mkEmptyTable(sort);
      return empty;
    }
    if (smtTuples.length == 1)
    {
      return smtTuples[0];
    }
    Term union = smtTuples[0];
    for (int i = 1; i < smtTuples.length; i++)
    {
      union = solver.mkTerm(getUnionAllKind(), union, smtTuples[i]);
    }
    return union;
  }

  protected abstract Kind getUnionAllKind();

  protected abstract Term mkEmptyTable(Sort sort);

  protected abstract Term mkSingleton(Term smtTuple);

  protected Term translate(LogicalJoin n) throws CVC5ApiException
  {
    Term a = translate(n.getLeft());
    Term b = translate(n.getRight());
    Term product = solver.mkTerm(getProductKind(), a, b);
    if (!n.getCondition().isAlwaysTrue())
    {
      product = applyFilter(n.getCondition(), product);
    }
    switch (n.getJoinType())
    {
      case INNER: return product;
      case LEFT:
      {
        Term left = mkLeft(a, product);
        Term join = solver.mkTerm(getUnionAllKind(), left, product);
        return join;
      }
      case RIGHT:
      {
        Term right = mkRight(b, product);
        Term join = solver.mkTerm(getUnionAllKind(), right, product);
        return join;
      }
      case FULL:
      {
        Term left = mkLeft(a, product);
        Term right = mkRight(b, product);
        Term join = solver.mkTerm(getUnionAllKind(), left, right);
        join = solver.mkTerm(getUnionAllKind(), join, product);
        return join;
      }
      default: throw new RuntimeException(n.toString());
    }
  }

  private Term mkLeft(Term a, Term product) throws CVC5ApiException
  {
    //(set.map
    // (lambda ((t (Tuple)))
    //         (tuple ((_ tuple.select 0) t) .. ((_ tuple.select (m - 1)) t) null ..null))
    //  (set.minus a ((_ set.project 0 .. (m - 1)) product))
    Sort aTupleSort = getElementSort(a.getSort());
    int aTupleLength = aTupleSort.getTupleLength();
    int[] aIndices = IntStream.range(0, aTupleLength).boxed().mapToInt(Integer::intValue).toArray();
    Op op = solver.mkOp(getProjectKind(), aIndices);
    Term projection = solver.mkTerm(op, product);
    Term difference = solver.mkTerm(getDifferenceRemoveKind(), a, projection);

    Sort productTupleSort = getElementSort(product.getSort());
    Datatype aDatatype = aTupleSort.getDatatype();
    DatatypeConstructor aConstructor = aDatatype.getConstructor(0);
    int productTupleLength = productTupleSort.getTupleLength();
    Term[] terms = new Term[productTupleLength];
    Term t = solver.mkVar(aTupleSort, "t");
    // fill a elements
    for (int i = 0; i < aTupleLength; i++)
    {
      Term selectorTerm = aConstructor.getSelector(i).getTerm();
      Term selectedTerm = solver.mkTerm(Kind.APPLY_SELECTOR, new Term[] {selectorTerm, t});
      terms[i] = selectedTerm;
    }
    // fill the remaining elements with nulls
    Sort[] productTupleSorts = productTupleSort.getTupleSorts();
    for (int i = aTupleLength; i < productTupleLength; i++)
    {
      Sort elementSort = productTupleSorts[i];
      terms[i] = solver.mkNullableNull(elementSort);
    }
    Term productTuple = solver.mkTuple(terms);

    Term f = defineFun(new Term[] {t}, productTupleSort, productTuple, "leftJoin", true);
    Term mapF = solver.mkTerm(getMapKind(), f, difference);
    return mapF;
  }

  private Term mkRight(Term b, Term product) throws CVC5ApiException
  {
    //(set.map
    // (lambda ((t (Tuple)))
    //         (tuple null ..null ((_ tuple.select 0) t) .. ((_ tuple.select (n - 1)) t)))
    //  (set.minus b ((_ set.project m .. (n - 1)) product))
    Sort bTupleSort = getElementSort(b.getSort());
    int bTupleLength = bTupleSort.getTupleLength();
    Sort productTupleSort = getElementSort(product.getSort());
    int productTupleLength = productTupleSort.getTupleLength();
    int aTupleLength = productTupleLength - bTupleLength;
    int[] bIndices = IntStream.range(aTupleLength, productTupleLength)
                         .boxed()
                         .mapToInt(Integer::intValue)
                         .toArray();
    Op op = solver.mkOp(getProjectKind(), bIndices);
    Term projection = solver.mkTerm(op, product);
    Term difference = solver.mkTerm(getDifferenceRemoveKind(), b, projection);

    Datatype bDatatype = bTupleSort.getDatatype();
    DatatypeConstructor bConstructor = bDatatype.getConstructor(0);

    Term[] terms = new Term[productTupleLength];
    Term t = solver.mkVar(bTupleSort, "t");
    // fill initial elements with nulls
    Sort[] tupleSorts = productTupleSort.getTupleSorts();
    for (int i = 0; i < aTupleLength; i++)
    {
      Sort elementSort = tupleSorts[i];
      terms[i] = solver.mkNullableNull(elementSort);
    }
    // fill b elements
    for (int i = aTupleLength; i < productTupleLength; i++)
    {
      Term selectorTerm = bConstructor.getSelector(i - aTupleLength).getTerm();
      Term selectedTerm = solver.mkTerm(Kind.APPLY_SELECTOR, new Term[] {selectorTerm, t});
      terms[i] = selectedTerm;
    }
    Term productTuple = solver.mkTuple(terms);

    Term f = defineFun(new Term[] {t}, productTupleSort, productTuple, "rightJoin", true);
    Term mapF = solver.mkTerm(getMapKind(), f, difference);
    return mapF;
  }

  protected abstract Kind getDifferenceRemoveKind();

  protected abstract Sort getElementSort(Sort sort);

  protected abstract Kind getProductKind();

  protected Term translate(LogicalFilter n) throws CVC5ApiException
  {
    // (set.filter (lambda (t (Tuple ...) ) ... ) input)
    Term child = translate(n.getInput());
    return applyFilter(n.getCondition(), child);
  }

  protected Term applyFilter(RexNode condition, Term table)
  {
    Sort tupleSort = getElementSort(table.getSort());
    Datatype datatype = tupleSort.getDatatype();
    DatatypeConstructor constructor = datatype.getConstructor(0);
    Term t = solver.mkVar(tupleSort, "t");
    Sort functionType = solver.getBooleanSort();
    Term body = translateRowExpr(condition, constructor, t, "");
    Term isSome = solver.mkNullableIsSome(body);
    Term val = solver.mkNullableVal(body);
    body = isSome.andTerm(val);

    Term p = defineFun(new Term[] {t}, functionType, body, "p", true);
    Term ret = solver.mkTerm(getFilterKind(), p, table);
    return ret;
  }

  protected abstract Kind getFilterKind();

  protected Term defineFun(
      Term[] vars, Sort functionType, Term body, String prefix, boolean includeIndex)
  {
    String name = prefix;
    if (includeIndex)
    {
      name = prefix + functionIndex;
    }
    Term f = solver.defineFun(name, vars, functionType, body, true);
    functionIndex++;
    declaredFunctions.put(name, f);
    return f;
  }

  protected Term declareFun(Sort[] args, Sort functionType, String prefix, boolean includeIndex)
  {
    String name = prefix;
    if (includeIndex)
    {
      name = prefix + functionIndex;
    }
    Term f = solver.declareFun(name, args, functionType);
    functionIndex++;
    declaredFunctions.put(name, f);
    return f;
  }

  protected Term translate(LogicalProject project) throws CVC5ApiException
  {
    // check whether to use table.project or set.map
    boolean isTableProject = true;
    List<RexNode> exprs = project.getChildExps();
    int[] indices = new int[exprs.size()];
    for (int i = 0; i < exprs.size(); i++)
    {
      RexNode expr = exprs.get(i);
      if (expr instanceof RexInputRef)
      {
        RexInputRef rex = (RexInputRef) expr;
        indices[i] = rex.getIndex();
      }
      else
      {
        isTableProject = false;
      }
    }
    Term child = translate(project.getInput());
    if (isTableProject)
    {
      // ((_ table.project indices) input)
      Op op = solver.mkOp(getProjectKind(), indices);
      Term ret = solver.mkTerm(op, child);
      return ret;
    }
    else
    {
      // (set.map (lambda (t (Tuple ...) ) ... ) input)
      Sort argType = getElementSort(child.getSort());
      Term t = solver.mkVar(argType, "t");
      Sort functionType = getSort(project.getRowType());

      Datatype datatype = t.getSort().getDatatype();
      DatatypeConstructor constructor = datatype.getConstructor(0);
      Term[] terms = new Term[exprs.size()];
      for (int i = 0; i < terms.length; i++)
      {
        terms[i] = translateRowExpr(exprs.get(i), constructor, t, "");
      }
      Term body = solver.mkTuple(terms);
      Term f = defineFun(new Term[] {t}, functionType, body, "f", true);
      Term ret = solver.mkTerm(getMapKind(), f, child);
      return ret;
    }
  }

  protected abstract Kind getMapKind();

  protected Term translateRowExpr(
      RexNode expr, DatatypeConstructor constructor, Term t, String operator)
  {
    if (expr instanceof RexInputRef)
    {
      // ((_ tuple.select index) t)
      RexInputRef rex = (RexInputRef) expr;
      int index = rex.getIndex();
      Term selectorTerm = constructor.getSelector(index).getTerm();
      Term selectedTerm = solver.mkTerm(Kind.APPLY_SELECTOR, new Term[] {selectorTerm, t});
      Term simplifiedTerm = solver.simplify(selectedTerm);
      return simplifiedTerm;
    }
    else if (expr instanceof RexLiteral)
    {
      return translate(expr);
    }
    else if (expr instanceof RexCall)
    {
      RexCall call = (RexCall) expr;
      Kind k;
      if (call.op.toString().equals("CAST"))
      {
        Term ret = translateRowExpr(call.getOperands().get(0), constructor, t, "");
        return ret;
      }
      Term[] argTerms = getArgTerms(constructor, t, call);
      switch (call.op.toString())
      {
        case "=": k = Kind.EQUAL; break;
        case "<>": k = Kind.DISTINCT; break;
        case "+": k = Kind.ADD; break;
        case "-": k = Kind.SUB; break;
        case ">":
        {
          k = Kind.GT;
          Sort sort = getSort(call.operands.get(0).getType());
          if (sort.isString() || (sort.isNullable() && sort.getNullableElementSort().isString()))
          {
            k = Kind.STRING_LT;
            swap(argTerms, 0, 1);
          }
          break;
        }
        case "<":
        {
          k = Kind.LT;
          Sort sort = getSort(call.operands.get(0).getType());
          if (sort.isString() || (sort.isNullable() && sort.getNullableElementSort().isString()))
          {
            k = Kind.STRING_LT;
          }
          break;
        }
        case ">=":
        {
          k = Kind.GEQ;
          Sort sort = getSort(call.operands.get(0).getType());
          if (sort.isString() || (sort.isNullable() && sort.getNullableElementSort().isString()))
          {
            k = Kind.STRING_LEQ;
            swap(argTerms, 0, 1);
          }
          break;
        }
        case "<=":
        {
          k = Kind.LEQ;
          Sort sort = getSort(call.operands.get(0).getType());
          if (sort.isString() || (sort.isNullable() && sort.getNullableElementSort().isString()))
          {
            k = Kind.STRING_LEQ;
          }
          break;
        }
        case "*": k = Kind.MULT; break;
        case "/": k = Kind.DIVISION; break;
        case "AND":
        {
          Term l = argTerms[0];
          Term r = argTerms[1];
          Term lVal = solver.mkNullableVal(l);
          Term rVal = solver.mkNullableVal(r);
          Term lIsSome = solver.mkNullableIsSome(l);
          Term rIsSome = solver.mkNullableIsSome(r);
          Term isSome = lIsSome.andTerm(rIsSome);
          Term notLeft = lIsSome.andTerm(lVal.notTerm());
          Term notRight = rIsSome.andTerm(rVal.notTerm());
          Term andTerm = isSome.andTerm(lVal.andTerm(rVal));
          Term ret = notLeft.orTerm(notRight).orTerm(andTerm);
          return solver.mkNullableSome(ret);
        }
        case "OR":
        {
          Term l = argTerms[0];
          Term r = argTerms[1];
          Term lVal = solver.mkNullableVal(l);
          Term rVal = solver.mkNullableVal(r);
          Term lIsSome = solver.mkNullableIsSome(l);
          Term rIsSome = solver.mkNullableIsSome(r);
          Term isSome = lIsSome.andTerm(rIsSome);
          Term left = lIsSome.andTerm(lVal);
          Term right = rIsSome.andTerm(rVal);
          Term orTerm = isSome.andTerm(lVal.orTerm(rVal));
          Term ret = left.orTerm(right).orTerm(orTerm);
          return solver.mkNullableSome(ret);
        }
        case "NOT": k = Kind.NOT; break;
        case "UPPER": k = Kind.STRING_TO_UPPER; break;
        case "SUBSTRING":
        {
          k = Kind.STRING_SUBSTR;
          assert (argTerms.length >= 2);
          // decrease stat index by 1 since smt is 0 based, whereas SQL is 1 based
          Term sub = solver.mkNullableLift(Kind.SUB, new Term[]{argTerms[1], solver.mkNullableSome(one)});
          argTerms[1] = solver.simplify(sub);
          if (argTerms.length == 3)
          {
            // SELECT SUBSTRING('abcdef' from 2 for 3) = bcd
            break;
          }

          // SELECT SUBSTRING('abcdef' from 2) = bcdef
          Term[] arguments = new Term[3];
          arguments[0] = argTerms[0];
          arguments[1] = argTerms[1];
          Term stringTerm = argTerms[0];
          arguments[2] = solver.simplify(solver.mkNullableLift(Kind.STRING_LENGTH, new Term[]{stringTerm}));
          argTerms = arguments;
          break;
        }
        case "||": k = Kind.STRING_CONCAT; break;
        case "CASE":
          k = Kind.ITE;
          {
            Term isSome = solver.mkNullableIsSome(argTerms[0]);
            Term val = solver.mkNullableVal(argTerms[0]);
            argTerms[0] = isSome.andTerm(val);
            return solver.mkTerm(k, argTerms);
          }
        case "IS TRUE":
        {
          Term isSome = solver.mkNullableIsSome(argTerms[0]);
          Term val = solver.mkNullableVal(argTerms[0]);
          Term andNode = isSome.andTerm(val);
          return solver.mkNullableSome(andNode);
        }
        case "IS NOT TRUE":
        {
          Term isSome = solver.mkNullableIsSome(argTerms[0]);
          Term val = solver.mkNullableVal(argTerms[0]);
          Term notVal = val.notTerm();
          Term andNode = isSome.andTerm(notVal);
          return solver.mkNullableSome(andNode);
        }
        case "IS NULL":
        {
          argTerms = getArgTerms(constructor, t, call);
          Term isNull = solver.mkNullableIsNull(argTerms[0]);
          return solver.mkNullableSome(isNull);
        }
        case "IS NOT NULL":
        {
          argTerms = getArgTerms(constructor, t, call);
          Term isSome = solver.mkNullableIsSome(argTerms[0]);
          return solver.mkNullableSome(isSome);
        }
        default:
        {
          println(call);
          k = Kind.UNDEFINED_KIND;
          System.exit(1);
        }
      }
      return solver.mkNullableLift(k, argTerms);
    }
    else
    {
      throw new RuntimeException(expr.toString());
    }
  }

  private void swap(Term[] argTerms, int i, int j)
  {
    Term temp = argTerms[i];
    argTerms[i] = argTerms[j];
    argTerms[j] = temp;
  }

  protected Term[] getArgTerms(DatatypeConstructor constructor, Term t, RexCall call)
  {
    List<RexNode> operands = call.getOperands();
    Term[] argTerms = new Term[operands.size()];
    for (int i = 0; i < operands.size(); i++)
    {
      argTerms[i] = translateRowExpr(operands.get(i), constructor, t, call.op.toString());
    }
    return argTerms;
  }

  protected Term translate(RexNode expr)
  {
    RexLiteral literal = (RexLiteral) expr;
    String typeString = literal.getType().toString();
    if (typeString.equals("INTEGER") || typeString.equals("BIGINT"))
    {
      if (literal.getValue() == null)
      {
        return solver.mkNullableNull(solver.mkNullableSort(solver.getIntegerSort()));
      }
      int integer = RexLiteral.intValue(literal);
      Term ret = solver.mkInteger(integer);
      return solver.mkNullableSome(ret);      
    }
    if (typeString.contains("VARCHAR") || typeString.contains("CHAR"))
    {
      if (literal.getValue() == null)
      {
        return solver.mkNullableNull(solver.mkNullableSort(solver.getStringSort()));
      }
      String string = RexLiteral.stringValue(literal);
      Term ret = solver.mkString(string);
      return solver.mkNullableSome(ret);
    }
    if (typeString.equals("BOOLEAN"))
    {
      if (literal.getValue() == null)
      {
        return solver.mkNullableNull(solver.mkNullableSort(solver.getBooleanSort()));
      }
      boolean value = RexLiteral.booleanValue(literal);
      Term ret = solver.mkBoolean(value);
      return ret = solver.mkNullableSome(ret);
    }
    else
    {
      throw new RuntimeException(literal.toString());
    }
  }

  protected Term translate(EnumerableTableScan table)
  {
    if (tables.containsKey(table))
    {
      return tables.get(table);
    }
    String tableName = getTableName(table);
    Sort tupleSort = getSort(table.getRowType());
    Sort tableSort = mkTableSort(tupleSort);
    Term cvc5Table = solver.mkConst(tableSort, tableName);
    tables.put(table, cvc5Table);
    return cvc5Table;
  }

  private String getTableName(EnumerableTableScan table)
  {
    String tableName = String.join("_", table.getTable().getQualifiedName());
    return tableName;
  }

  protected abstract Sort mkTableSort(Sort tupleSort);

  protected Sort getSort(RelDataType relDataType)
  {
    if (relDataType.getFieldList() != null)
    {
      List<Sort> columnSorts = new ArrayList<>();
      for (RelDataTypeField type : relDataType.getFieldList())
      {
        columnSorts.add(getFieldSort(type.getType()));
      }
      Sort tupleSort = solver.mkTupleSort(columnSorts.toArray(new Sort[0]));
      return tupleSort;
    }
    return getFieldSort(relDataType);
  }

  protected Sort getFieldSort(RelDataType type)
  {
    if (type instanceof RelDataTypeFactoryImpl.JavaType)
    {
      RelDataTypeFactoryImpl.JavaType javaType = (RelDataTypeFactoryImpl.JavaType) type;
      if (javaType.getJavaClass() == java.lang.Integer.class)
      {
        Sort sort = getIntFieldSort();
        return sort;
      }
      else if (javaType.getJavaClass() == java.lang.String.class)
      {
        Sort sort = getStringFieldSort();
        return sort;
      }
      else
      {
        throw new RuntimeException("Unsupported sql type: " + type);
      }
    }
    else if (type instanceof BasicSqlType)
    {
      BasicSqlType basicSqlType = (BasicSqlType) type;
      String typeString = basicSqlType.getSqlTypeName().toString();
      if (typeString.equals("INTEGER") || typeString.equals("BIGINT"))
      {
        Sort sort = getIntFieldSort();
        return sort;
      }
      else if (typeString.contains("VARCHAR") || typeString.contains("CHAR"))
      {
        Sort sort = getStringFieldSort();
        return sort;
      }
      else if (typeString.equals("BOOLEAN"))
      {
        Sort sort = getBooleanFieldSort();
        return sort;
      }
      else
      {
        print("Unsupported sql type: " + type);
        System.exit(1);
        throw new RuntimeException("Unsupported sql type: " + type);
      }
    }
    else
    {
      throw new RuntimeException("Unsupported sql type: " + type);
    }
  }

  private Sort getIntFieldSort()
  {
    Sort sort = solver.getIntegerSort();
    sort = solver.mkNullableSort(sort);
    return sort;
  }
  private Sort getStringFieldSort()
  {
    Sort sort = solver.getStringSort();
    sort = solver.mkNullableSort(sort);
    return sort;
  }
  private Sort getBooleanFieldSort()
  {
    Sort sort = solver.getBooleanSort();
    sort = solver.mkNullableSort(sort);
    return sort;
  }
}
