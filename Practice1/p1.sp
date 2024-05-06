pratice 1 from Lab5-1 Dynamic 3-input XOR  (loading c=1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out 
mp0  out  in  vdd  vdd  P_18  l=0.18u  w=2u
mn0  out  in  gnd  gnd  N_18  l=0.18u  w=2u
.ends

.subckt  xor a b c clk out 

xinva a aout inv
xinvb b bout inv
xinvc c cout inv

mp0  out clk  vdd   vdd  P_18 l=0.18u  w=4u
*    D   G    S
mn0  out aout n0    gnd  N_18  l=0.18u w=3.5u
mn1  n0  b    n1    gnd  N_18  l=0.18u w=3.5u
mn2  n1  c    nnn   gnd  N_18  l=0.18u w=3.5u

mn3  out a     n2  gnd  N_18  l=0.18u w=3.5u
mn4  n2  bout  n3  gnd  N_18  l=0.18u w=3.5u
mn5  n3  c     nnn gnd  N_18  l=0.18u w=3.5u

mn6  out a     n4   gnd  N_18  l=0.18u w=3u
mn7  n4  b     n5   gnd  N_18  l=0.18u w=4u
mn8  n5  cout  nnn  gnd  N_18  l=0.18u w=4u

mn9  out aout     n6   gnd  N_18  l=0.18u w=3.5u
mn10 n6  bout     n7   gnd  N_18  l=0.18u w=3.5u
mn11 n7  cout     nnn  gnd  N_18  l=0.18u w=3.5u

mn12 nnn clk 0 gnd  N_18  l=0.18u w=10u
.ends

xxor3 a b c clk out1 xor
x1 out1 out2 inv 
x2 out2 out inv

c1 out gnd 1p

vvdd vdd  0  1.8 *宣告一個直流電壓源
vgnd gnd  0  0

*VCLK    CLK  GND    PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
va       a       0     pulse(1.8 0    1n   0.5n    0.5n    7.5n        16n)
vb       b       0     pulse(1.8 0    1n   0.5n    0.5n    15.5n  32n)
vc   	  c       0     pulse(1.8 0    1n   0.5n    0.5n    31.5n 64n)
vclk 	  clk     0     pulse(1.8 0    1n   0.5n    0.5n    3.5n  8n)


.meas tran delay000 trig v(clk)      val=0.9  rise=1
+                   targ v (out)     val=0.9  fall=1

.meas tran delay110 trig v(clk)      val=0.9  rise=4
+                   targ v (out)     val=0.9  fall=2

.meas tran delay101 trig v(clk)      val=0.9  rise=6
+                   targ v (out)     val=0.9  fall=3

.meas tran delay011 trig v(clk)      val=0.9  rise=7
+                   targ v (out)     val=0.9  fall=4

.meas tran pw avg power

.tran 0.1n 64n 
.end
