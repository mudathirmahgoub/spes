package sqleq.input;

import java.util.List;

/**
 * The catalog written back as DDL in the accent a prover's schema reader expects: SQLSolver's
 * MySQL-flavoured {@code CREATE TABLE}, or Postgres for the cvc5 translator's reader. Only what a
 * prover may assume is written: the columns and their types, {@code NOT NULL}, and the keys of
 * {@link Catalog.Table#proverKeys()}; a {@code UNIQUE} over a nullable column is not among them.
 */
public final class DdlOut {
  private DdlOut() {}

  public static String mysql(Catalog cat) {
    StringBuilder b = new StringBuilder();
    int n = 0;
    for (Catalog.Table t : cat.tables()) {
      if (t.schema != null && !t.schema.equals("public")) {
        continue; // reachable by its qualified name only; both schema readers would register it bare as well
      }
      b.append("CREATE TABLE ").append(bq(t.name)).append(" (\n");
      boolean first = true;
      for (Catalog.Column c : t.columns) {
        b.append(first ? "" : ",\n").append("  ").append(bq(c.name)).append(' ').append(mysqlType(c));
        if (c.notNull) {
          b.append(" not null");
        }
        first = false;
      }
      List<List<String>> keys = t.proverKeys();
      for (int k = 0; k < keys.size(); k++) {
        List<String> key = keys.get(k);
        if (t.primaryKey != null && key.equals(t.primaryKey) && k == 0) {
          b.append(",\n  PRIMARY KEY (").append(bqList(key)).append(")");
        } else {
          b.append(",\n  UNIQUE KEY ").append(bq("uk_" + (++n))).append(" (").append(bqList(key)).append(")");
        }
      }
      for (Catalog.ForeignKey fk : t.foreignKeys) {
        Catalog.Table ref = cat.table(fk.refTable);
        if (ref == null) {
          continue;
        }
        List<String> rcols = fk.refColumns != null ? fk.refColumns : ref.primaryKey;
        if (rcols == null || rcols.size() != fk.columns.size()) {
          continue;
        }
        b.append(",\n  CONSTRAINT ").append(bq("fk_" + (++n))).append(" FOREIGN KEY (").append(bqList(fk.columns))
            .append(") REFERENCES ").append(bq(ref.name)).append(" (").append(bqList(rcols)).append(")");
      }
      b.append("\n);\n\n");
    }
    return b.toString();
  }

  private static String mysqlType(Catalog.Column c) {
    switch (c.type) {
      case INTEGER: return "int";
      case BIGINT: return "bigint";
      case DECIMAL: return "decimal" + c.typeArgs;
      case DOUBLE: return "double";
      case BOOLEAN: return "boolean";
      case STRING: return c.typeArgs.isEmpty() ? "text" : "varchar" + c.typeArgs;
      case CHAR: return "char" + c.typeArgs;
      case DATE: return "date";
      case TIME: return "time";
      case TIMESTAMP: return "datetime";
      default: return "blob";
    }
  }

  public static String postgres(Catalog cat) {
    StringBuilder b = new StringBuilder();
    for (Catalog.Table t : cat.tables()) {
      if (t.schema != null && !t.schema.equals("public")) {
        continue; // reachable by its qualified name only; both schema readers would register it bare as well
      }
      b.append("create table ").append(dq(t.name)).append(" (\n");
      boolean first = true;
      for (Catalog.Column c : t.columns) {
        b.append(first ? "" : ",\n").append("  ").append(dq(c.name)).append(' ').append(pgType(c));
        if (c.notNull) {
          b.append(" NOT NULL");
        }
        first = false;
      }
      List<List<String>> keys = t.proverKeys();
      for (int k = 0; k < keys.size(); k++) {
        List<String> key = keys.get(k);
        if (t.primaryKey != null && key.equals(t.primaryKey) && k == 0) {
          b.append(",\n  PRIMARY KEY (").append(dqList(key)).append(")");
        } else {
          b.append(",\n  UNIQUE (").append(dqList(key)).append(")");
        }
      }
      b.append("\n);\n\n");
    }
    return b.toString();
  }

  private static String pgType(Catalog.Column c) {
    switch (c.type) {
      case INTEGER: return "integer";
      case BIGINT: return "bigint";
      case DECIMAL: return "numeric" + c.typeArgs;
      case DOUBLE: return "double precision";
      case BOOLEAN: return "boolean";
      case STRING: return c.typeArgs.isEmpty() ? "text" : "varchar" + c.typeArgs;
      case CHAR: return "char" + c.typeArgs;
      case DATE: return "date";
      case TIME: return "time";
      case TIMESTAMP: return "timestamp";
      case INTERVAL: return "interval";
      default: return "bytea"; // opaque: a sort with equality only, which the translator declines
    }
  }

  static String bq(String name) {
    return "`" + name.replace("`", "``") + "`";
  }

  static String dq(String name) {
    return "\"" + name.replace("\"", "\"\"") + "\"";
  }

  private static String bqList(List<String> names) {
    StringBuilder b = new StringBuilder();
    for (String n : names) {
      b.append(b.length() == 0 ? "" : ", ").append(bq(n));
    }
    return b.toString();
  }

  private static String dqList(List<String> names) {
    StringBuilder b = new StringBuilder();
    for (String n : names) {
      b.append(b.length() == 0 ? "" : ", ").append(dq(n));
    }
    return b.toString();
  }
}
