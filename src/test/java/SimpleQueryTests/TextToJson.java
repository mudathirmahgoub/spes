package SimpleQueryTests;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class TextToJson
{
  public static List<String> cvc5ProvenTests = new ArrayList<>();

  public static void main(String[] args) throws Exception
  {
    try
    {
      List<String> sparkTests = Files.readAllLines(Paths.get("sql_solver/spark_tests.sql"));

      List<Benchmark> benchmarks = new ArrayList<>();
      for (int i = 0; i < sparkTests.size(); i++)
      {
        Benchmark benchmark = new Benchmark();
        benchmark.name = String.valueOf(i/2+1);
        benchmark.q1 = sparkTests.get(i);
        i++;
        benchmark.q2 = sparkTests.get(i);
        benchmarks.add(benchmark);
      }
      Gson gson = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
      Writer writer = new FileWriter("testData/spark_tests.json");
      gson.toJson(benchmarks, writer);
      writer.flush();
      writer.close();
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }
}
