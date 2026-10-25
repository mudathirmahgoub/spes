package sqleq.input;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

/**
 * A pair file taken to the two queries a prover is asked about: the catalog read, a DML pair
 * reduced to queries, Postgres spellings rewritten, the declared functions and the parameters
 * collected. What is left for the prover's own adapter is to type the parameters with its planner
 * and to declare the functions in its operator table.
 */
public final class Frontend {
  public static final class Prepared {
    public final PairFile file;
    public final Catalog catalog;
    public final Dml.Kind kind;
    public final String q0;
    public final String q1;
    public final List<Declares.Decl> declares;
    public final TreeSet<Integer> params;
    public final List<String> notes;

    Prepared(PairFile file, Catalog catalog, Dml.Kind kind, String q0, String q1, List<Declares.Decl> declares,
        TreeSet<Integer> params, List<String> notes) {
      this.file = file;
      this.catalog = catalog;
      this.kind = kind;
      this.q0 = q0;
      this.q1 = q1;
      this.declares = declares;
      this.params = params;
      this.notes = notes;
    }
  }

  private Frontend() {}

  public static Prepared prepare(PairFile pf) throws Unsupported {
    Catalog cat = Catalog.build(pf.ddl);
    Dml.Reduced red = Dml.reduceWith(cat, pf.statements.get(0), pf.statements.get(1));
    String q0 = Rewrites.rewrite(red.q0);
    String q1 = Rewrites.rewrite(red.q1);
    Guards.check(q0);
    Guards.check(q1);
    List<Declares.Decl> decls = new ArrayList<Declares.Decl>();
    for (String line : pf.declares) {
      Declares.Decl d = Declares.parse(line);
      if (d.aggregate) {
        throw new Unsupported("declared aggregate function " + d.name);
      }
      decls.add(d);
    }
    List<String> notes = new ArrayList<String>(red.notes);
    if (!cat.warnings.isEmpty()) {
      notes.add(cat.warnings.size() + " DDL statement(s) skipped: " + cat.warnings.get(0));
    }
    return new Prepared(pf, cat, red.kind, q0, q1, decls, ParamTypes.params(q0, q1), notes);
  }
}
