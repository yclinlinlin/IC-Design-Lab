test A*B+C*(B*D+A*E)(loading c=0.1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd wp=1.5u wn=1u 
mp0  out  in  vdd  vdd  P_18  l=0.18u  w=wp 
mn0  out  in  gnd  gnd  N_18  l=0.18u  w=wn 
.ends

.subckt xor a b  clk out vdd gnd
xinva a aout vdd gnd inv wp=3u
xinvb b bout vdd gnd inv wp=3u

mp1 out  clk   vdd    vdd p_18 l=0.18u w=0.83u

mn1 out  aout n1   gnd n_18 l=0.18u w=6u
mn2 n1   bout n2   gnd n_18 l=0.18u w=6u
mn3 out  a    n3   gnd n_18 l=0.18u w=6u
mn4 n3   b    n2   gnd n_18 l=0.18u w=6u
mn5 n2   clk  0    gnd n_18 l=0.18u w=6u
.ends

.subckt  and  a b  out vdd gnd wn1=5u wn2=5u
xinvb b bout vdd gnd inv 

mn0		out		bout	gnd	0	N_18	l=0.18u   w=wn1
mn1		out	    b	    a	0	N_18	l=0.18u   w=wn2 
.ends

.subckt  or  a b  out  vdd gnd
xinvb b bout vdd gnd inv 

*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mn0		out		  bout    a   	0		N_18		l=0.18u  	w=5u 
mn1		out		   b	  vdd	0		N_18		l=0.18u  	w=5u 
.ends

.subckt  nand  a b clk out vdd gnd m1=1
mp0		out		clk		vdd		vdd		P_18		l=0.18u   w=0.5u m=m1

mn0		out		a	net1		0		N_18		l=0.18u   w=2u m=m1
mn1		net1	b	net2		0		N_18		l=0.18u   w=2u m=m1

mn2		net2	clk		0		0		N_18		l=0.18u   w=2u m=m1
.ends

.subckt  nor  a b clk out  vdd gnd
*定義了一個名為nor的子電路
*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mp0		out		clk		vdd		vdd		P_18		l=0.18u   w=0.5u

mn0		out		a		n1   	0		N_18		l=0.18u  	w=2u 
mn1		out		b		n1		0		N_18		l=0.18u  	w=2u 
 
mn2		n1	   clk		0		0		N_18		l=0.18u   w=2u 
.ends

*A*B+C+B*D*E
.subckt logic1 a b c d e out vdd gnd
xAB  a  b  n1 vdd gnd and
xBD  b  d  n2 vdd gnd and

xABC n1 c  n3 vdd gnd or
xBDE n2 e  n4 vdd gnd and

xABCBDE n3 n4  out  vdd gnd or

.ends

*A*B+C+B*D+E
.subckt logic2 a b c d e clk out vdd gnd
xAB  a b clk n1 vdd gnd nand
x1   n1 n1out vdd gnd inv

xBD  b d clk n2 vdd gnd nand
x2   n2 n2out vdd gnd inv

xABC n1out c clk n3  vdd gnd nor
x3   n3 n3out vdd gnd inv

xBDE n2out e clk n4  vdd gnd nor
x4   n4 n4out vdd gnd inv

xABCBDE n3out n4out  clk out1  vdd gnd nor
x5   out1 out vdd gnd inv
.ends

xl1 a b c d e out1 vdd gnd logic1
xl2 a b c d e clk out2 vdd gnd logic2 
xall  out2 out1  clk outt1 vdd gnd xor


xbuffer1  outt1      outt2   vdd gnd inv *wp=10u
xbuffer2  outt2      out  vdd gnd inv *wp=10u
*xbuffer3  outt3      outt4   vdd gnd inv *wp=10u
*xbuffer4  outt4      out   vdd gnd inv *wp=10u
*xbuffer5  out5      out6   vdd gnd inv *wp=10u
*xbuffer6  out6      out    vdd gnd inv *wp=10u

cload  out  gnd   0.2p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*VCLK  CLK  GND   PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
vclk  clk   gnd   pulse(1.8 0  0.01n   0.1n  0.1n 0.4n 1n)
vine   e    gnd   pulse(1.8 0  0.01n   0.1n  0.1n 31.9n  64n)
vind   d    gnd   pulse(1.8 0  0.01n   0.1n  0.1n 15.9n  32n)
vinc   c    gnd   pulse(1.8 0  0.01n   0.1n  0.1n 7.9n  16n)
vinb   b    gnd   pulse(1.8 0  0.01n   0.1n  0.1n 3.9n  8n)
vina   a    gnd   pulse(1.8 0  0.01n   0.1n  0.1n 1.9n  4n)


.meas tran delay000 trig v(clk)   val=0.9 fall=1
+                   targ v(out) val=0.9 fall=1

.meas tran delay110 trig v(clk)   val=0.9 rise=2
+                   targ v(out) val=0.9 rise=1

.meas tran delay001 trig v(clk)   val=0.9 fall=3
+                   targ v(out) val=0.9 fall=2

.meas tran delay111 trig v(clk)   val=0.9 rise=4
+                   targ v(out) val=0.9 rise=2



.meas tran pw avg power

.tran 0.1n 64n
.end
