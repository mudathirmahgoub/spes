package sqleq;

import java.io.File;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.calcite.plan.RelOptUtil;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.sql.SqlFunction;
import org.apache.calcite.sql.SqlIdentifier;
import org.apache.calcite.sql.SqlSyntax;
import org.apache.calcite.sql.parser.SqlParserPos;
import org.apache.calcite.sql.SqlFunctionCategory;
import org.apache.calcite.sql.SqlNode;
import org.apache.calcite.sql.SqlOperator;
import org.apache.calcite.sql.SqlOperatorTable;
import org.apache.calcite.sql.fun.SqlStdOperatorTable;
import org.apache.calcite.sql.type.OperandTypes;
import org.apache.calcite.sql.type.ReturnTypes;
import org.apache.calcite.sql.type.SqlTypeFamily;
import org.apache.calcite.sql.type.SqlTypeName;
import org.apache.calcite.sql.type.SqlTypeTransforms;
import org.apache.calcite.sql.util.ChainedSqlOperatorTable;
import org.apache.calcite.tools.FrameworkConfig;
import org.apache.calcite.tools.Frameworks;
import org.apache.calcite.tools.Planner;

import DbSchema.DatabaseSchema;
import DbSchema.Dialect;
import SimpleQueryTests.Cvc5AbstractTranslator;
import SimpleQueryTests.Cvc5BagsTranslator;
import SimpleQueryTests.Cvc5SetsTranslator;
import io.github.cvc5.Result;
import sqleq.input.Batch;
import sqleq.input.DdlOut;
import sqleq.input.Declares;
import sqleq.input.Frontend;
import sqleq.input.ParamTypes;
import sqleq.input.Unsupported;

/**
 * The cvc5 translator on sqleq's input: pair files with PostgreSQL DDL, {@code $N} parameters,
 * and {@code DELETE}/{@code UPDATE}/{@code INSERT} pairs.
 *
 * <p>The pair is read by {@link Frontend}: the DDL becomes a {@link DatabaseSchema} in Postgres
 * accent with the keys a prover may assume, a DML pair becomes the two queries computing its
 * effect, Postgres spellings become Calcite's. Each {@code $N} is typed by planning the pair once
 * with Calcite dynamic parameters and then declared as a nullary function {@code qp_N}, which the
 * translator encodes as one uninterpreted constant shared by both sides. The plans go to
 * {@link Cvc5BagsTranslator} or {@link Cvc5SetsTranslator} unchanged.
 *
 * <pre>
 *   java -Djava.library.path=$CVC5_LIB -cp $CP sqleq.SqleqCvc5 --semantics=bags --timeout=10 --out=results.csv path/to/pairs
 * </pre>
 */
public final class SqleqCvc5 implements Batch.Checker {
  static final String USAGE = "usage: sqleq.SqleqCvc5 [--semantics=bags|sets] [--timeout=SECONDS] [--out=FILE.csv] [--smt=DIR] [--log=DIR] [--no-fork] PATH...\n"
      + "  PATH: sqleq pair files (.sql) or directories of them; --smt: write each pair's SMT-LIB problem under DIR";

  private final boolean sets;
  private final String smtDir;

  SqleqCvc5(Batch.Options o) {
    this.sets = o.get("semantics", "bags").equals("sets");
    this.smtDir = o.get("smt", null);
  }

  public static void main(String[] args) throws Exception {
    if (System.getProperty("cex") == null) {
      System.setProperty("cex", "none");
    }
    Batch.Options o = Batch.parse(args);
    System.exit(Batch.run(args, SqleqCvc5.class.getName(), new SqleqCvc5(o), USAGE));
  }

  @Override
  public void check(Frontend.Prepared p, long timeoutMs, Batch.Row row) throws Exception {
    if (p.catalog.tables().isEmpty()) {
      throw new Unsupported("no declared tables: the translator needs a schema");
    }
    DatabaseSchema schema = DatabaseSchema.parse(DdlOut.postgres(p.catalog), Dialect.POSTGRESQL);
    List<SqlOperator> udfs = new ArrayList<SqlOperator>();
    for (Declares.Decl d : p.declares) {
      udfs.add(function(d.name.toLowerCase(Locale.ROOT), d.arity, sqlTypeName(d)));
    }
    String q0 = p.q0;
    String q1 = p.q1;
    if (!p.params.isEmpty()) {
      Map<Integer, List<SqlTypeName>> seen = new HashMap<Integer, List<SqlTypeName>>();
      for (String q : new String[] {q0, q1}) {
        RelNode rel = plan(schema, udfs, ParamTypes.withQuestionMarks(q), "parameter typing");
        ParamTypes.collect(rel, ParamTypes.occurrences(q), seen);
      }
      Map<Integer, SqlTypeName> types = ParamTypes.unify(p.params, seen);
      for (Map.Entry<Integer, SqlTypeName> e : types.entrySet()) {
        udfs.add(function("qp_" + e.getKey(), 0, e.getValue()));
      }
      q0 = ParamTypes.withCalls(q0, "qp_");
      q1 = ParamTypes.withCalls(q1, "qp_");
      row.note = "params " + types;
    }
    RelNode r0 = plan(schema, udfs, q0, "Calcite");
    RelNode r1 = plan(schema, udfs, q1, "Calcite");
    if (RelOptUtil.toString(r0).equals(RelOptUtil.toString(r1))) {
      row.verdict = "identical plans";
      row.bucket = "proved-literal";
      row.note = "both sides plan to one Calcite tree, cvc5 not asked";
      return;
    }
    System.setProperty("tlimit", String.valueOf(timeoutMs));
    PrintWriter w;
    if (smtDir != null) {
      File f = new File(smtDir, p.file.name + ".smt2");
      f.getParentFile().mkdirs();
      w = new PrintWriter(f, "UTF-8");
    } else {
      w = new PrintWriter(new StringWriter());
    }
    PrintStream out = System.out;
    System.setOut(new PrintStream(new OutputStream() {
      @Override
      public void write(int b) {}
    }));
    long t0 = System.currentTimeMillis();
    try {
      Cvc5AbstractTranslator translator = sets ? new Cvc5SetsTranslator(true, w) : new Cvc5BagsTranslator(true, w);
      Result result = translator.translate(p.file.name, r0, q0, r1, q1);
      row.verdict = result.toString();
      if (result.isUnsat()) {
        row.bucket = "proved";
      } else if (result.isSat()) {
        row.bucket = "model";
      } else {
        row.bucket = System.currentTimeMillis() - t0 >= timeoutMs * 0.8 ? "timeout" : "unknown";
      }
    } catch (UnsupportedOperationException e) {
      throw new Unsupported(firstLine(e));
    } finally {
      System.setOut(out);
      w.flush();
      w.close();
    }
  }

  static RelNode plan(DatabaseSchema schema, List<SqlOperator> udfs, String sql, String stage) throws Unsupported {
    FrameworkConfig config = Frameworks.newConfigBuilder()
        .defaultSchema(schema.rootSchema())
        .parserConfig(schema.parserConfig())
        .operatorTable(new ChainedSqlOperatorTable(Arrays.<SqlOperatorTable>asList(
            SqlStdOperatorTable.instance(), new UdfTable(udfs))))
        .build();
    Planner planner = Frameworks.getPlanner(config);
    try {
      SqlNode ast = planner.parse(sql);
      ast = planner.validate(ast);
      return planner.rel(ast).rel;
    } catch (Exception e) {
      throw new Unsupported(stage + ": " + firstLine(e));
    } catch (AssertionError e) {
      throw new Unsupported(stage + ": " + firstLine(e));
    }
  }

  /** A function with an identifier: Calcite 1.19 looks a call up by {@code getNameAsId()}, null without one. */
  static SqlFunction function(String name, int arity, SqlTypeName type) {
    return new SqlFunction(new SqlIdentifier(name, SqlParserPos.ZERO),
        ReturnTypes.cascade(ReturnTypes.explicit(type), SqlTypeTransforms.FORCE_NULLABLE), null,
        OperandTypes.family(Collections.nCopies(arity, SqlTypeFamily.ANY)), null, SqlFunctionCategory.USER_DEFINED_FUNCTION);
  }

  /** The pair's functions, found by name regardless of case; a lookup without a name finds nothing. */
  static final class UdfTable implements SqlOperatorTable {
    private final List<SqlOperator> operators;

    UdfTable(List<SqlOperator> operators) {
      this.operators = operators;
    }

    @Override
    public void lookupOperatorOverloads(SqlIdentifier opName, SqlFunctionCategory category, SqlSyntax syntax,
        List<SqlOperator> out) {
      if (opName == null || !opName.isSimple() || syntax != SqlSyntax.FUNCTION) {
        return;
      }
      for (SqlOperator op : operators) {
        if (op.getName().equalsIgnoreCase(opName.getSimple())) {
          out.add(op);
        }
      }
    }

    @Override
    public List<SqlOperator> getOperatorList() {
      return operators;
    }
  }

  static SqlTypeName sqlTypeName(Declares.Decl d) throws Unsupported {
    switch (d.type) {
      case INTEGER: return SqlTypeName.INTEGER;
      case BIGINT: return SqlTypeName.BIGINT;
      case BOOLEAN: return SqlTypeName.BOOLEAN;
      case STRING: return SqlTypeName.VARCHAR;
      case CHAR: return SqlTypeName.CHAR;
      default: throw new Unsupported("declared function " + d.name + " returns " + d.returnType + ", a type the translator has no sort for");
    }
  }

  static String firstLine(Throwable e) {
    String m = e.getMessage() == null ? e.toString() : e.getMessage();
    return m.split("\n")[0];
  }
}
