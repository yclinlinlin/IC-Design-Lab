pratice4 (loading c=1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd  0  1.8
vgnd gnd  0  0

.subckt  FA   a b ci co s
mp0 out1 0 vdd vdd  p_18 l=0.18u w=1.5u

mn0 out1 ci netn0  0   n_18 l=0.18u w=6u
mn1 netn0 a 0  0   n_18 l=0.18u w=6u
mn2 netn0 b 0  0   n_18 l=0.18u w=6u
mn3 out1 a netn1  0   n_18 l=0.18u w=6u
mn4 netn1 b 0  0   n_18 l=0.18u w=6u

mpi0 co out1 vdd vdd  p_18 l=0.18u w=4.5u
mni0 co out1 0  0   n_18 l=0.18u w=2.25u

mp5 netp0 0 vdd vdd p_18 l=0.5u w=0.5u
mp6 out2 out1 netp0 vdd p_18 l=0.18u w=0.5u
mp7 out2 0 vdd vdd p_18 l=0.18u w=2u

mn5 out2 out1 netn2  0   n_18 l=0.18u w=10u
mn6 netn2 a 0  0   n_18 l=0.18u w=10u
mn7 netn2 b 0  0   n_18 l=0.18u w=10u
mn8 netn2 ci 0  0   n_18 l=0.18u w=10u
mn9 out2 ci netn3  0   n_18 l=0.18u w=6u
mn10 netn3 a netn4  0   n_18 l=0.18u w=6u
mn11 netn4 b 0  0   n_18 l=0.18u w=6u

mpi1 s out2 vdd vdd  p_18 l=0.18u w=4u
mni1 s out2 0  0   n_18 l=0.18u w=2u
.ends

x0 a b ci co s FA


va a 0 pulse(1.8 0 1n  0.5n  0.5n  19.5n 40n)
vb b 0 pulse(1.8 0 1n  0.5n  0.5n  39.5n 80n)
vci ci 0 pulse(1.8 0  1n  0.5n  0.5n  79.5n 160n)

cload0 co gnd 1p
cload1 s gnd 1p

.meas tran delayN0  trig v(a) val=0.9  fall=1
+       targ v(s) val=0.9  fall=1

.meas tran delayN1  trig v(a) val=0.9  rise=1
+       targ v(s) val=0.9  rise=1

.meas tran delayN2  trig v(a) val=0.9  rise=2
+       targ v(s) val=0.9  fall=2

.meas tran delayN3  trig v(a) val=0.9  fall=3
+       targ v(s) val=0.9  rise=2

.meas tran delayN4  trig v(a) val=0.9  rise=3
+       targ v(s) val=0.9  fall=3

.meas tran delayN5  trig v(a) val=0.9  rise=4
+       targ v(s) val=0.9  rise=3


.meas tran delayC0  trig v(a) val=0.9  fall=1
+       targ v(co) val=0.9  fall=1

.meas tran delayC1  trig v(a) val=0.9  rise=2
+       targ v(co) val=0.9  rise=1

.meas tran delayC2  trig v(a) val=0.9  fall=3
+       targ v(co) val=0.9  fall=2

.meas tran delayC3  trig v(a) val=0.9  rise=3
+       targ v(co) val=0.9  rise=2

.meas tran pw avg power

.meas tran pdp0=param('pw*delayN0')

.tran 0.05n 200n  *(sweep k 0.05p 1p 0.05p)
.end
