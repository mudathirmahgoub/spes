package SimpleQueryTests;
import io.github.cvc5.*;
import java.io.PrintWriter;
import java.util.List;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.logical.LogicalMinus;
import org.apache.calcite.rel.logical.LogicalUnion;

public class Cvc5SetsTranslator extends Cvc5AbstractTranslator
{
  public Cvc5SetsTranslator(boolean isNullable, PrintWriter writer)
  {
    super(isNullable, writer);
  }

  @Override
  protected boolean isSetSemantics()
  {
    return true;
  }

  @Override
  protected Kind getProjectKind()
  {
    return Kind.RELATION_PROJECT;
  }

  @Override
  protected Kind getIntersectionKind()
  {
    return Kind.SET_INTER;
  }

  @Override
  protected Kind getProductKind()
  {
    return Kind.RELATION_PRODUCT;
  }

  @Override
  protected Kind getFilterKind()
  {
    return Kind.SET_FILTER;
  }

  @Override
  protected Kind getMapKind()
  {
    return Kind.SET_MAP;
  }

  @Override
  protected Kind getUnionAllKind()
  {
    return Kind.SET_UNION;
  }

  @Override
  protected Sort mkTableSort(Sort tupleSort)
  {
    return solver.mkSetSort(tupleSort);
  }

  @Override
  protected Term mkEmptyTable(Sort sort)
  {
    return solver.mkEmptySet(sort);
  }

  protected Term mkSingleton(Term smtTuple)
  {
    return solver.mkTerm(Kind.SET_SINGLETON, smtTuple);
  }

  @Override
  protected Term translate(LogicalMinus minus) throws CVC5ApiException
  {
    Term a = translate(minus.getInput(0));
    Term b = translate(minus.getInput(1));
    Term difference = solver.mkTerm(Kind.SET_MINUS, a, b);
    return difference;
  }

  @Override
  public Term translate(LogicalUnion n) throws CVC5ApiException
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
}
