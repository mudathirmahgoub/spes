package SimpleQueryTests;
import io.github.cvc5.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.calcite.adapter.enumerable.EnumerableTableScan;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.logical.LogicalAggregate;
import org.apache.calcite.rel.logical.LogicalFilter;
import org.apache.calcite.rel.logical.LogicalJoin;
import org.apache.calcite.rel.logical.LogicalProject;
import org.apache.calcite.rel.logical.LogicalUnion;
import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeFactoryImpl;
import org.apache.calcite.rel.type.RelDataTypeField;
import org.apache.calcite.rex.RexCall;
import org.apache.calcite.rex.RexInputRef;
import org.apache.calcite.rex.RexLiteral;
import org.apache.calcite.rex.RexNode;
import org.apache.calcite.sql.type.BasicSqlType;

public class Cvc5Translator
{
  public static HashMap<EnumerableTableScan, Term> tables = new HashMap<>();
  public static HashMap<String, Term> definedFunctions = new HashMap<>();
  private static Solver solver;
  private static int functionIndex = 0;

  public static Result translate(RelNode n1, String sql1, RelNode n2, String sql2)
      throws CVC5ApiException
  {
    Cvc5Translator.reset();
    System.out.println();
    Term q1 = Cvc5Translator.translate(n1, sql1);
    Term q2 = Cvc5Translator.translate(n2, sql2);
    solver.assertFormula(q1.eqTerm(q2).notTerm());
    printSmtProblem();
    Result result = solver.checkSat();
    System.out.println("answer: " + result);
    if (result.isSat())
    {
      Term[] terms = tables.values().toArray(new Term[0]);
      System.out.println(solver.getModel(new Sort[0], terms));
    }
    return result;
  }

  private static void printSmtProblem()
  {
    System.out.println("(set-logic HO_ALL)\r\n" + //        
        "(set-option :fmf-bound true)\r\n" + //
        "(set-option :uf-lazy-ll true)\r\n" + //
        "(set-option :strings-exp true)");

    Term[] terms = tables.values().toArray(new Term[0]);
    for (Term term : terms)
    {
      System.out.print("(declare-const ");
      System.out.print(term + " ");
      System.out.println(term.getSort() + ")");
    }
    for (Map.Entry<String, Term> entry : definedFunctions.entrySet())
    {
      System.out.print("(declare-const ");
      System.out.print(entry.getKey() + " ");
      System.out.println(entry.getValue().getSort() + ")");
    }
    for (Term term : solver.getAssertions())
    {
      System.out.print("(assert ");
      System.out.print(term);
      System.out.println(")");
    }
    System.out.println("(check-sat)");
  }

  public static Term translate(RelNode n, String sql) throws CVC5ApiException
  {
    System.out.println("Translating sql query: " + sql);
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
      LogicalUnion union = (LogicalUnion) n;
      List<RelNode> inputs = n.getInputs();
      Kind k = union.all ? Kind.BAG_UNION_DISJOINT : Kind.BAG_UNION_MAX;
      Term result = translate(inputs.get(0));
      result = solver.mkTerm(k, result, translate(inputs.get(1)));
      for (int i = 2; i < inputs.size(); i++)
      {
        result = solver.mkTerm(k, result, translate(inputs.get(i)));
      }
      return result;
    }
    return null;
  }
  private static Term translateJoin(LogicalJoin n) throws CVC5ApiException
  {
    Term left = translate(n.getLeft());
    Term right = translate(n.getRight());
    Term product = solver.mkTerm(Kind.TABLE_PRODUCT, left, right);
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
    // (bag.filter (lambda (t (Tuple ...) ) ... ) input)
    Term child = translate(n.getInput());
    return applyFilter(n.getCondition(), child);
  }

  private static Term applyFilter(RexNode condition, Term table)
  {
    Sort tupleSort = table.getSort().getBagElementSort();
    Datatype datatype = tupleSort.getDatatype();
    DatatypeConstructor constructor = datatype.getConstructor(0);
    Term t = solver.mkVar(tupleSort, "t");
    Sort functionType = solver.getBooleanSort();
    Term body = translateRowExpr(condition, constructor, t);
    Term p = defineFun(t, functionType, body, "p");
    Term ret = solver.mkTerm(Kind.BAG_FILTER, p, table);
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
    // check whether to use table.project or bag.map
    boolean isTableProject = true;
    List<RexNode> exprs = project.getChildExps();
    int[] indices = new int[exprs.size()];
    for (int i = 0; i < exprs.size(); i++)
    {
      RexNode expr = exprs.get(i);
      if (exprs instanceof RexInputRef)
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
      Op op = solver.mkOp(Kind.TABLE_PROJECT, indices);
      Term ret = solver.mkTerm(op, child);
      return ret;
    }
    else
    {
      // (bag.map (lambda (t (Tuple ...) ) ... ) input)
      Sort argType = child.getSort().getBagElementSort();
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
      Term ret = solver.mkTerm(Kind.BAG_MAP, f, child);
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
      int integer = RexLiteral.intValue(expr);
      return solver.mkInteger(integer);
    }
    else if (expr instanceof RexCall)
    {
      RexCall call = (RexCall) expr;
      Kind k;
      switch (call.op.toString())
      {
        case "=": k = Kind.EQUAL; break;
        case "+": k = Kind.ADD; break;
        case "-": k = Kind.SUB; break;
        default:
        {
          System.out.println(call);
          k = Kind.UNDEFINED_KIND;
          System.exit(0);
        }
      }
      List<RexNode> operands = call.getOperands();
      Term[] argTerms = new Term[operands.size()];
      for (int i = 0; i < operands.size(); i++)
      {
        argTerms[i] = translateRowExpr(operands.get(i), constructor, t);
      }
      return solver.mkTerm(k, argTerms);
    }
    else
    {
      throw new RuntimeException(expr.toString());
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
    Sort tableSort = solver.mkBagSort(tupleSort);
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
        if (basicSqlType.getSqlTypeName().toString().equals("INTEGER"))
        {
          columnSorts.add(solver.getIntegerSort());
        }
        else if (basicSqlType.getSqlTypeName().toString().equals("VARCHAR"))
        {
          columnSorts.add(solver.getStringSort());
        }
        else
        {
          System.out.print("Unsupported sql type: " + type);
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
    solver.setOption("tlimit", "6000");
  }
}