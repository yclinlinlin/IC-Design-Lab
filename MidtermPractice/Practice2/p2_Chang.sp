3-input pseudo XOR 
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd



.subckt inv in out vdd gnd  
mp1 out    in   vdd   vdd  p_18  l=0.18u w=1u
mn1 out   in   gnd   gnd  n_18  l=0.18u w=5u
.ends

.subckt  xor  a b c  out vdd gnd

xa1 a aout vdd gnd inv
xb1 b bout vdd gnd inv
xc1 c cout vdd gnd inv


mp1  out    gnd     vdd    vdd  p_18  l=0.18u w=3.25u 
                                           
mn1  out   aout   n1     gnd  n_18  l=0.18u w=5u
mn2  n1    b      n2    gnd  n_18  l=0.18u w=5u 
mn3  n2   c      gnd     gnd  n_18  l=0.18u w=5u

mn4  out   aout   n3    gnd  n_18  l=0.18u w=5.97u
mn5  n3    bout   n4    gnd  n_18  l=0.18u w=5.97u
mn6  n4   cout   gnd     gnd  n_18  l=0.18u w=5.97u

mn7  out   a      n5    gnd  n_18  l=0.18u w=6.5u
mn8  n5   b      n6    gnd  n_18  l=0.18u w=6.5u
mn9  n6   cout   gnd    gnd  n_18  l=0.18u w=6.5u

mn10 out   a    n7     gnd  n_18  l=0.18u w=4.8u
mn11 n7    bout   n8   gnd  n_18  l=0.18u w=4.8u
mn12 n8  c    gnd    gnd  n_18  l=0.18u w=4.8u

.ends


x1 a b c  out vdd gnd  xor

*xd1 out1  out2 vdd gnd inv
*xe1 out2  out vdd gnd inv

c1oad out gnd 1p

vvdd vdd  0  1.8
vgnd gnd  0  0

*VCLK  CLK  GND     PULSE(VL  VH   delay  trise  tfall  pulse_width  period)
vc  c  0  pulse(1.8 0 1n  0.5n 0.5n 39.9n  80n)
vb  b  0  pulse(1.8 0 1n  0.5n 0.5n 79.9n  160n)
va  a  0  pulse(1.8 0 1n  0.5n 0.5n 159.9n  320n)


.meas tran delay000 trig v(c) val=0.9 fall=1
+       targ v(out) val=0.9 fall=1

.meas tran delay001 trig v(c) val=0.9 rise=1
+       targ v(out) val=0.9 rise=1

.meas tran delay011 trig v(c) val=0.9 rise=2
+       targ v(out) val=0.9 fall=2

.meas tran delay100 trig v(c) val=0.9 fall=3
+       targ v(out) val=0.9 rise=2

.meas tran delay101 trig v(c) val=0.9 rise=3
+       targ v(out) val=0.9 fall=3

.meas tran delay111 trig v(c) val=0.9 rise=4
+       targ v(out) val=0.9 rise=3

.meas tran pw avg power

.tran 0.1n 320n *(sweep  k  0.05p  0.5p   0.05p)
.end
