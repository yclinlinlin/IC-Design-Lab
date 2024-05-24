full-adder1-v-change
.option post=2
.prot
.lib 'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 k
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

mp6  o2   o1  n5   vdd p_18 l=0.18u w=2u
mp7  n5   c   vdd  vdd p_18 l=0.18u w=2u
mp8  n5   a   vdd  vdd p_18 l=0.18u w=2u
mp9  n5   b   vdd  vdd p_18 l=0.18u w=2u
mp10 o2   c   n6   vdd p_18 l=0.18u w=2u
mp11 n6   b   n7   vdd p_18 l=0.18u w=2u
mp12 n7   a   n5   vdd p_18 l=0.18u w=2u
mn6  o2   o1  n8   gnd n_18 l=0.18u w=1u
mn7  n8   a   gnd  gnd n_18 l=0.18u w=1u
mn8  n8   b   gnd  gnd n_18 l=0.18u w=1u
mn9  n8   c   gnd  gnd n_18 l=0.18u w=1u
mn10 o2   c   n9   gnd n_18 l=0.18u w=1u
mn11 n9   a   n10  gnd n_18 l=0.18u w=1u
mn12 n10  b   gnd  gnd n_18 l=0.18u w=1u

x2 o2 sum vdd gnd inv1
.ends
x1 a b c sum cout vdd gnd full_adder


cload  sum   gnd   0.1p
cload1  cout   gnd   0.1p


vc c gnd pulse('k' 0 1n 0.1n 0.1n '20n*(10^((1.8-k)*5))-0.1n' '40n*(10^((1.8-k)*5))')
vb b gnd pulse('k' 0 1n 0.1n 0.1n '40n*(10^((1.8-k)*5))-0.1n' '80n*(10^((1.8-k)*5))')
va a gnd pulse('k' 0 1n 0.1n 0.1n '80n*(10^((1.8-k)*5))-0.1n' '160n*(10^((1.8-k)*5))')

.tran 0.1n 100m   (sweep k 0.6 1.8 0.2)
*delay analysis val=half of vdd
.meas tran delayN1 trig v(c)    val='k*0.5'   rise=2
+                  targ v(sum)  val='k*0.5'   fall=2
.meas tran delayN2 trig v(c)    val='k*0.5'   fall=3
+                  targ v(cout) val='k*0.5'   fall=2




*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end





