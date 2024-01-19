package SimpleQueryTests;
import io.github.cvc5.*;
import java.io.PrintWriter;
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
  protected Sort mkTableSort(Sort tupleSort)
  {
    return solver.mkBagSort(tupleSort);
  }

  @Override
  protected Term mkEmptyTable(Sort sort)
  {
    return solver.mkEmptyBag(sort);
  }

  protected Term mkSingleton(Term smtTuple)
  {
    return solver.mkTerm(Kind.BAG_MAKE, smtTuple, one);
  }

  @Override
  protected Term translate(LogicalMinus minus) throws CVC5ApiException
  {
    Term a = translate(minus.getInput(0));
    Term b = translate(minus.getInput(1));
    Term difference = minus.all ? solver.mkTerm(Kind.BAG_DIFFERENCE_SUBTRACT, a, b)
                                : solver.mkTerm(Kind.BAG_DIFFERENCE_REMOVE, a, b);
    return difference;
  }

  @Override
  public Term translate(LogicalUnion n) throws CVC5ApiException
  {
    List<RelNode> inputs = n.getInputs();
    Kind k = n.all ? Kind.BAG_UNION_DISJOINT : Kind.BAG_UNION_MAX;
    Term result = translate(inputs.get(0));
    result = solver.mkTerm(k, result, translate(inputs.get(1)));
    for (int i = 2; i < inputs.size(); i++)
    {
      result = solver.mkTerm(k, result, translate(inputs.get(i)));
    }
    return result;
  }
}
