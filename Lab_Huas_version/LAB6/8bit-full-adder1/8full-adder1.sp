8bit-full-adder1
.option post=2
.prot
.lib 'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0 0

*MOSFET
.subckt inv1 in out vdd gnd
mp1 out in vdd vdd p_18 l=0.18u w=1u
mn1 out in gnd gnd n_18 l=0.18u w=2u
.ends
*Full Adder
.subckt full_adder a b c sum cout vdd gnd
mp1  o1   a   n1   vdd p_18 l=0.18u w=2u
mp2  n1   b   n2   vdd p_18 l=0.18u w=2u
mp3  n2   a   vdd  vdd p_18 l=0.18u w=2u
mp4  o1   c   n2   vdd p_18 l=0.18u w=2u
mp5  n2   b   vdd  vdd p_18 l=0.18u w=2u
mn1  o1   c   n3   gnd n_18 l=0.18u w=1u
mn2  n3   a   gnd  gnd n_18 l=0.18u w=1u
mn3  n3   b   gnd  gnd n_18 l=0.18u w=1u
mn4  o1   a   n4   gnd n_18 l=0.18u w=1u
mn5  n4   b   gnd  gnd n_18 l=0.18u w=1u
x1 o1 cout vdd gnd inv1

mp6  o2   o1  n5   vdd p_18 l=0.18u w=1u
mp7  n5   c   vdd  vdd p_18 l=0.18u w=1u
mp8  n5   a   vdd  vdd p_18 l=0.18u w=1u
mp9  n5   b   vdd  vdd p_18 l=0.18u w=1u
mp10 o2   c   n6   vdd p_18 l=0.18u w=1u
mp11 n6   b   n7   vdd p_18 l=0.18u w=1u
mp12 n7   a   n5   vdd p_18 l=0.18u w=1u
mn6  o2   o1  n8   gnd n_18 l=0.18u w=2u
mn7  n8   a   gnd  gnd n_18 l=0.18u w=2u
mn8  n8   b   gnd  gnd n_18 l=0.18u w=2u
mn9  n8   c   gnd  gnd n_18 l=0.18u w=2u
mn10 o2   c   n9   gnd n_18 l=0.18u w=2u
mn11 n9   a   n10  gnd n_18 l=0.18u w=2u
mn12 n10  b   gnd  gnd n_18 l=0.18u w=2u

x2 o2 sum vdd gnd inv1
.ends
x1 a b c   sum0 c1   vdd gnd full_adder
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

vc c gnd pulse(1.8 0 1n 0.1n 0.1n 19.9n 40n)
vb b gnd pulse(1.8 0 1n 0.1n 0.1n 39.9n 80n)
va a gnd pulse(1.8 0 1n 0.1n 0.1n 79.9n 160n)
.tran 0.5n 200n
*delay analysis val=half of vdd
.meas tran delayN1 trig v(c)    val=0.9  rise=3
+                  targ v(sum0) val=0.9  fall=3
.meas tran delayN2 trig v(c)    val=0.9  fall=4
+                  targ v(sum1) val=0.9  rise=3
.meas tran delayN3 trig v(c)    val=0.9  fall=4
+                  targ v(sum2) val=0.9  rise=3
.meas tran delayN4 trig v(c)    val=0.9  fall=4
+                  targ v(sum3) val=0.9  rise=3
.meas tran delayN5 trig v(c)    val=0.9  fall=4
+                  targ v(sum4) val=0.9  rise=3
.meas tran delayN6 trig v(c)    val=0.9  fall=4
+                  targ v(sum5) val=0.9  rise=3
.meas tran delayN7 trig v(c)    val=0.9  fall=4
+                  targ v(sum6) val=0.9  rise=3
.meas tran delayN8 trig v(c)    val=0.9  fall=4
+                  targ v(sum7) val=0.9  rise=3
.meas tran delayN9 trig v(c)    val=0.9  fall=3
+                  targ v(cout) val=0.9  fall=2




*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
*.meas tran pdp=param('pw*delayN1')



.end