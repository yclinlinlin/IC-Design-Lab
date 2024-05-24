8-bit Dynamic Manchester Carry-Generation Chain
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

* drain gate source body mos_type L
.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=1u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=0.5u
.ends 
.subckt nand1 a b out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=1u
mp1 out b vdd vdd p_18 l=0.18u w=1u
mn0 out a net gnd n_18 l=0.18u w=1u
mn1 net b gnd gnd n_18 l=0.18u w=1u
.ends
xo1 b0 a0 g0_ vdd gnd nand1
xo2 g0_ g0 vdd gnd inv1
xb1 a  b  g1_ vdd gnd nand1
xb2 g1_ g1 vdd gnd inv1
.subckt xor1 a b out vdd gnd

xa1 a aout vdd gnd inv1
xb1 b bout vdd gnd inv1
                                               
mp1 net1   aout   vdd     vdd  p_18  l=0.18u w=2u
mp2 out    b      net1    vdd  p_18  l=0.18u w=2u
mp3 net2   a      vdd     vdd  p_18  l=0.18u w=2u
mp4 out    bout   net2    vdd  p_18  l=0.18u w=2u
mn1 out    a      net3    gnd  n_18  l=0.18u w=1u
mn2 net3   b      gnd     gnd  n_18  l=0.18u w=1u
mn3 out    aout   net4    gnd  n_18  l=0.18u w=1u
mn4 net4   bout   gnd     gnd  n_18  l=0.18u w=1u
.ends
xc5 a0 b0 p0 vdd gnd xor1
xd5 a  b  p1 vdd gnd xor1
.subckt cgc ck p c g cout vdd gnd
xe1 c  cout3 vdd   gnd inv1
xf2 out1  cout  vdd   gnd inv1
mp0 out1 ck    vdd   vdd p_18 l=0.18u w=1u
mn0 out1 p     cout3 gnd n_18 l=0.18u w=1u
mn1 out1 g     net   gnd n_18 l=0.18u w=1u
mn2 net  ck    gnd   gnd n_18 l=0.18u w=1u
.ends
xi1  clk p0 ci   g0   c0 vdd gnd cgc
xj2  clk p1 c0   g1   c1 vdd gnd cgc
xk1  clk p1 c1   g1   c2 vdd gnd cgc
xl2  clk p1 c2   g1   c3 vdd gnd cgc
xm1  clk p1 c3   g1   c4 vdd gnd cgc
xn2  clk p1 c4   g1   c5 vdd gnd cgc
xo3  clk p1 c5   g1   c6 vdd gnd cgc
xp2  clk p1 c6   g1   c7 vdd gnd cgc

*cload node+ node- value
cload0 c0 gnd 0.05p
cload1 c1 gnd 0.05p
cload2 c2 gnd 0.05p
cload3 c3 gnd 0.05p
cload4 c4 gnd 0.05p
cload5 c5 gnd 0.05p
cload6 c6 gnd 0.05p
cload7 c7 gnd 0.05p
*V node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
vclk clk gnd pulse(0  1.8 2.1n 0.1n 0.1n 1.9n 4n)
va a gnd pulse(1.8 0 0.1n 0.1n 0.1n 3.9n 8n)
vb b gnd pulse(1.8 0 0.1n 0.1n 0.1n 7.9n 16n)
vci ci gnd 0
va0 a0 gnd 1.8
vb0 b0 gnd 1.8





*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 40n 
*(sweep k 0.5u 2u 0.5u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(clk)  val=0.9   rise=3
+                  targ v(c0) val=0.9     rise=3
.meas tran delayN2 trig v(clk)  val=0.9   rise=3
+                  targ v(c1) val=0.9     rise=2
.meas tran delayN3 trig v(clk)  val=0.9   rise=3
+                  targ v(c2) val=0.9     rise=2
.meas tran delayN4 trig v(clk)  val=0.9   rise=3
+                  targ v(c3) val=0.9     rise=2
.meas tran delayN5 trig v(clk)  val=0.9   rise=3
+                  targ v(c4) val=0.9     rise=2
.meas tran delayN6 trig v(clk)  val=0.9   rise=3
+                  targ v(c5) val=0.9     rise=2
.meas tran delayN7 trig v(clk)  val=0.9   rise=3
+                  targ v(c6) val=0.9     rise=2
.meas tran delayN8 trig v(clk)  val=0.9   rise=3
+                  targ v(c7) val=0.9     rise=2




*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end