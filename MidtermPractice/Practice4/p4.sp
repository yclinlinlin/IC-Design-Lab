pratice4 from lab3/Lab6-1 1-bit Full Adder (loading c=1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd


.subckt  inv  in  out vdd gnd wp=4.95u wn=2.25u ml=1
mp		out		in		vdd		vdd		P_18		l=0.18u	w=wp m=ml
mn		out		in		gnd		gnd		N_18		l=0.18u	w=wn m=ml
.ends

*Full Adder
.subckt  fulladder  a b cin cout sum  vdd gnd 

mp0		netc0		0		vdd		vdd		P_18		l=0.18u 	w=2.04u
*       D        G      S
mn0		netc0		cin		net2	0		N_18		l=0.18u  	w=5u
mn1		net2		a		0		0		N_18		l=0.18u  	w=5u
mn2		net2		b		0		0		N_18		l=0.18u  	w=5u
mn3		netc0		a		net3	0		N_18		l=0.18u  	w=5u
mn4		net3		b		0		0		N_18		l=0.18u  	w=5u
*cout 
xinvc netc0 cout vdd gnd inv  

*sum為關鍵路徑，尺寸要較大
mp11		n3		0	  vdd	  vdd		P_18		l=0.18u 	w=1.05u

mn11		n3		netc0	n4	    0		N_18		l=0.18u  	w=15.5u
mn22		n4		a		0	    0		N_18		l=0.18u  	w=15.5u
mn33		n4		b		0		0		N_18		l=0.18u  	w=11u
mn44		n4		cin		0	    0		N_18		l=0.18u  	w=11u
mn55		n3		cin		n5	    0		N_18		l=0.18u  	w=9u
mn66		n5		a		n6	    0		N_18		l=0.18u  	w=9u
mn77		n6		b		0		0		N_18		l=0.18u  	w=9u
*sum
xinvs n3 sum  vdd gnd inv wp=4.2u wn=4u
.ends

xadder a b cin cout1 sum vdd gnd fulladder
*x1 sum1 sum2 vdd gnd inv
*x2 sum2 sum  vdd gnd inv

x3 cout1 cout2 vdd gnd inv wp=4.5u wn=2.05u
x4 cout2 cout  vdd gnd inv wp=4.5u wn=2.05u

cload1   cout   gnd   1p
cload2   sum    gnd   1p

vvdd vdd  0  1.8 *宣告一個直流電壓源
vgnd gnd  0  0

*VCLK    CLK  GND    PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
va   a   gnd pulse(1.8 0 1n 0.5n 0.5n 39.5n 80n)
vb   b   gnd pulse(1.8 0 1n 0.5n 0.5n 79.5n 160n)
vcin cin gnd pulse(1.8 0 1n 0.5n 0.5n 159.5n 320n)


.meas tran delay000  trig v(a)   val=0.9  fall=1
+                    targ v(sum) val=0.9  fall=1

.meas tran delay100  trig v(a)   val=0.9  rise=1
+                    targ v(sum) val=0.9  rise=1

.meas tran delay110  trig v(a)   val=0.9  rise=2
+                    targ v(sum) val=0.9  fall=2

.meas tran delay001  trig v(a)   val=0.9  fall=3
+                    targ v(sum) val=0.9  rise=2

.meas tran delay101  trig v(a)   val=0.9  rise=3
+                    targ v(sum) val=0.9  fall=3

.meas tran delay111  trig v(a)   val=0.9  rise=4
+                    targ v(sum) val=0.9  rise=3

.meas tran delayC000  trig v(a)    val=0.9  fall=1
+                     targ v(cout) val=0.9  fall=1

.meas tran delayC110  trig v(a)    val=0.9  rise=2
+                     targ v(cout) val=0.9  rise=1

.meas tran delayC001  trig v(a)    val=0.9  fall=3
+                     targ v(cout) val=0.9  fall=2

.meas tran delayC101  trig v(a)    val=0.9  rise=3
+                     targ v(cout) val=0.9  rise=2

.meas tran pw avg power


.tran 0.1n 320n
.end
