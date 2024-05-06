pratice5 from Lab6-1 1-bit Full Adder (loading c=1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd  0  1.8 *宣告一個直流電壓源
vgnd gnd  0  0

.subckt  inv  in  out vdd gnd ml=1
mp		out		in		vdd		vdd		P_18		l=0.18u	w=6u m=ml
mn		out		in		gnd		gnd		N_18		l=0.18u	w=1u m=ml
.ends
*Full Adder
.subckt  fulladder  a b cin cout sum  vdd gnd 

mp0    netc0     clk    vdd    vdd    P_18      l=0.18u    w=4.6u
*       D        G      S
mn0		netc0		cin		net2	0		N_18		l=0.18u  	w=3u
mn1		net2		a		net4	0		N_18		l=0.18u  	w=3u
mn2		net2		b		net4	0		N_18		l=0.18u  	w=3u
mn3		netc0		a		net3	0		N_18		l=0.18u  	w=3u
mn4		net3		b		net4	0		N_18		l=0.18u  	w=3u

mn5    net4     clk     0     gnd     N_18       l=0.18u   w=3u
*cout 
xinvc1 netc0 cout1 vdd gnd inv  
xinvc2 cout1 cout2 vdd gnd inv 
xinvc3 cout2 cout  vdd gnd inv 
*sum為關鍵路徑，尺寸要較大


mp00		netc0	clk	    vdd	  vdd		P_18		l=0.18u 	w=3u


mn11		n3		netc0	n4	    0		N_18		l=0.18u  	w=3u
mn22		n4		a		n7     0		N_18		l=0.18u  	w=3u
mn33		n4		b		n7	    0		N_18		l=0.18u  	w=3u
mn44		n4		cin		n7	    0		N_18		l=0.18u  	w=3u
mn55		n3		cin		n5	    0		N_18		l=0.18u  	w=3u
mn66		n5		a		n6	    0		N_18		l=0.18u  	w=3u
mn77		n6		b		n7		 0		N_18		l=0.18u  	w=3u

mn88       n7     clk     0     gnd     N_18       l=0.18u   w=3u
*sum
xinvs    n3 sum  vdd gnd inv ml=4
.ends

xadder a b cin cout sum vdd gnd fulladder

cload1   cout   gnd   1p
cload2   sum    gnd   1p

*VCLK    CLK  GND    PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
va   a   gnd pulse(1.8 0  1n 0.5n 0.5n 19.9n 40n)
vb   b   gnd pulse(1.8 0  1n 0.5n 0.5n 39.9n  80n)
vcin cin gnd pulse(1.8 0  1n 0.5n 0.5n 79.9n  160n)
vclk clk 0   pulse(0  1.8 1n 0.5n 0.5n 9.9n  20n)

.meas tran delayN1  trig v (clk)   val=0.9  rise=2
+                   targ v (sum)   val=0.9  fall=2
.meas tran delayN2  trig v (clk)   val=0.9  fall=3
+                   targ v (sum)   val=0.9  rise=2
.meas tran delayN3  trig v (clk)   val=0.9  rise=3
+                   targ v (sum)   val=0.9  fall=3

.meas tran pw avg power


.tran 0.1n 320n
.end
