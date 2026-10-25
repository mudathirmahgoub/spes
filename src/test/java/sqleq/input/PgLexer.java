package sqleq.input;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * Tokens of PostgreSQL SQL text, cut where Postgres cuts them.
 *
 * <p>Everything downstream -- splitting a pair file into statements, reading its DDL, reducing a
 * DML statement to the query that computes its effect, rewriting casts -- works on these tokens
 * rather than on regular expressions, because every one of those jobs has to know what is inside a
 * string and what is not. Postgres has six ways of quoting: {@code '…'} with {@code ''} doubled,
 * {@code E'…'} with backslash escapes, {@code "…"} identifiers, {@code $$…$$} and {@code $tag$…$tag$}
 * bodies, {@code --} comments and nesting {@code /* … *}{@code /} comments. All six are read here.
 *
 * <p>Comments are dropped. Each token keeps its offsets in the source, so a slice of the original
 * text can be handed on verbatim where that matters.
 */
public final class PgLexer {
  public enum Kind { WORD, QUOTED, STRING, NUMBER, PARAM, OP, LPAREN, RPAREN, COMMA, SEMI, DOT, OTHER }

  public static final class Token {
    public final Kind kind;
    public final String text;
    public final int start;
    public final int end;

    Token(Kind kind, String text, int start, int end) {
      this.kind = kind;
      this.text = text;
      this.start = start;
      this.end = end;
    }

    /** The keyword spelling of a bare word, upper-cased; other tokens as written. */
    public String upper() {
      return kind == Kind.WORD ? text.toUpperCase(Locale.ROOT) : text;
    }

    public boolean isWord(String keyword) {
      return kind == Kind.WORD && text.equalsIgnoreCase(keyword);
    }

    public boolean isOp(String op) {
      return kind == Kind.OP && text.equals(op);
    }

    public boolean isIdent() {
      return kind == Kind.WORD || kind == Kind.QUOTED;
    }

    /** The name an identifier denotes: lower-cased when bare, as written when quoted. */
    public String name() {
      if (kind == Kind.QUOTED) {
        return text.substring(1, text.length() - 1).replace("\"\"", "\"");
      }
      return text.toLowerCase(Locale.ROOT);
    }

    /** The {@code N} of a {@code $N} parameter. */
    public int paramIndex() {
      return Integer.parseInt(text.substring(1));
    }

    @Override
    public String toString() {
      return text;
    }
  }

  private static final String OPCHARS = "+-*/<>=~!@#%^&|`?:";

  private PgLexer() {}

  public static List<Token> lex(String s) throws Unsupported {
    List<Token> out = new ArrayList<Token>();
    int n = s.length();
    int i = 0;
    while (i < n) {
      char c = s.charAt(i);
      if (Character.isWhitespace(c)) {
        i++;
        continue;
      }
      if (c == '-' && i + 1 < n && s.charAt(i + 1) == '-') {
        while (i < n && s.charAt(i) != '\n') {
          i++;
        }
        continue;
      }
      if (c == '/' && i + 1 < n && s.charAt(i + 1) == '*') {
        int depth = 0;
        int j = i;
        while (j < n) {
          if (s.startsWith("/*", j)) {
            depth++;
            j += 2;
          } else if (s.startsWith("*/", j)) {
            depth--;
            j += 2;
            if (depth == 0) {
              break;
            }
          } else {
            j++;
          }
        }
        if (depth != 0) {
          throw new Unsupported("unterminated comment");
        }
        i = j;
        continue;
      }
      int start = i;
      if (c == '\'') {
        int j = quoted(s, i, '\'');
        out.add(new Token(Kind.STRING, s.substring(i, j), i, j));
        i = j;
        continue;
      }
      if ((c == 'E' || c == 'e') && i + 1 < n && s.charAt(i + 1) == '\'') {
        int j = i + 2;
        boolean closed = false;
        while (j < n) {
          char d = s.charAt(j);
          if (d == '\\') {
            j += 2;
            continue;
          }
          if (d == '\'') {
            if (j + 1 < n && s.charAt(j + 1) == '\'') {
              j += 2;
              continue;
            }
            j++;
            closed = true;
            break;
          }
          j++;
        }
        if (!closed) {
          throw new Unsupported("unterminated escape string");
        }
        out.add(new Token(Kind.STRING, s.substring(i, j), i, j));
        i = j;
        continue;
      }
      if (c == '"') {
        int j = quoted(s, i, '"');
        out.add(new Token(Kind.QUOTED, s.substring(i, j), i, j));
        i = j;
        continue;
      }
      if (c == '$') {
        int j = i + 1;
        while (j < n && Character.isDigit(s.charAt(j))) {
          j++;
        }
        if (j > i + 1 && !(j < n && isIdentPart(s.charAt(j)))) {
          out.add(new Token(Kind.PARAM, s.substring(i, j), i, j));
          i = j;
          continue;
        }
        j = i + 1;
        while (j < n && (Character.isLetterOrDigit(s.charAt(j)) || s.charAt(j) == '_')) {
          j++;
        }
        if (j < n && s.charAt(j) == '$') {
          String tag = s.substring(i, j + 1);
          int close = s.indexOf(tag, j + 1);
          if (close < 0) {
            throw new Unsupported("unterminated dollar-quoted string");
          }
          int end = close + tag.length();
          out.add(new Token(Kind.STRING, s.substring(i, end), i, end));
          i = end;
          continue;
        }
        out.add(new Token(Kind.OTHER, "$", i, i + 1));
        i++;
        continue;
      }
      boolean dotNumber = c == '.' && i + 1 < n && Character.isDigit(s.charAt(i + 1)) && !previousIsOperand(out);
      if (Character.isDigit(c) || dotNumber) {
        int j = i;
        if (c == '0' && i + 1 < n && "bBoOxX".indexOf(s.charAt(i + 1)) >= 0) {
          // 0b101, 0o17, 0xff: one token, which Calcite then rejects rather than reading as an alias
          j = i + 2;
          while (j < n && (Character.isLetterOrDigit(s.charAt(j)) || s.charAt(j) == '_')) {
            j++;
          }
          out.add(new Token(Kind.NUMBER, s.substring(i, j), i, j));
          i = j;
          continue;
        }
        while (j < n && (Character.isDigit(s.charAt(j)) || s.charAt(j) == '_')) {
          j++;
        }
        if (j < n && s.charAt(j) == '.') {
          j++;
          while (j < n && Character.isDigit(s.charAt(j))) {
            j++;
          }
        }
        if (j < n && (s.charAt(j) == 'e' || s.charAt(j) == 'E')) {
          int k = j + 1;
          if (k < n && (s.charAt(k) == '+' || s.charAt(k) == '-')) {
            k++;
          }
          if (k < n && Character.isDigit(s.charAt(k))) {
            while (k < n && Character.isDigit(s.charAt(k))) {
              k++;
            }
            j = k;
          }
        }
        out.add(new Token(Kind.NUMBER, s.substring(i, j), i, j));
        i = j;
        continue;
      }
      if (isIdentStart(c)) {
        int j = i;
        while (j < n && isIdentPart(s.charAt(j))) {
          j++;
        }
        out.add(new Token(Kind.WORD, s.substring(i, j), i, j));
        i = j;
        continue;
      }
      switch (c) {
        case '(':
          out.add(new Token(Kind.LPAREN, "(", i, i + 1));
          i++;
          continue;
        case ')':
          out.add(new Token(Kind.RPAREN, ")", i, i + 1));
          i++;
          continue;
        case ',':
          out.add(new Token(Kind.COMMA, ",", i, i + 1));
          i++;
          continue;
        case ';':
          out.add(new Token(Kind.SEMI, ";", i, i + 1));
          i++;
          continue;
        case '.':
          out.add(new Token(Kind.DOT, ".", i, i + 1));
          i++;
          continue;
        case '[':
        case ']':
          out.add(new Token(Kind.OTHER, String.valueOf(c), i, i + 1));
          i++;
          continue;
        default:
          break;
      }
      if (OPCHARS.indexOf(c) >= 0) {
        int j = i;
        while (j < n && OPCHARS.indexOf(s.charAt(j)) >= 0) {
          if (j > i && (s.startsWith("--", j) || s.startsWith("/*", j))) {
            break;
          }
          j++;
        }
        out.add(new Token(Kind.OP, s.substring(i, j), i, j));
        i = j;
        continue;
      }
      throw new Unsupported("unexpected character '" + c + "' at offset " + start);
    }
    return out;
  }

  private static int quoted(String s, int i, char q) throws Unsupported {
    int n = s.length();
    int j = i + 1;
    while (j < n) {
      if (s.charAt(j) == q) {
        if (j + 1 < n && s.charAt(j + 1) == q) {
          j += 2;
          continue;
        }
        return j + 1;
      }
      j++;
    }
    throw new Unsupported("unterminated " + (q == '\'' ? "string" : "quoted identifier"));
  }

  private static boolean previousIsOperand(List<Token> out) {
    if (out.isEmpty()) {
      return false;
    }
    Kind k = out.get(out.size() - 1).kind;
    return k == Kind.WORD || k == Kind.QUOTED || k == Kind.RPAREN || k == Kind.NUMBER;
  }

  static boolean isIdentStart(char c) {
    return Character.isLetter(c) || c == '_' || c >= 128;
  }

  static boolean isIdentPart(char c) {
    return isIdentStart(c) || Character.isDigit(c) || c == '$';
  }

  /** The source text spanned by tokens {@code [from, to)}, verbatim; empty when the range is. */
  public static String slice(String source, List<Token> tokens, int from, int to) {
    if (to <= from) {
      return "";
    }
    return source.substring(tokens.get(from).start, tokens.get(to - 1).end);
  }

  /** The index of the {@code )} matching the {@code (} at {@code open}, or -1. */
  public static int matching(List<Token> tokens, int open) {
    int depth = 0;
    for (int i = open; i < tokens.size(); i++) {
      Kind k = tokens.get(i).kind;
      if (k == Kind.LPAREN) {
        depth++;
      } else if (k == Kind.RPAREN) {
        depth--;
        if (depth == 0) {
          return i;
        }
      }
    }
    return -1;
  }

  /** The index of the {@code (} matching the {@code )} at {@code close}, or -1. */
  public static int matchingBack(List<Token> tokens, int close) {
    int depth = 0;
    for (int i = close; i >= 0; i--) {
      Kind k = tokens.get(i).kind;
      if (k == Kind.RPAREN) {
        depth++;
      } else if (k == Kind.LPAREN) {
        depth--;
        if (depth == 0) {
          return i;
        }
      }
    }
    return -1;
  }

  /** Splits {@code [from, to)} at the commas at its own nesting depth; empty pieces are kept. */
  public static List<int[]> splitTopLevel(List<Token> tokens, int from, int to) {
    List<int[]> parts = new ArrayList<int[]>();
    int depth = 0;
    int start = from;
    for (int i = from; i < to; i++) {
      Kind k = tokens.get(i).kind;
      if (k == Kind.LPAREN) {
        depth++;
      } else if (k == Kind.RPAREN) {
        depth--;
      } else if (k == Kind.COMMA && depth == 0) {
        parts.add(new int[] {start, i});
        start = i + 1;
      }
    }
    parts.add(new int[] {start, to});
    return parts;
  }

  /** Re-spells tokens as text: the originals, spaced, with no space around dots or inside parentheses. */
  public static String join(List<Token> tokens, int from, int to) {
    StringBuilder b = new StringBuilder();
    for (int i = from; i < to; i++) {
      Token t = tokens.get(i);
      if (b.length() > 0) {
        Token p = tokens.get(i - 1);
        boolean tight = t.kind == Kind.DOT || p.kind == Kind.DOT || t.kind == Kind.COMMA || t.kind == Kind.RPAREN
            || p.kind == Kind.LPAREN || (t.kind == Kind.LPAREN && (p.kind == Kind.WORD || p.kind == Kind.QUOTED));
        if (!tight) {
          b.append(' ');
        }
      }
      b.append(t.text);
    }
    return b.toString();
  }
}
