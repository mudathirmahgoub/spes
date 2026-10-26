"""Split the SMT-LIB files spes writes (one problem per '; test name:' block, separated by
(reset)) into one file per problem, dropping what must not be in a benchmark file: the
tlimit-per option (the timeout is given on the command line), the bags-map-up-pair option
(neither cvc5 under test has it), and the get-model/get-value commands and the answer
comments spes appended after solving."""
import re, os, sys, glob
S=os.path.dirname(os.path.abspath(__file__))
outdir=f"{S}/problems"; os.makedirs(outdir, exist_ok=True)
DROP=re.compile(r"^\((set-option :tlimit-per|set-option :bags-map-up-pair|get-model|get-value|reset)\b")
total=0; mapup=0
for f in sorted(glob.glob(f"{S}/gen/*.smt2")):
    batch=os.path.basename(f)[:-5]
    blocks=open(f).read().split(";-----------------------------------------------------------\n")
    for blk in blocks:
        m=re.match(r"; test name: (\S+)", blk)
        if not m: continue
        name=m.group(1)
        if "(check-sat)" not in blk: continue   # skipped or errored translation
        lines=[]
        for l in blk.split("\n"):
            if DROP.match(l):
                if "bags-map-up-pair" in l: mapup+=1
                continue
            if l.startswith(";answer:") or l.startswith("; duration:"): continue
            lines.append(l)
        # keep everything up to and including the first (check-sat)
        text="\n".join(lines)
        text=text[:text.index("(check-sat)")+len("(check-sat)")]+"\n"
        d=f"{outdir}/{batch}"; os.makedirs(d, exist_ok=True)
        open(f"{d}/{name}.smt2","w").write(text); total+=1
print("problems written:", total, " bags-map-up-pair options dropped:", mapup)
