full-adder
.option post=2
.prot
.lib 'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0 0

*MOSFET
.subckt inv1 in out vdd gnd
mp1 out in vdd vdd p_18 l=0.18u w=4u
mn1 out in gnd gnd n_18 l=0.18u w=4u
.ends

.subckt nand1 a b out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=1u
mp1 out b vdd vdd p_18 l=0.18u w=1u
mn0 out a net gnd n_18 l=0.18u w=2u
mn1 net b gnd gnd n_18 l=0.18u w=2u
.ends

.subckt xor1 a b out vdd gnd
xa1 a aout vdd gnd inv1
xb1 b bout vdd gnd inv1
mp1 net1 aout vdd vdd p_18 l=0.18u w=2u
mp2 out b net1 vdd p_18 l=0.18u w=2u
mp3 net2 a vdd vdd p_18 l=0.18u w=2u
mp4 out bout net2 vdd p_18 l=0.18u w=2u
mn1 out a net3 gnd n_18 l=0.18u w=1u
mn2 net3 b gnd gnd n_18 l=0.18u w=1u
mn3 out aout net4 gnd n_18 l=0.18u w=1u
mn4 net4 bout gnd gnd n_18 l=0.18u w=1u
.ends

*Full Adder
.subckt full_adder a b c sum cout vdd gnd
xa1 a b c1 vdd  gnd xor1
xn1 a b c2 vdd  gnd nand1
xn2 c1 c net  vdd gnd nand1
xn3 c2 net cout vdd gnd nand1
xa2 c1 c sum  vdd gnd xor1
.ends
x1 a b c sum cout vdd gnd full_adder


cload  sum   gnd   0.01p
cload1  cout   gnd   0.01p

vc c gnd pulse(1.8 0 1n 0.1n 0.1n 19.9n 40n)
vb b gnd pulse(1.8 0 1n 0.1n 0.1n 39.9n 80n)
va a gnd pulse(1.8 0 1n 0.1n 0.1n 79.9n 160n)
.tran 0.05n 200n
*delay analysis val=half of vdd
.meas tran delayN1 trig v(c)  val=0.9   rise=2
+                  targ v(sum) val=0.9  fall=3
.meas tran delayN2 trig v(c)  val=0.9   fall=3
+                  targ v(cout) val=0.9  fall=2




*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
*.meas tran pdp=param('pw*delayN1')



.end