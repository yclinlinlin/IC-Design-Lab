Lab6-2-b   8-bit Full Adder (loading c=0.1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd ml=1
mp		out		in		vdd		vdd		P_18		l=0.18u	w=2u m=ml
mn		out		in		gnd		gnd		N_18		l=0.18u	w=1u m=ml
.ends
*Full Adder
.subckt  fulladder  a b cin cout sum  vdd gnd 
*為關鍵路徑，尺寸要較大
mp0		net0		a		  vdd		vdd		P_18		l=0.18u 	  w=6u
mp1		net1		b		  net0	vdd		P_18		l=0.18u	    w=6u
mp2		netc0		a		  net1	vdd		P_18		l=0.18u	    w=6u
mp3		net0		b		  vdd		vdd		P_18		l=0.18u	    w=6u
mp4		netc0		cin		net0	vdd		P_18		l=0.18u	    w=6u

mn0		netc0		cin		net2	0		N_18		l=0.18u  	w=3u
mn1		net2		a		  0		  0		N_18		l=0.18u  	w=3u
mn2		net2		b		  0		  0		N_18		l=0.18u  	w=3u
mn3		netc0		a		  net3	0		N_18		l=0.18u  	w=3u
mn4		net3		b		  0		  0		N_18		l=0.18u  	w=3u
*cout 
xinvc netc0 cout vdd gnd inv m1=3

mp11		n0		cin	  vdd	  vdd		P_18		l=0.18u 	w=2u
mp22		n0		a		  vdd	  vdd		P_18		l=0.18u 	w=2u
mp33		n0		b		  vdd	  vdd		P_18		l=0.18u 	w=2u
mp44		n1		a		  n0	  vdd		P_18		l=0.18u	  w=2u
mp55		n2		b		  n1	  vdd		P_18		l=0.18u	  w=2u
mp66		n3		cin		n2	  vdd		P_18		l=0.18u	  w=2u
mp77		n3		netc0	n0	  vdd		P_18		l=0.18u	  w=2u

mn11		n3		netc0	n4	    0		N_18		l=0.18u  	w=1u
mn22		n4		a		  0	      0		N_18		l=0.18u  	w=1u
mn33		n4		b		  0		    0		N_18		l=0.18u  	w=1u
mn44		n4		cin		0	      0		N_18		l=0.18u  	w=1u
mn55		n3		cin		n5	    0		N_18		l=0.18u  	w=1u
mn66		n5		a		  n6	    0		N_18		l=0.18u  	w=1u
mn77		n6		b		  0		    0		N_18		l=0.18u  	w=1u
*sum
xinvs n3 sum  vdd gnd inv 
.ends
  *a  b  cin cout sum  vdd gnd 
x0 a0 b0 cin c0   sum0 vdd gnd fulladder
x1 a1 b1 c0  c1   sum1 vdd gnd fulladder
x2 a2 b2 c1  c2   sum2 vdd gnd fulladder
x3 a3 b3 c2  c3   sum3 vdd gnd fulladder
x4 a4 b4 c3  c4   sum4 vdd gnd fulladder
x5 a5 b5 c4  c5   sum5 vdd gnd fulladder
x6 a6 b6 c5  c6   sum6 vdd gnd fulladder
x7 a7 b7 c6  c7   sum7 vdd gnd fulladder

cload0   sum0   gnd   0.1p
cload1   sum1   gnd   0.1p
cload2   sum2   gnd   0.1p
cload3   sum3   gnd   0.1p
cload4   sum4   gnd   0.1p
cload5   sum5   gnd   0.1p
cload6   sum6   gnd   0.1p
cload7   sum7   gnd   0.1p
cload8   c7     gnd   0.1p

vvdd vdd  0  k *宣告一個直流電壓源
vgnd gnd  0  0

V0  a0 0 k 
V1  a1 0 k
V2  a2 0 k
V3  a3 0 k
V4  a4 0 k
V5  a5 0 k
V6  a6 0 k
V7  a7 0 k

V8  b0 0 0
V9  b1 0 0
V10 b2 0 0
V11 b3 0 0
V12 b4 0 0
V13 b5 0 0
V14 b6 0 0
V15 b7 0 0
*vdd=0.4v
*Vc cin 0 pulse(0.4  0  1n  0.1n  0.1n  1279.9n 2560n)
Vc cin 0 pulse('k'   0  1n  0.1n  0.1n  '10n*(2^((1.8-k)*5))-0.1n'  '20n*(2^((1.8-k)*5))')

.meas tran delayr  trig v (cin)   val='k*0.5'  rise=2
+                  targ v (c7)    val='k*0.5'  rise=2
.meas tran delayf  trig v (cin)   val='k*0.5'  fall=3
+                  targ v (c7)    val='k*0.5'  fall=3

.meas tran delayr1  trig v (cin)   val='k*0.5'  rise=1
+                   targ v (c7)    val='k*0.5'  rise=1
.meas tran delayf1  trig v (cin)   val='k*0.5'  fall=1
+                   targ v (c7)    val='k*0.5'  fall=1

.meas tran pw avg power
.meas tran pdp1=param('pw*delayr')
.meas tran pdp2=param('pw*delayf')
.tran 0.1n 7680n (sweep k  0.4 1.6 0.2)
.end
