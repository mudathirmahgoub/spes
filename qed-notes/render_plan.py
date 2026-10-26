#!/usr/bin/env python3
"""Render a Postgres EXPLAIN (FORMAT JSON) plan as an SVG tree."""
import json, sys, html

BOX_W, BOX_H, H_GAP, V_GAP = 250, 78, 26, 56
PAD = 28

PALETTE = {
    "Aggregate":  ("#FDF0D5", "#B4690E", "#7A4708"),
    "Hash Join":  ("#E7F0FB", "#2B6CB0", "#1B4A7A"),
    "Merge Join": ("#E7F0FB", "#2B6CB0", "#1B4A7A"),
    "Nested Loop":("#E7F0FB", "#2B6CB0", "#1B4A7A"),
    "Seq Scan":   ("#E8F5EC", "#2F855A", "#1F5A3D"),
    "Index Scan": ("#E8F5EC", "#2F855A", "#1F5A3D"),
    "Hash":       ("#F1F1F4", "#6B6B76", "#46464E"),
    "Sort":       ("#F6ECFA", "#7B3FA0", "#552A70"),
}
DEFAULT = ("#F1F1F4", "#6B6B76", "#46464E")


def label(node):
    t = node["Node Type"]
    if t == "Aggregate":
        t = ("Hash" if node.get("Strategy") == "Hashed" else node.get("Strategy", "")) + "Aggregate"
    rel = node.get("Relation Name")
    if rel:
        t += f" on {rel}"          # schema prefixes (public./pg_temp.) are noise
    detail = (node.get("Group Key") and "Group Key: " + ", ".join(node["Group Key"])) \
        or node.get("Hash Cond") or node.get("Merge Cond") or node.get("Join Filter") or ""
    if node.get("Inner Unique"):
        detail = (detail + "  •  Inner Unique" if detail else "Inner Unique")
    rows = node.get("Actual Rows")
    est = node.get("Plan Rows")
    stats = f"rows={int(rows):,}  (est {int(est):,})" if rows is not None else ""
    ms = node.get("Actual Total Time")
    if ms is not None:
        stats += f"   {ms:.1f} ms"
    return t, detail, stats


def layout(node, depth, cursor, out):
    kids = node.get("Plans", [])
    if not kids:
        x = cursor[0]
        cursor[0] += BOX_W + H_GAP
    else:
        xs = [layout(k, depth + 1, cursor, out) for k in kids]
        x = (min(xs) + max(xs)) / 2
    out.append((x, depth, node))
    return x


def render(plan_json, title, out_path):
    root = plan_json[0]["Plan"]
    nodes, cursor = [], [0.0]
    layout(root, 0, cursor, nodes)
    depth_max = max(d for _, d, _ in nodes)
    W = cursor[0] - H_GAP + 2 * PAD
    H = (depth_max + 1) * BOX_H + depth_max * V_GAP + 2 * PAD + 46
    pos = {id(n): (x + PAD, PAD + 46 + d * (BOX_H + V_GAP)) for x, d, n in nodes}

    s = [f'<svg xmlns="http://www.w3.org/2000/svg" width="{W:.0f}" height="{H:.0f}" '
         f'viewBox="0 0 {W:.0f} {H:.0f}" font-family="ui-sans-serif,-apple-system,Helvetica,Arial,sans-serif">',
         f'<rect width="100%" height="100%" fill="#FFFFFF"/>',
         f'<text x="{PAD}" y="{PAD+8}" font-size="19" font-weight="700" fill="#1A1A1E">{html.escape(title)}</text>']

    for _, _, n in nodes:                                   # edges first
        px, py = pos[id(n)]
        for k in n.get("Plans", []):
            kx, ky = pos[id(k)]
            s.append(f'<path d="M {kx+BOX_W/2:.0f} {ky} C {kx+BOX_W/2:.0f} {ky-V_GAP/2:.0f}, '
                     f'{px+BOX_W/2:.0f} {py+BOX_H+V_GAP/2:.0f}, {px+BOX_W/2:.0f} {py+BOX_H:.0f}" '
                     f'stroke="#9A9AA4" stroke-width="1.8" fill="none"/>')

    for _, _, n in nodes:
        x, y = pos[id(n)]
        t, detail, stats = label(n)
        fill, stroke, ink = PALETTE.get(n["Node Type"], DEFAULT)
        s.append(f'<rect x="{x:.0f}" y="{y}" width="{BOX_W}" height="{BOX_H}" rx="9" '
                 f'fill="{fill}" stroke="{stroke}" stroke-width="1.8"/>')
        s.append(f'<text x="{x+13:.0f}" y="{y+25}" font-size="14.5" font-weight="700" fill="{ink}">{html.escape(t[:32])}</text>')
        if detail:
            s.append(f'<text x="{x+13:.0f}" y="{y+45}" font-size="11.5" fill="#4A4A55">{html.escape(detail[:38])}</text>')
        s.append(f'<text x="{x+13:.0f}" y="{y+65}" font-size="11.5" font-family="ui-monospace,Menlo,monospace" fill="#1A1A1E">{html.escape(stats)}</text>')

    s.append('</svg>')
    open(out_path, "w").write("\n".join(s))
    print(f"wrote {out_path}  ({W:.0f}x{H:.0f})")


for src, title, dst in [
    ("q1_plan.json", "Q1  —  aggregate ABOVE the join", "q1_plan.svg"),
    ("q2_plan.json", "Q2  —  aggregate BELOW the join (pushed down)", "q2_plan.svg"),
]:
    render(json.load(open(src)), title, dst)
