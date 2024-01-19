package SimpleQueryTests;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.*;
import org.apache.calcite.rel.RelNode;

public class Cvc5Analysis
{
  public static void verify(String sql1, String sql2, String name) throws Exception
  {
    if (!(isSupported(sql1) && isSupported(sql2)))
    {
      return;
    }
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
      return;
    }
    if (compile)
    {
      try
      {
        long startTime = System.currentTimeMillis();
        // Cvc5BagsTranslator.translate(name, logicPlan, sql1, logicPlan2, sql2);
        Cvc5SetsTranslator.translate(name, logicPlan, sql1, logicPlan2, sql2);
      }
      catch (Exception e)
      {
        System.out.println("buggy in code");
        throw e;
      }
    }
    return;
  }

  public static void main(String[] args) throws Exception
  {
    File f = new File("testData/no_aggregation_no_null_no_cast_no_outer_join.json");
    JsonParser parser = new JsonParser();
    JsonArray array = parser.parse(new FileReader(f)).getAsJsonArray();
    for (int i = 0; i < array.size(); i++)
    {
      JsonObject testCase = array.get(i).getAsJsonObject();
      String query1 = testCase.get("q1").getAsString();
      String query2 = testCase.get("q2").getAsString();
      String name = testCase.get("name").getAsString();
      verify(query1, query2, name);
    }
  }

  static public boolean isSupported(String sql)
  {
    String[] keyWords = {"ROW", "ORDER", "CAST"};
    for (String keyWord : keyWords)
    {
      if (sql.contains(keyWord))
      {
        return false;
      }
    }
    return true;
  }
}
