// cut-out model to fit Openbuilds V-Slot 20mm extrusion

module slotV(len,fuzz) {
  difference() {
    translate([-10-1,0,0]) cylinder(r=5.2+1+fuzz,h=len,$fn=4);
    translate([-8+.3+4/2,0,len/2]) cube([4,7,len],center=true);  // arbitrary .3mm extra lip to tab
  }

  // actual slot profile
  %hull() {
    translate([-10+2+1.2/2,0,len/2]) cube([1.2,10.6,len],center=true);
    translate([-5,0,len/2]) cube([2,4,len],center=true);
  }
}

module ext20(len,fuzz) {
w=20+fuzz*2;
w2f = w/2 - 0.6*abs(fuzz);
ro=1;
$fn=24;
  difference() {
    union() {
      translate([0,0,len/2]) cube([w,w,len],center=true);
      for(i=[-1,1]) for(j=[-1,1]) // extra clearance around corners
        translate([w2f*i,w2f*j,0])
          cylinder(r=fuzz*2,h=len,$fn=8);
    }

    translate([0,0,-1]) {
      for (a=[0,90,180,270]) {
        rotate([0,0,a])
          slotV(len+2,fuzz);
      }
      %cylinder(r=2,h=len+2);
    }
  }
}

ext20(5,0.2);
