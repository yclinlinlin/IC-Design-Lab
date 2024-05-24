2-input NAND
.option post=2 *generate output waveform
.prot 
.lib  'cic018.l' tt *call library
.unprot
.global vdd gnd
*DC source
vvdd vdd 0 1.8
vgnd gnd 0  0

* drain gate source body mos_type L 
.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=1u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=0.5u
.ends
.subckt nand  CK a b out vdd gnd
mp0 out  CK   vdd vdd p_18 l=0.18u w=1u
mn0 out  a    n1  gnd n_18 l=0.18u w=1u
mn1 n1   b    n2  gnd n_18 l=0.18u w=1u
mn2 n2   CK   gnd gnd n_18 l=0.18u w=1u
.ends
.subckt nand1  CK a b out vdd gnd
mp0 out  CK   vdd vdd p_18 l=0.18u w=1u
mp1 out  out_ vdd vdd p_18 l=0.18u w=1u
mn0 out  a    n1  gnd n_18 l=0.18u w=1u
mn1 n1   b    n2  gnd n_18 l=0.18u w=1u
mn2 n2   CK   gnd gnd n_18 l=0.18u w=1u
x1 out out_ vdd gnd inv1
.ends
.ends
xg1  CK a b    out1 vdd gnd nand
xh2  CK c out1 out2 vdd gnd nand1
xj3  CK d out2 out3 vdd gnd nand1
xk4  CK e out3 out4 vdd gnd nand1
*cload node+ node- value
cload   out1   gnd   0.1p
cload1  out2   gnd   0.1p
cload2  out3   gnd   0.1p
cload3  out4   gnd   0.1p

*V node+ node- pulse(V1  V2 T_delay T_rise T_fall pw    period)
va a    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)
vb b    gnd   1.8
vc c    gnd   1.8
vd d    gnd   1.8
ve e    gnd   1.8
vCK CK    gnd   pulse(0 1.8  2.1n   0.1n  0.1n  1.9n 4n)



*transient analysis:Time step is 0.1n ,stop time is 80n
.tran 0.1n 40n 
*(sweep k 0.5u 2u 0.5u)

*delay analysis val=half of vdd
.meas tran delayN1 trig v(CK)  val=0.9   fall=2
+                  targ v(out1) val=0.9  rise=2
.meas tran delayN2 trig v(CK)  val=0.9   fall=2
+                  targ v(out2) val=0.9  rise=2
.meas tran delayN3 trig v(CK)  val=0.9   fall=2
+                  targ v(out3) val=0.9  rise=2
.meas tran delayN4 trig v(CK)  val=0.9   fall=2
+                  targ v(out4) val=0.9  rise=2



*average_power analysis
.meas tran pw avg power

*power-Delay-Product(pdp) analysis
.meas tran pdp=param('pw*delayN1')



.end