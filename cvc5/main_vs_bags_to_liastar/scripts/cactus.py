"""Cactus plots: time on the x axis (log), number of problems solved on the y axis,
one curve per configuration, a vertical line at the time limit, the final count as a
label at the right end of each curve."""
import sys, os, matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
S=os.path.dirname(os.path.abspath(__file__))
T=sys.argv[1] if len(sys.argv)>1 else "10000"; LIMIT=int(T)/1000
CFG=[c for c in [("cvc5 main (03e5ee1eb)","res_main_%s.tsv"%T,"#4477aa","-"),("main at the merge base (72f647eb7)","res_base_%s.tsv"%T,"#66ccee","-"),("bags_to_liastar","res_branch_%s.tsv"%T,"#ee7733","--"),("bags_to_liastar --bags-to-liastar","res_liastar_%s.tsv"%T,"#228833","-."),("... --bags-liastar-model=elements","res_elements_%s.tsv"%T,"#aa3377",":"),("... gated on cardinality terms","res_liastar_gated_%s.tsv"%T,"#009988","-."),("bags_to_liastar + main merged","res_merged_%s.tsv"%T,"#cc3311","--"),("merged --bags-to-liastar (gated)","res_merged_liastar_gated_%s.tsv"%T,"#000000",":")] if os.path.exists(f"{S}/{c[1]}")]
def load(f):
    d={}
    for l in open(f"{S}/{f}"):
        a=l.rstrip("\n").split("\t"); d[a[0]]=(a[1],float(a[2]))
    return d
R={c:load(f) for c,f,_,_ in CFG}
fig,axes=plt.subplots(1,2,figsize=(13,5.2))
for ax,sem in zip(axes,("bags","sets")):
    n=0; ends=[]
    for c,f,col,ls in CFG:
        ts=sorted(v[1] for k,v in R[c].items() if k.split("__")[1].startswith(sem) and v[0] in("sat","unsat"))
        n=max(n,sum(1 for k in R[c] if k.split("__")[1].startswith(sem)))
        if not ts: continue
        ax.plot(ts, range(1,len(ts)+1), color=col, ls=ls, lw=1.8, label=c)
        ends.append((len(ts), ts[-1], col))
    # end labels, staggered when the counts are close
    ends.sort()
    prev=None; bump=0
    for cnt, t, col in ends:
        bump = bump+1 if prev is not None and cnt-prev < 6 else 0
        ax.annotate(str(cnt), (t, cnt), textcoords="offset points", xytext=(4+14*bump,-3), fontsize=8, color=col)
        prev=cnt
    ax.axvline(LIMIT, color="#777777", lw=0.8, ls=":")
    ax.text(LIMIT*0.9, 3, f"{LIMIT:g} s", color="#777777", fontsize=8, ha="right")
    ax.set_xscale("log"); ax.set_xlabel("time (s)"); ax.set_ylabel("problems solved")
    ax.set_title(f"{sem} semantics ({n} problems)"); ax.grid(alpha=0.3, which="both", lw=0.4)
    ax.legend(fontsize=7, loc="upper left")
fig.tight_layout(); fig.savefig(f"{S}/cactus_{T}.pdf"); fig.savefig(f"{S}/cactus_{T}.png", dpi=150)
print("wrote", f"{S}/cactus_{T}.pdf")
