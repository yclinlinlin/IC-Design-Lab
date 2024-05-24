2-input NAND
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

* drain gate source body mos_type L 
.subckt nand a b out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=1u
mp1 out b vdd vdd p_18 l=0.18u w=1u
mn0 out a net gnd n_18 l=0.18u w=1u
mn1 net b gnd gnd n_18 l=0.18u w=1u
.ends
xa1  a b out1 vdd gnd nand
xa2  c out1 out2 vdd gnd nand
xa3  d out2 out3 vdd gnd nand
xa4  e out3 out4 vdd gnd nand
*cload node+ node- value
cload  out   gnd   0.02p

*V node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)
vb b    gnd   1.8
vc c    gnd   1.8
vd d    gnd   1.8
ve e    gnd   1.8


*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 80n 
*(sweep k 0.5u 2u 0.5u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(a)  val=0.9 rise=1
+                  targ v(out1) val=0.9 fall=1
.meas tran delayN2 trig v(a)  val=0.9 rise=1
+                  targ v(out2) val=0.9 rise=1
.meas tran delayN3 trig v(a)  val=0.9 rise=1
+                  targ v(out3) val=0.9 fall=1
.meas tran delayN4 trig v(a)  val=0.9 rise=1
+                  targ v(out4) val=0.9 rise=1



*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end