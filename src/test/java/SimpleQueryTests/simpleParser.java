package SimpleQueryTests;

import DbSchema.DatabaseSchema;
import org.apache.calcite.adapter.java.JavaTypeFactory;
import org.apache.calcite.jdbc.JavaTypeFactoryImpl;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.type.RelDataTypeSystem;
import org.apache.calcite.sql.SqlNode;
import org.apache.calcite.sql.parser.SqlParseException;
import org.apache.calcite.tools.FrameworkConfig;
import org.apache.calcite.tools.Frameworks;
import org.apache.calcite.tools.Planner;
import org.apache.calcite.tools.RelConversionException;
import org.apache.calcite.tools.ValidationException;

/**
 * Parses one query into a relational plan, against a chosen {@link DatabaseSchema}.
 *
 * <p>A planner can only be used for one query, so a parser is short-lived: one per query. The
 * schema behind it is not -- it is parsed once and shared -- and it carries the accent, so the
 * same object decides both which tables exist and how a query's identifiers are folded to find
 * them.
 */
public class simpleParser
{
  public static final JavaTypeFactory typeFactory =
      new JavaTypeFactoryImpl(RelDataTypeSystem.DEFAULT);

  private final DatabaseSchema schema;
  private final Planner planner;

  /** Parses against the built-in EMP/DEPT schema, in Calcite's own accent. */
  public simpleParser()
  {
    this(DatabaseSchema.defaultSchema());
  }

  public simpleParser(DatabaseSchema schema)
  {
    this.schema = schema;
    FrameworkConfig config = Frameworks.newConfigBuilder()
                                 .defaultSchema(schema.rootSchema())
                                 .parserConfig(schema.parserConfig())
                                 .build();
    this.planner = Frameworks.getPlanner(config);
  }

  public DatabaseSchema schema()
  {
    return schema;
  }

  public RelNode getRelNode(String sql)
      throws SqlParseException, ValidationException, RelConversionException
  {
    System.out.println("parsing query: " + sql);
    SqlNode parse = planner.parse(sql);
    SqlNode validate = planner.validate(parse);
    return planner.rel(validate).rel;
  }
}
