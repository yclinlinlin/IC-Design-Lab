Lab3-2 Pseudo-NMOS 3-input XOR  (loading c=0.05p~0.5p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out 
mp0  out  in  vdd  vdd  P_18  l=0.18u  w=2u
mn0  out  in  gnd  gnd  N_18  l=0.18u  w=1u
.ends

.subckt  xor a b c out 

xinva a aout inv
xinvb b bout inv
xinvc c cout inv

mp0  out 0   vdd    vdd  P_18 l=0.18u  w=0.5u
*    D   G    S
mn0  out aout n0    gnd  N_18  l=0.18u w=3u
mn1  n0  b    n1    gnd  N_18  l=0.18u w=3u
mn2  n1  c    0     gnd  N_18  l=0.18u w=3u

mn3  out a     n2 gnd  N_18  l=0.18u w=3u
mn4  n2  bout  n3 gnd  N_18  l=0.18u w=3u
mn5  n3  c   0     gnd  N_18  l=0.18u w=3u

mn6  out a     n4 gnd  N_18  l=0.18u w=3u
mn7  n4  b     n5 gnd  N_18  l=0.18u w=3u
mn8  n5  cout  0     gnd  N_18  l=0.18u w=3u

mn9  out aout     n6 gnd  N_18  l=0.18u w=3u
mn10 n6  bout     n7 gnd  N_18  l=0.18u w=3u
mn11 n7  cout     0 gnd  N_18  l=0.18u w=3u

.ends

xxor3 a b c out xor
c1 out gnd k

vvdd vdd  0  1.8 *宣告一個直流電壓源
vgnd gnd  0  0

va a 0 pulse(1.8  0  0.1n  0.1n  0.1n  39.9n 80n)
vb b 0 pulse(1.8  0  0.1n  0.1n  0.1n  79.9n 160n)
vc c 0 pulse(1.8  0  0.1n  0.1n  0.1n  159.9n 320n)

.meas tran delayN trig v(c)        val=0.9  rise=1
+                 targ v (out)     val=0.9   rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran 0.1n 640n (sweep  k  0.05p  0.5p   0.05p)
.end
