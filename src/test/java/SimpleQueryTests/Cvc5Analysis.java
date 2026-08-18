package SimpleQueryTests;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import org.apache.calcite.rel.RelNode;

public class Cvc5Analysis
{
  public static List<String> cvc5ProvenTests = new ArrayList<>();
  public static void main(String[] args) throws Exception
  {
    // Drop blank arguments. Maven's exec:exec always passes the -Dq1/-Dq2/-Dsem/-Dout
    // placeholders, and the ones the user did not set arrive as empty strings.
    List<String> given = new ArrayList<>();
    for (String arg : args)
    {
      if (arg != null && !arg.trim().isEmpty())
      {
        given.add(arg.trim());
      }
    }

    // Two-query mode: compare a single pair given on the command line.
    //   Cvc5Analysis "<query1>" "<query2>" [bags|sets] [output.smt2]
    if (given.size() >= 2)
    {
      verifyPair(given.toArray(new String[0]));
      return;
    }

    File f = new File("testData/no_aggregation_sat.json");
    // File f = new File("testData/test.json");    

    boolean isSetSemantics = false;
    PrintWriter writer;
    if (isSetSemantics)
    {
      writer = new PrintWriter(new File("min_sets_sat.smt2"));
    }
    else
    {
      writer = new PrintWriter(new File("min_bags_sat.smt2"));
    }

    JsonParser parser = new JsonParser();
    JsonArray array = parser.parse(new FileReader(f)).getAsJsonArray();
    for (int i = 0; i < array.size(); i++)
    {
      JsonObject testCase = array.get(i).getAsJsonObject();
      String query1 = testCase.get("q1").getAsString();
      String query2 = testCase.get("q2").getAsString();
      String name = testCase.get("name").getAsString();
      verify(query1, query2, name, writer, isSetSemantics);
    }

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
  public static void verifyPair(String[] args) throws Exception
  {
    String sql1 = args[0];
    String sql2 = args[1];
    boolean isSetSemantics = args.length >= 3 && args[2].equalsIgnoreCase("sets");
    String output = args.length >= 4 ? args[3] : "single.smt2";

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

  public static void verify(
      String sql1, String sql2, String name, PrintWriter writer, boolean isSetSemantics)
      throws Exception
  {
    if (!(isSupported(sql1) && isSupported(sql2)))
    {
      return;
    }
    boolean isNullable = isNullable(sql1) || isNullable(sql2);
    isNullable = true;
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
      e.printStackTrace();
      System.out.println("fail compile");
      System.out.println("test: " + name);
      System.exit(1);
      // return;
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
        translator.translate(name, logicPlan, sql1, logicPlan2, sql2);
      }
      catch (Exception e)
      {
        System.out.println("buggy in code");
        throw e;
      }
    }
    return;
  }

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
