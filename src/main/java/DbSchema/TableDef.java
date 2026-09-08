package DbSchema;

import com.google.common.collect.ImmutableList;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import org.apache.calcite.config.CalciteConnectionConfig;
import org.apache.calcite.rel.RelCollation;
import org.apache.calcite.rel.RelCollations;
import org.apache.calcite.rel.RelFieldCollation;
import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeFactory;
import org.apache.calcite.schema.Schema;
import org.apache.calcite.schema.Statistic;
import org.apache.calcite.schema.Statistics;
import org.apache.calcite.schema.Table;
import org.apache.calcite.sql.SqlCall;
import org.apache.calcite.sql.SqlNode;
import org.apache.calcite.util.ImmutableBitSet;

/**
 * One table read out of a schema file, presented to Calcite as a {@link Table}.
 *
 * <p>This is what used to be a hand-written class per table ({@code EMP}, {@code DEPT}, ...).
 * Everything those classes said is still said here, only now it is read from DDL: the row
 * type from the column list, and the unique keys from the declared {@code PRIMARY KEY} and
 * {@code UNIQUE} constraints, where before every table simply claimed its first column was
 * a key.
 */
public final class TableDef implements Table
{
  /**
   * Nothing in this pipeline is cost-based -- {@code Planner.rel} converts, it does not
   * optimise -- so the row count is only here because {@link Statistics} wants one. The key
   * list is the part that matters: the validator uses it to drop a {@code DISTINCT} or an
   * aggregate that a key already makes redundant.
   */
  private static final double ROW_COUNT = 5;

  private final String schemaName;
  private final String name;
  private final List<ColumnDef> columns;
  private final List<List<String>> keys;

  TableDef(String schemaName, String name, List<ColumnDef> columns, List<List<String>> keys)
  {
    this.schemaName = schemaName;
    this.name = name;
    this.columns = Collections.unmodifiableList(new ArrayList<>(columns));
    this.keys = Collections.unmodifiableList(new ArrayList<>(keys));
  }

  /** The schema the DDL qualified the table with ({@code public} in {@code public.emp}), or null. */
  public String schemaName()
  {
    return schemaName;
  }

  public String name()
  {
    return name;
  }

  public List<ColumnDef> columns()
  {
    return columns;
  }

  /** The declared unique keys, each as a list of column names. */
  public List<List<String>> keys()
  {
    return keys;
  }

  public String qualifiedName()
  {
    return schemaName == null ? name : schemaName + "." + name;
  }

  @Override
  public RelDataType getRowType(RelDataTypeFactory typeFactory)
  {
    RelDataTypeFactory.Builder builder = new RelDataTypeFactory.Builder(typeFactory);
    for (ColumnDef column : columns)
    {
      builder.add(column.name(), column.toRelDataType(typeFactory));
    }
    return builder.build();
  }

  @Override
  public Statistic getStatistic()
  {
    List<ImmutableBitSet> keyBits = new ArrayList<>();
    for (List<String> key : keys)
    {
      ImmutableBitSet bits = toBitSet(key);
      if (bits != null)
      {
        keyBits.add(bits);
      }
    }
    // The hand-written tables all claimed to be sorted on their first column. That claim is
    // kept exactly where it was true of them -- a single-column key on column 0 -- and made
    // nowhere else, since an invented sort order would let the planner drop a real ORDER BY.
    List<RelCollation> collations = keyBits.contains(ImmutableBitSet.of(0))
        ? ImmutableList.of(RelCollations.of(new RelFieldCollation(
              0, RelFieldCollation.Direction.ASCENDING, RelFieldCollation.NullDirection.UNSPECIFIED)))
        : ImmutableList.<RelCollation>of();
    return Statistics.of(ROW_COUNT, ImmutableList.copyOf(keyBits), collations);
  }

  /** @return the ordinals of {@code key}'s columns, or null if it names a column we do not have */
  private ImmutableBitSet toBitSet(List<String> key)
  {
    Set<Integer> ordinals = new LinkedHashSet<>();
    for (String columnName : key)
    {
      int ordinal = indexOf(columnName);
      if (ordinal < 0)
      {
        return null;
      }
      ordinals.add(ordinal);
    }
    return ordinals.isEmpty() ? null : ImmutableBitSet.of(ordinals);
  }

  public int indexOf(String columnName)
  {
    for (int i = 0; i < columns.size(); i++)
    {
      if (columns.get(i).name().equals(columnName))
      {
        return i;
      }
    }
    return -1;
  }

  @Override
  public boolean isRolledUp(String column)
  {
    return false;
  }

  @Override
  public boolean rolledUpColumnValidInsideAgg(
      String column, SqlCall call, SqlNode parent, CalciteConnectionConfig config)
  {
    return false;
  }

  @Override
  public Schema.TableType getJdbcTableType()
  {
    return Schema.TableType.TABLE;
  }

  @Override
  public String toString()
  {
    return qualifiedName() + columns;
  }
}
