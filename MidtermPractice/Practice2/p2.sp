pratice2 from Lab3-2 Pseudo-NMOS 3-input XOR  (loading c=1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out m1=1
mp0  out  in  vdd  vdd  P_18  l=0.18u  w=5u m=m1
mn0  out  in  gnd  gnd  N_18  l=0.18u  w=2u m=m1
.ends

.subckt  xor a b c out 

xinva a aout inv
xinvb b bout inv
xinvc c cout inv

mp0  out 0   vdd    vdd  P_18  l=0.19u  w=3u
*    D   G    S
mn0  out aout n0    gnd  N_18  l=0.18u w=3.5u
mn1  n0  b    n1    gnd  N_18  l=0.18u w=3.5u
mn2  n1  c    0     gnd  N_18  l=0.18u w=3.5u

mn3  out a     n2   gnd  N_18  l=0.18u w=4u
mn4  n2  bout  n3   gnd  N_18  l=0.18u w=4u
mn5  n3  c   0      gnd  N_18  l=0.18u w=4u

mn6  out a     n4   gnd  N_18  l=0.18u w=5u
mn7  n4  b     n5   gnd  N_18  l=0.18u w=5u
mn8  n5  cout  0    gnd  N_18  l=0.18u w=5u

mn9  out aout  n6   gnd  N_18  l=0.18u w=5u
mn10 n6  bout  n7   gnd  N_18  l=0.18u w=5u
mn11 n7  cout  0    gnd  N_18  l=0.18u w=5.5u
.ends

xxor3 a b c out1 xor

x1 out1 out2 inv 
x2 out2 out inv 


*x3 out3 out4 inv 
*x4 out4 out inv 
*x5 out5 out6 inv 
*x6 out6 out7 inv 
*x7 out7 out8 inv 
*x8 out8 out9 inv 
*x9 out9 out10 inv 
*x10 out10 out inv 

c1 out gnd 1p

vvdd vdd  0  1.8 *宣告一個直流電壓源
vgnd gnd  0  0
*VCLK    CLK  GND    PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
va a 0 pulse(1.8  0  1n  0.5n  0.5n  159.9n 320n)
vb b 0 pulse(1.8  0  1n  0.5n  0.5n  79.9n 160n)
vc c 0 pulse(1.8  0  1n  0.5n  0.5n  39.9n  80n)

.meas tran delay000 trig v(c)        val=0.9   fall=1
+                   targ v(out)      val=0.9   fall=1
.meas tran delay001 trig v(c)        val=0.9   rise=1
+                   targ v (out)     val=0.9   rise=1
.meas tran delay011 trig v(c)        val=0.9   rise=2
+                   targ v (out)     val=0.9   fall=2
.meas tran delay100 trig v(c)        val=0.9   fall=3
+                   targ v (out)     val=0.9   rise=2
.meas tran delay101 trig v(c)        val=0.9   rise=3
+                   targ v (out)     val=0.9   fall=3
.meas tran delay111 trig v(c)        val=0.9   rise=4
+                   targ v (out)     val=0.9   rise=3

.meas tran pw avg power

.tran 0.1n 320n 
.end
