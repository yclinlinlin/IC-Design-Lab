Pass-transistor 3-input XOR
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0
.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=2u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=1u
.ends
*	drain gate source body mos_type L 
.subckt xor1 a b c out vdd gnd

xa1 a     aout  vdd gnd inv1
xb1 b     bout  vdd gnd inv1
xc1 c     cout  vdd gnd inv1

xn1 n     nout1 vdd gnd inv1
xn2 nout1 nout2 vdd gnd inv1
xn3 nout2 nout  vdd gnd inv1
xn4 out1  out2 vdd gnd inv1
xn5 out2  out  vdd gnd inv1



mn1  n      bout   a       gnd  n_18  l=0.18u w=1u
mn2  n      b      aout    gnd  n_18  l=0.18u w=1u
mn3  out1   nout   c       gnd  n_18  l=0.18u w=1u
mn4  out1   nout2  cout    gnd  n_18  l=0.18u w=1u


.ends
xa1 a b c out vdd gnd xor1
*cload node+ node- value
cload  out   gnd   k

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a 0 pulse(1.8 0 0.1n 0.1n 0.1n 39.9n 80n)
vb b 0 pulse(1.8 0 0.1n 0.1n 0.1n 79.9n 160n)
vc c 0 pulse(1.8 0 0.1n 0.1n 0.1n 159.9n 320n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 640n (sweep k 0.05p 0.5p 0.05p)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(c)  val=0.9 rise=1
+                  targ v(out) val=0.9 rise=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end