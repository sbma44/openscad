$fa=0.5;
$fp=1;

PLUG_HEIGHT=7.5;
HOLE_RADIUS=6.35;

translate([0, 0, PLUG_HEIGHT]) union() {
    difference() {
        scale([1, 1, 3 / (HOLE_RADIUS + 5)]) sphere(r=HOLE_RADIUS + 5);
        translate([-15, -15, -20]) cube([30, 30, 20]);
    }
    
    difference() {
        translate([0, 0, -1 * PLUG_HEIGHT]) linear_extrude(PLUG_HEIGHT) circle(r=6.35, $fn=32);
        translate([-15, -4, -1 * ((PLUG_HEIGHT * 0.5) + 1.5)]) cube([30, 8, 3]);
    }
}