package SimpleQueryTests;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import org.apache.calcite.jdbc.CalciteConnection;
import org.apache.calcite.schema.SchemaPlus;
import org.apache.calcite.sql.parser.SqlParseException;
import org.apache.calcite.tools.RelConversionException;
import org.apache.calcite.tools.ValidationException;

public class PostgresDatabase
{
  public static void main(String[] args)
      throws SQLException, SqlParseException, ValidationException, RelConversionException
  {
    CalciteConnection calciteConnection =
        DriverManager.getConnection("jdbc:calcite:").unwrap(CalciteConnection.class);
    SchemaPlus rootSchema = calciteConnection.getRootSchema();
    String url = "jdbc:postgresql://localhost/spes?user=postgres&password=abc";
    Connection connection = DriverManager.getConnection(url);
    Statement statement = connection.createStatement();
    ResultSet rs = statement.executeQuery("select * from spes.public.emp");
    while (rs.next())
    {
      ResultSetMetaData rsmd = rs.getMetaData();
      for (int i = 1; i <= rsmd.getColumnCount(); i++)
      {
        if (i > 1)
          System.out.print(",  ");
        String columnValue = rs.getString(i);
        System.out.print(columnValue + " " + rsmd.getColumnName(i));
      }
    }
    connection.close();
    // rootSchema.add("main", JdbcSchema.create(rootSchema, "main", ds, null, "public"));
    // FrameworkConfig config = Frameworks.newConfigBuilder().defaultSchema(rootSchema).build();

    // Planner planner = Frameworks.getPlanner(config);

    // SqlNode sqlNode = planner.parse("select * from public.emp");
    // System.out.println(sqlNode.toString());

    // sqlNode = planner.validate(sqlNode);

    // RelRoot relRoot = planner.rel(sqlNode);
    // System.out.println(relRoot.toString());

    // RelNode relNode = relRoot.project();
    // System.out.println(RelOptUtil.toString(relNode));
  }
}
