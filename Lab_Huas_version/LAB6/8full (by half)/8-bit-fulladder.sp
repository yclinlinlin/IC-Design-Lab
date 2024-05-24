8-bit-fulladder
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

.subckt eight-bit-fulladder1 a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0 cin s0 s1 s2 s3 s4 s5 s6 s7 cout vdd gnd
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
xj1 a0 b0 cin s0 c0   vdd gnd fulladder1
xj2 a1 b1 c0  s1 c1   vdd gnd fulladder1
xj3 a2 b2 c1  s2 c2   vdd gnd fulladder1
xj4 a3 b3 c2  s3 c3   vdd gnd fulladder1
xj5 a4 b4 c3  s4 c4   vdd gnd fulladder1
xj6 a5 b5 c4  s5 c5   vdd gnd fulladder1
xj7 a6 b6 c5  s6 c6   vdd gnd fulladder1
xj8 a7 b7 c6  s7 cout vdd gnd fulladder1
.ends      
xk1 a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0 cin s0 s1 s2 s3 s4 s5 s6 s7 cout vdd gnd eight-bit-fulladder1 

*cload node+ node- value
cload0   s0   gnd   0.01p
cload1   s1   gnd   0.01p
cload2   s2   gnd   0.01p
cload3   s3   gnd   0.01p
cload4   s4   gnd   0.01p
cload5   s5   gnd   0.01p
cload6   s6   gnd   0.01p
cload7   s7   gnd   0.01p
cload8   cout   gnd   0.01p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
vcin cin    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  19.9n 40n)
vb0 b0    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)
vb1 b1    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)
vb2 b2    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)
vb3 b3    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)
vb4 b4    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)
vb5 b5    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)
vb6 b6    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)
vb7 b7    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)
va0 a0    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  79.9n 160n)
va1 a1    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  79.9n 160n)
va2 a2    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  79.9n 160n)
va3 a3    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  79.9n 160n)
va4 a4    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  79.9n 160n)
va5 a5    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  79.9n 160n)
va6 a6    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  79.9n 160n)
va7 a7    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  79.9n 160n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 160n *(sweep k 0.3u 5u 0.1u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(a)  val=0.9 rise=4
+                  targ v(out) val=0.9 fall=2

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end