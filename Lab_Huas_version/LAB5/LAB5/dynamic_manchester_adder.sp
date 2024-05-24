dynamic_manchester_adder
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd  vdd  0 1.8 
vgnd  gnd  0  0

*MOSFET
.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=4u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=4u
.ends
.subckt nand1 a b out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=1u
mp1 out b vdd vdd p_18 l=0.18u w=1u
mn0 out a net gnd n_18 l=0.18u w=2u
mn1 net b gnd gnd n_18 l=0.18u w=2u
.ends
xa1 a0 b0 g01   vdd gnd  nand1
xa2 a  b  g11   vdd gnd  nand1
xi1 g01 g0 vdd gnd  inv1
xi2 g11 g1 vdd gnd  inv1
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
xo1 a0 b0 p0 vdd gnd   xor1
xo2 a  b  p1 vdd gnd   xor1
.subckt mancher clk p g ci ncout vdd gnd
xi3 ci   cii   vdd   gnd  inv1
xi4 out1 ncout vdd   gnd  inv1
mp1 out1   clk   vdd    vdd  p_18 	l=0.18u w=2u
mn1 out1   p     cii    gnd  n_18 	l=0.18u w=2u
mn2 out1   g     net    gnd  n_18 	l=0.18u w=8u
mn3 net    clk   gnd    gnd  n_18 	l=0.18u w=8u
.ends
xm1 clk p0  g0  ci c0 vdd gnd mancher
xm2 clk p1  g1  c0 c1 vdd gnd mancher
xm3 clk p1  g1  c1 c2 vdd gnd mancher
xm4 clk p1  g1  c2 c3 vdd gnd mancher
xm5 clk p1  g1  c3 c4 vdd gnd mancher
xm6 clk p1  g1  c4 c5 vdd gnd mancher
xm7 clk p1  g1  c5 c6 vdd gnd mancher
xm8 clk p1  g1  c6 c7 vdd gnd mancher

*cload
cload0 c0 gnd 0.05p
cload1 c1 gnd 0.05p
cload2 c2 gnd 0.05p
cload3 c3 gnd 0.05p
cload4 c4 gnd 0.05p
cload5 c5 gnd 0.05p
cload6 c6 gnd 0.05p
cload7 c7 gnd 0.05p


vck	clk	gnd	pulse(0		1.8	2.1n	0.1n	0.1n	1.9n	4n)
va	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	3.9n	8n)
vb	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	7.9n	16n)
vci	ci	gnd	0
va0	a0	gnd	1.8
vb0	b0	gnd	1.8

.tran 0.1n 40n

.meas tran delayN1 trig v(clk) val=0.9 rise=2
+                  targ v(c3)  val=0.9 rise=1

.meas tran pw avg power

.meas tran pdp=param('pw*delayN1')

.end