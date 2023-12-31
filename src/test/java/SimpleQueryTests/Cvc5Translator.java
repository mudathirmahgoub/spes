package SimpleQueryTests;
import com.google.common.collect.ImmutableList;
import io.github.cvc5.*;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import org.apache.calcite.adapter.enumerable.EnumerableTableScan;
import org.apache.calcite.plan.RelOptQuery;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.core.AggregateCall;
import org.apache.calcite.rel.logical.LogicalAggregate;
import org.apache.calcite.rel.logical.LogicalProject;
import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeFactoryImpl;
import org.apache.calcite.rel.type.RelDataTypeField;
import org.apache.calcite.rel.type.RelDataTypeFieldImpl;
import org.apache.calcite.rex.RexInputRef;
import org.apache.calcite.rex.RexNode;
import org.apache.calcite.util.ImmutableBitSet;

public class Cvc5Translator
{
  public static HashMap<EnumerableTableScan, Term> tables = new HashMap<>();
  private static Solver solver = new Solver();
  public static void translate(RelNode n, String sql) throws CVC5ApiException
  {
    System.out.println("Translating sql query: " + sql);
    translate(n);
  }
  public static Term translate(RelNode n) throws CVC5ApiException
  {
    System.out.println(n.getClass());
    if (n instanceof EnumerableTableScan)
    {
      System.out.print("EnumerableTableSca: " + n);
      Term ret = translateTable((EnumerableTableScan) n);
      return ret;
    }
    if (n instanceof LogicalAggregate)
    {
      LogicalAggregate aggregate = (LogicalAggregate) n;
      List<AggregateCall> aggregateCalls = aggregate.getAggCallList();
      List<RexNode> rowNodes = aggregate.getChildExps();
      ImmutableList<ImmutableBitSet> bitSets = aggregate.getGroupSets();
      ImmutableBitSet bitSet = aggregate.getGroupSet();
      return translate(aggregate.getInput());
    }
    if (n instanceof LogicalProject)
    {
      LogicalProject project = (LogicalProject) n;
      // check whether to use table.project or bag.map
      boolean isTableProject = true;
      List<RexNode> exprs = project.getChildExps();
      int[] indices = new int[exprs.size()];
      int i = 0;
      for (RexNode expr : exprs)
      {
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
        Op op = solver.mkOp(Kind.TABLE_PROJECT, indices);
        Term ret = solver.mkTerm(op, child);
        return ret;
      }
      else
      {
        
      }
      List<RexNode> rowNodes = project.getChildExps();
      RelOptQuery query = project.getQuery();
      translate(project.getInput());
    }
    return null;
  }

  private static Term translateTable(EnumerableTableScan table)
  {
    if (tables.containsKey(table))
    {
      return tables.get(table);
    }
    String tableName = String.join("_", table.getTable().getQualifiedName());
    Sort tableSort = getSort(table.getRowType());
    Term cvc5Table = solver.mkConst(tableSort, tableName);
    tables.put(table, cvc5Table);
    return cvc5Table;
  }

  private static Sort getSort(RelDataType rowType)
  {
    List<Sort> columnSorts = new ArrayList<>();
    for (RelDataTypeField type : rowType.getFieldList())
    {
      if (type.getType() instanceof RelDataTypeFactoryImpl.JavaType)
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
      else
      {
        throw new RuntimeException("Unsupported sql type: " + type);
      }
    }
    Sort tupleSort = solver.mkTupleSort(columnSorts.toArray(new Sort[0]));
    Sort tableSort = solver.mkBagSort(tupleSort);
    return tableSort;
  }

  public static void reset()
  {
    tables.clear();
    Context.deletePointers();
    solver = new Solver();
  }
}