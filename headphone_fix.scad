EXT_X=32;
EXT_Y=9;
SQUIRCLE_RADIUS = 5;
HEAD_DIAM = 160;
WIDGET_EXTENT = 30;
WIDGET_EXTENT_ANGLE = (1.0 * WIDGET_EXTENT / (PI * HEAD_DIAM)) * 360;
THICKNESS = 1.5;
GAP_WIDTH = 2;

module rectacrescent(x, y, squircle_r) {
    squircle_d = 2 * squircle_r;
        
    translate([(-0.5 * x) + squircle_r, (-0.5 * y) + squircle_r]) {
            
            
        union() {
            intersection() {
                union() {
                    circle(r=squircle_r, $fn=64);
                    translate([x - squircle_d, 0]) circle(r=squircle_r, $fn=64);
                }
                translate([-1 * squircle_r, -1 * squircle_r]) square([x, y]);
            }
            translate([0, -1 * squircle_r]) square([x - squircle_d, y]);
            translate([-1 * squircle_r, 0]) square([x, y - squircle_r]);
        }
    }
}

echo("WIDGET_EXTENT_ANGLE");
echo(WIDGET_EXTENT_ANGLE);
difference() {
    union() {
        rotate([0, 0, -0.5 * WIDGET_EXTENT_ANGLE]) {
            rotate_extrude(angle=WIDGET_EXTENT_ANGLE, $fn=256) translate([0.5 * HEAD_DIAM, 0]) rotate(-90) difference() {
                rectacrescent(EXT_X + (2 * THICKNESS), EXT_Y + (2 * THICKNESS), SQUIRCLE_RADIUS + THICKNESS);
                translate([-0.5 * GAP_WIDTH, (-0.5 * EXT_Y) - THICKNESS]) square([GAP_WIDTH, THICKNESS + 0.5]);
            }
        }
        translate([(0.5 * HEAD_DIAM) + 4, 0, 0]) rotate([90, 90, 90]) linear_extrude(height=3) text("W", size=18, valign="center", halign="center");
    }
    rotate([0, 0, (-0.5 * (WIDGET_EXTENT_ANGLE + 10))]) rotate_extrude(angle=WIDGET_EXTENT_ANGLE + 10, $fn=256) translate([0.5 * HEAD_DIAM, 0]) rotate(-90) rectacrescent(EXT_X, EXT_Y, SQUIRCLE_RADIUS);
}

