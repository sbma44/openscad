HOLE_SEP = 89;
HOLE_DIAM = 8;
HOLE_INNER = 4.5;

 module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}

difference() {
    union() {
        cylinder(h=4, d=HOLE_DIAM, $fn=64);
        translate([HOLE_SEP, 0, 0]) cylinder(h=4, d=HOLE_DIAM, $fn=64);
        translate([(0.5 * HOLE_SEP) - 6, -7.5, 15]) rotate([0, 90, 90]) intersection() {
            import("gopro/GoPro_Arm_Inline.stl");
            cube([20, 20, 40], center=true);
        }
        translate([-0.5 * HOLE_DIAM, -5, 3]) cube([HOLE_SEP + HOLE_DIAM, 10, 4]);
    }
    cylinder_outer(8, HOLE_INNER / 2, 64);
    translate([HOLE_SEP, 0, 0]) cylinder_outer(8, HOLE_INNER / 2, 64);
}