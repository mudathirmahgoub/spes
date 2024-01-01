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
    File f = new File("testData/no_aggregation_no_null.json");
    JsonParser parser = new JsonParser();
    JsonArray array = parser.parse(new FileReader(f)).getAsJsonArray();
    JsonArray filteredArray = new JsonArray();

    JsonWriter writer = new JsonWriter(new FileWriter("testData/no_aggregation_no_null_no_cast.json"));
    Gson gson = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
    writer.beginArray();

    for (int i = 0; i < array.size(); i++)
    {
      JsonObject testCase = array.get(i).getAsJsonObject();
      String query1 = testCase.get("q1").getAsString();
      String query2 = testCase.get("q2").getAsString();
      //if (query1.contains("GROUP BY") || query2.contains("GROUP BY"))
      //if (query1.contains("NULL") || query2.contains("NULL"))
      if (query1.contains("CAST") || query2.contains("CAST"))
      {
        continue;
      }
      gson.toJson(testCase, writer);
      filteredArray.add(testCase);
    }
    writer.endArray();
    writer.close();
  }
}
