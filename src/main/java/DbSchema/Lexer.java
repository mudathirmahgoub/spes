package DbSchema;

import java.util.ArrayList;
import java.util.List;

/**
 * Turns a schema file into statements of tokens.
 *
 * <p>It has to survive everything a dump writes around the DDL: {@code --} and {@code /* *}{@code /}
 * comments, MySQL's {@code #} comments and its {@code /*!40101 ... *}{@code /} conditional blocks,
 * quoted identifiers in whichever of the three styles the dialect uses, string literals with
 * doubled or backslash-escaped quotes, and PostgreSQL's {@code $$}-quoted function bodies --
 * which matter only because they contain semicolons that must not split a statement.
 */
final class Lexer
{
  private final String input;
  private final Dialect dialect;
  private int position;

  private Lexer(String input, Dialect dialect)
  {
    this.input = input;
    this.dialect = dialect;
  }

  /** Splits {@code ddl} into statements at top-level semicolons, dropping empty ones. */
  static List<List<Token>> statements(String ddl, Dialect dialect)
  {
    Lexer lexer = new Lexer(ddl, dialect);
    List<List<Token>> statements = new ArrayList<>();
    List<Token> current = new ArrayList<>();
    Token token;
    while ((token = lexer.next()) != null)
    {
      if (token.isPunctuation(";"))
      {
        if (!current.isEmpty())
        {
          statements.add(current);
          current = new ArrayList<>();
        }
      }
      else
      {
        current.add(token);
      }
    }
    if (!current.isEmpty())
    {
      statements.add(current);
    }
    return statements;
  }

  private Token next()
  {
    skipWhitespaceAndComments();
    if (position >= input.length())
    {
      return null;
    }
    char c = input.charAt(position);
    if (c == '\'')
    {
      return new Token(Token.Kind.STRING, readQuoted('\'', '\''), false);
    }
    if (c == '`')
    {
      return new Token(Token.Kind.WORD, readQuoted('`', '`'), true);
    }
    if (c == '"')
    {
      return new Token(Token.Kind.WORD, readQuoted('"', '"'), true);
    }
    if (c == '[' && bracketQuotesIdentifiers())
    {
      return new Token(Token.Kind.WORD, readQuoted('[', ']'), true);
    }
    if (c == '$' && dollarQuoteLength() > 0)
    {
      return new Token(Token.Kind.STRING, readDollarQuoted(), false);
    }
    if (Character.isDigit(c))
    {
      return new Token(Token.Kind.NUMBER, readWhile("0123456789."), false);
    }
    if (isWordStart(c))
    {
      StringBuilder word = new StringBuilder();
      while (position < input.length() && isWordPart(input.charAt(position)))
      {
        word.append(input.charAt(position++));
      }
      return new Token(Token.Kind.WORD, word.toString(), false);
    }
    position++;
    return new Token(Token.Kind.PUNCTUATION, String.valueOf(c), false);
  }

  /** SQL Server writes {@code [x]}; PostgreSQL writes {@code integer[]}, an array of integers. */
  private boolean bracketQuotesIdentifiers()
  {
    return dialect == Dialect.SQLSERVER || dialect == Dialect.SQLITE;
  }

  private boolean hashStartsComment()
  {
    return dialect == Dialect.MYSQL || dialect == Dialect.SPARK || dialect == Dialect.BIGQUERY;
  }

  private static boolean isWordStart(char c)
  {
    return Character.isLetter(c) || c == '_' || c == '$' || c == '@';
  }

  private static boolean isWordPart(char c)
  {
    return Character.isLetterOrDigit(c) || c == '_' || c == '$' || c == '@' || c == '#';
  }

  private void skipWhitespaceAndComments()
  {
    while (position < input.length())
    {
      char c = input.charAt(position);
      if (Character.isWhitespace(c))
      {
        position++;
      }
      else if (c == '-' && peekIs(1, '-'))
      {
        skipToEndOfLine();
      }
      else if (c == '#' && hashStartsComment())
      {
        skipToEndOfLine();
      }
      else if (c == '/' && peekIs(1, '*'))
      {
        // this also swallows MySQL's /*!40101 ... */, whose contents are session settings
        int end = input.indexOf("*/", position + 2);
        position = end < 0 ? input.length() : end + 2;
      }
      else
      {
        return;
      }
    }
  }

  private void skipToEndOfLine()
  {
    int end = input.indexOf('\n', position);
    position = end < 0 ? input.length() : end + 1;
  }

  private boolean peekIs(int offset, char c)
  {
    return position + offset < input.length() && input.charAt(position + offset) == c;
  }

  /**
   * Reads a quoted run, taking a doubled closing quote as an escaped one and -- for string
   * literals, where MySQL allows it -- a backslash as escaping the next character.
   */
  private String readQuoted(char open, char close)
  {
    position++; // the opening quote
    StringBuilder text = new StringBuilder();
    while (position < input.length())
    {
      char c = input.charAt(position);
      if (c == '\\' && open == '\'' && position + 1 < input.length())
      {
        text.append(input.charAt(position + 1));
        position += 2;
      }
      else if (c == close)
      {
        if (peekIs(1, close))
        {
          text.append(close);
          position += 2;
        }
        else
        {
          position++;
          return text.toString();
        }
      }
      else
      {
        text.append(c);
        position++;
      }
    }
    return text.toString(); // unterminated: take what there was
  }

  /** @return the length of the {@code $tag$} opening at the cursor, or 0 if this is not one */
  private int dollarQuoteLength()
  {
    int end = position + 1;
    while (end < input.length() && (Character.isLetterOrDigit(input.charAt(end)) || input.charAt(end) == '_'))
    {
      end++;
    }
    return end < input.length() && input.charAt(end) == '$' ? end + 1 - position : 0;
  }

  private String readDollarQuoted()
  {
    int tagLength = dollarQuoteLength();
    String tag = input.substring(position, position + tagLength);
    int end = input.indexOf(tag, position + tagLength);
    String body = end < 0 ? input.substring(position + tagLength)
                          : input.substring(position + tagLength, end);
    position = end < 0 ? input.length() : end + tagLength;
    return body;
  }

  private String readWhile(String accepted)
  {
    StringBuilder text = new StringBuilder();
    while (position < input.length() && accepted.indexOf(input.charAt(position)) >= 0)
    {
      text.append(input.charAt(position++));
    }
    return text.toString();
  }
}
