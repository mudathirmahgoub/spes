package SimpleQueryTests;
import io.github.cvc5.*;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.logical.LogicalMinus;
import org.apache.calcite.rel.logical.LogicalUnion;

/**
 * Encodes SQL under set semantics, where a table is a cvc5 {@code Set} of tuples and a row is
 * either present or absent.
 *
 * <p>This is deliberately an approximation of SQL: {@code UNION ALL}, {@code EXCEPT ALL} and
 * {@code INTERSECT ALL} collapse onto the plain set operators, so multiplicities are lost and
 * two queries differing only in duplicates are reported equivalent. In exchange the encoding
 * is much easier for the solver, which in practice proves considerably more benchmarks than
 * the bag encoding does. Use it when duplicates are known not to matter.
 *
 * <p>Because sets carry no duplicates, {@link #mkDistinct} is the identity here.
 *
 * @see Cvc5BagsTranslator for the faithful, and default, encoding
 */
public class Cvc5SetsTranslator extends Cvc5AbstractTranslator
{
  public Cvc5SetsTranslator(boolean isNullable, PrintWriter writer)
  {
    super(isNullable, writer);
  }

  @Override
  protected Sort getElementSort(Sort sort)
  {
    return sort.getSetElementSort();
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
  protected Kind getDifferenceRemoveKind()
  {
    return Kind.SET_MINUS;
  }

  @Override
  protected Kind getAggregateKind()
  {
    return Kind.RELATION_AGGREGATE;
  }

  @Override
  protected Kind getEmptyKind()
  {
    return Kind.SET_EMPTY;
  }

  @Override
  protected Sort mkTableSort(Sort tupleSort)
  {
    return tm.mkSetSort(tupleSort);
  }

  @Override
  protected Term mkEmptyTable(Sort sort)
  {
    return tm.mkEmptySet(sort);
  }

  @Override
  protected Term mkSingleton(Term smtTuple)
  {
    return tm.mkTerm(Kind.SET_SINGLETON, smtTuple);
  }

  /** Sets carry no duplicates, so duplicate removal is the identity here. */
  @Override
  protected Term mkDistinct(Term table)
  {
    return table;
  }

  @Override
  protected Term translate(LogicalMinus minus) throws CVC5ApiException
  {
    Term a = translate(minus.getInput(0));
    Term b = translate(minus.getInput(1));
    Term difference = tm.mkTerm(Kind.SET_MINUS, a, b);
    return difference;
  }

  @Override
  protected Term translate(LogicalUnion n) throws CVC5ApiException
  {
    List<RelNode> inputs = n.getInputs();
    Kind k = Kind.SET_UNION;
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
    if (k == Kind.SET_SINGLETON)
    {
      List<Object> tupleValues = getTupleValues(tableValue.getChild(0));
      rows.add(tupleValues);
      return rows;
    }
    if (k == Kind.SET_UNION)
    {
      rows.addAll(getTableRows(tableValue.getChild(0)));
      rows.addAll(getTableRows(tableValue.getChild(1)));
      return rows;
    }
    throw new RuntimeException("Unsupported kind in term: " + tableValue);
  }
}
