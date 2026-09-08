package DbSchema;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.apache.calcite.avatica.util.Casing;
import org.apache.calcite.avatica.util.Quoting;
import org.apache.calcite.sql.parser.SqlParser;
import org.apache.calcite.sql.validate.SqlConformance;
import org.apache.calcite.sql.validate.SqlConformanceEnum;

/**
 * A SQL accent: how one database spells identifiers.
 *
 * <p>The accent decides two things that have to agree with each other, or a query will not
 * find its own tables:
 *
 * <ul>
 *   <li>how an identifier written in the <em>schema</em> is stored -- {@code create table emp}
 *       registers {@code EMP} under Calcite's own rules but {@code emp} under PostgreSQL's;
 *   <li>how an identifier written in a <em>query</em> is looked up -- the same casing rule
 *       plus the dialect's quote character and conformance level.
 * </ul>
 *
 * <p>Both come from the single {@link SqlParser.Config} below, so schema and query can never
 * drift apart. {@link #CALCITE} is the default and reproduces Calcite's out-of-the-box
 * behaviour: unquoted names fold to upper case, {@code "} quotes, lookup is case sensitive.
 */
public enum Dialect
{
  /** Calcite's own defaults. Unquoted names fold to upper case. */
  CALCITE("calcite", Quoting.DOUBLE_QUOTE, Casing.TO_UPPER, Casing.UNCHANGED, true,
      SqlConformanceEnum.DEFAULT, "ansi", "standard", "default", "h2"),

  /** Unquoted names fold to <em>lower</em> case, which is PostgreSQL's rule, not the standard's. */
  POSTGRESQL("postgresql", Quoting.DOUBLE_QUOTE, Casing.TO_LOWER, Casing.UNCHANGED, true,
      SqlConformanceEnum.PRAGMATIC_2003, "postgres", "pg", "psql", "redshift", "greenplum"),

  /** Back-quoted identifiers, and lookup ignores case. */
  MYSQL("mysql", Quoting.BACK_TICK, Casing.UNCHANGED, Casing.UNCHANGED, false,
      SqlConformanceEnum.MYSQL_5, "mariadb"),

  /**
   * SQLite keeps the case you wrote and compares names ignoring it. It also accepts
   * {@code "}, {@code `} and {@code [..]} as quotes; the DDL reader takes all three, while
   * queries have to pick one, and that one is {@code "}.
   */
  SQLITE("sqlite", Quoting.DOUBLE_QUOTE, Casing.UNCHANGED, Casing.UNCHANGED, false,
      SqlConformanceEnum.LENIENT, "sqlite3"),

  /** Bracketed identifiers, case-insensitive lookup. */
  SQLSERVER("sqlserver", Quoting.BRACKET, Casing.UNCHANGED, Casing.UNCHANGED, false,
      SqlConformanceEnum.SQL_SERVER_2008, "mssql", "tsql", "sqlserver2008"),

  /** Like {@link #CALCITE} -- Calcite's defaults are Oracle's -- with Oracle's conformance. */
  ORACLE("oracle", Quoting.DOUBLE_QUOTE, Casing.TO_UPPER, Casing.UNCHANGED, true,
      SqlConformanceEnum.ORACLE_12, "oracle12", "oracle10"),

  /** Back-quoted identifiers, case-insensitive, permissive. */
  SPARK("spark", Quoting.BACK_TICK, Casing.UNCHANGED, Casing.UNCHANGED, false,
      SqlConformanceEnum.LENIENT, "hive", "sparksql"),

  /** Back-quoted identifiers, case-insensitive, permissive. */
  BIGQUERY("bigquery", Quoting.BACK_TICK, Casing.UNCHANGED, Casing.UNCHANGED, false,
      SqlConformanceEnum.LENIENT, "bq");

  private static final Map<String, Dialect> BY_NAME = byName();

  private final String canonicalName;
  private final Quoting quoting;
  private final Casing unquotedCasing;
  private final Casing quotedCasing;
  private final boolean caseSensitive;
  private final SqlConformance conformance;
  private final List<String> aliases;

  Dialect(String canonicalName, Quoting quoting, Casing unquotedCasing, Casing quotedCasing,
      boolean caseSensitive, SqlConformance conformance, String... aliases)
  {
    this.canonicalName = canonicalName;
    this.quoting = quoting;
    this.unquotedCasing = unquotedCasing;
    this.quotedCasing = quotedCasing;
    this.caseSensitive = caseSensitive;
    this.conformance = conformance;
    this.aliases = Collections.unmodifiableList(Arrays.asList(aliases));
  }

  private static Map<String, Dialect> byName()
  {
    Map<String, Dialect> map = new LinkedHashMap<>();
    for (Dialect dialect : values())
    {
      map.put(dialect.canonicalName, dialect);
      for (String alias : dialect.aliases)
      {
        map.put(alias, dialect);
      }
    }
    return Collections.unmodifiableMap(map);
  }

  /**
   * Looks up an accent by name or by one of its aliases, ignoring case and any
   * punctuation ({@code sql-server}, {@code SQL_Server} and {@code sqlserver} are one name).
   */
  public static Dialect of(String name)
  {
    if (name == null || name.trim().isEmpty())
    {
      return CALCITE;
    }
    String key = name.trim().toLowerCase(Locale.ROOT).replaceAll("[^a-z0-9]", "");
    Dialect dialect = BY_NAME.get(key);
    if (dialect == null)
    {
      throw new IllegalArgumentException(
          "unknown SQL dialect '" + name + "'; known dialects are " + supportedNames());
    }
    return dialect;
  }

  /** Every name {@link #of} accepts, for error messages and {@code --help} text. */
  public static String supportedNames()
  {
    List<String> names = new ArrayList<>();
    for (Dialect dialect : values())
    {
      names.add(dialect.canonicalName + " (aliases: " + String.join(", ", dialect.aliases) + ")");
    }
    return String.join(", ", names);
  }

  public String canonicalName()
  {
    return canonicalName;
  }

  /** Whether table and column lookup ignores case. */
  public boolean caseSensitive()
  {
    return caseSensitive;
  }

  /**
   * Folds an identifier the way this dialect's parser would, so that a name written in the
   * schema and the same name written in a query end up equal.
   */
  public String normalize(String identifier, boolean quoted)
  {
    Casing casing = quoted ? quotedCasing : unquotedCasing;
    switch (casing)
    {
      case TO_UPPER:
        return identifier.toUpperCase(Locale.ROOT);
      case TO_LOWER:
        return identifier.toLowerCase(Locale.ROOT);
      default:
        return identifier;
    }
  }

  /** The Calcite parser configuration for queries written in this accent. */
  public SqlParser.Config parserConfig()
  {
    return SqlParser.configBuilder()
        .setQuoting(quoting)
        .setUnquotedCasing(unquotedCasing)
        .setQuotedCasing(quotedCasing)
        .setCaseSensitive(caseSensitive)
        .setConformance(conformance)
        .build();
  }

  @Override
  public String toString()
  {
    return canonicalName;
  }
}
