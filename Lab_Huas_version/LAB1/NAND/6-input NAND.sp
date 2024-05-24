6-input NAND
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

*	drain gate source body mos_type L 
.subckt nand1 a b c d e f out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=1u
mp1 out b vdd vdd p_18 l=0.18u w=1u
mp2 out c vdd vdd p_18 l=0.18u w=1u
mp3 out d vdd vdd p_18 l=0.18u w=1u
mp4 out e vdd vdd p_18 l=0.18u w=1u
mp5 out f vdd vdd p_18 l=0.18u w=1u
mn0 out a net1 gnd n_18 l=0.18u w=3u
mn1 net1 b net2 gnd n_18 l=0.18u w=3u
mn2 net2 c net3 gnd n_18 l=0.18u w=3u
mn3 net3 d net4 gnd n_18 l=0.18u w=3u
mn4 net4 e net5 gnd n_18 l=0.18u w=3u
mn5 net5 f gnd gnd n_18 l=0.18u w=3u
.ends
xa1 a b c d e f out vdd gnd nand1
*cload node+ node- value
cload  out   gnd   0.05p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a    gnd   1.8
vb b    gnd   1.8
vc c    gnd   1.8
vd d    gnd   1.8
ve e    gnd   1.8
vf f    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 80n 
*(sweep k 0.5u 2u 0.5u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(f)  val=0.9 rise=1
+                  targ v(out) val=0.9 fall=1

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end