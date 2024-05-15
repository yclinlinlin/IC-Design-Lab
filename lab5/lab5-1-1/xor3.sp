Lab5-1 Dynamic 3-input XOR  (loading c=0.05p~1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out 
mp0  out  in  vdd  vdd  P_18  l=0.18u  w=2u
mn0  out  in  gnd  gnd  N_18  l=0.18u  w=1u
.ends

.subckt  xor a b c clk out 

xinva a aout inv
xinvb b bout inv
xinvc c cout inv

mp0  out clk  vdd   vdd  P_18 l=0.18u  w=2u
*    D   G    S
mn0  out aout n0    gnd  N_18  l=0.18u w=4u
mn1  n0  b    n1    gnd  N_18  l=0.18u w=4u
mn2  n1  c    nnn   gnd  N_18  l=0.18u w=4u

mn3  out a     n2  gnd  N_18  l=0.18u w=4u
mn4  n2  bout  n3  gnd  N_18  l=0.18u w=4u
mn5  n3  c     nnn gnd  N_18  l=0.18u w=4u

mn6  out a     n4   gnd  N_18  l=0.18u w=4u
mn7  n4  b     n5   gnd  N_18  l=0.18u w=4u
mn8  n5  cout  nnn  gnd  N_18  l=0.18u w=4u

mn9  out aout     n6   gnd  N_18  l=0.18u w=4u
mn10 n6  bout     n7   gnd  N_18  l=0.18u w=4u
mn11 n7  cout     nnn  gnd  N_18  l=0.18u w=4u

mn12 nnn clk 0 gnd  N_18  l=0.18u w=4u
.ends

xxor3 a b c clk out xor
c1 out gnd k

vvdd vdd  0  1.8 *宣告一個直流電壓源
vgnd gnd  0  0

va   a   0 pulse(1.8 0 0.1n 0.1n 0.1n 3.9n 8n)
vb   b   0 pulse(1.8 0 0.1n 0.1n 0.1n 7.9n 16n)
vc   c   0 pulse(1.8 0 0.1n 0.1n 0.1n 15.9n 32n)
vclk clk 0 pulse(0 1.8 2.1n 0.1n 0.1n 1.9n 4n)

.meas tran delayf trig v(clk)      val=0.9  rise=1
+                 targ v (out)     val=0.9  fall=1
.meas tran delayr trig v(clk)      val=0.9  fall=1
+                 targ v (out)     val=0.9  rise=1
.meas tran pw avg power

.meas tran pdp1=param('pw*delayf')
.meas tran pdp2=param('pw*delayr')

.tran 0.1n 40n (sweep  k  0.05p  1p   0.05p)
.end
