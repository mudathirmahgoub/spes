package SimpleQueryTests;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import org.apache.calcite.rel.RelNode;

public class Cvc5Analysis
{
  public static List<String> cvc5ProvenTests = new ArrayList<>();
  public static void main(String[] args) throws Exception
  {
    File f = new File("testData/test.json");
    //File f = new File("testData/test.json");    

    boolean isSetSemantics = false;
    PrintWriter writer;
    if (isSetSemantics)
    {
      writer = new PrintWriter(new File("spark_tests_sets.smt2"));
    }
    else
    {
      writer = new PrintWriter(new File("spark_tests_bags.smt2"));
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
