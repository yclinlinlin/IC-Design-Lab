pratice6 A*B+C*(B*D+A*E)(loading c=0.5p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd wp=3.5u wn=1u 
mp0  out  in  vdd  vdd  P_18  l=0.18u  w=wp 
mn0  out  in  gnd  gnd  N_18  l=0.18u  w=wn 
.ends

.subckt  and  a b  out vdd gnd wn=5u
xinvb b bout vdd gnd inv 

mn0		out		bout	gnd	0	N_18	l=0.18u   w=wn 
mn1		out	    b	    a	0	N_18	l=0.18u   w=wn 
.ends

.subckt  or  a b  out  vdd gnd
xinvb b bout vdd gnd inv 

*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mn0		out		  bout    a   	0		N_18		l=0.18u  	w=5u 
mn1		out		   b	  vdd	    0		N_18		l=0.18u  	w=5u 
.ends

.subckt logic a b c d e out vdd gnd
xAB a b  n1 vdd gnd and
xAE a e  n2 vdd gnd and
xBD b d  n3 vdd gnd and

xAEBD n2 n3  n4  vdd gnd or

xCAEBD n4 c n5 vdd gnd and

xABCAEBD n1 n5  out  vdd gnd or
.ends

xout a b c d e out1 vdd gnd logic

x1  out1      out2   vdd gnd inv *wp=10u
x2  out2      out    vdd gnd inv *wp=10u


cload  out  gnd   0.5p

vvdd	vdd		0		1.8
vgnd	gnd		0		0


*VCLK    CLK  GND    PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
vina e    gnd   pulse(1.8 0  1n   0.5n  0.5n 399.5n 800n)
vinb d    gnd   pulse(1.8 0  1n   0.5n  0.5n 199.5n 400n)
vinc c    gnd   pulse(1.8 0  1n   0.5n  0.5n 99.5n  200n)
vind b    gnd   pulse(1.8 0  1n   0.5n  0.5n 49.5n  100n)
vine a    gnd   pulse(1.8 0  1n   0.5n  0.5n 24.5n  50n)


.meas tran delay000_00 trig v(a)   val=0.9 fall=1
+                      targ v(out) val=0.9 fall=1

.meas tran delay110_00 trig v(a)   val=0.9 rise=2
+                      targ v(out) val=0.9 rise=1

.meas tran delay001_00 trig v(a)   val=0.9 fall=3
+                      targ v(out) val=0.9 fall=2

.meas tran delay111_00 trig v(a)   val=0.9 rise=4
+                      targ v(out) val=0.9 rise=2

.meas tran delay000_10 trig v(a)   val=0.9 fall=5
+                      targ v(out) val=0.9 fall=3

.meas tran delay110_10 trig v(a)   val=0.9 rise=6
+                      targ v(out) val=0.9 rise=3

.meas tran delay001_10 trig v(a)   val=0.9 fall=7
+                      targ v(out) val=0.9 fall=4

.meas tran delay110_01 trig v(a)   val=0.9 rise=10
+                      targ v(out) val=0.9 rise=4

.meas tran delay001_01 trig v(a)   val=0.9 fall=11
+                      targ v(out) val=0.9 fall=5

.meas tran delay101_01 trig v(a)   val=0.9 rise=11
+                      targ v(out) val=0.9  rise=5

.meas tran delay011_01 trig v(a)   val=0.9 fall=12
+                      targ v(out) val=0.9  fall=6

.meas tran delay111_01 trig v(a)   val=0.9 rise=12
+                      targ v(out) val=0.9  rise=6

.meas tran delay000_11 trig v(a)   val=0.9 fall=13
+                      targ v(out) val=0.9  fall=7

.meas tran delay110_11 trig v(a)   val=0.9 rise=14
+                      targ v(out) val=0.9  rise=7

.meas tran delay001_11 trig v(a)   val=0.9 fall=15
+                      targ v(out) val=0.9  fall=8

.meas tran delay101_11 trig v(a)   val=0.9 rise=15
+                      targ v(out) val=0.9  rise=8

.meas tran pw avg power

.tran 0.1n 800n
.end
