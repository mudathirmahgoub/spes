package DbSchema;

import java.util.Locale;

/** One lexical item of a DDL file. */
final class Token
{
  enum Kind
  {
    /** A bare word, or -- when {@link #quoted} -- a delimited identifier. */
    WORD,
    NUMBER,
    STRING,
    PUNCTUATION
  }

  final Kind kind;
  final String text;
  final boolean quoted;

  Token(Kind kind, String text, boolean quoted)
  {
    this.kind = kind;
    this.text = text;
    this.quoted = quoted;
  }

  boolean isIdentifier()
  {
    return kind == Kind.WORD;
  }

  /** An unquoted word, which is the only thing that can be a keyword. */
  boolean isWord()
  {
    return kind == Kind.WORD && !quoted;
  }

  boolean isNumber()
  {
    return kind == Kind.NUMBER;
  }

  boolean isString()
  {
    return kind == Kind.STRING;
  }

  boolean isPunctuation(String punctuation)
  {
    return kind == Kind.PUNCTUATION && text.equals(punctuation);
  }

  boolean isKeyword(String keyword)
  {
    return isWord() && text.equalsIgnoreCase(keyword);
  }

  String upper()
  {
    return text.toUpperCase(Locale.ROOT);
  }

  @Override
  public String toString()
  {
    return text;
  }
}
