module pentagram(r, w=1, d=1) {
    linear_extrude(height=d) {
        for(a=[0:+(360/5):360]) {        
            rotate([0, 0, a]) 
                translate([-r, 0, 0]) rotate([0, 0, 18]) translate([w * 0.95, -0.5 * w]) square(size=[r, w]);
            rotate([0, 0, a])
                translate([-r, 0, 0]) rotate([0, 0, -1 * 18]) translate([w * 0.95, -0.5 * w]) square(size=[r, w]);
        }
        difference() {
            circle(r=r);
            circle(r=r-w);
        }
    }
}
DIAMETER = 34;
pentagram((DIAMETER/2) - 1, 1, 1.5);