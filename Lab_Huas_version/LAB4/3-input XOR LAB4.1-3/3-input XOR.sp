3-input XOR
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

*	drain gate source body mos_type L 
.subckt xor1 a b c out vdd gnd
.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=2u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=1u
.ends
xa1 a aout vdd gnd inv1
xb1 b bout vdd gnd inv1
xc1 c cout vdd gnd inv1

mp1  out    c      net1    vdd  p_18  l=0.18u w=2u
mp2  net1   b      net2    vdd  p_18  l=0.18u w=2u
mp3  net2   aout   vdd     vdd  p_18  l=0.18u w=2u
mp4  out    c      net3    vdd  p_18  l=0.18u w=2u
mp5  net3   bout   net4    vdd  p_18  l=0.18u w=2u
mp6  net4   a      vdd     vdd  p_18  l=0.18u w=2u
mp7  out    cout   net5    vdd  p_18  l=0.18u w=2u
mp8  net5   b      net6    vdd  p_18  l=0.18u w=2u
mp9  net6   a      vdd     vdd  p_18  l=0.18u w=2u
mp10 out    cout   net7    vdd  p_18  l=0.18u w=2u
mp11 net7   bout   net8    vdd  p_18  l=0.18u w=2u
mp12 net8   aout   vdd     vdd  p_18  l=0.18u w=2u

mn1  out    aout   net9    gnd  n_18  l=0.18u w=1u
mn2  net9   b      net10   gnd  n_18  l=0.18u w=1u
mn3  net10  c      gnd     gnd  n_18  l=0.18u w=1u
mn4  out    a      net11   gnd  n_18  l=0.18u w=1u
mn5  net11  bout   net12   gnd  n_18  l=0.18u w=1u
mn6  net12  c      gnd     gnd  n_18  l=0.18u w=1u
mn7  out    a      net13   gnd  n_18  l=0.18u w=1u
mn8  net13  b      net14   gnd  n_18  l=0.18u w=1u
mn9  net14  cout   gnd     gnd  n_18  l=0.18u w=1u
mn10 out    aout   net15   gnd  n_18  l=0.18u w=1u
mn11 net15  bout   net16   gnd  n_18  l=0.18u w=1u
mn12 net16  cout   gnd     gnd  n_18  l=0.18u w=1u

.ends
xa1 a b c out vdd gnd xor1
*cload node+ node- value
cload  out   gnd   0.05p

*V	node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a 0 pulse(1.8 0 0.1n 0.1n 0.1n 2.4n  5n)
vb b 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n  10n)
vc c 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)

*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 640n *(sweep k 0.05p 0.5p 0.05p)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(a)  val=0.9 rise=4
+                  targ v(out) val=0.9 rise=3

*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end