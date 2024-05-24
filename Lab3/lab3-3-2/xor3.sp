Lab3-3 Pass-transistor 3-input XOR (loading c=0.05p)
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
xinvx x xout inv

mn0  x   bout  a    gnd  N_18  l=0.18u w=1u
mn1  x   b     aout gnd  N_18  l=0.18u w=1u

mn2  out  xout  c    gnd  N_18  l=0.18u w=1u
mn3  out  x     cout gnd  N_18  l=0.18u w=1u

.ends

xxor3 a b c out xor
c1 out gnd 0.05p

vvdd vdd  0  1.8 *宣告一個直流電壓源
vgnd gnd  0  0

*1倍
*va a 0 pulse(1.8  0  0.1n  0.1n  0.1n  39.9n 80n)
*vb b 0 pulse(1.8  0  0.1n  0.1n  0.1n  79.9n 160n)
*vc c 0 pulse(1.8  0  0.1n  0.1n  0.1n  159.9n 320n)

*2倍
*va a 0 pulse(1.8  0  0.1n  0.1n  0.1n  19.9n 40n)
*vb b 0 pulse(1.8  0  0.1n  0.1n  0.1n  39.9n 80n)
*vc c 0 pulse(1.8  0  0.1n  0.1n  0.1n  79.9n 160n)

*4倍
va a 0 pulse(1.8  0  0.1n  0.1n  0.1n  9.9n 20n)
vb b 0 pulse(1.8  0  0.1n  0.1n  0.1n  19.9n 40n)
vc c 0 pulse(1.8  0  0.1n  0.1n  0.1n  39.9n 80n)

*8倍
*va a 0 pulse(1.8  0  0.1n  0.1n  0.1n  4.9n 10n)
*vb b 0 pulse(1.8  0  0.1n  0.1n  0.1n  9.9n 20n)
*vc c 0 pulse(1.8  0  0.1n  0.1n  0.1n  19.9n 40n)

*16倍
*va a 0 pulse(1.8  0  0.1n  0.1n  0.1n  2.4n 5n)
*vb b 0 pulse(1.8  0  0.1n  0.1n  0.1n  4.9n 10n)
*vc c 0 pulse(1.8  0  0.1n  0.1n  0.1n  9.9n 20n)

.meas tran delayN trig v(a)       val=0.9  rise=1
+                 targ v(out)     val=0.9  rise=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran 0.1n 640n
.end
