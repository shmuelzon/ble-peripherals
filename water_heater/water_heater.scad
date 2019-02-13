box_size = [45, 45, 7.5];
led_size = [33, 5.5];
button_size = [20, 9];
wall_width = 1.5;
$fn = 36;


module screw_hole()
{
  cylinder(h = 1, r = 1.5);
  translate([0, 0, 1]) cylinder(h = box_size[2] - 1, r = 2.6);
}

module main()
{
  difference()
  {
    minkowski()
    {
      rad = 1;
      translate([rad, rad, 0]) cube([box_size[0] - (rad * 2), box_size[1] - (rad * 2), box_size[2] / 2]);
      cylinder(h = box_size[2] / 2, r = rad);
    }
    /* Concave */
    translate([box_size[0] / 2, box_size[1] / 2, wall_width]) cylinder(h = box_size[2] - wall_width, r1 = 18.75, r2 = 21);
  
    /* Screw holes */
    translate([box_size[0] / 2, 4.25 ,0]) screw_hole();
    translate([box_size[0] / 2, box_size[1] - 4.25 ,0]) screw_hole();
  
    /* LEDs cut-out */
    translate([(box_size[0] / 2) - (led_size[0] / 2), (box_size[1] / 2) - (led_size[1] / 2), 0]) cube([led_size[0], led_size[1], wall_width]);
  
    /* Button cut-out */
    translate([(box_size[0] / 2), 11.25, wall_width / 2]) scale([button_size[0], button_size[1], wall_width]) cylinder(h = 1, r = 0.5, center = true);
  }
}

module diffuser()
{
  cube([led_size[0] + 2, led_size[1] + 2, 1]);
  translate([1, 1, 1]) cube([led_size[0] - 0.5, led_size[1] - 0.5, wall_width]);
}

module button()
{
  scale([button_size[0] + 2, button_size[1] + 2, 1]) cylinder(h = 1, r = 0.5);
  translate([0, 0, 1]) scale([button_size[0] - 0.5, button_size[1] - 0.5, wall_width + 5]) cylinder(h = 1, r = 0.5);
}

main();
translate([50, 20, 0]) diffuser();
translate([70, 10, 0]) button();
