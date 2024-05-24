4-input NAND
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

*	drain gate source body mos_type L 
.subckt nand1 a b c d out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=1u
mp1 out b vdd vdd p_18 l=0.18u w=1u
mp2 out c vdd vdd p_18 l=0.18u w=1u
mp3 out d vdd vdd p_18 l=0.18u w=1u
mn0 out  a net1 gnd n_18 l=0.18u w=1u
mn1 net1 b net2 gnd n_18 l=0.18u w=1u
mn2 net2 c net3 gnd n_18 l=0.18u w=1u
mn3 net3 d gnd gnd n_18  l=0.18u w=1u
.ends
xa1 a b c d out vdd gnd nand1
*cload node+ node- value
cload  out   gnd   k

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a    gnd   1.8
vb b    gnd   1.8
vc c    gnd   1.8
vd d    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)
*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 80n *(sweep k 0.02p 0.3p 0.04p)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(d)  val=0.9 rise=2
+                  targ v(out) val=0.9 fall=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end