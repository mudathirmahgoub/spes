package SimpleQueryTests;
import io.github.cvc5.*;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.logical.LogicalMinus;
import org.apache.calcite.rel.logical.LogicalUnion;

public class Cvc5BagsTranslator extends Cvc5AbstractTranslator
{
  public Cvc5BagsTranslator(boolean isNullable, PrintWriter writer)
  {
    super(isNullable, writer);
  }

  @Override
  protected boolean isSetSemantics()
  {
    return false;
  }

  @Override
  protected Sort getElementSort(Sort sort)
  {
    return sort.getBagElementSort();
  }

  @Override
  protected Kind getProjectKind()
  {
    return Kind.TABLE_PROJECT;
  }

  @Override
  protected Kind getGroupKind()
  {
    return Kind.TABLE_GROUP;
  }

  @Override
  protected Kind getRelationMinKind()
  {
    return Kind.RELATION_MIN;
  }

  @Override
  protected Kind getRelationMaxKind()
  {
    return Kind.RELATION_MAX;
  }

  @Override
  protected Kind getIntersectionKind()
  {
    return Kind.BAG_INTER_MIN;
  }

  @Override
  protected Kind getProductKind()
  {
    return Kind.TABLE_PRODUCT;
  }

  @Override
  protected Kind getFilterKind()
  {
    return Kind.BAG_FILTER;
  }

  @Override
  protected Kind getMapKind()
  {
    return Kind.BAG_MAP;
  }

  @Override
  protected Kind getUnionAllKind()
  {
    return Kind.BAG_UNION_DISJOINT;
  }

  @Override
  protected Kind getDifferenceRemoveKind()
  {
    return Kind.BAG_DIFFERENCE_REMOVE;
  }

  @Override
  protected Kind getAggregateKind()
  {
    return Kind.TABLE_AGGREGATE;
  }

  @Override
  protected Kind getEmptyKind()
  {
    return Kind.BAG_EMPTY;
  }
  @Override
  protected Sort mkTableSort(Sort tupleSort)
  {
    return tm.mkBagSort(tupleSort);
  }

  @Override
  protected Term mkEmptyTable(Sort sort)
  {
    return tm.mkEmptyBag(sort);
  }

  protected Term mkSingleton(Term smtTuple)
  {
    return tm.mkTerm(Kind.BAG_MAKE, smtTuple, one);
  }

  @Override
  protected Term translate(LogicalMinus minus) throws CVC5ApiException
  {
    Term a = translate(minus.getInput(0));
    Term b = translate(minus.getInput(1));
    Term difference = minus.all ? tm.mkTerm(Kind.BAG_DIFFERENCE_SUBTRACT, a, b)
                                : tm.mkTerm(Kind.BAG_DIFFERENCE_REMOVE, a, b);
    return difference;
  }

  @Override
  public Term translate(LogicalUnion n) throws CVC5ApiException
  {
    List<RelNode> inputs = n.getInputs();
    Kind k = n.all ? Kind.BAG_UNION_DISJOINT : Kind.BAG_UNION_MAX;
    Term result = translate(inputs.get(0));
    result = tm.mkTerm(k, result, translate(inputs.get(1)));
    for (int i = 2; i < inputs.size(); i++)
    {
      result = tm.mkTerm(k, result, translate(inputs.get(i)));
    }
    return result;
  }

  @Override
  protected List<List<Object>> getTableRows(Term tableValue) throws CVC5ApiException
  {
    List<List<Object>> rows = new ArrayList<>();
    Kind k = tableValue.getKind();
    if (k == getEmptyKind())
    {
      return rows;
    }
    if (k == Kind.BAG_MAKE)
    {
      List<Object> tupleValues = getTupleValues(tableValue.getChild(0));
      int multiplicity = tableValue.getChild(1).getIntegerValue().intValue();
      for (int i = 0; i < multiplicity; i++)
      {
        rows.add(tupleValues);
      }
      return rows;
    }
    if (k == Kind.BAG_UNION_DISJOINT)
    {
      rows.addAll(getTableRows(tableValue.getChild(0)));
      rows.addAll(getTableRows(tableValue.getChild(1)));
      return rows;
    }
    throw new RuntimeException("Unsupported kind in term: " + tableValue);
  }
}
