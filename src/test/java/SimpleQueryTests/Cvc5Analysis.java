package SimpleQueryTests;

import AlgeNode.AlgeNode;
import AlgeNodeParser.AlgeNodeParserPair;
import AlgeRule.AlgeRule;
import Z3Helper.z3Utility;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.microsoft.z3.Context;
import java.io.*;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.core.JoinRelType;
import org.apache.calcite.rel.logical.LogicalAggregate;
import org.apache.calcite.rel.logical.LogicalJoin;

public class Cvc5Analysis
{
  static long time = 0;
  static int SPJcount = 0;
  static long SPJTime = 0;
  static int aggCount = 0;
  static long aggTime = 0;
  static int outerJoinCount = 0;
  static long outerJoinTime = 0;

  public static boolean BeVerified(String sql1,
      String sql2,
      String name,
      PrintWriter cannotCompile,
      PrintWriter cannotProve,
      PrintWriter prove,
      PrintWriter bug) throws Exception
  {
    if ((contains(sql1)) || (contains(sql2)))
    {
      return false;
    }
    RelNode logicPlan = null;
    RelNode logicPlan2 = null;
    boolean compile = false;
    try
    {
      z3Utility.reset();
      simpleParser parser = new simpleParser();
      simpleParser parser2 = new simpleParser();

      logicPlan = parser.getRelNode(sql1);
      logicPlan2 = parser2.getRelNode(sql2);
      // System.out.println(RelOptUtil.toString(logicPlan));
      // System.out.println(RelOptUtil.toString(logicPlan2));
      compile = true;
    }
    catch (Exception e)
    {
      System.out.println("fail compile");
      cannotCompile.println(name);
      cannotCompile.println("---------------------------------------------------");
      cannotCompile.println(e);
      StackTraceElement[] reasons = e.getStackTrace();
      for (int i = 0; i < reasons.length; i++)
      {
        cannotCompile.println(reasons[i].toString());
      }
      cannotCompile.println("---------------------------------------------------");
      return false;
    }
    if (compile)
    {
      Context z3Context = new Context();
      try
      {
        long startTime = System.currentTimeMillis();
        AlgeNode algeExpr = AlgeNodeParserPair.constructAlgeNode(logicPlan, z3Context);
        AlgeNode algeExpr2 = AlgeNodeParserPair.constructAlgeNode(logicPlan2, z3Context);
        algeExpr = AlgeRule.normalize(algeExpr);
        algeExpr2 = AlgeRule.normalize(algeExpr2);
        Cvc5BagsTranslator.translate(name, logicPlan, sql1, logicPlan2, sql2);
      }
      catch (Exception e)
      {
        System.out.println("buggy in code");
        z3Context.close();
        bug.println(name);
        bug.println("---------------------------------------------------");
        bug.println(e);
        StackTraceElement[] reasons = e.getStackTrace();
        for (int i = 0; i < reasons.length; i++)
        {
          bug.println(reasons[i].toString());
        }
        bug.println("---------------------------------------------------");
        bug.flush();
        throw e;
      }
    }
    return false;
  }

  public static void main(String[] args) throws Exception
  {
    File f = new File("testData/no_aggregation_no_null_no_cast_no_outer_join.json");
    JsonParser parser = new JsonParser();
    JsonArray array = parser.parse(new FileReader(f)).getAsJsonArray();
    FileWriter prove = new FileWriter("calciteProve.txt");
    BufferedWriter bw = new BufferedWriter(prove);
    PrintWriter out = new PrintWriter(bw);
    FileWriter notProve = new FileWriter("cannotProve.txt");
    BufferedWriter bw2 = new BufferedWriter(notProve);
    PrintWriter out2 = new PrintWriter(bw2);
    FileWriter notCompile = new FileWriter("cannotCompile.txt");
    BufferedWriter bw3 = new BufferedWriter(notCompile);
    PrintWriter out3 = new PrintWriter(bw3);
    FileWriter bug = new FileWriter("bug.txt");
    BufferedWriter bw4 = new BufferedWriter(bug);
    PrintWriter out4 = new PrintWriter(bw4);
    int count = 0;
    for (int i = 0; i < array.size(); i++)
    {
      JsonObject testCase = array.get(i).getAsJsonObject();
      String query1 = testCase.get("q1").getAsString();
      String query2 = testCase.get("q2").getAsString();
      String name = testCase.get("name").getAsString();

      // if(!name.equals("testSemiJoinRuleExists")){
      // continue;
      // }

      boolean result = BeVerified(query1, query2, name, out3, out2, out, out4);
      if (result)
      {
        count++;
      }
    }
    out.close();
    out2.close();
    out3.close();
    out4.close();
  }

  static public boolean contains(String sql)
  {
    String[] keyWords = {"VALUE", "EXISTS", "ROW", "ORDER", "CAST", "INTERSECT", "EXCEPT", " IN "};
    for (String keyWord : keyWords)
    {
      if (sql.contains(keyWord))
      {
        return true;
      }
    }
    return false;
  }

  static public boolean hasAgg(RelNode plan)
  {
    if (plan instanceof LogicalAggregate)
    {
      return true;
    }
    for (RelNode input : plan.getInputs())
    {
      if (hasAgg(input))
      {
        return true;
      }
    }
    return false;
  }

  static public boolean outerJoin(RelNode plan)
  {
    if (plan instanceof LogicalJoin)
    {
      LogicalJoin join = (LogicalJoin) plan;
      if (join.getJoinType() != JoinRelType.INNER)
      {
        return true;
      }
    }
    for (RelNode input : plan.getInputs())
    {
      if (outerJoin(input))
      {
        return true;
      }
    }
    return false;
  }
}
