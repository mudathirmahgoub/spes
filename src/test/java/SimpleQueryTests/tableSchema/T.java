package SimpleQueryTests.tableSchema;

import com.google.common.collect.ImmutableList;
import org.apache.calcite.config.CalciteConnectionConfig;
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

public class T implements Table
{
  @SuppressWarnings("deprecation")
  public RelDataType getRowType(RelDataTypeFactory typeFactory)
  {
    @SuppressWarnings("deprecation")
    RelDataTypeFactory.FieldInfoBuilder b = typeFactory.builder();
    RelDataType stringType = typeFactory.createJavaType(String.class);
    RelDataType integerType = typeFactory.createJavaType(String.class);
    RelDataType stringNotNull = typeFactory.createTypeWithNullability(stringType, false);
    RelDataType integerNotNull = typeFactory.createTypeWithNullability(integerType, false);
    b.add("K0", stringNotNull);
    b.add("C1", stringNotNull);
    b.add("F1_A0", integerNotNull);
    b.add("F2_A0", integerNotNull);
    b.add("F0_C0", integerNotNull);
    b.add("F1_C0", integerNotNull);
    b.add("F0_C1", integerNotNull);
    b.add("F1_C2", integerNotNull);
    b.add("F2_C3", integerNotNull);
    return b.build();
  }
  @Override
  public boolean isRolledUp(String s)
  {
    return false;
  }
  @Override
  public boolean rolledUpColumnValidInsideAgg(
      String s, SqlCall sqlCall, SqlNode sqlNode, CalciteConnectionConfig calciteConnectionConfig)
  {
    return false;
  }
  public Statistic getStatistic()
  {
    //        return Statistics.of(100, ImmutableList.<ImmutableBitSet>of());
    RelFieldCollation.Direction dir = RelFieldCollation.Direction.ASCENDING;
    RelFieldCollation collation =
        new RelFieldCollation(0, dir, RelFieldCollation.NullDirection.UNSPECIFIED);
    return Statistics.of(
        5, ImmutableList.of(ImmutableBitSet.of(0)), ImmutableList.of(RelCollations.of(collation)));
  }
  public Schema.TableType getJdbcTableType()
  {
    return Schema.TableType.STREAM;
  }

  public Table stream()
  {
    return null;
  }
}
