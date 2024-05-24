3-input xor static cmos (loading c=0.05p~0.5p)
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

mp0  net1     aout  vdd    vdd  P_18 l=0.18u  w=6u
mp1  net0     b     net1   vdd  P_18 l=0.18u  w=6u
mp2  out      c     net0   vdd  P_18 l=0.18u  w=6u

mp3  net3   a     vdd   vdd  P_18 l=0.18u  w=6u
mp4  net2   bout  net3  vdd  P_18 l=0.18u  w=6u
mp5  out    c     net2  vdd  P_18 l=0.18u  w=6u

mp6  net5  a     vdd  vdd  P_18 l=0.18u  w=6u
mp7  net4  b     net5 vdd  P_18 l=0.18u  w=6u
mp8  out   cout  net4 vdd  P_18 l=0.18u  w=6u

mp9  net7 aout  vdd   vdd  P_18 l=0.18u  w=6u
mp10 net6 bout  net7  vdd  P_18 l=0.18u  w=6u
mp11 out  cout  net6  vdd  P_18 l=0.18u  w=6u

mn0  out aout n0 gnd  N_18  l=0.18u w=3u
mn1  n0  b    n1 gnd  N_18  l=0.18u w=3u
mn2  n1  c    0 gnd  N_18  l=0.18u w=3u

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

.meas tran delayN trig v(a)   val=0.9  rise=1
+      targ v(out)     val=0.9 rise=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 640n (sweep  k  0.05p  0.5p   0.05p)
.end
