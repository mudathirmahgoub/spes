package SimpleQueryTests;
import com.google.common.collect.ImmutableList;
import io.github.cvc5.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.calcite.adapter.enumerable.EnumerableTableScan;
import org.apache.calcite.rel.RelNode;
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

public class Cvc5SetsTranslator
{
  public static HashMap<EnumerableTableScan, Term> tables = new HashMap<>();
  public static HashMap<String, Term> definedFunctions = new HashMap<>();
  private static Solver solver;
  private static int functionIndex = 0;
  private static PrintWriter writer = null;
  private static Term zero;
  private static Term one;

  static
  {
    try
    {
      writer = new PrintWriter(new File("output.smt2"));
    }
    catch (FileNotFoundException e)
    {
      System.exit(-1);
    }
  }

  public static void reset() throws CVC5ApiException
  {
    tables.clear();
    definedFunctions.clear();
    functionIndex = 0;
    Context.deletePointers();
    solver = new Solver();
    solver.setLogic("HO_ALL");
    solver.setOption("produce-models", "true");
    solver.setOption("debug-check-models", "true");
    solver.setOption("dag-thresh", "0");
    solver.setOption("uf-lazy-ll", "true");
    solver.setOption("fmf-bound", "true");
    solver.setOption("tlimit-per", "6000");
    zero = solver.mkInteger(0);
    one = solver.mkInteger(1);
  }

  public static Result translate(String name, RelNode n1, String sql1, RelNode n2, String sql2)
      throws CVC5ApiException
  {
    reset();
    println(";-----------------------------------------------------------");
    println("; test name: " + name);
    Term q1 = translate(n1, sql1);
    Term q2 = translate(n2, sql2);
    solver.assertFormula(q1.eqTerm(q2).notTerm());
    printSmtProblem();
    Result result = solver.checkSat();
    println(";answer: " + result);
    if (result.isSat())
    {
      println("(get-model)");
      Term[] terms = tables.values().toArray(new Term[0]);
      println(solver.getModel(new Sort[0], terms));
    }
    return result;
  }

  private static void println(Object object)
  {
    writer.println(object);
    System.out.println(object);
    writer.flush();
  }
  private static void print(Object object)
  {
    writer.print(object);
    System.out.print(object);
    writer.flush();
  }

  private static void printSmtProblem()
  {
    println("(set-logic HO_ALL)\r\n" + //
        "(set-option :fmf-bound true)\r\n" + //
        "(set-option :uf-lazy-ll true)\r\n" + //
        "(set-option :strings-exp true)");

    Term[] terms = tables.values().toArray(new Term[0]);
    for (Term term : terms)
    {
      print("(declare-const ");
      print(term + " ");
      println(term.getSort() + ")");
    }
    for (Map.Entry<String, Term> entry : definedFunctions.entrySet())
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

  public static Term translate(RelNode n, String sql) throws CVC5ApiException
  {
    println(";Translating sql query: " + sql);
    return translate(n);
  }
  public static Term translate(RelNode n) throws CVC5ApiException
  {
    if (n instanceof EnumerableTableScan)
    {
      Term ret = translateTable((EnumerableTableScan) n);
      return ret;
    }
    if (n instanceof LogicalAggregate)
    {
      LogicalAggregate aggregate = (LogicalAggregate) n;
      if (aggregate.getAggCallList().isEmpty())
      {
        // it is similar to duplicate removal of a projection
        Term child = translate(aggregate.getInput());
        ImmutableBitSet bitSet = aggregate.getGroupSet();
        // ((_ table.project indices) child)
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
        Op op = solver.mkOp(Kind.RELATION_PROJECT, indices);
        Term ret = solver.mkTerm(op, child);
        return ret;
      }
      return null;
      // LogicalAggregate aggregate = (LogicalAggregate) n;
      // List<AggregateCall> aggregateCalls = aggregate.getAggCallList();
      // List<RexNode> rowNodes = aggregate.getChildExps();
      // ImmutableList<ImmutableBitSet> bitSets = aggregate.getGroupSets();
      // ImmutableBitSet bitSet = aggregate.getGroupSet();
      // return translate(aggregate.getInput());
    }
    if (n instanceof LogicalProject)
    {
      return translateProject((LogicalProject) n);
    }
    if (n instanceof LogicalFilter)
    {
      return translateFilter((LogicalFilter) n);
    }
    if (n instanceof LogicalJoin)
    {
      return translateJoin((LogicalJoin) n);
    }
    if (n instanceof LogicalUnion)
    {
      List<RelNode> inputs = n.getInputs();
      Kind k = Kind.SET_UNION;
      Term result = translate(inputs.get(0));
      result = solver.mkTerm(k, result, translate(inputs.get(1)));
      for (int i = 2; i < inputs.size(); i++)
      {
        result = solver.mkTerm(k, result, translate(inputs.get(i)));
      }
      return result;
    }
    if (n instanceof LogicalMinus)
    {
      LogicalMinus minus = (LogicalMinus) n;
      Term a = translate(minus.getInput(0));
      Term b = translate(minus.getInput(1));
      Term difference = solver.mkTerm(Kind.SET_MINUS, a, b);
      return difference;
    }
    if (n instanceof LogicalIntersect)
    {
      LogicalIntersect intersect = (LogicalIntersect) n;
      Term a = translate(intersect.getInput(0));
      Term b = translate(intersect.getInput(1));
      Term difference = solver.mkTerm(Kind.SET_INTER, a, b);
      return difference;
    }
    if (n instanceof LogicalValues)
    {
      return translate((LogicalValues) n);
    }
    return null;
  }

  private static Term translate(LogicalValues values)
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
      Term singleton = solver.mkTerm(Kind.SET_SINGLETON, smtTuple);
      smtTuples[i] = singleton;
    }
    if (smtTuples.length == 0)
    {
      Sort sort = getSort(values.getRowType());
      Term empty = solver.mkEmptySet(sort);
      return empty;
    }
    if (smtTuples.length == 1)
    {
      return smtTuples[0];
    }
    Term union = smtTuples[0];
    for (int i = 1; i < smtTuples.length; i++)
    {
      union = solver.mkTerm(Kind.SET_UNION, union, smtTuples[i]);
    }
    return union;
  }
  private static Term translateJoin(LogicalJoin n) throws CVC5ApiException
  {
    Term left = translate(n.getLeft());
    Term right = translate(n.getRight());
    Term product = solver.mkTerm(Kind.RELATION_PRODUCT, left, right);
    if (!n.getCondition().isAlwaysTrue())
    {
      product = applyFilter(n.getCondition(), product);
    }
    switch (n.getJoinType())
    {
      case INNER: return product;
      default: throw new RuntimeException(n.toString());
    }
  }
  private static Term translateFilter(LogicalFilter n) throws CVC5ApiException
  {
    // (set.filter (lambda (t (Tuple ...) ) ... ) input)
    Term child = translate(n.getInput());
    return applyFilter(n.getCondition(), child);
  }

  private static Term applyFilter(RexNode condition, Term table)
  {
    Sort tupleSort = table.getSort().getSetElementSort();
    Datatype datatype = tupleSort.getDatatype();
    DatatypeConstructor constructor = datatype.getConstructor(0);
    Term t = solver.mkVar(tupleSort, "t");
    Sort functionType = solver.getBooleanSort();
    Term body = translateRowExpr(condition, constructor, t);
    Term p = defineFun(t, functionType, body, "p");
    Term ret = solver.mkTerm(Kind.SET_FILTER, p, table);
    return ret;
  }

  private static Term defineFun(Term t, Sort functionType, Term body, String prefix)
  {
    String name = prefix + functionIndex;
    Term f = solver.defineFun(name, new Term[] {t}, functionType, body, true);
    functionIndex++;
    definedFunctions.put(name, f);
    return f;
  }
  private static Term translateProject(LogicalProject project) throws CVC5ApiException
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
      Op op = solver.mkOp(Kind.RELATION_PROJECT, indices);
      Term ret = solver.mkTerm(op, child);
      return ret;
    }
    else
    {
      // (set.map (lambda (t (Tuple ...) ) ... ) input)
      Sort argType = child.getSort().getSetElementSort();
      Term t = solver.mkVar(argType, "t");
      Sort functionType = getSort(project.getRowType());

      Datatype datatype = t.getSort().getDatatype();
      DatatypeConstructor constructor = datatype.getConstructor(0);
      Term[] terms = new Term[exprs.size()];
      for (int i = 0; i < terms.length; i++)
      {
        terms[i] = translateRowExpr(exprs.get(i), constructor, t);
      }
      Term body = solver.mkTuple(terms);
      Term f = defineFun(t, functionType, body, "f");
      Term ret = solver.mkTerm(Kind.SET_MAP, f, child);
      return ret;
    }
  }

  private static Term translateRowExpr(RexNode expr, DatatypeConstructor constructor, Term t)
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
        Term ret = translateRowExpr(call.getOperands().get(0), constructor, t);
        return ret;
      }
      switch (call.op.toString())
      {
        case "=": k = Kind.EQUAL; break;
        case "+": k = Kind.ADD; break;
        case "-": k = Kind.SUB; break;
        case ">": k = Kind.GT; break;
        case "<": k = Kind.LT; break;
        case ">=": k = Kind.GEQ; break;
        case "<=": k = Kind.LEQ; break;
        case "*": k = Kind.MULT; break;
        case "/": k = Kind.DIVISION; break;
        case "AND": k = Kind.AND; break;
        case "OR": k = Kind.OR; break;
        case "NOT": k = Kind.NOT; break;
        case "UPPER": k = Kind.STRING_TO_UPPER; break;
        case "SUBSTRING":
        {
          k = Kind.STRING_SUBSTR;
          Term[] argTerms = getArgTerms(constructor, t, call);
          assert (argTerms.length >= 2);
          // decrease stat index by 1 since smt is 0 based, whereas SQL is 1 based
          argTerms[1] = solver.simplify(solver.mkTerm(Kind.SUB, argTerms[1], one));
          if (argTerms.length == 3)
          {
            // SELECT SUBSTRING('abcdef' from 2 for 3) = bcd
            return solver.mkTerm(k, argTerms);
          }

          // SELECT SUBSTRING('abcdef' from 2) = bcdef
          Term[] arguments = new Term[3];
          arguments[0] = argTerms[0];
          arguments[1] = argTerms[1];
          arguments[2] = solver.simplify(solver.mkTerm(Kind.STRING_LENGTH, argTerms[0]));

          return solver.mkTerm(k, arguments);
        }
        case "||": k = Kind.STRING_CONCAT; break;
        case "CASE": k = Kind.ITE; break;
        default:
        {
          println(call);
          k = Kind.UNDEFINED_KIND;
          System.exit(0);
        }
      }
      Term[] argTerms = getArgTerms(constructor, t, call);
      return solver.mkTerm(k, argTerms);
    }
    else
    {
      throw new RuntimeException(expr.toString());
    }
  }

  private static Term[] getArgTerms(DatatypeConstructor constructor, Term t, RexCall call)
  {
    List<RexNode> operands = call.getOperands();
    Term[] argTerms = new Term[operands.size()];
    for (int i = 0; i < operands.size(); i++)
    {
      argTerms[i] = translateRowExpr(operands.get(i), constructor, t);
    }
    return argTerms;
  }

  private static Term translate(RexNode expr)
  {
    RexLiteral literal = (RexLiteral) expr;
    String typeString = literal.getType().toString();
    if (typeString.equals("INTEGER"))
    {
      int integer = RexLiteral.intValue(literal);
      return solver.mkInteger(integer);
    }
    if (typeString.contains("VARCHAR") || typeString.contains("CHAR"))
    {
      String string = RexLiteral.stringValue(literal);
      return solver.mkString(string);
    }
    if (typeString.equals("BOOLEAN"))
    {
      boolean value = RexLiteral.booleanValue(literal);
      return solver.mkBoolean(value);
    }
    else
    {
      throw new RuntimeException(literal.toString());
    }
  }

  private static Term translateTable(EnumerableTableScan table)
  {
    if (tables.containsKey(table))
    {
      return tables.get(table);
    }
    String tableName = String.join("_", table.getTable().getQualifiedName());
    Sort tupleSort = getSort(table.getRowType());
    Sort tableSort = solver.mkSetSort(tupleSort);
    Term cvc5Table = solver.mkConst(tableSort, tableName);
    tables.put(table, cvc5Table);
    return cvc5Table;
  }

  private static Sort getSort(RelDataType rowType)
  {
    List<Sort> columnSorts = new ArrayList<>();
    for (RelDataTypeField type : rowType.getFieldList())
    {
      RelDataType relDataType = type.getType();
      if (relDataType instanceof RelDataTypeFactoryImpl.JavaType)
      {
        RelDataTypeFactoryImpl.JavaType javaType = (RelDataTypeFactoryImpl.JavaType) type.getType();
        if (javaType.getJavaClass() == java.lang.Integer.class)
        {
          columnSorts.add(solver.getIntegerSort());
        }
        else if (javaType.getJavaClass() == java.lang.String.class)
        {
          columnSorts.add(solver.getStringSort());
        }
        else
        {
          throw new RuntimeException("Unsupported sql type: " + type);
        }
      }
      else if (relDataType instanceof BasicSqlType)
      {
        BasicSqlType basicSqlType = (BasicSqlType) relDataType;
        String typeString = basicSqlType.getSqlTypeName().toString();
        if (typeString.equals("INTEGER"))
        {
          columnSorts.add(solver.getIntegerSort());
        }
        else if (typeString.contains("VARCHAR") || typeString.contains("CHAR"))
        {
          columnSorts.add(solver.getStringSort());
        }
        else if (typeString.equals("BOOLEAN"))
        {
          columnSorts.add(solver.getBooleanSort());
        }
        else
        {
          print("Unsupported sql type: " + type);
          System.exit(0);
          throw new RuntimeException("Unsupported sql type: " + type);
        }
      }
      else
      {
        throw new RuntimeException("Unsupported sql type: " + type);
      }
    }
    Sort tupleSort = solver.mkTupleSort(columnSorts.toArray(new Sort[0]));
    return tupleSort;
  }
}
