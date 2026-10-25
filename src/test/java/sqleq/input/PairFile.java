package sqleq.input;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * One sqleq pair file, read.
 *
 * <p>The format is sqleq's: a leading comment block whose {@code -- key: value} lines are directives
 * ({@code truth}, {@code expect <axis>}, {@code catalog}, {@code binding}, {@code origin}), then
 * PostgreSQL DDL (any number of statements), optional {@code declare … function} lines, and exactly
 * two statements: two queries, or two {@code DELETE}s, {@code UPDATE}s or {@code INSERT}s.
 * Statements are cut at the semicolons Postgres would cut them at, which is what {@link PgLexer}
 * is for.
 */
public final class PairFile {
  private static final Pattern DIRECTIVE = Pattern.compile("^-- ([a-z][a-z0-9_-]*(?: [a-z0-9_-]+)?): (.*)$");

  public final String name;
  public final String text;
  public final Map<String, String> directives = new LinkedHashMap<String, String>();
  public final List<String> ddl = new ArrayList<String>();
  public final List<String> declares = new ArrayList<String>();
  public final List<String> statements = new ArrayList<String>();

  private PairFile(String name, String text) {
    this.name = name;
    this.text = text;
  }

  /** {@code equivalent}, {@code not-equivalent}, or null when the file states no truth. */
  public String truth() {
    return directives.get("truth");
  }

  public static PairFile read(Path path, String name) throws IOException, Unsupported {
    return parse(name, new String(Files.readAllBytes(path), StandardCharsets.UTF_8));
  }

  public static PairFile parse(String name, String text) throws Unsupported {
    PairFile pf = new PairFile(name, text);
    for (String line : text.split("\n")) {
      String t = line.trim();
      if (t.isEmpty()) {
        continue;
      }
      if (!t.startsWith("--")) {
        break;
      }
      Matcher m = DIRECTIVE.matcher(t);
      if (m.matches()) {
        pf.directives.put(m.group(1), m.group(2).trim());
      }
    }
    List<PgLexer.Token> toks = PgLexer.lex(text);
    int depth = 0;
    int from = 0;
    for (int i = 0; i <= toks.size(); i++) {
      boolean end = i == toks.size();
      if (!end) {
        PgLexer.Kind k = toks.get(i).kind;
        if (k == PgLexer.Kind.LPAREN) {
          depth++;
        } else if (k == PgLexer.Kind.RPAREN) {
          depth--;
        }
      }
      if (end || (toks.get(i).kind == PgLexer.Kind.SEMI && depth == 0)) {
        if (i > from) {
          pf.classify(PgLexer.slice(text, toks, from, i), toks.get(from));
        }
        from = i + 1;
      }
    }
    if (pf.statements.size() != 2) {
      throw new Unsupported("expected two statements after the DDL, found " + pf.statements.size());
    }
    return pf;
  }

  private void classify(String statement, PgLexer.Token first) throws Unsupported {
    if (first.kind == PgLexer.Kind.LPAREN) {
      statements.add(statement);
      return;
    }
    if (first.kind != PgLexer.Kind.WORD) {
      throw new Unsupported("statement starting with " + first.text);
    }
    String w = first.upper();
    if (w.equals("SELECT") || w.equals("WITH") || w.equals("VALUES") || w.equals("TABLE")
        || w.equals("DELETE") || w.equals("UPDATE") || w.equals("INSERT")) {
      statements.add(statement);
    } else if (w.equals("DECLARE")) {
      declares.add(statement);
    } else if (w.equals("CREATE") || w.equals("ALTER") || w.equals("DROP") || w.equals("SET") || w.equals("COMMENT")
        || w.equals("GRANT") || w.equals("REVOKE") || w.equals("BEGIN") || w.equals("COMMIT") || w.equals("START")
        || w.equals("ANALYZE") || w.equals("VACUUM") || w.equals("REFRESH") || w.equals("DO") || w.equals("RESET")) {
      ddl.add(statement);
    } else {
      throw new Unsupported("statement kind " + w);
    }
  }
}
