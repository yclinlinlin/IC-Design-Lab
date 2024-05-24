Pseudo 3-input XOR
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0
.param frequency=125Meg *125Meg~1000Meg
.param period=1/frequency
.param Tr=0.1n  *rising time
.param Tf=0.1n  *falling time

*	drain gate source body mos_type L 
.subckt xor1 a b c CK out2 vdd gnd
.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=2u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=1u
.ends
xa1 a aout vdd gnd inv1
xb1 b bout vdd gnd inv1
xc1 c cout vdd gnd inv1

mp1  out    CK    vdd    vdd  p_18  l=0.18u w=2u

mn1  out    aout   net9      gnd  n_18  l=0.18u w=1u
mn2  net9   b      net10     gnd  n_18  l=0.18u w=1u
mn3  net10  c      net17     gnd  n_18  l=0.18u w=1u
mn4  out    a      net11     gnd  n_18  l=0.18u w=1u
mn5  net11  bout   net12     gnd  n_18  l=0.18u w=1u
mn6  net12  c      net17     gnd  n_18  l=0.18u w=1u
mn7  out    a      net13     gnd  n_18  l=0.18u w=1u
mn8  net13  b      net14     gnd  n_18  l=0.18u w=1u
mn9  net14  cout   net17     gnd  n_18  l=0.18u w=1u
mn10 out    aout   net15     gnd  n_18  l=0.18u w=1u
mn11 net15  bout   net16     gnd  n_18  l=0.18u w=1u
mn12 net16  cout   net17     gnd  n_18  l=0.18u w=1u
mn13 net17  CK     gnd       gnd  n_18  l=0.18u w=1u
xd1 out out1 vdd gnd inv1
xe1 out1 out2 vdd gnd inv1
.ends
xa1 a b c CK out2 vdd gnd xor1

*cload node+ node- value
cload  out2   gnd   0.1p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
vCK CK 0 pulse(0   1.8 0.1n Tr Tf '0.5*period*0.5-0.5*(Tr+Tf)' 'period*0.5')
va a 0 pulse (1.8  0   0.1n Tr Tf 'period*0.5-0.5*(Tr+Tf)'    period)
vb b 0 pulse (1.8  0   0.1n Tr Tf '2*period*0.5-0.5*(Tr+Tf)' 'period*2')
vc c 0 pulse (1.8  0   0.1n Tr Tf '4*period*0.5-0.5*(Tr+Tf)' 'period*4')

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 40n *(sweep k 0.05p 0.5p 0.05p)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(CK)  val=0.9 fall=4
+                  targ v(out2) val=0.9 rise=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end