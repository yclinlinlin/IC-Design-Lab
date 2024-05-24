eight-bit-comparator
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

*	drain gate source body mos_type L 
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
.subckt comp a1 a0 b1 b0 lt eq gt vdd gnd		
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
.subckt back lt1 eq1 gt1 lt2 eq2 gt2 lt eq gt vdd gnd
xf1  lt1 n1 vdd gnd inv1
xf2  eq1 n2  vdd gnd inv1
xf3  gt1 n3  vdd gnd inv1
xf4  eq1 lt2 n4  vdd gnd nand1
xf5  eq1 gt2 n5  vdd gnd nand1
xf6  n1  n4 lt vdd gnd nand1
xf7  n2 n9 eq vdd gnd nor1
xf8  n3  n5 gt vdd gnd nand1
xf9  eq2 n9 vdd gnd inv1

.ends
.subckt comp1 a3 a2 a1 a0 b3 b2 b1 b0 lt eq gt vdd gnd
xg1 a3 a2 b3 b2 lt1 eq1 gt1 vdd gnd comp
xg2 a1 a0 b1 b0 lt2 eq2 gt2 vdd gnd comp
xg3 lt1 eq1 gt1 lt2 eq2 gt2 lt eq gt vdd gnd back
.ends
.subckt comp2 a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0 lt eq gt vdd gnd
xh1 a7 a6 a5 a4 b7 b6 b5 b4 lt1 eq1 gt1 vdd gnd comp1
xh2 a3 a2 a1 a0 b3 b2 b1 b0 lt2 eq2 gt2 vdd gnd comp1
xh3 lt1 eq1 gt1 lt2 eq2 gt2 lt eq gt vdd gnd back
.ends
xi1 a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0 lt eq gt vdd gnd comp2
*cload node+ node- value
cload1  lt   gnd   0.1p
cload2  gt   gnd   0.1p
cload3  eq   gnd   0.1p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va7 a7    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n  81919.9n  163840n )
va6 a6    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n  40959.9n   81920n )
va5 a5    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n   20479.9n   40960n )
va4 a4    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n   10239.9n   20480n )
va3 a3    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n   5119.9n   10240n )
va2 a2    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n   2559.9n    5120n )
va1 a1    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n    1279.9n    2560n )
va0 a0    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n    639.9n    1280n )
vb7 b7    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n    319.9n     640n )
vb6 b6    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n      159.9n    320n )
vb5 b5    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n      79.9n    160n )
vb4 b4    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n      39.9n     80n )
vb3 b3    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n      19.9n      40n )
vb2 b2    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n      9.9n      20n )
vb1 b1    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n      4.9n      10n )
vb0 b0    gnd   pulse( 1.8 0  0.1n   0.1n  0.1n      2.4n       5n )

.tran 0.05n 163840n
*(sweep k 0.25u 2.5u 0.05u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(b0)  val=0.9 fall=258
+                  targ v(eq)  val=0.9 rise=2
.meas tran delayN2 trig v(b0)  val=0.9 fall=130
+                  targ v(lt)  val=0.9 rise=2
.meas tran delayN3 trig v(b0)  val=0.9 fall=257
+                  targ v(gt)  val=0.9 rise=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end