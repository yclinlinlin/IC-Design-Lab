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
mp0 out7   in   vdd    vdd  p_18 	l=0.18u w=0.6u 
mn0 out7   in   gnd    gnd  n_18 	l=0.18u w=0.25u

mp1 out6   out7   vdd    vdd  p_18 	l=0.18u w=1.5516u 
mn1 out6   out7   gnd    gnd  n_18 	l=0.18u w=0.6465u

mp2 out5   out6   vdd    vdd  p_18 	l=0.18u w=4.01244u 
mn2 out5   out6  gnd    gnd  n_18 	l=0.18u w=1.67185u
  
mp3 out4   out5   vdd    vdd  p_18 	l=0.18u w=10.3762u 
mn3 out4   out5   gnd    gnd  n_18 	l=0.18u w=4.32341u
  
mp4 out3   out4   vdd    vdd  p_18 	l=0.18u w=26.8328u 
mn4 out3   out4   gnd    gnd  n_18 	l=0.18u w=11.1803u
  
mp5 out2   out3   vdd    vdd  p_18 	l=0.18u w=69.3897u 
mn5 out2   out3   gnd    gnd  n_18 	l=0.18u w=28.9124u

mp6 out1   out2   vdd    vdd  p_18 	l=0.18u w=59.807u  m=3 
mn6 out1   out2   gnd    gnd  n_18 	l=0.18u w=74.7674u
  
mp7 out	  out1   vdd    vdd  p_18 	l=0.18u w=77.3406u m=6 
mn7 out   out1   gnd    gnd  n_18 	l=0.18u w=64.4496u m=3

*cload node+ node- value
mpc gnd	  out   vdd    vdd  p_18 	l=0.18u w=2.4u m=500 
mnc gnd   out   gnd    gnd  n_18 	l=0.18u w=1u   m=500

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
vin in    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n 10n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 80n 
*(sweep k 0.5u 2u 0.5u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(in)  val=0.9 rise=1
+                  targ v(out) val=0.9 rise=1

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end