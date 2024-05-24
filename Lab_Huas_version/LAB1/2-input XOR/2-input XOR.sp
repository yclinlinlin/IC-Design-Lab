2-input XOR
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w='2*k'
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=k
.ends

*	drain gate source body mos_type L 
.subckt xor1 a b out vdd gnd

xa1 a aout vdd gnd inv1
xb1 b bout vdd gnd inv1

mp1 net1   aout   vdd     vdd  p_18  l=0.18u w='2*k'
mp2 out    b      net1    vdd  p_18  l=0.18u w='2*k'
mp3 net2   a      vdd     vdd  p_18  l=0.18u w='2*k'
mp4 out    bout   net2    vdd  p_18  l=0.18u w='2*k'
mn1 out    a      net3    gnd  n_18  l=0.18u w=k
mn2 net3   b      gnd     gnd  n_18  l=0.18u w=k
mn3 out    aout   net4    gnd  n_18  l=0.18u w=k
mn4 net4   bout   gnd     gnd  n_18  l=0.18u w=k
.ends
xa1 a b out vdd gnd xor1
*cload node+ node- value
cload  out   gnd   0.01p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n 10n)
vb b    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 80n (sweep k 0.3u 5u 0.1u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(a)  val=0.9 rise=4
+                  targ v(out) val=0.9 fall=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end