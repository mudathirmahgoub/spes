package SimpleQueryTests;

import io.github.cvc5.Result;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
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
 */
public class Cvc5Analysis
{
  public static List<String> cvc5ProvenTests = new ArrayList<>();
  public static void main(String[] args) throws Exception
  {
    // Maven's exec:exec always passes the -Dq1/-Dq2/-Dsem/-Dout placeholders, so unset
    // ones arrive as empty strings. Only q1 and q2 decide the mode; blanks in the later
    // positions just fall back to their defaults.
    //   Cvc5Analysis "<query1>" "<query2>" [bags|sets] [output.smt2]
    if (args.length >= 2 && !isBlank(args[0]) && !isBlank(args[1]))
    {
      verifyPair(args);
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
        Result result = verify(query1, query2, name, writer, isSetSemantics);
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
      catch (Exception e)
      {
        // A genuine translation failure. Recorded rather than fatal so one bad query
        // cannot hide the results of the other 200.
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

  public static void verifyPair(String[] args) throws Exception
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
      verify(sql1, sql2, "commandLine", writer, isSetSemantics);
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

  public static Result verify(
      String sql1, String sql2, String name, PrintWriter writer, boolean isSetSemantics)
      throws Exception
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
      simpleParser parser = new simpleParser();
      simpleParser parser2 = new simpleParser();

      logicPlan = parser.getRelNode(sql1);
      logicPlan2 = parser2.getRelNode(sql2);
      compile = true;
    }
    catch (Exception e)
    {
      throw new UnsupportedOperationException("could not parse " + name + ": " + e.getMessage());
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
