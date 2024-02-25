package SimpleQueryTests;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class JsonToText
{
  public static List<String> cvc5ProvenTests = new ArrayList<>();
  public static void main(String[] args) throws Exception
  {
    File f = new File("testData/no_aggregation.json");

    PrintWriter writer = new PrintWriter(new File("sql_solver/no_aggregation.sql"));

    JsonParser parser = new JsonParser();
    JsonArray array = parser.parse(new FileReader(f)).getAsJsonArray();
    for (int i = 0; i < array.size(); i++)
    {
      JsonObject testCase = array.get(i).getAsJsonObject();
      String query1 = testCase.get("q1").getAsString();
      String query2 = testCase.get("q2").getAsString();
      String name = testCase.get("name").getAsString();
      writer.println(query1);
      writer.println(query2);
    }
    writer.close();
  }
}
