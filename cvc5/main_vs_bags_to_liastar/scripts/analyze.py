import sys, os, collections, statistics
S=os.path.dirname(os.path.abspath(__file__))
T=sys.argv[1] if len(sys.argv)>1 else "10000"
ALL=[("main","res_main_%s.tsv"%T),("base","res_base_%s.tsv"%T),("branch","res_branch_%s.tsv"%T),
     ("branch+liastar","res_liastar_%s.tsv"%T),("branch+liastar+elements","res_elements_%s.tsv"%T),
     ("branch+liastar+dio","res_liastar_dio_%s.tsv"%T),("branch+liastar(gated)","res_liastar_gated_%s.tsv"%T),
     ("merged","res_merged_%s.tsv"%T),("merged+liastar","res_merged_liastar_%s.tsv"%T),
     ("merged+liastar+elements","res_merged_elements_%s.tsv"%T),("merged+liastar(gated)","res_merged_liastar_gated_%s.tsv"%T)]
CFG=[c for c in ALL if os.path.exists(f"{S}/{c[1]}")]
def load(f):
    d={}
    for l in open(f"{S}/{f}"):
        a=l.rstrip("\n").split("\t"); d[a[0]]=(a[1],float(a[2]),a[3] if len(a)>3 else "")
    return d
R={c:load(f) for c,f in CFG}
files=sorted(R["main"])
def batch(f): return f.split("/")[0]
def sem(f): return batch(f).split("__")[1]
solved=lambda s: s in ("sat","unsat")
lines=[]
def P(*a): lines.append(" ".join(str(x) for x in a))
P(f"# cvc5 main vs bags_to_liastar on the spes SQL benchmarks (timeout {int(T)/1000:g} s, 8 in parallel)\n")
P("| batch | semantics | problems | " + " | ".join(f"{c}: sat / unsat / t.o. / err" for c,_ in CFG) + " |")
P("|---|---|---|" + "---|"*len(CFG))
for b in sorted(set(batch(f) for f in files)):
    fs=[f for f in files if batch(f)==b]
    cells=[]
    for c,_ in CFG:
        st=collections.Counter(R[c][f][0] for f in fs)
        cells.append(f"{st['sat']} / {st['unsat']} / {st['timeout']} / {st['error']}")
    P(f"| {b.split('__')[0]} | {sem(fs[0])} | {len(fs)} | " + " | ".join(cells) + " |")
for s in ("bags","sets"):
    fs=[f for f in files if sem(f)==s]
    cells=[]
    for c,_ in CFG:
        st=collections.Counter(R[c][f][0] for f in fs)
        cells.append(f"**{st['sat']+st['unsat']}** solved: {st['sat']} / {st['unsat']} / {st['timeout']} / {st['error']}")
    P(f"| **all {s}** | {s} | {len(fs)} | " + " | ".join(cells) + " |")
P("")
# disagreements
P("## Disagreements between solved answers")
dis=[]
for f in files:
    ans={c:R[c][f][0] for c,_ in CFG if solved(R[c][f][0])}
    if len(set(ans.values()))>1: dis.append((f,ans))
P(f"{len(dis)} disagreements" + ("" if not dis else ":"))
for f,ans in dis: P(f"- {f}: {ans}")
P("")
# model errors
P("## check-models failures")
for c,_ in CFG:
    bad=[f for f in files if R[c][f][2].startswith("MODEL-ERROR")]
    P(f"- {c}: {len(bad)}" + (" -- " + ", ".join(bad[:10]) if bad else ""))
P("")
# gained / lost
P("## Solved by one configuration and not another")
PAIRS=[(a,b) for a,b in [("base","main"),("base","branch"),("main","branch"),("branch","branch+liastar"),("branch","branch+liastar+elements"),("branch+liastar","branch+liastar+elements"),("branch+liastar","branch+liastar+dio"),("branch","branch+liastar(gated)"),("main","merged"),("merged","merged+liastar"),("merged","merged+liastar(gated)"),("merged","merged+liastar+elements")] if a in R and b in R]
for a,b in PAIRS:
    only_b=[f for f in files if not solved(R[a][f][0]) and solved(R[b][f][0])]
    only_a=[f for f in files if solved(R[a][f][0]) and not solved(R[b][f][0])]
    P(f"### {b} vs {a}: +{len(only_b)} / -{len(only_a)}")
    for f in only_b: P(f"- gained {f}: {a}={R[a][f][0]} {R[b][f][0]} in {R[b][f][1]:.2f}s")
    for f in only_a: P(f"- lost {f}: {a}={R[a][f][0]} {R[a][f][1]:.2f}s, {b}={R[b][f][0]}")
    P("")
# times
P("## Time on the problems all three solve")
common=[f for f in files if all(solved(R[c][f][0]) for c,_ in CFG)]
P(f"{len(common)} problems")
for c,_ in CFG:
    ts=[R[c][f][1] for f in common]
    P(f"- {c}: total {sum(ts):.1f}s, median {statistics.median(ts):.3f}s, max {max(ts):.2f}s")
for a,b in [(a,b) for a,b in [("base","main"),("base","branch"),("branch","branch+liastar"),("branch","branch+liastar(gated)"),("main","merged"),("merged","merged+liastar(gated)")] if a in R and b in R]:
    rat=[R[b][f][1]/max(R[a][f][1],0.02) for f in common]
    P(f"- {b}/{a}: median ratio {statistics.median(rat):.2f}, mean {statistics.mean(rat):.2f}")
    worst=sorted(((R[b][f][1]-R[a][f][1],f) for f in common), reverse=True)[:5]
    P("  largest slowdowns: " + ", ".join(f"{f} {R[a][f][1]:.2f}->{R[b][f][1]:.2f}" for _,f in worst))
    best=sorted(((R[a][f][1]-R[b][f][1],f) for f in common), reverse=True)[:5]
    P("  largest speedups: " + ", ".join(f"{f} {R[a][f][1]:.2f}->{R[b][f][1]:.2f}" for _,f in best))
open(f"{S}/report_{T}.md","w").write("\n".join(lines)+"\n")
print("\n".join(lines))
