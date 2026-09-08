package DbSchema;

import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeFactory;
import org.apache.calcite.sql.type.SqlTypeName;

/** One column of a {@link TableDef}: its name, the type it was declared with, and whether it may be null. */
public final class ColumnDef
{
  private final String name;
  private final String rawType;
  private final SqlTypeName typeName;
  private final int precision;
  private final int scale;
  private final boolean nullable;

  ColumnDef(String name, String rawType, int precision, int scale, boolean nullable)
  {
    this.name = name;
    this.rawType = rawType;
    this.typeName = SqlTypes.of(rawType);
    this.precision = precision;
    this.scale = scale;
    this.nullable = nullable;
  }

  public String name()
  {
    return name;
  }

  /** The type exactly as the DDL spelled it, which is what error messages should quote. */
  public String rawType()
  {
    return rawType;
  }

  public SqlTypeName typeName()
  {
    return typeName;
  }

  public boolean nullable()
  {
    return nullable;
  }

  /** The same column with its nullability overridden; used when a key or a NOT NULL is seen later. */
  ColumnDef withNullable(boolean newNullable)
  {
    return nullable == newNullable ? this
                                   : new ColumnDef(name, rawType, precision, scale, newNullable);
  }

  RelDataType toRelDataType(RelDataTypeFactory typeFactory)
  {
    RelDataType type;
    if (precision < 0 || !typeName.allowsPrec())
    {
      // MySQL's int(11) is a display width, and Calcite rejects a precision on an INTEGER
      type = typeFactory.createSqlType(typeName);
    }
    else if (scale < 0 || !typeName.allowsScale())
    {
      type = typeFactory.createSqlType(typeName, clamp(typeFactory, precision));
    }
    else
    {
      type = typeFactory.createSqlType(typeName, clamp(typeFactory, precision), scale);
    }
    return typeFactory.createTypeWithNullability(type, nullable);
  }

  /**
   * Calcite asserts that a precision fits the type system, and real schemas do overshoot
   * ({@code varchar(1000000)} is legal in PostgreSQL, not in Calcite). A too-wide string is
   * still a string, so the width is trimmed rather than the schema rejected.
   */
  private int clamp(RelDataTypeFactory typeFactory, int value)
  {
    int max = typeFactory.getTypeSystem().getMaxPrecision(typeName);
    if (max >= 0 && value > max)
    {
      return max;
    }
    return value < 1 ? 1 : value;
  }

  @Override
  public String toString()
  {
    return name + " " + rawType + (nullable ? "" : " NOT NULL");
  }
}
