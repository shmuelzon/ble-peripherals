box_size = [31, 42, 16.5];
wall_width = 0.8;
$fn = 36;

module peg()
{
  cylinder(h = 10, r = 2.5);
  translate([0, 0, 10]) cylinder(h = 3, r = 1.5);
}

module peg_socket()
{
  difference() {
    cylinder(h = 5.7, r = 2.75);
    cylinder(h = 5.7, r = 1.75);
  }
}

module battery_holder()
{
  cube([1.6, 14.5, 3.5]);
  translate([0, 0, 3.5]) cube([0.6, 2, 9.5]);
  translate([0.6, 0, 3.5]) cube([1, 3.5, 9.5]);
  translate([0.6, 10, 3.5]) cube([1, 4.5, 9.5]);
}

module vent()
{
  /*
  translate([0, 1.5, 0.75]) rotate([0, 90, 0]) cylinder(h = wall_width + 0.1, r = 0.5);
  translate([0, 0, 0.75]) rotate([0, 90, 0]) cylinder(h = wall_width + 0.1, r = 0.5);
  translate([0, -1.5, 0.75]) rotate([0, 90, 0]) cylinder(h = wall_width + 0.1, r = 0.5);
  translate([0, 1.5, -0.75]) rotate([0, 90, 0]) cylinder(h = wall_width + 0.1, r = 0.5);
  translate([0, 0, -0.75]) rotate([0, 90, 0]) cylinder(h = wall_width + 0.1, r = 0.5);
  translate([0, -1.5, -0.75]) rotate([0, 90, 0]) cylinder(h = wall_width + 0.1, r = 0.5);
  */
  translate([0.4, 1.5, 0.75]) cube([wall_width + 0.1, 1, 1], center=true);
  translate([0.4, 0, 0.75]) cube([wall_width + 0.1, 1, 1], center=true);
  translate([0.4, -1.5, 0.75]) cube([wall_width + 0.1, 1, 1], center=true);
  translate([0.4, 1.5, -0.75]) cube([wall_width + 0.1, 1, 1], center=true);
  translate([0.4, 0, -0.75]) cube([wall_width + 0.1, 1, 1], center=true);
  translate([0.4, -1.5, -0.75]) cube([wall_width + 0.1, 1, 1], center=true);
}

module _box()
{
}

module box()
{
  difference()
  {
    union()
    {
      /* Base */
      cube(box_size + [wall_width * 2, wall_width * 2, wall_width - box_size[2]]);
      /* Walls */
      translate([0, 0, wall_width]) cube([box_size[0] + 2 * wall_width, wall_width, box_size[2]]);
      translate([0, box_size[1] + wall_width, wall_width]) cube([box_size[0] + 2 * wall_width, wall_width, box_size[2]]);
      translate([0, wall_width, wall_width]) cube([wall_width, box_size[1], box_size[2]]);
      translate([box_size[0] + wall_width, wall_width, wall_width]) cube([wall_width, box_size[1], box_size[2]]);
    }
    /* Motion sensor cut-out */
    translate([box_size[0] / 2 + wall_width, box_size[1] / 2 + wall_width, 0]) cylinder(h = wall_width, r = 10.5);
    /* LED cut-out */
    translate([box_size[0] / 2 + wall_width - 13, box_size[1] / 2 + wall_width, wall_width / 2]) cube([2.5, 2.5, wall_width], true);
    /* Ambient light sensor cut-out */
    translate([box_size[0] / 2 + wall_width + 13, box_size[1] / 2 + wall_width, wall_width / 2]) cube([2.5, 2.5, wall_width], true);
    /* Vents */
    translate([0, 31.25 + wall_width, 10 + wall_width]) vent();
    translate([wall_width + 8, box_size[1] + wall_width * 2, 10 + wall_width]) rotate([0, 0, -90]) vent();
  }
  
  /* PCB pegs */
  translate([2.75 + wall_width, 25.75 + wall_width, wall_width]) peg();
  translate([2.75 + wall_width, 36.75 + wall_width, wall_width]) peg();
  translate([box_size[0] - 2.75 + wall_width, 24.75 + wall_width, wall_width]) peg();
  
  /* Battery holders */
  translate([wall_width, wall_width, wall_width]) battery_holder();
  translate([box_size[0] + wall_width, wall_width, wall_width]) mirror([1, 0, 0]) battery_holder();
}

module cover()
{
  /* Base */
  cube(box_size + [wall_width * 2, wall_width * 2, wall_width - box_size[2]]);
  /* Walls */
  translate([wall_width, wall_width, wall_width]) cube([box_size[0], wall_width, 3]);
  translate([wall_width, box_size[1], wall_width]) cube([box_size[0], wall_width, 3]);
  translate([wall_width, wall_width, wall_width]) cube([wall_width, box_size[1], 3]);
  translate([box_size[0], wall_width, wall_width]) cube([wall_width, box_size[1], 3]);
  /* Peg sockets */
  translate([box_size[0] - 2.75 + wall_width, 25.75 + wall_width, wall_width]) peg_socket();
  translate([box_size[0] - 2.75 + wall_width, 36.75 + wall_width, wall_width]) peg_socket();
  translate([2.75 + wall_width, 24.75 + wall_width, wall_width]) peg_socket();
}

box();
translate([50, 0, 0]) cover();
