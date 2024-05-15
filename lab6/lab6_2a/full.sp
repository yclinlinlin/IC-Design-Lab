Lab6-2-a 1-bit Full Adder (loading c=0.1p)
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
mp0		net0		a		vdd		vdd		P_18		l=0.18u 	w=6u
mp1		net1		b		net0	vdd		P_18		l=0.18u	    w=6u
mp2		netc0		a		net1	vdd		P_18		l=0.18u	    w=6u
mp3		net0		b		vdd		vdd		P_18		l=0.18u	    w=6u
mp4		netc0		cin		net0	vdd		P_18		l=0.18u	    w=6u

mn0		netc0		cin		net2	0		N_18		l=0.18u  	w=3u
mn1		net2		a		0		0		N_18		l=0.18u  	w=3u
mn2		net2		b		0		0		N_18		l=0.18u  	w=3u
mn3		netc0		a		net3	0		N_18		l=0.18u  	w=3u
mn4		net3		b		0		0		N_18		l=0.18u  	w=3u
*cout 
xinvc netc0 cout vdd gnd inv  
*sum為關鍵路徑，尺寸要較大
mp11		n0		cin		vdd	  vdd		P_18		l=0.18u 	w=8u
mp22		n0		a		vdd	  vdd		P_18		l=0.18u 	w=8u
mp33		n0		b		vdd	  vdd		P_18		l=0.18u 	w=8u
mp44		n1		a		n0	  vdd		P_18		l=0.18u	    w=8u
mp55		n2		b		n1	  vdd		P_18		l=0.18u	    w=8u
mp66		n3		cin		n2	  vdd		P_18		l=0.18u	    w=8u
mp77		n3		netc0	n0	  vdd		P_18		l=0.18u	    w=8u

mn11		n3		netc0	n4	    0		N_18		l=0.18u  	w=4u
mn22		n4		a		0	    0		N_18		l=0.18u  	w=4u
mn33		n4		b		0		0		N_18		l=0.18u  	w=4u
mn44		n4		cin		0	    0		N_18		l=0.18u  	w=4u
mn55		n3		cin		n5	    0		N_18		l=0.18u  	w=4u
mn66		n5		a		n6	    0		N_18		l=0.18u  	w=4u
mn77		n6		b		0		0		N_18		l=0.18u  	w=4u
*sum
xinvs n3 sum  vdd gnd inv ml=4
.ends

xadder a b cin cout sum vdd gnd fulladder
cload1   cout   gnd   0.1p
cload2   sum    gnd   0.1p

vvdd vdd  0  0.4  *宣告一個直流電壓源
vgnd gnd  0  0
*VDD=1.8V
*va   a   gnd pulse(1.8 0 1n 0.1n 0.1n 79.9n 160n)
*vb   b   gnd pulse(1.8 0 1n 0.1n 0.1n 39.9n 80n)
*vcin cin gnd pulse(1.6 0 1n 0.1n 0.1n 19.9n 40n)
*VDD=1.6V
*va   a   gnd pulse(1.6 0 1n 0.1n 0.1n 159.9n 320n)
*vb   b   gnd pulse(1.6 0 1n 0.1n 0.1n 79.9n 160n)
*vcin cin gnd pulse(1.6 0 1n 0.1n 0.1n 39.9n 80n)
*VDD=0.4V
va   a   gnd pulse(0.4 0 1n 0.1n 0.1n 10239.9n 20480n)
vb   b   gnd pulse(0.4 0 1n 0.1n 0.1n 5119.9n 10240n)
vcin cin gnd pulse(0.4 0 1n 0.1n 0.1n 2559.9n 5120n)

*使用sweep
*va  a   gnd pulse('k' 0  1n  0.1n  0.1n '80n*(2^((1.8-k)*5))-0.1n' '160n*(2^((1.8-k)*5))')
*vb  b   gnd pulse('k' 0  1n  0.1n  0.1n '40n*(2^((1.8-k)*5))-0.1n' '80n*(2^((1.8-k)*5))')
*vc  cin gnd pulse('k' 0  1n  0.1n  0.1n '20n*(2^((1.8-k)*5))-0.1n' '40n*(2^((1.8-k)*5))')

.meas tran delayN2  trig v (cin)   val=0.2  fall=3
+                   targ v (sum)   val=0.2  rise=2

*.meas tran delayN1  trig v (cin)   val='k*0.5'  rise=2
*+                   targ v (sum)   val='k*0.5'  fall=2
*.meas tran delayN2  trig v (cin)   val='k*0.5'  fall=3
*+                   targ v (sum)   val='k*0.5'  rise=2
*.meas tran delayN3  trig v (cin)   val='k*0.5'  rise=3
*+                   targ v (sum)   val='k*0.5'  fall=3

.meas tran pw avg power

.meas tran pdp2=param('pw*delayN2')

.tran 0.1n 20480n *(sweep k  0.4 1.6 0.2)
.end
