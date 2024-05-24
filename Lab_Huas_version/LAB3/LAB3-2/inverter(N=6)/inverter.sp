inverter
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

*	drain gate source body mos_type L 
mp0 out5   in   vdd    vdd  p_18 	l=0.18u w=0.6u 
mn0 out5   in   gnd    gnd  n_18 	l=0.18u w=0.25u

mp1 out4   out5   vdd    vdd  p_18 	l=0.18u w=2.12972u 
mn1 out4   out5   gnd    gnd  n_18 	l=0.18u w=0.88738u

mp2 out3   out4   vdd    vdd  p_18 	l=0.18u w=7.55953u 
mn2 out3   out4   gnd    gnd  n_18 	l=0.18u w=3.1498u

mp3 out2   out3   vdd    vdd  p_18 	l=0.18u w=26.8328u 
mn3 out2   out3   gnd    gnd  n_18 	l=0.18u w=11.1803u

mp4 out1   out2   vdd    vdd  p_18 	l=0.18u w=47.62055u m=2 
mn4 out1   out2   gnd    gnd  n_18 	l=0.18u w=39.685u

mp5 out	  out1   vdd    vdd  p_18 	l=0.18u w=85.518u   m=4 
mn5 out   out1   gnd    gnd  n_18 	l=0.18u w=70.4315u  m=2

*cload node+ node- value
mpc gnd	  out   vdd    vdd  p_18 	l=0.18u w=2.4u m=500 
mnc gnd   out   gnd    gnd  n_18 	l=0.18u w=1u   m=500

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
vin in    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n 10n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 80n 
*(sweep k 0.5u 2u 0.5u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(in)  val=0.9 rise=2
+                  targ v(out) val=0.9 rise=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end