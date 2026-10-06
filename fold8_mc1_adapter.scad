// Z Fold8 Ultra -> Mocagen MC1 front-offset tray (parametric, OpenSCAD)
// STATUS: UNVERIFIED. Phone dims come from the spec sheet; the MC1 grip
// dimensions below are PLACEHOLDERS - measure your controller and edit them.

orientation = "landscape";   // "landscape" or "portrait"

// ---- Phone (unfolded) ----
phone_long   = 158.4;
phone_short  = 132.6;
phone_thick  = 5.5;
pad_clear    = 1.4;          // XY expansion for scratch-safe pads (spec)

// ---- Tray ----
tray_depth   = 6.5;          // bounding depth (spec)
wall         = 2.4;
lip_height   = 6;            // bottom retention lip rise
lip_overhang = 2.5;          // how far lip wraps over screen edge
standoff     = 9;            // forward offset from faceplate (spec: 8-10)

// ---- MC1 grip clip (PLACEHOLDERS - MEASURE!) ----
grip_w       = 38;           // handle width the jaw wraps
grip_t       = 30;           // handle thickness
interference = 0.2;          // jaw tighter than grip (spec)
jaw_wall     = 3;
clip_len     = 40;           // clip length along handle axis
clip_gap_x   = 175;          // centre-to-centre of the two clips (set to your MC1 extended width)

// ---- Derived ----
bucket_w = (orientation == "landscape" ? phone_long : phone_short) + pad_clear;
bucket_h = (orientation == "landscape" ? phone_short : phone_long) + pad_clear;
plate_w  = max(bucket_w + 2*wall, clip_gap_x + grip_w + 2*jaw_wall);

module tray() {
  difference() {
    // backplate + cradle walls
    translate([-bucket_w/2 - wall, 0, 0])
      cube([bucket_w + 2*wall, bucket_h + 2*wall, wall + tray_depth]);
    // phone pocket
    translate([-bucket_w/2, wall, wall])
      cube([bucket_w, bucket_h, tray_depth + 1]);
    // open the back to save plastic / allow heat
    translate([-bucket_w/2 + 12, wall + 12, -1])
      cube([bucket_w - 24, bucket_h - 24, wall + 2]);
    // side windows for buttons & hinge access
    translate([-bucket_w/2 - wall - 1, wall + bucket_h*0.25, wall + 1.5])
      cube([wall + 2, bucket_h*0.5, tray_depth]);
  }
  // bottom retention lip
  translate([-bucket_w/2 - wall, 0, 0])
    cube([bucket_w + 2*wall, wall, wall + lip_height]);
  translate([-bucket_w/2, wall, wall + tray_depth - 1.5])
    cube([bucket_w, lip_overhang, 1.5]);
}

module clip() {
  jaw_in = grip_w - interference;     // 0.2 mm interference fit
  jaw_t  = grip_t - interference;
  difference() {
    cube([jaw_in + 2*jaw_wall, clip_len, jaw_t + 2*jaw_wall]);
    translate([jaw_wall, -1, jaw_wall]) cube([jaw_in, clip_len + 2, jaw_t]);
    // flex slot: open one side so the jaw snaps on
    translate([jaw_wall + 4, -1, jaw_wall + jaw_t - 0.01])
      cube([jaw_in - 8, clip_len + 2, jaw_wall + 1]);
  }
}

module standoff_bridge(x) {
  // rigid column from clip up to the tray, offset forward by `standoff`
  translate([x - 6, clip_len, 0]) cube([12, bucket_h * 0.35, wall + standoff]);
}

union() {
  translate([0, clip_len + standoff, 0]) tray();
  for (s = [-1, 1]) {
    translate([s*clip_gap_x/2 - (grip_w + 2*jaw_wall)/2, 0, 0]) clip();
    standoff_bridge(s*clip_gap_x/2);
  }
}
