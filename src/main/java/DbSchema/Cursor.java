package DbSchema;

import java.util.ArrayList;
import java.util.List;

/** A read position in a statement's tokens, with the small lookaheads the DDL grammar needs. */
final class Cursor
{
  private final List<Token> tokens;
  private int position;

  Cursor(List<Token> tokens)
  {
    this.tokens = tokens;
  }

  boolean hasNext()
  {
    return position < tokens.size();
  }

  Token peek()
  {
    return tokens.get(position);
  }

  Token next()
  {
    return tokens.get(position++);
  }

  boolean peekIsKeyword(String keyword)
  {
    return hasNext() && peek().isKeyword(keyword);
  }

  boolean tryKeyword(String keyword)
  {
    if (peekIsKeyword(keyword))
    {
      position++;
      return true;
    }
    return false;
  }

  /** Consumes the whole sequence, or nothing at all if it is not all there. */
  boolean tryKeywords(String... keywords)
  {
    int start = position;
    for (String keyword : keywords)
    {
      if (!tryKeyword(keyword))
      {
        position = start;
        return false;
      }
    }
    return true;
  }

  boolean tryAnyKeyword(String... keywords)
  {
    for (String keyword : keywords)
    {
      if (tryKeyword(keyword))
      {
        return true;
      }
    }
    return false;
  }

  boolean tryPunctuation(String punctuation)
  {
    if (hasNext() && peek().isPunctuation(punctuation))
    {
      position++;
      return true;
    }
    return false;
  }

  /** Consumes a possibly qualified identifier, if one is next. */
  void skipIdentifier()
  {
    if (hasNext() && peek().isIdentifier())
    {
      position++;
      while (tryPunctuation(".") && hasNext() && peek().isIdentifier())
      {
        position++;
      }
    }
  }

  /** Whether {@code keyword} appears anywhere in what is left, without consuming anything. */
  boolean remainingHasKeyword(String keyword)
  {
    for (int i = position; i < tokens.size(); i++)
    {
      if (tokens.get(i).isKeyword(keyword))
      {
        return true;
      }
    }
    return false;
  }

  /** Advances to the next occurrence of {@code punctuation}, or to the end. */
  void skipUntilPunctuation(String punctuation)
  {
    while (hasNext() && !peek().isPunctuation(punctuation))
    {
      position++;
    }
  }

  /** With the opening {@code (} already consumed, skips to just past its {@code )}. */
  void skipGroup()
  {
    int depth = 1;
    while (hasNext() && depth > 0)
    {
      Token token = next();
      if (token.isPunctuation("("))
      {
        depth++;
      }
      else if (token.isPunctuation(")"))
      {
        depth--;
      }
    }
  }

  /**
   * With the opening {@code (} already consumed, reads to its {@code )} and splits what was
   * inside on the commas at that level -- the column definitions of a {@code CREATE TABLE},
   * the columns of a key, the arguments of a type.
   */
  List<List<Token>> commaSeparatedGroup()
  {
    List<List<Token>> items = new ArrayList<>();
    List<Token> current = new ArrayList<>();
    int depth = 1;
    while (hasNext())
    {
      Token token = next();
      if (token.isPunctuation("("))
      {
        depth++;
      }
      else if (token.isPunctuation(")"))
      {
        depth--;
        if (depth == 0)
        {
          break;
        }
      }
      else if (token.isPunctuation(",") && depth == 1)
      {
        items.add(current);
        current = new ArrayList<>();
        continue;
      }
      current.add(token);
    }
    if (!current.isEmpty())
    {
      items.add(current);
    }
    return items;
  }
}
