two-bit-comparator
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

*	drain gate source body mos_type L 
.subckt comp a1 a0 b1 b0 lt eq gt vdd gnd
.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=1u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=0.5u
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
		
xa1 a0 a0out vdd gnd inv1
xa2 a1 a1out vdd gnd inv1
xa3 b0 b0out vdd gnd inv1
xa4 b1 b1out vdd gnd inv1
xb1 a1out b1    n1 vdd gnd nor1
xb2 a1out b1    n2 vdd gnd nand1
xb3 a0out b0    n3 vdd gnd nand1
xb4 a1    b1out n4 vdd gnd nand1
xb5 a0    b0out n5 vdd gnd nand1
xb6 a1    b1out n6 vdd gnd nor1
xc1 n1    n3    n7 vdd gnd nor1
xc2 n7    n9    vdd gnd inv1
xc3 n5    n6    n8 vdd gnd nor1
xc4 n8    n10    vdd gnd inv1
xd1 n9    n2    lt vdd gnd nand1
xd2 n10   n4    gt vdd gnd nand1
xe1 gt lt eq vdd gnd nor1
.ends

xf1 a1 a0 b1 b0 lt eq gt vdd gnd comp
*cload node+ node- value
cload1  lt   gnd   0.1p
cload2  gt   gnd   0.1p
cload3  eq   gnd   0.1p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va1 a1    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  19.9n 40n)
va0 a0    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)
vb1 b1    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n 10n)
vb0 b0    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  2.4n 5n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.05n 40n 
*(sweep k 0.25u 2.5u 0.05u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(b0)  val=0.9 fall=4
+                  targ v(eq)  val=0.9 fall=2
.meas tran delayN2 trig v(b0)  val=0.9 fall=4
+                  targ v(lt)  val=0.9 rise=2
.meas tran delayN3 trig v(b0)  val=0.9 fall=5
+                  targ v(gt)  val=0.9 rise=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end