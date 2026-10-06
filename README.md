# Fold8 Ultra → Mocagen MC1 adapter

`fold8_mc1_adapter.scad` is a parametric OpenSCAD model built from `spec.md`
(the brief). Set `orientation` to `landscape` (159.8 mm bucket) or `portrait`
(134.0 mm bucket), export STL, print flat in PETG/Tough PLA (4 walls, 25–35%
gyroid, 5 top/bottom layers).

**Not verified:** OpenSCAD wasn't available here, so the model has not been
rendered or test-fit. The MC1 grip dimensions (`grip_w`, `grip_t`,
`clip_gap_x`, `clip_len`) are placeholders — measure your controller first.

## Verification notes (web check)
- Fold8 Ultra unfolded is listed as **158.4 x 143.2 x 4.1 mm** (retailer/aggregator
  listings; Samsung's own page not checked). The original brief's 132.6 x 5.5 was wrong
  and has been corrected here.
- Mocagen MC1: a listing claims it grips phones ~4.5–8.1 in (~114–206 mm). The
  "175 mm hard stop" in the brief is **unconfirmed**. If the MC1 really stretches
  past 158.4 mm, an unfolded Fold8 may fit without this adapter at all — test first.
- No source found for MC1 handle/grip geometry: `grip_w`, `grip_t`, `clip_gap_x`
  remain placeholders. Thingiverse #6542406 could not be fetched (blocked).

## MC1 official size diagram (manufacturer image, supplied by user)
- Clamp opening: **min 3.94 in (100 mm) – max 7.09 in (180 mm)**. The brief's 175 mm was wrong.
- Phone thickness limit: **<= 0.2 in (~5.1 mm)**; minimum clamped edge length **>= 3.54 in (90 mm)**.
- Unfolded Fold8 Ultra (158.4 x 143.2 x 4.1 mm) is inside all three limits, so it
  **should clamp natively in the MC1 in either orientation, no adapter needed**.
  Caveats: thickness is the thin-edge figure, and the clamp bracket needs to grip
  the frame edge without pressing the inner display or hinge. Test-fit before printing.
- Not in the diagram: handle/grip geometry, so the clip dimensions remain placeholders.
