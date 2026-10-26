package sqleq.input;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;

/**
 * Runs a checker over sqleq pair files and reports one row per pair.
 *
 * <p>Each pair runs in a fresh JVM by default: both provers can hang past their own timeouts, and
 * a child process is the one thing that can always be killed. The child is this same main class
 * with {@code --single}; its one result line is read back. {@code --no-fork} runs in-process.
 *
 * <p>The row has the pair's {@code truth} where the file states one, the tool's own verdict, a
 * bucket in sqleq's words ({@code proved}, {@code model}, {@code no-proof}, {@code unknown},
 * {@code timeout}, {@code unsupported}, {@code error}), the time, and a note. A {@code proved} on a
 * pair whose truth is {@code not-equivalent} is marked {@code !UNSOUND}; a {@code model} on an
 * equivalent pair {@code !false-model}. Both are listed in the summary.
 */
public final class Batch {
  public static final class Row {
    public String name;
    public String truth = "";
    public String verdict = "";
    public String bucket = "";
    public String note = "";
    public long ms;
  }

  public interface Checker {
    /** Decides one prepared pair; fills {@code verdict}, {@code bucket} and {@code note} of the row. */
    void check(Frontend.Prepared p, long timeoutMs, Row row) throws Exception;
  }

  public static final class Options {
    public long timeoutMs = 10000;
    public String out;
    public boolean fork = true;
    public boolean single;
    public String name;
    public String logDir;
    public int jobs = 1;
    public final List<String> paths = new ArrayList<String>();
    public final Map<String, String> extra = new LinkedHashMap<String, String>();

    public String get(String key, String dflt) {
      String v = extra.get(key);
      return v == null ? dflt : v;
    }
  }

  private Batch() {}

  public static Options parse(String[] args) {
    Options o = new Options();
    for (String a : args) {
      if (a.startsWith("--timeout=")) {
        o.timeoutMs = (long) (Double.parseDouble(a.substring(10)) * 1000);
      } else if (a.startsWith("--out=")) {
        o.out = a.substring(6);
      } else if (a.equals("--no-fork")) {
        o.fork = false;
      } else if (a.equals("--single")) {
        o.single = true;
      } else if (a.startsWith("--name=")) {
        o.name = a.substring(7);
      } else if (a.startsWith("--log=")) {
        o.logDir = a.substring(6);
      } else if (a.startsWith("--jobs=")) {
        o.jobs = Math.max(1, Integer.parseInt(a.substring(7)));
      } else if (a.startsWith("--") && a.indexOf('=') > 2) {
        o.extra.put(a.substring(2, a.indexOf('=')), a.substring(a.indexOf('=') + 1));
      } else if (a.startsWith("--")) {
        o.extra.put(a.substring(2), "true");
      } else {
        o.paths.add(a);
      }
    }
    return o;
  }

  public static int run(String[] args, String mainClass, Checker checker, String usage) throws Exception {
    Options o = parse(args);
    if (o.paths.isEmpty()) {
      System.err.println(usage);
      return 2;
    }
    List<String[]> files = collect(o.paths);
    if (o.single) {
      if (files.size() != 1) {
        System.err.println("--single takes one file");
        return 2;
      }
      Row r = runOne(checker, o.name != null ? o.name : files.get(0)[0], Paths.get(files.get(0)[1]), o.timeoutMs);
      System.out.println("@@ROW\t" + tsv(r));
      System.out.flush();
      return 0;
    }
    final Row[] rows = new Row[files.size()];
    if (o.fork && o.jobs > 1) {
      java.util.concurrent.ExecutorService pool = java.util.concurrent.Executors.newFixedThreadPool(o.jobs);
      List<java.util.concurrent.Future<?>> futures = new ArrayList<java.util.concurrent.Future<?>>();
      for (int i = 0; i < files.size(); i++) {
        final int k = i;
        final String[] f = files.get(i);
        final String[] a = args;
        final Options opts = o;
        final String main = mainClass;
        futures.add(pool.submit(new Runnable() {
          @Override
          public void run() {
            Row r;
            try {
              r = fork(main, a, f[0], f[1], opts);
            } catch (Exception e) {
              r = new Row();
              r.name = f[0];
              r.verdict = "error";
              r.bucket = "error";
              r.note = e.toString();
            }
            rows[k] = r;
            synchronized (System.out) {
              System.out.printf("%-60s %-14s %-12s %6d ms  %s%n", r.name, r.bucket, r.verdict, r.ms, r.note);
              System.out.flush();
            }
          }
        }));
      }
      for (java.util.concurrent.Future<?> fu : futures) {
        fu.get();
      }
      pool.shutdown();
    } else {
      for (int i = 0; i < files.size(); i++) {
        String[] f = files.get(i);
        Row r = o.fork ? fork(mainClass, args, f[0], f[1], o) : runOne(checker, f[0], Paths.get(f[1]), o.timeoutMs);
        rows[i] = r;
        System.out.printf("%-60s %-14s %-12s %6d ms  %s%n", r.name, r.bucket, r.verdict, r.ms, r.note);
        System.out.flush();
      }
    }
    List<Row> rowList = Arrays.asList(rows);
    if (o.out != null) {
      writeCsv(o.out, rowList);
    }
    summary(rowList);
    return 0;
  }

  /** {@code {name, path}} for every {@code .sql} under the given paths, names relative to the directory given. */
  public static List<String[]> collect(List<String> paths) throws IOException {
    List<String[]> out = new ArrayList<String[]>();
    for (String p : paths) {
      final Path root = Paths.get(p);
      if (Files.isDirectory(root)) {
        List<Path> found = new ArrayList<Path>();
        try (java.util.stream.Stream<Path> walk = Files.walk(root)) {
          java.util.Iterator<Path> it = walk.iterator();
          while (it.hasNext()) {
            Path q = it.next();
            if (Files.isRegularFile(q) && q.toString().endsWith(".sql")) {
              found.add(q);
            }
          }
        }
        Collections.sort(found);
        for (Path q : found) {
          String rel = root.relativize(q).toString();
          out.add(new String[] {rel.substring(0, rel.length() - 4), q.toString()});
        }
      } else {
        String n = root.getFileName().toString();
        out.add(new String[] {n.endsWith(".sql") ? n.substring(0, n.length() - 4) : n, root.toString()});
      }
    }
    return out;
  }

  public static Row runOne(Checker checker, String name, Path path, long timeoutMs) {
    long t0 = System.currentTimeMillis();
    Row r = new Row();
    r.name = name;
    try {
      PairFile pf = PairFile.read(path, name);
      r.truth = pf.truth() == null ? "" : pf.truth();
      Frontend.Prepared p = Frontend.prepare(pf);
      checker.check(p, timeoutMs, r);
      if (!p.notes.isEmpty()) {
        r.note = (r.note.isEmpty() ? "" : r.note + "; ") + join(p.notes);
      }
    } catch (Unsupported u) {
      r.verdict = "unsupported";
      r.bucket = "unsupported";
      r.note = u.getMessage();
    } catch (Throwable e) {
      r.verdict = "error";
      r.bucket = "error";
      String m = e.toString();
      r.note = m.split("\n")[0];
    }
    r.ms = System.currentTimeMillis() - t0;
    flag(r);
    return r;
  }

  static void flag(Row r) {
    if ((r.bucket.equals("proved") || r.bucket.equals("proved-literal")) && r.truth.equals("not-equivalent")) {
      r.note = "!UNSOUND " + r.note;
    } else if (r.bucket.equals("model") && r.truth.equals("equivalent")) {
      r.note = "!false-model " + r.note;
    }
  }

  private static Row fork(String mainClass, String[] args, String name, String path, Options o) throws IOException, InterruptedException {
    String java = System.getProperty("java.home") + File.separator + "bin" + File.separator + "java";
    List<String> cmd = new ArrayList<String>();
    cmd.add(java);
    cmd.add("-cp");
    cmd.add(System.getProperty("java.class.path"));
    cmd.add("-Djava.library.path=" + System.getProperty("java.library.path"));
    cmd.add("--enable-native-access=ALL-UNNAMED");
    cmd.add("-Xss64m");
    for (String key : new String[] {"tlimit", "cex", "cex.dir"}) {
      if (System.getProperty(key) != null) {
        cmd.add("-D" + key + "=" + System.getProperty(key));
      }
    }
    for (Object k : System.getProperties().keySet()) {
      if (k.toString().startsWith("sqleq.") || k.toString().startsWith("sqlsolver.")) {
        cmd.add("-D" + k + "=" + System.getProperty(k.toString()));
      }
    }
    cmd.add(mainClass);
    cmd.add("--single");
    cmd.add("--name=" + name);
    cmd.add("--timeout=" + o.timeoutMs / 1000.0);
    for (Map.Entry<String, String> e : o.extra.entrySet()) {
      cmd.add("--" + e.getKey() + "=" + e.getValue());
    }
    cmd.add("--no-fork");
    cmd.add(path);
    ProcessBuilder pb = new ProcessBuilder(cmd);
    if (o.logDir != null) {
      File dir = new File(o.logDir, new File(name).getParent() == null ? "" : new File(name).getParent());
      dir.mkdirs();
      pb.redirectError(new File(o.logDir, name + ".log"));
    } else {
      pb.redirectError(ProcessBuilder.Redirect.DISCARD);
    }
    long t0 = System.currentTimeMillis();
    final Process proc = pb.start();
    final String[] rowLine = new String[1];
    final StringBuilder tail = new StringBuilder();
    Thread reader = new Thread(new Runnable() {
      @Override
      public void run() {
        try (BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream(), StandardCharsets.UTF_8))) {
          String line;
          while ((line = in.readLine()) != null) {
            if (line.startsWith("@@ROW\t")) {
              rowLine[0] = line.substring(6);
            } else {
              if (tail.length() > 4000) {
                tail.setLength(0);
              }
              tail.append(line).append('\n');
            }
          }
        } catch (IOException e) {
          // the process ended
        }
      }
    });
    reader.setDaemon(true);
    reader.start();
    boolean done = proc.waitFor(o.timeoutMs + 20000, TimeUnit.MILLISECONDS);
    if (!done) {
      proc.destroyForcibly();
      proc.waitFor();
    }
    reader.join(2000);
    Row r = new Row();
    r.name = name;
    r.ms = System.currentTimeMillis() - t0;
    if (rowLine[0] != null) {
      String[] f = rowLine[0].split("\t", -1);
      r.truth = f.length > 1 ? f[1] : "";
      r.verdict = f.length > 2 ? f[2] : "";
      r.bucket = f.length > 3 ? f[3] : "";
      r.ms = f.length > 4 ? Long.parseLong(f[4]) : r.ms;
      r.note = f.length > 5 ? f[5] : "";
    } else if (!done) {
      r.verdict = "timeout";
      r.bucket = "timeout";
      r.note = "hang: the process did not answer within the limit and was killed";
      try {
        r.truth = truthOf(Paths.get(path));
      } catch (Exception e) {
        // leave it blank
      }
    } else {
      r.verdict = "error";
      r.bucket = "error";
      String t = tail.toString().trim();
      r.note = "the process ended without a result (exit " + proc.exitValue() + ")" + (t.isEmpty() ? "" : ": " + lastLine(t));
      try {
        r.truth = truthOf(Paths.get(path));
      } catch (Exception e) {
        // leave it blank
      }
    }
    flag(r);
    return r;
  }

  private static String truthOf(Path path) throws IOException {
    for (String line : Files.readAllLines(path, StandardCharsets.UTF_8)) {
      if (line.startsWith("-- truth:")) {
        return line.substring(9).trim();
      }
    }
    return "";
  }

  private static String lastLine(String t) {
    String[] lines = t.split("\n");
    return lines[lines.length - 1];
  }

  static String tsv(Row r) {
    return clean(r.name) + "\t" + clean(r.truth) + "\t" + clean(r.verdict) + "\t" + clean(r.bucket) + "\t" + r.ms + "\t" + clean(r.note);
  }

  private static String clean(String s) {
    return s == null ? "" : s.replace('\t', ' ').replace('\n', ' ').replace('\r', ' ');
  }

  private static String join(List<String> xs) {
    StringBuilder b = new StringBuilder();
    for (String x : xs) {
      b.append(b.length() == 0 ? "" : "; ").append(x);
    }
    return b.toString();
  }

  private static void writeCsv(String out, List<Row> rows) throws IOException {
    try (PrintWriter w = new PrintWriter(Files.newBufferedWriter(Paths.get(out), StandardCharsets.UTF_8))) {
      w.println("name,truth,verdict,bucket,ms,note");
      for (Row r : rows) {
        w.println(csv(r.name) + "," + csv(r.truth) + "," + csv(r.verdict) + "," + csv(r.bucket) + "," + r.ms + "," + csv(r.note));
      }
    }
  }

  private static String csv(String s) {
    if (s == null) {
      return "";
    }
    if (s.indexOf(',') >= 0 || s.indexOf('"') >= 0 || s.indexOf('\n') >= 0) {
      return "\"" + s.replace("\"", "\"\"") + "\"";
    }
    return s;
  }

  private static void summary(List<Row> rows) {
    Map<String, Integer> buckets = new TreeMap<String, Integer>();
    int withTruth = 0;
    int confirmedEq = 0;
    int confirmedNeq = 0;
    List<String> unsound = new ArrayList<String>();
    List<String> falseModels = new ArrayList<String>();
    for (Row r : rows) {
      Integer n = buckets.get(r.bucket);
      buckets.put(r.bucket, n == null ? 1 : n + 1);
      if (!r.truth.isEmpty()) {
        withTruth++;
        if ((r.bucket.equals("proved") || r.bucket.equals("proved-literal")) && r.truth.equals("equivalent")) {
          confirmedEq++;
        }
        if (r.bucket.equals("model") && r.truth.equals("not-equivalent")) {
          confirmedNeq++;
        }
        if (r.note.startsWith("!UNSOUND")) {
          unsound.add(r.name);
        }
        if (r.note.startsWith("!false-model")) {
          falseModels.add(r.name);
        }
      }
    }
    System.out.println();
    System.out.println("pairs: " + rows.size());
    for (Map.Entry<String, Integer> e : buckets.entrySet()) {
      System.out.printf("  %-12s %d%n", e.getKey(), e.getValue());
    }
    if (withTruth > 0) {
      System.out.println("against the stated truth (" + withTruth + " pairs): " + confirmedEq + " proofs of equivalent pairs, "
          + confirmedNeq + " models of non-equivalent pairs");
      System.out.println("  proofs of NON-equivalent pairs (unsound): " + unsound.size() + (unsound.isEmpty() ? "" : " " + unsound));
      System.out.println("  models of equivalent pairs (false models): " + falseModels.size() + (falseModels.isEmpty() ? "" : " " + falseModels));
    }
  }
}
