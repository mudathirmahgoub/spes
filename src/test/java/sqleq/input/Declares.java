package sqleq.input;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * sqleq's {@code declare scalar|aggregate function NAME(args) returns TYPE;} lines, which stand
 * for functions the pair calls and the DDL does not define. A scalar one becomes an uninterpreted
 * function of the declared return type. An aggregate one is refused: lowered as a scalar it would
 * silently change the row count.
 */
public final class Declares {
  private static final Pattern LINE = Pattern.compile(
      "(?is)^\\s*declare\\s+(?:.*?\\s)??(scalar|aggregate)\\s+function\\s+(\\S+?)\\s*\\((.*?)\\)\\s+returns\\s+(.+?)\\s*;?\\s*$");

  public static final class Decl {
    public final String name;
    public final int arity;
    public final String returnType;
    public final Catalog.Type type;
    public final boolean aggregate;

    Decl(String name, int arity, String returnType, Catalog.Type type, boolean aggregate) {
      this.name = name;
      this.arity = arity;
      this.returnType = returnType;
      this.type = type;
      this.aggregate = aggregate;
    }
  }

  private Declares() {}

  public static Decl parse(String line) throws Unsupported {
    Matcher m = LINE.matcher(line);
    if (!m.matches()) {
      throw new Unsupported("declare line not understood: " + line.trim());
    }
    String args = m.group(3).trim();
    int arity = args.isEmpty() ? 0 : args.split(",").length;
    Catalog.Column probe = new Catalog.Column("f");
    Catalog.applyType(probe, m.group(4));
    return new Decl(m.group(2), arity, m.group(4).trim(), probe.type, m.group(1).equalsIgnoreCase("aggregate"));
  }
}
