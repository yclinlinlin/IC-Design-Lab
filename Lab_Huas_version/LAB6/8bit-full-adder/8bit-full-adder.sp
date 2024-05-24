8bit-full-adder
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
x1 a b cin sum0 c1   vdd gnd full_adder
x2 a b c1  sum1 c2   vdd gnd full_adder
x3 a b c2  sum2 c3   vdd gnd full_adder
x4 a b c3  sum3 c4   vdd gnd full_adder
x5 a b c4  sum4 c5   vdd gnd full_adder
x6 a b c5  sum5 c6   vdd gnd full_adder
x7 a b c6  sum6 c7   vdd gnd full_adder
x8 a b c7  sum7 cout vdd gnd full_adder

cload0   sum0   gnd   0.01p
cload1   sum1   gnd   0.01p
cload2   sum2   gnd   0.01p
cload3   sum3   gnd   0.01p
cload4   sum4   gnd   0.01p
cload5   sum5   gnd   0.01p
cload6   sum6   gnd   0.01p
cload7   sum7   gnd   0.01p
cload8   cout   gnd   0.01p

vc cin gnd pulse(1.8 0 1n 0.1n 0.1n 19.9n 40n)
vb b gnd pulse(1.8 0 1n 0.1n 0.1n 39.9n 80n)
va a gnd pulse(1.8 0 1n 0.1n 0.1n 79.9n 160n)
.tran 0.05n 200n
*delay analysis val=half of vdd





*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
*.meas tran pdp=param('pw*delayN1')



.end