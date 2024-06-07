.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot

.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

.subckt  nand   a  b  out
mp0 out a vdd vdd p_18 l=0.18u  w=0.25u
mp1 out b vdd vdd p_18 l=0.18u  w=0.25u
mn0 out a net gnd n_18 l=0.18u  w=0.25u
mn1 net b gnd gnd n_18 l=0.18u  w=0.25u
.ends
.subckt  inv  in  out 
mp1 out in vdd  vdd p_18 l=0.18u  w=0.25u
mn1 out in gnd  gnd   n_18 l=0.18u  w=0.25u
.ends

.subckt  xor   a  b  out 
xa1 a aout  inv
xb1 b bout  inv
mp1 n1 aout vdd vdd p_18 l=0.18u  w=0.25u
mp2 out b    n1  vdd p_18 l=0.18u  w=0.25u
mp3 n2 a    vdd vdd p_18 l=0.18u  w=0.25u
mp4 out bout n2  vdd p_18 l=0.18u  w=0.25u
mn1 out b    n3  gnd n_18 l=0.18u  w=0.25u
mn2 n3 a    gnd gnd n_18 l=0.18u  w=0.25u
mn3 out bout n4  gnd n_18 l=0.18u  w=0.25u
mn4 n4 aout gnd gnd n_18 l=0.18u  w=0.25u
.ends
.subckt FA a b cin sum cout
x1 a b n1 xor 
x2 n1 cin sum xor
x3 a b n2 nand
x4 cin n1 n3 nand
x5 n3 n2 cout nand
.ends
.subckt eightinputFA a b a1 b1 a2 b2 a3 b3 a4 b4 a5 b5 a6 b6 a7 b7 cin sum sum1 sum2 sum3 sum4 sum5 sum6 sum7 cout
x1 a b cin sum c0 FA
x2 a1 b1 c0 sum1 c1 FA
x3 a2 b2 c1 sum2 c2 FA
x4 a3 b3 c2 sum3 c3 FA
x5 a4 b4 c3 sum4 c4 FA
x6 a5 b5 c4 sum5 c5 FA
x7 a6 b6 c5 sum6 c6 FA
x8 a7 b7 c6 sum7 cout FA

.ends

xa1 a b a1 b1 a2 b2 a3 b3 a4 b4 a5 b5 a6 b6 a7 b7 cin sum sum1 sum2 sum3 sum4 sum5 sum6 sum7 cout eightinputfa

cload0 SUM gnd 0.05p
cload1 SUM1 gnd 0.05p
cload2 SUM2 gnd 0.05p
cload3 SUM3 gnd 0.05p
cload4 SUM4 gnd 0.05p
cload5 SUM5 gnd 0.05p
cload6 SUM6 gnd 0.05p
cload7 SUM7 gnd 0.05p
cload8 COUT gnd 0.05p



va   a   gnd  pulse(1.8 0 0.1n 0.1n 0.1n 3.9n 8n)
vb   b   gnd  pulse(1.8 0 0.1n 0.1n 0.1n 7.9n 16n)
vci  cin  gnd  0
va1  a1   gnd  1.8
vb1  b1   gnd  1.8
va2  a2   gnd  1.8
vb2  b2   gnd  1.8
va3  a3   gnd  1.8
vb3  b3   gnd  1.8
va4  a4   gnd  1.8
vb4  b4   gnd  1.8
va5  a5   gnd  1.8
vb5  b5   gnd  1.8
va6  a6   gnd  1.8
vb6  b6   gnd  1.8
va7  a7   gnd  1.8
vb7  b7   gnd  1.8




.tran 0.1n 40n *(sweep k 0.5u 2u 0.5u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(clk)   val=0.9   rise=4
+                  targ v(c0)  val=0.9   rise=1
.meas tran delayN2 trig v(clk)   val=0.9   rise=4
+                  targ v(c1)  val=0.9   rise=4
.meas tran delayN3 trig v(clk)   val=0.9   rise=4
+                  targ v(c2)  val=0.9   rise=4
.meas tran delayN4 trig v(clk)   val=0.9   rise=4
+                  targ v(c3)  val=0.9   rise=4
.meas tran delayN5 trig v(clk)   val=0.9   rise=4
+                  targ v(c4)  val=0.9   rise=4
.meas tran delayN6 trig v(clk)   val=0.9   rise=4
+                  targ v(c5)  val=0.9   rise=4
.meas tran delayN7 trig v(clk)   val=0.9   rise=4
+                  targ v(c6)  val=0.9   rise=4
.meas tran delayN8 trig v(clk)   val=0.9   rise=4
+                  targ v(c7)  val=0.9   rise=4


.meas tran pw avg power


.meas tran pdp=param('pw*delayN1')

.end