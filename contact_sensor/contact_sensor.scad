box_size = [27.5, 27.5, 8];
magnet_size = [6.5, 10.5, 6.5];
wall_width = 0.8;
$fn = 36;

module peg()
{
  cylinder(h = 2.2, r = 2.5);
  translate([0, 0, 2.2]) cylinder(h = 3.3, r = 1.5);
}

module box()
{
  /* Base */
  cube(box_size + [wall_width * 2, wall_width * 2, wall_width - box_size[2]]);
  /* Walls */
  translate([0, 0, wall_width]) cube([box_size[0] + 2 * wall_width, wall_width, box_size[2]]);
  translate([0, box_size[1] + wall_width, wall_width]) cube([box_size[0] + 2 * wall_width, wall_width, box_size[2]]);
  translate([0, wall_width, wall_width]) cube([wall_width, box_size[1], box_size[2]]);
  translate([box_size[0] + wall_width, wall_width, wall_width]) cube([wall_width, box_size[1], box_size[2]]); 
  /* PCB pegs */
  translate([3.25 + wall_width, 24.25 + wall_width, wall_width]) peg();
  translate([24.25 + wall_width, 3.25 + wall_width, wall_width]) peg();
}

module box_cover()
{
  /* Base */
  cube(box_size + [wall_width * 2, wall_width * 2, wall_width - box_size[2]]);
  /* Walls */
  translate([wall_width, wall_width, wall_width]) cube([box_size[0], wall_width, 1.5]);
  translate([wall_width, box_size[1], wall_width]) cube([box_size[0], wall_width, 1.5]);
  translate([wall_width, wall_width, wall_width]) cube([wall_width, box_size[1], 1.5]);
  translate([box_size[0], wall_width, wall_width]) cube([wall_width, box_size[1], 1.5]);
}

module magnet()
{
  /* Base */
  minkowski()
  {
    rad = 1;
    translate([rad, rad, 0]) cube([magnet_size[0] - (rad * 2) + (wall_width * 2), box_size[1] - (rad * 2) + (wall_width * 2), wall_width / 2]);
    cylinder(h = wall_width / 2, r = rad);
  }
  /* Platform (to raise the magnet) */
  translate([0, (box_size[1] / 2) - (magnet_size[1] / 2), wall_width]) cube([magnet_size[0] + wall_width * 2, magnet_size[1] + wall_width * 2, 1.5]);
  /* Walls */
  translate([0, (box_size[1] / 2) - (magnet_size[1] / 2), wall_width + 1.5]) cube([magnet_size[0] + 2 * wall_width, wall_width, magnet_size[2]]);
  translate([0, (box_size[1] / 2) + (magnet_size[1] / 2) + wall_width, wall_width + 1.5]) cube([magnet_size[0] + 2 * wall_width, wall_width, magnet_size[2]]);
  translate([0, (box_size[1] / 2) - (magnet_size[1] / 2), wall_width + 1.5]) cube([wall_width, magnet_size[1] + wall_width * 2, magnet_size[2]]);
  translate([magnet_size[0] + wall_width, (box_size[1] / 2) - (magnet_size[1] / 2), wall_width + 1.5]) cube([wall_width, magnet_size[1] + wall_width * 2, magnet_size[2]]);
}

module magnet_cover()
{
  /* Base */
  cube([magnet_size[0] + (wall_width * 2), magnet_size[1] + (wall_width * 2), wall_width]);
  /* Walls */
  translate([wall_width, wall_width, wall_width]) cube([0.5, magnet_size[1], 1]);
  translate([magnet_size[0] + 0.5, wall_width, wall_width]) cube([0.5, magnet_size[1], 1]);
}

box();
translate([50, 0, 0]) box_cover();

translate([0, 50, 0]) magnet();
translate([50, 50, 0]) magnet_cover();
