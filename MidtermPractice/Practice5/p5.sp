pratice5 from Lab6-1 1-bit Full Adder (loading c=1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd  0  1.8 *宣告一個直流電壓源
vgnd gnd  0  0

.subckt  inv  in  out vdd gnd wp=4.5u wn=2.25u
mp		out		in		vdd		vdd		P_18		l=0.18u	w=wp
mn		out		in		gnd		gnd		N_18		l=0.18u	w=wn
.ends

*Full Adder
.subckt  fulladder  a b cin clk cout sum  vdd gnd 

mp0    netc0     clk    vdd    vdd    P_18      l=0.18u    w=1.5u
*       D        G      S
mn0		netc0		cin		net2	0		N_18		l=0.18u  	w=3u
mn1		net2		a		net4	0		N_18		l=0.18u  	w=3u
mn2		net2		b		net4	0		N_18		l=0.18u  	w=3u
mn3		netc0		a		net3	0		N_18		l=0.18u  	w=3u
mn4		net3		b		net4	0		N_18		l=0.18u  	w=3u

mn5    net4     clk     0     gnd     N_18       l=0.18u   w=3u
*cout 
xinvc1 netc0 cout vdd gnd inv  


*sum為關鍵路徑，尺寸要較大
mp00		n3	   clk	    vdd	  vdd		P_18		l=0.18u 	w=4u


mn11		n3		netc0	n4	    0		N_18		l=0.18u  	w=3u
mn22		n4		a		n7     0		N_18		l=0.18u  	w=3u
mn33		n4		b		n7	    0		N_18		l=0.18u  	w=3u
mn44		n4		cin		n7	    0		N_18		l=0.18u  	w=3u
mn55		n3		cin		n5	    0		N_18		l=0.18u  	w=3u
mn66		n5		a		n6	    0		N_18		l=0.18u  	w=3u
mn77		n6		b		n7		 0		N_18		l=0.18u  	w=3u

mn88       n7     clk     0     gnd     N_18       l=0.18u   w=4u
*sum
xinvs    n3 sum  vdd gnd inv
.ends

xadder a b cin clk cout  sum vdd gnd fulladder

cload1   cout   gnd   1p
cload2   sum    gnd   1p

*VCLK    CLK  GND    PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
vclk clk 0   pulse(1.8 0   1n 0.5n 0.5n 9.5n   20n)
va   a   gnd pulse(1.8 0   1n 0.5n 0.5n 19.5n  40n)
vb   b   gnd pulse(1.8 0   1n 0.5n 0.5n 39.5n  80n)
vcin cin gnd pulse(1.8 0   1n 0.5n 0.5n 79.5n  160n)



.meas tran delay100  trig v(clk) val=0.9  rise=2
+                   targ v(sum) val=0.9  rise=1

.meas tran delay010  trig v(clk) val=0.9  rise=3
+                   targ v(sum) val=0.9  rise=2

.meas tran delay001  trig v(clk) val=0.9  rise=5
+                   targ v(sum) val=0.9  rise=3

.meas tran delay111  trig v(clk) val=0.9  rise=8
+                   targ v(sum) val=0.9  rise=4


.meas tran delayC110  trig v(clk) val=0.9  rise=4
+                     targ v(cout) val=0.9  rise=1

.meas tran delayC101  trig v(clk) val=0.9  rise=6
+                     targ v(cout) val=0.9  rise=2

.meas tran delayC011  trig v(clk) val=0.9  rise=7
+                     targ v(cout) val=0.9  rise=3

.meas tran delayC111  trig v(clk) val=0.9  rise=8
+                     targ v(cout) val=0.9  rise=4


.meas tran pw avg power

.tran 0.1n 160n

.end
