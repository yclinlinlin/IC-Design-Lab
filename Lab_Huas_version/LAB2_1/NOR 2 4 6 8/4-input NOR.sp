4-input NOR
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

*	drain gate source body mos_type L 
.subckt nor1 a b c d out vdd gnd
mn0 out  a gnd  gnd n_18 l=0.18u w=1u
mn1 out  b gnd  gnd n_18 l=0.18u w=1u
mn2 out  c gnd  gnd n_18 l=0.18u w=1u
mn3 out  d gnd  gnd n_18 l=0.18u w=1u
mp0 out  a net1 vdd p_18 l=0.18u w=1u
mp1 net1 b net2 vdd p_18 l=0.18u w=1u
mp2 net2 c net3 vdd p_18 l=0.18u w=1u
mp3 net3 d vdd  vdd p_18 l=0.18u w=1u
.ends
xa1 a b c d out vdd gnd nor1
*cload node+ node- value
cload  out   gnd   0.05p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a    gnd   0
vb b    gnd   0
vc c    gnd   0
vd d    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)
*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 80n 
*(sweep k 0.5u 2u 0.5u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(d)  val=0.9 rise=2
+                  targ v(out) val=0.9 fall=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end