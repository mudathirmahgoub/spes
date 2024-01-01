package SimpleQueryTests;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonWriter;
import java.io.*;

public class BenchmarkFilter
{
  public static void main(String[] args) throws Exception
  {
    File f = new File("testData/calcite_tests.json");
    JsonParser parser = new JsonParser();
    JsonArray array = parser.parse(new FileReader(f)).getAsJsonArray();
    JsonArray filteredArray = new JsonArray();

    JsonWriter writer = new JsonWriter(
        new FileWriter("testData/no_aggregation_no_null_no_cast_no_outer_join.json"));
    Gson gson = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
    writer.beginArray();

    for (int i = 0; i < array.size(); i++)
    {
      JsonObject testCase = array.get(i).getAsJsonObject();
      String query1 = testCase.get("q1").getAsString();
      String query2 = testCase.get("q2").getAsString();
      if (supported(query1) || supported(query2))
      {
        continue;
      }
      gson.toJson(testCase, writer);
      filteredArray.add(testCase);
    }
    writer.endArray();
    writer.close();
  }

  private static boolean supported(String query)
  {
    return query.contains("SUM") || query.contains("COUNT") || query.contains("MIN")
        || query.contains("MAX") || query.contains("AVG") || query.contains("GROUP BY")
        || query.contains("NULL") || query.contains("CAST") || query.contains("LEFT")
        || query.contains("RIGHT") || query.contains("FULL");
  }
}
