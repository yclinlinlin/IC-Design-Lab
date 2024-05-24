4-input XOR
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
.subckt xor1 a b c d out vdd gnd

xa1 a aout vdd gnd inv1
xb1 b bout vdd gnd inv1
xc1 c cout vdd gnd inv1
xd1 d dout vdd gnd inv1

mp1  out   dout net1 	vdd p_18  l=0.18u w='2*k'
mp2  net1  cout net2 	vdd p_18  l=0.18u w='2*k'
mp3  net2  bout net3 	vdd p_18  l=0.18u w='2*k'
mp4  net3  a    vdd 	vdd p_18  l=0.18u w='2*k'
mp5  net2  b    net4    vdd p_18  l=0.18u w='2*k'
mp6  net4  aout vdd     vdd p_18  l=0.18u w='2*k'
mp7  net1  c    net5 	vdd p_18  l=0.18u w='2*k'
mp8  net5  bout net6 	vdd p_18  l=0.18u w='2*k'
mp9  net6  aout vdd     vdd p_18  l=0.18u w='2*k'
mp10 net5  b    net7 	vdd p_18  l=0.18u w='2*k'
mp11 net7  a    vdd     vdd p_18  l=0.18u w='2*k'
                                                
mp12 out   d    net8 	vdd p_18  l=0.18u w='2*k'
mp13 net8  cout net9 	vdd p_18  l=0.18u w='2*k'
mp14 net9  bout net10 	vdd p_18  l=0.18u w='2*k'
mp15 net10 aout vdd     vdd p_18  l=0.18u w='2*k'
mp16 net9  b    net11 	vdd p_18  l=0.18u w='2*k'
mp17 net11 a    vdd     vdd p_18  l=0.18u w='2*k'
mp18 net8  c    net12 	vdd p_18  l=0.18u w='2*k'
mp19 net12 bout net13 	vdd p_18  l=0.18u w='2*k'
mp20 net13 a    vdd 	vdd p_18  l=0.18u w='2*k'
mp21 net12 b    net14 	vdd p_18  l=0.18u w='2*k'
mp22 net14 aout vdd     vdd p_18  l=0.18u w='2*k'
                                            
mn1  out   dout net15   gnd  n_18 l=0.18u w=k
mn2  net15 cout net16   gnd  n_18 l=0.18u w=k
mn3  net16 aout net17   gnd  n_18 l=0.18u w=k
mn4  net17 bout gnd     gnd  n_18 l=0.18u w=k
mn5  net16 a    net18   gnd  n_18 l=0.18u w=k
mn6  net18 b    gnd     gnd  n_18 l=0.18u w=k
mn7  net15 c    net19   gnd  n_18 l=0.18u w=k
mn8  net19 a    net20   gnd  n_18 l=0.18u w=k
mn9  net20 bout gnd     gnd  n_18 l=0.18u w=k
mn10 net19 aout net21   gnd  n_18 l=0.18u w=k
mn11 net21 b    gnd     gnd  n_18 l=0.18u w=k
                                            
mn12 out   d    net22   gnd  n_18 l=0.18u w=k
mn13 net22 cout net23   gnd  n_18 l=0.18u w=k
mn14 net23 a    net24   gnd  n_18 l=0.18u w=k
mn15 net24 bout gnd     gnd  n_18 l=0.18u w=k
mn16 net23 aout net25   gnd  n_18 l=0.18u w=k
mn17 net25 b    gnd     gnd  n_18 l=0.18u w=k
mn18 net22 c    net26   gnd  n_18 l=0.18u w=k
mn19 net26 aout net27   gnd  n_18 l=0.18u w=k
mn20 net27 bout gnd     gnd  n_18 l=0.18u w=k
mn21 net26 a    net28   gnd  n_18 l=0.18u w=k
mn22 net28 b    gnd     gnd  n_18 l=0.18u w=k
.ends
xa1 a b c d out vdd gnd xor1
*cload node+ node- value
cload  out   gnd   0.01p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n 10n)
vb b    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)
vc c    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  19.9n 40n)
vd d    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 320n (sweep k 0.3u 5u 0.1u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(a)  val=0.9 fall=2
+                  targ v(out) val=0.9 rise=2


*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end