full adder
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

.subckt fulladder1 a b  cin sum carry vdd gnd
.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=0.25u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=0.25u
.ends
.subckt halfadder1 a b sum carry vdd gnd


*	drain gate source body mos_type L 
.subckt xor1 a b out vdd gnd

xa1 a aout vdd gnd inv1
xb1 b bout vdd gnd inv1

mp1 net1   aout   vdd     vdd  p_18  l=0.18u w=0.25u
mp2 out    b      net1    vdd  p_18  l=0.18u w=0.25u
mp3 net2   a      vdd     vdd  p_18  l=0.18u w=0.25u
mp4 out    bout   net2    vdd  p_18  l=0.18u w=0.25u
mn1 out    a      net3    gnd  n_18  l=0.18u w=0.25u
mn2 net3   b      gnd     gnd  n_18  l=0.18u w=0.25u
mn3 out    aout   net4    gnd  n_18  l=0.18u w=0.25u
mn4 net4   bout   gnd     gnd  n_18  l=0.18u w=0.25u
.ends

.subckt nand1 a b out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=0.25u
mp1 out b vdd vdd p_18 l=0.18u w=0.25u
mn0 out a net gnd n_18 l=0.18u w=0.25u
mn1 net b gnd gnd n_18 l=0.18u w=0.25u
.ends
xc1 a b sum vdd gnd xor1
xdl a b cout vdd gnd nand1
xe1 cout carry vdd gnd inv1
.ends

xf1 a  b   s1  c1 vdd gnd halfadder1
xg1 s1 cin sum c2 vdd gnd halfadder1

.subckt nor1 a b out vdd gnd
mp0 net a vdd vdd p_18 l=0.18u w=0.25u
mp1 out b net vdd p_18 l=0.18u w=0.25u
mn0 out a gnd gnd n_18 l=0.18u w=0.25u
mn1 out b gnd gnd n_18 l=0.18u w=0.25u
.ends

xh1 c1 c2  cout vdd gnd nor1
xk1 cout carry vdd gnd inv1


.ends
xj1 a b cin sum carry vdd gnd fulladder1

*cload node+ node- value
cload  out   gnd   0.05p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
vcin cin    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n 10n)
vb b    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)
va a    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  19.9n 40n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 80n *(sweep k 0.3u 5u 0.1u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(a)  val=0.9 rise=4
+                  targ v(out) val=0.9 fall=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end