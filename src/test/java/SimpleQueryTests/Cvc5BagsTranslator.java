package SimpleQueryTests;
import io.github.cvc5.*;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.logical.LogicalMinus;
import org.apache.calcite.rel.logical.LogicalUnion;

/**
 * Encodes SQL under bag (multiset) semantics, where a table is a cvc5 {@code Bag} of tuples and
 * a row's multiplicity is how many times it occurs.
 *
 * <p>This is the semantics SQL actually has, so it is the default. The mapping is mostly direct
 * -- {@code UNION ALL} is {@code bag.union_disjoint}, a projection is {@code table.project},
 * and both accumulate multiplicities the way SQL does. The one place care is needed is SQL's
 * duplicate-eliminating constructs: {@code SELECT DISTINCT} and the non-{@code ALL} set
 * operators. Those go through {@link #mkDistinct}, which caps every multiplicity at one.
 * Without it the encoding silently keeps duplicates and reports queries as equivalent when
 * they are not.
 *
 * @see Cvc5SetsTranslator for the set-semantics encoding, where duplicates never arise
 */
public class Cvc5BagsTranslator extends Cvc5AbstractTranslator
{
  /** Refuse to materialise a counterexample row more times than this. */
  private static final BigInteger MAX_MULTIPLICITY = BigInteger.valueOf(10_000);

  public Cvc5BagsTranslator(boolean isNullable, PrintWriter writer)
  {
    super(isNullable, writer);
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

  /** {@code bag.setof}: caps every multiplicity at one. */
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

  /**
   * Expands a bag value from a cvc5 model into the rows of a counterexample table.
   *
   * <p>Model values are always built from {@code bag.empty}, {@code bag} (a single row with a
   * multiplicity) and {@code bag.union_disjoint}, so those are the only three shapes handled;
   * anything else means the term was not a value and is a bug rather than a limitation.
   */
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
      BigInteger multiplicity = tableValue.getChild(1).getIntegerValue();
      if (multiplicity.signum() <= 0)
      {
        return rows;
      }
      if (multiplicity.compareTo(MAX_MULTIPLICITY) > 0)
      {
        throw new RuntimeException(
            "refusing to materialise " + multiplicity + " copies of a row in " + tableValue);
      }
      List<Object> tupleValues = getTupleValues(tableValue.getChild(0));
      for (int i = 0; i < multiplicity.intValue(); i++)
      {
        // a fresh list per row: callers are free to treat rows as independent
        rows.add(new ArrayList<>(tupleValues));
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
