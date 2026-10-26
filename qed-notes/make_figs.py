#!/usr/bin/env python3
"""Rasterise the plan SVGs at 3x for LaTeX inclusion."""
import re, subprocess, sys, os
OUT = "tex/figs"
for name in ["q1_plan", "q2_plan"]:
    s = open(f"{name}.svg").read()
    s3 = re.sub(r'width="(\d+)" height="(\d+)"',
                lambda m: 'width="%d" height="%d"' % (int(m.group(1))*3, int(m.group(2))*3),
                s, count=1)
    tmp = f"/tmp/{name}_3x.svg"
    open(tmp, "w").write(s3)
    subprocess.run(["sips", "-s", "format", "png", tmp, "--out", f"{OUT}/{name}.png"],
                   check=True, capture_output=True)
    print("wrote", f"{OUT}/{name}.png")
