pratice3 from Lab3-3 Pass-transistor 3-input XOR  (loading c=1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd wp=4u wn=2u m1=1
mp0  out  in  vdd  vdd  P_18  l=0.18u  w=wp m=m1
mn0  out  in  gnd  gnd  N_18  l=0.18u  w=wn m=m1
.ends

.subckt xor3 a b c out vdd gnd

xa a aout vdd gnd inv
xb b bout vdd gnd inv wp=5u wn=2.2u
xc c cout vdd gnd inv wp=4u wn=1.55u

m1 out a     n1   gnd n_18   w=1.6u  l=0.18u
m2 out aout  n2   gnd n_18   w=1.3u  l=0.18u
m3 n1  b     c    gnd n_18   w=1.1u  l=0.18u
m4 n1  bout  cout gnd n_18   w=2.9u  l=0.18u
m5 n2  b     cout gnd n_18   w=1.1u  l=0.18u
m6 n2   bout c    gnd n_18   w=1.18u l=0.18u

.ends

xxor a b c out1 vdd gnd xor3
x1 out1 out2 vdd gnd inv wp=10u wn=1.82u
x2 out2 out  vdd gnd inv wp=10u wn=1.82u

c1 out gnd 1p

vvdd vdd  0  1.8 *宣告一個直流電壓源
vgnd gnd  0  0

*VCLK    CLK  GND    PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
vina a    gnd   pulse(1.8 0  1n   0.5n  0.5n 199.5n 400n  )
vinb b    gnd   pulse(1.8 0  1n   0.5n  0.5n 99.5n 200n  )
vinc c    gnd   pulse(1.8 0  1n   0.5n  0.5n 49.5n 100n )


.meas tran delayN1 trig v(c)   val=0.9 rise=1
+                  targ v(out) val=0.9 rise=1
.meas tran delayN2 trig v(c)   val=0.9 rise=2
+                  targ v(out) val=0.9 fall=2
.meas tran delayN3 trig v(c)   val=0.9 fall=3
+                  targ v(out) val=0.9 rise=2
.meas tran delayN4 trig v(c)   val=0.9 rise=3
+                  targ v(out) val=0.9 fall=3
.meas tran delayN5 trig v(c)   val=0.9 rise=4
+                  targ v(out) val=0.9 rise=3
.meas tran delayN6 trig v(c)   val=0.9 fall=5
+                  targ v(out) val=0.9 fall=4
.meas tran pw avg power

.tran 10n 600n
.end
