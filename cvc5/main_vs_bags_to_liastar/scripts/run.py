"""Run one cvc5 binary with given flags over all problem files.
usage: run.py OUT.tsv WORKERS TIMEOUT_MS BINARY [FLAGS...]"""
import subprocess, os, sys, glob, time
from concurrent.futures import ThreadPoolExecutor
S=os.path.dirname(os.path.abspath(__file__))
out, workers, tlimit, binary = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), sys.argv[4]
flags=sys.argv[5:]
files=sorted(glob.glob(f"{S}/problems/*/*.smt2"))
def run(f):
    t=time.time()
    try:
        p=subprocess.run([binary, f"--tlimit={tlimit}"]+flags+[f], capture_output=True, text=True, timeout=tlimit/1000+30)
        out_lines=(p.stdout+p.stderr).strip().split("\n")
        st=[l for l in out_lines if l in ("sat","unsat","unknown")]
        if st: status=st[0]
        elif "timeout" in (p.stdout+p.stderr): status="timeout"
        else: status="error"
        note=""
        if status=="error" or p.returncode not in (0,):
            first=[l for l in out_lines if l.strip()][:1]
            note=(first[0] if first else "")[:120].replace("\t"," ")
        if any("check-model" in l or "ERRORS SATISFYING" in l for l in out_lines): note="MODEL-ERROR "+note
    except subprocess.TimeoutExpired:
        status="timeout"; note="hard"
    return os.path.relpath(f, f"{S}/problems"), status, time.time()-t, note
with ThreadPoolExecutor(workers) as ex: res=list(ex.map(run, files))
with open(out,"w") as o:
    for r in res: o.write(f"{r[0]}\t{r[1]}\t{r[2]:.2f}\t{r[3]}\n")
from collections import Counter
print(binary, " ".join(flags), "->", dict(Counter(r[1] for r in res)), f"files={len(res)}")
