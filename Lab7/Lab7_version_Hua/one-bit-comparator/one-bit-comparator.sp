one-bit-comparator
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

*	drain gate source body mos_type L 
.subckt comp a b lt eq gt vdd gnd
.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=4u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=1u
.ends
.subckt nor1 a b out vdd gnd
mp0 net a vdd vdd p_18 l=0.18u w=2u
mp1 out b net vdd p_18 l=0.18u w=2u
mn0 out a gnd gnd n_18 l=0.18u w=1u
mn1 out b gnd gnd n_18 l=0.18u w=1u
.ends
.subckt nand1 a b out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=2u
mp1 out b vdd vdd p_18 l=0.18u w=2u
mn0 out a net gnd n_18 l=0.18u w=1u
mn1 net b gnd gnd n_18 l=0.18u w=1u
.ends

		
xa1 a aout vdd gnd inv1
xa2 b bout vdd gnd inv1
xb1 b aout o1  vdd gnd nand1
xb2 o1 lt  vdd gnd inv1
xc1 a bout o2  vdd gnd nand1
xc2 o2 gt  vdd gnd inv1
xd1 gt lt eq vdd gnd nor1
.ends
xf1 a b lt eq gt vdd gnd comp
*cload node+ node- value
cload1  lt   gnd   0.1p
cload2  gt   gnd   0.1p
cload3  eq   gnd   0.1p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  2.4n 5n)
vb b    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n 10n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.05n 40n 
*(sweep k 0.25u 2.5u 0.05u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(a)  val=0.9 rise=3
+                  targ v(eq) val=0.9 fall=2
.meas tran delayN2 trig v(a)  val=0.9 fall=4
+                  targ v(lt) val=0.9 rise=2
.meas tran delayN3 trig v(a)  val=0.9 rise=3
+                  targ v(gt) val=0.9 rise=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end