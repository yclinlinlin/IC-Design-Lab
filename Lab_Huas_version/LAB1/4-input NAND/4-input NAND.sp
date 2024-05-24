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
mp0 out a vdd vdd p_18 l=0.18u w='0.5*k'
mp1 out b vdd vdd p_18 l=0.18u w='0.5*k'
mp2 out c vdd vdd p_18 l=0.18u w='0.5*k'
mp3 out d vdd vdd p_18 l=0.18u w='0.5*k'
mn0 out a net1 gnd n_18 l=0.18u  w=k
mn1 net1 b net2 gnd n_18 l=0.18u w=k
mn2 net2 c net3 gnd n_18 l=0.18u w=k
mn3 net3 d gnd gnd n_18 l=0.18u  w=k
.ends
xa1 a b c d out vdd gnd nand1
*cload node+ node- value
cload  out   gnd   0.01p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n  10n)
vb b    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n  20n)
vc c    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  19.9n 40n)
vd d    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)
*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 160n (sweep k 0.6u 10u 0.2u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(a)  val=0.9 rise=16
+                  targ v(out) val=0.9 fall=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end