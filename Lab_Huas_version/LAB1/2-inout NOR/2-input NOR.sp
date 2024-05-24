2-input NOR
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

*	drain gate source body mos_type L 
.subckt nor1 a b out vdd gnd
mp0 net a vdd vdd p_18 l=0.18u w='4*k'
mp1 out b net vdd p_18 l=0.18u w='4*k'
mn0 out a gnd gnd n_18 l=0.18u w=k
mn1 out b gnd gnd n_18 l=0.18u w=k
.ends
xa1 a b out vdd gnd nor1
*cload node+ node- value
cload  out   gnd   0.01p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n 10n)
vb b    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 80n   (sweep k 0.25u 2.5u 0.05u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(a)  val=0.9 rise=3
+                  targ v(out) val=0.9 fall=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end