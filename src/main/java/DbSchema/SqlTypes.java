package DbSchema;

import java.util.Collections;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Pattern;
import org.apache.calcite.sql.type.SqlTypeName;

/**
 * Maps the type names the various dialects use onto Calcite's own.
 *
 * <p>The mapping is deliberately many-to-one: {@code int4}, {@code mediumint} and
 * {@code serial} are all just {@code INTEGER} here, because the solver reasons about
 * mathematical integers and never about machine width. Widths that do change what a query
 * means -- the length of a {@code CHAR}, the scale of a {@code DECIMAL} -- are kept.
 *
 * <p>A type nobody recognises becomes {@link SqlTypeName#ANY}. That lets a schema with a
 * {@code geometry} column load and be queried through its other tables; only a query that
 * actually reads the odd table fails, and it fails with "unsupported sql type" rather than
 * with a silently wrong encoding.
 */
final class SqlTypes
{
  private static final Map<String, SqlTypeName> TYPES = types();

  /**
   * Qualifiers that say nothing we act on: {@code timestamp without time zone} is a
   * {@code timestamp}, {@code double precision} is a {@code double}, {@code int unsigned}
   * is an {@code int}.
   */
  private static final Pattern NOISE = Pattern.compile(
      "\\b(with|without)\\s+(local\\s+)?time\\s+zone\\b|\\b(unsigned|signed|zerofill|precision)\\b");

  private SqlTypes() {}

  private static Map<String, SqlTypeName> types()
  {
    Map<String, SqlTypeName> map = new HashMap<>();

    // 64-bit integers keep their own type only because the translator names it separately
    put(map, SqlTypeName.BIGINT, "bigint", "int8", "bigserial", "serial8", "long");
    put(map, SqlTypeName.INTEGER, "int", "integer", "int4", "mediumint", "smallint", "int2",
        "tinyint", "byteint", "serial", "serial4", "smallserial", "year", "number");
    put(map, SqlTypeName.BOOLEAN, "bool", "boolean", "bit");
    put(map, SqlTypeName.VARCHAR, "varchar", "charactervarying", "varchar2", "nvarchar",
        "nvarchar2", "nationalcharactervarying", "text", "tinytext", "mediumtext", "longtext",
        "ntext", "clob", "nclob", "string", "citext", "uuid", "json", "jsonb", "xml", "inet",
        "cidr", "macaddr", "enum", "set", "name");
    put(map, SqlTypeName.CHAR, "char", "character", "bpchar", "nchar", "nationalcharacter");
    put(map, SqlTypeName.DECIMAL, "decimal", "numeric", "dec", "money", "smallmoney");
    put(map, SqlTypeName.DOUBLE, "double", "float8", "binarydouble");
    put(map, SqlTypeName.REAL, "real", "float4", "binaryfloat");
    put(map, SqlTypeName.FLOAT, "float");
    put(map, SqlTypeName.DATE, "date");
    put(map, SqlTypeName.TIME, "time", "timetz");
    put(map, SqlTypeName.TIMESTAMP, "timestamp", "timestamptz", "datetime", "datetime2",
        "smalldatetime");
    put(map, SqlTypeName.VARBINARY, "varbinary", "blob", "bytea", "longblob", "mediumblob",
        "tinyblob", "image", "bytes");
    put(map, SqlTypeName.BINARY, "binary");
    return Collections.unmodifiableMap(map);
  }

  private static void put(Map<String, SqlTypeName> map, SqlTypeName type, String... names)
  {
    for (String name : names)
    {
      map.put(name, type);
    }
  }

  /**
   * @param rawType the type as written, e.g. {@code "character varying"} or {@code "INT UNSIGNED"}
   * @return the Calcite type it denotes, or {@link SqlTypeName#ANY} if it denotes nothing we know
   */
  static SqlTypeName of(String rawType)
  {
    String normalized = rawType.trim().toLowerCase(Locale.ROOT).replaceAll("\\s+", " ");
    normalized = NOISE.matcher(normalized).replaceAll("").replaceAll("\\s+", "");
    SqlTypeName type = TYPES.get(normalized);
    return type == null ? SqlTypeName.ANY : type;
  }
}
