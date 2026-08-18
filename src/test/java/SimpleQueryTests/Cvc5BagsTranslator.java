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

  @Override
  protected Term mkSingleton(Term smtTuple)
  {
    return tm.mkTerm(Kind.BAG_MAKE, smtTuple, one);
  }

  @Override
  protected Term mkDistinct(Term table)
  {
    return tm.mkTerm(Kind.BAG_SETOF, table);
  }

  @Override
  protected Term translate(LogicalMinus minus) throws CVC5ApiException
  {
    List<RelNode> inputs = minus.getInputs();
    Kind k = minus.all ? Kind.BAG_DIFFERENCE_SUBTRACT : Kind.BAG_DIFFERENCE_REMOVE;
    Term result = translate(inputs.get(0));
    for (int i = 1; i < inputs.size(); i++)
    {
      result = tm.mkTerm(k, result, translate(inputs.get(i)));
    }
    // EXCEPT (without ALL) returns distinct rows
    return minus.all ? result : mkDistinct(result);
  }

  @Override
  protected Term translate(LogicalUnion n) throws CVC5ApiException
  {
    List<RelNode> inputs = n.getInputs();
    Term result = translate(inputs.get(0));
    for (int i = 1; i < inputs.size(); i++)
    {
      result = tm.mkTerm(Kind.BAG_UNION_DISJOINT, result, translate(inputs.get(i)));
    }
    // UNION (without ALL) returns distinct rows
    return n.all ? result : mkDistinct(result);
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
