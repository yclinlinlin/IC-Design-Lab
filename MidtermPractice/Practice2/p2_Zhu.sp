3-input pse-xor
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd  0  1.8
vgnd gnd  0  0

.subckt  pse-xor   a  b  c    out
mp00 a- a vdd vdd  p_18 l=0.18u w=4u
mn00 a- a 0  0   n_18 l=0.18u w=2u

mp01 b- b vdd vdd  p_18 l=0.18u w=4u
mn01 b- b 0  0   n_18 l=0.18u w=2u

mp02 c- c vdd vdd  p_18 l=0.18u w=4u
mn02 c- c 0  0   n_18 l=0.18u w=2u

mp0 out  0 vdd  vdd  p_18 l=0.18u  w=3.1u

mn0 out  a- netn0 0  n_18 l=0.18u  w=4.8u
mn1 out  a- netn1 0  n_18 l=0.18u  w=4.8u
mn2 out  a netn2 0  n_18 l=0.18u  w=4.8u
mn3 out  a netn3 0  n_18 l=0.18u  w=4.8u
mn4 netn0  b netn4 0  n_18 l=0.18u  w=4.8u
mn5 netn1  b- netn5 0  n_18 l=0.18u  w=4.8u
mn6 netn2  b netn6 0  n_18 l=0.18u  w=4.8u
mn7 netn3  b- netn7 0  n_18 l=0.18u  w=4.8u
mn8 netn4  c 0 0  n_18 l=0.18u  w=4.8u
mn9 netn5  c- 0 0  n_18 l=0.18u  w=4.8u
mn10 netn6  c- 0 0  n_18 l=0.18u  w=4.8u
mn11 netn7  c 0 0  n_18 l=0.18u  w=4.8u
.ends

.subckt  buf   in   out
mp00 out1 in vdd vdd  p_18 l=0.18u w=4.8u
mn00 out1 in 0  0   n_18 l=0.18u w=1.9u

mp01 out out1 vdd vdd  p_18 l=0.18u w=4.8u
mn01 out out1 0  0   n_18 l=0.18u w=1.9u
.ends

x123 a  b  c   out. pse-xor
x1 out. out  buf

c1 out gnd 1p

va a 0 pulse(1.8 0 0.1n  0.5n  0.5n  19.5n 40n)

vb b 0 pulse(1.8 0 0.1n  0.5n  0.5n  9.5n 20n)

vc c 0 pulse(1.8 0 0.1n  0.5n  0.5n  4.5n 10n)



.meas tran delayN trig v(c) val=0.9  fall=1
+      targ v(out) val=0.9  fall=1

.meas tran delayN1 trig v(c) val=0.9  rise=1
+      targ v(out) val=0.9  rise=1

.meas tran delayN2 trig v(c) val=0.9  rise=2
+      targ v(out) val=0.9  fall=2

.meas tran delayN3 trig v(c) val=0.9  fall=3
+      targ v(out) val=0.9  rise=2

.meas tran delayN4 trig v(c) val=0.9  rise=3
+      targ v(out) val=0.9  fall=3

.meas tran delayN5 trig v(c) val=0.9  rise=4
+      targ v(out) val=0.9  rise=3


.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran 0.1n 80n  *(sweep k 0.05p 1p 0.05p)
.end
