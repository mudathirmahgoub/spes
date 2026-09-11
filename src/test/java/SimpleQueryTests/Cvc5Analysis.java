package SimpleQueryTests;

import DbSchema.DatabaseSchema;
import DbSchema.Dialect;
import io.github.cvc5.Result;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.apache.calcite.rel.RelNode;

/**
 * Entry point for checking SQL query equivalence with cvc5.
 *
 * <p>Two modes:
 *
 * <pre>
 *   Cvc5Analysis "&lt;query1&gt;" "&lt;query2&gt;" [bags|sets] [output.smt2]
 *   Cvc5Analysis                     # batch, driven by -Dbatch / -Dsem / -Dout
 * </pre>
 *
 * <p>Both write the full SMT-LIB problem they handed to the solver, so a result can be
 * re-checked with the {@code cvc5} binary directly.
 *
 * <p>Either mode takes the tables to check against from {@code -schema=<file>} and the accent
 * they and the queries are written in from {@code -dialect=<name>}; both also work as
 * {@code -Dschema=} / {@code -Ddialect=} system properties, which is how Maven passes them.
 * Without them the queries are checked against the built-in {@code EMP}/{@code DEPT} schema.
 *
 * <p>Every inequivalent pair also leaves behind the counterexample as a SQLite file holding
 * the model's rows and both queries, which {@code -Dcex} and {@code -Dcex.dir} control; see
 * {@link CounterexampleDatabase}. {@code -Dcex.show=<file>} prints one of those files back and
 * does nothing else, for a machine with no {@code sqlite3} command.
 */
public class Cvc5Analysis
{
  public static List<String> cvc5ProvenTests = new ArrayList<>();
  public static void main(String[] args) throws Exception
  {
    // Named options arrive either as -name=value arguments or as -Dname=value properties;
    // exec:exec uses both shapes, so both are read. What is left over is positional.
    Map<String, String> options = new LinkedHashMap<>();
    List<String> positional = new ArrayList<>();
    for (String arg : args)
    {
      int equals = arg == null ? -1 : arg.indexOf('=');
      if (arg != null && arg.startsWith("-") && equals > 1)
      {
        options.put(arg.substring(1, equals).trim().toLowerCase(Locale.ROOT),
            arg.substring(equals + 1));
      }
      else
      {
        positional.add(arg);
      }
    }
    // Reading a counterexample file back, which solves nothing and needs no schema.
    String show = option(options, "cex.show");
    if (!isBlank(show))
    {
      CounterexampleDatabase.show(new File(show), System.out);
      return;
    }
    DatabaseSchema schema = schema(option(options, "schema"), option(options, "dialect"));
    // The counterexample replay reads its own options as properties, which is how exec:exec
    // passes them; the argument form is accepted too, for symmetry with -schema.
    for (String name : new String[] {"cex", "cex.dir", "cex.url"})
    {
      String value = options.get(name);
      if (!isBlank(value))
      {
        System.setProperty(name, value);
      }
    }
    // Resolved here so a mistyped backend stops the run now rather than at its first sat.
    System.out.println("; counterexamples : " + CounterexampleDatabase.describe());

    // Maven's exec:exec always passes the -Dq1/-Dq2/-Dsem/-Dout placeholders, so unset
    // ones arrive as empty strings. Only q1 and q2 decide the mode; blanks in the later
    // positions just fall back to their defaults.
    //   Cvc5Analysis "<query1>" "<query2>" [bags|sets] [output.smt2]
    if (positional.size() >= 2 && !isBlank(positional.get(0)) && !isBlank(positional.get(1)))
    {
      verifyPair(positional.toArray(new String[0]), schema);
      return;
    }

    // Batch mode. All three are overridable:
    //   -Dbatch=<file.json>  -Dsem=bags|sets  -Dout=<file.smt2>
    // exec:exec always defines these, so an unset one arrives as an empty string
    File f = new File(property("batch", "testData/no_aggregation_sat.json"));
    boolean isSetSemantics = "sets".equalsIgnoreCase(property("sem", "bags"));
    String output = property("out", isSetSemantics ? "min_sets_sat.smt2" : "min_bags_sat.smt2");
    System.out.println("; batch     : " + f);
    System.out.println("; semantics : " + (isSetSemantics ? "sets" : "bags"));
    System.out.println("; smt2 file : " + output);
    PrintWriter writer = new PrintWriter(new File(output));

    JsonParser parser = new JsonParser();
    JsonArray array = parser.parse(new FileReader(f)).getAsJsonArray();
    int unsupported = 0;
    int errors = 0;
    for (int i = 0; i < array.size(); i++)
    {
      JsonObject testCase = array.get(i).getAsJsonObject();
      String query1 = testCase.get("q1").getAsString();
      String query2 = testCase.get("q2").getAsString();
      String name = testCase.get("name").getAsString();
      try
      {
        Result result = verify(query1, query2, name, writer, isSetSemantics, schema);
        String verdict = result == null ? "filtered"
            : result.isUnsat() ? "equivalent"
            : result.isSat() ? "inequivalent" : "unknown";
        System.out.println("; RESULT " + name + " " + verdict);
      }
      catch (UnsupportedOperationException e)
      {
        // A construct the translator refuses to encode. Skipping keeps the batch going;
        // the alternative used to be a silently wrong encoding, which is worse.
        unsupported++;
        report(writer, "; skipped " + name + ": " + e.getMessage());
        System.out.println("; RESULT " + name + " skipped");
      }
      catch (Throwable e)
      {
        // A genuine translation failure. Recorded rather than fatal so one bad query
        // cannot hide the results of the other 200 -- Throwable, not Exception, because
        // Calcite reports some conversion failures as a bare AssertionError, and one of
        // those used to end the run at whichever query hit it.
        errors++;
        report(writer, "; error " + name + ": " + e);
        System.out.println("; RESULT " + name + " error");
      }
    }

    writer.println("; unsupported   : " + unsupported);
    writer.println("; errors        : " + errors);
    writer.println("; total time: " + Cvc5AbstractTranslator.totalTime + " ms.");
    writer.println("; sat answers    : " + Cvc5AbstractTranslator.satAnswers);
    writer.println("; unsat answers  : " + Cvc5AbstractTranslator.unsatAnswers);
    writer.println("; unknown answers: " + Cvc5AbstractTranslator.unknownAnswers);
    // On stdout as well as in the file: an unconfirmed counterexample means an encoding is
    // wrong, and that is not something to find only by reading a 500 MB SMT-LIB file later.
    report(writer,
        "; counterexamples : " + Cvc5AbstractTranslator.confirmedCounterexamples + " confirmed of "
            + Cvc5AbstractTranslator.replayedCounterexamples + " replayed, in "
            + CounterexampleDatabase.describe());
    writer.close();
    // System.out.println("Proved by spes and not cvc5:");
    // for (String test : spesProvenTests)
    // {
    //   if (cvc5ProvenTests.contains(test))
    //   {
    //     continue;
    //   }
    //   System.out.println(test);
    // }
    // System.out.println("Proved by cvc5 and not spes:");
    // for (String test : cvc5ProvenTests)
    // {
    //   if (spesProvenTests.contains(test))
    //   {
    //     continue;
    //   }
    //   System.out.println(test);
    // }
  }

  /**
   * Checks a single pair of queries supplied on the command line.
   *
   * <pre>
   *   Cvc5Analysis "&lt;query1&gt;" "&lt;query2&gt;" [bags|sets] [output.smt2]
   * </pre>
   *
   * Semantics defaults to bags, output file to single.smt2. Prints the raw cvc5 answer
   * plus its reading: unsat means the two queries were proved equivalent, sat means a
   * counterexample database was found, unknown means the solver hit its time limit.
   */
  private static void report(PrintWriter writer, String message)
  {
    writer.println(message);
    writer.flush();
    System.out.println(message);
  }

  /**
   * The schema queries are checked against: whatever {@code -schema} names -- a file, a
   * classpath resource, or DDL written out in full -- read in whatever accent
   * {@code -dialect} names. Both default to the built-in schema in Calcite's own accent.
   */
  static DatabaseSchema schema(String source, String dialectName)
  {
    Dialect dialect = Dialect.of(dialectName);
    DatabaseSchema schema = isBlank(source) && dialect == Dialect.CALCITE
        ? DatabaseSchema.defaultSchema()
        : DatabaseSchema.load(isBlank(source) ? DatabaseSchema.DEFAULT_SCHEMA : source, dialect);
    System.out.println("; schema    : " + schema.describe());
    List<String> warnings = schema.warnings();
    for (int i = 0; i < Math.min(warnings.size(), 10); i++)
    {
      System.out.println("; schema    ! " + warnings.get(i));
    }
    if (warnings.size() > 10)
    {
      System.out.println("; schema    ! ... and " + (warnings.size() - 10) + " more");
    }
    return schema;
  }

  /** A named option, from an argument if it was given there, otherwise from a system property. */
  private static String option(Map<String, String> options, String name)
  {
    String value = options.get(name);
    return isBlank(value) ? property(name, "") : value.trim();
  }

  /** A system property, treating an empty value as unset. */
  private static String property(String name, String fallback)
  {
    String value = System.getProperty(name);
    return isBlank(value) ? fallback : value.trim();
  }

  private static boolean isBlank(String s)
  {
    return s == null || s.trim().isEmpty();
  }

  public static void verifyPair(String[] args, DatabaseSchema schema) throws Exception
  {
    String sql1 = args[0].trim();
    String sql2 = args[1].trim();
    String semantics = args.length >= 3 && !isBlank(args[2]) ? args[2].trim() : "bags";
    boolean isSetSemantics = semantics.equalsIgnoreCase("sets");
    String output = args.length >= 4 && !isBlank(args[3]) ? args[3].trim() : "single.smt2";

    System.out.println("q1        : " + sql1);
    System.out.println("q2        : " + sql2);
    System.out.println("semantics : " + (isSetSemantics ? "sets" : "bags"));
    System.out.println("smt2 file : " + output);
    System.out.println();

    PrintWriter writer = new PrintWriter(new File(output));
    try
    {
      verify(sql1, sql2, "commandLine", writer, isSetSemantics, schema);
    }
    finally
    {
      writer.close();
    }

    System.out.println();
    if (Cvc5AbstractTranslator.unsatAnswers > 0)
    {
      System.out.println("result: unsat -- the queries are EQUIVALENT");
    }
    else if (Cvc5AbstractTranslator.satAnswers > 0)
    {
      System.out.println("result: sat -- the queries are NOT equivalent");
    }
    else if (Cvc5AbstractTranslator.unknownAnswers > 0)
    {
      System.out.println("result: unknown -- solver gave up (see tlimit-per)");
    }
    else
    {
      System.out.println("result: skipped -- unsupported query (see isSupported)");
    }
    System.out.println("elapsed: " + Cvc5AbstractTranslator.totalTime + " ms");
  }

  /** Checks one pair against the built-in schema. */
  public static Result verify(
      String sql1, String sql2, String name, PrintWriter writer, boolean isSetSemantics)
      throws Exception
  {
    return verify(sql1, sql2, name, writer, isSetSemantics, DatabaseSchema.defaultSchema());
  }

  public static Result verify(String sql1, String sql2, String name, PrintWriter writer,
      boolean isSetSemantics, DatabaseSchema schema) throws Exception
  {
    if (!(isSupported(sql1) && isSupported(sql2)))
    {
      return null;
    }
    // Always translate with nullable column sorts. The isNullable(sql) heuristic below is
    // kept because it documents which queries obviously need them, but a column can be
    // nullable without any of those keywords appearing, and the aggregate encoding needs a
    // null to mean "no value yet" regardless.
    boolean isNullable = true;
    RelNode logicPlan = null;
    RelNode logicPlan2 = null;
    boolean compile = false;
    try
    {
      simpleParser parser = new simpleParser(schema);
      simpleParser parser2 = new simpleParser(schema);

      logicPlan = parser.getRelNode(sql1);
      logicPlan2 = parser2.getRelNode(sql2);
      compile = true;
    }
    catch (Exception | AssertionError e)
    {
      // Calcite throws a bare AssertionError out of SqlToRelConverter for some queries, and
      // its message is null, so fall back to the class name rather than printing "null".
      String reason = e.getMessage() == null ? e.toString() : e.getMessage();
      throw new UnsupportedOperationException("could not parse " + name + ": " + reason);
    }
    if (compile)
    {
      try
      {
        Cvc5AbstractTranslator translator;
        if (isSetSemantics)
        {
          translator = new Cvc5SetsTranslator(isNullable, writer);
        }
        else
        {
          translator = new Cvc5BagsTranslator(isNullable, writer);
        }
        return translator.translate(name, logicPlan, sql1, logicPlan2, sql2);
      }
      catch (UnsupportedOperationException e)
      {
        throw e;
      }
      catch (Exception e)
      {
        // not a refusal but a genuine failure to encode a supported construct
        System.out.println("translation failed for " + name);
        throw e;
      }
    }
    return null;
  }

  /** Queries the batch driver skips outright, before any parsing. */
  static public boolean isSupported(String sql)
  {
    String[] keyWords = {"ORDER"};
    for (String keyWord : keyWords)
    {
      if (sql.contains(keyWord))
      {
        return false;
      }
    }
    return true;
  }
  /**
   * A rough syntactic hint that a query involves nulls. Not used to decide anything -- see
   * {@link #verify} -- but kept as documentation of which constructs introduce them.
   */
  static public boolean isNullable(String sql)
  {
    String[] keyWords = {"NULL", "LEFT", "RIGHT", "FULL"};
    for (String keyWord : keyWords)
    {
      if (sql.contains(keyWord))
      {
        return true;
      }
    }
    return false;
  }
}
