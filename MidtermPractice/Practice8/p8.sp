pratice8  dynamic from lab7-1 (loading c=0.5p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd  wp=2u wn=1.2u
mp		out		in		vdd		vdd		P_18		l=0.18u	w=wp
mn		out		in		gnd		gnd		N_18		l=0.18u	w=wn
.ends

.subckt  nand  a b clk out vdd gnd m1=1
mp0		out		clk		vdd		vdd		P_18		l=0.18u   w=4u m=m1

mn0		out		a	net1		0		N_18		l=0.18u   w=2u m=m1
mn1		net1	b	net2		0		N_18		l=0.18u   w=2u m=m1

mn2		net2	clk		0		0		N_18		l=0.18u   w=4u m=m1
.ends

.subckt  nor  a b clk out  vdd gnd
*定義了一個名為nor的子電路
*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mp0		out		clk		vdd		vdd		P_18		l=0.18u   w=4u

mn0		out		a		n1   	0		N_18		l=0.18u  	w=2u 
mn1		out		b		n1		0		N_18		l=0.18u  	w=2u 
 
mn2		n1	   clk		0		0		N_18		l=0.18u   w=4u 
.ends

.subckt comp a b clk gt lt eq vdd gnd 
xinva a    inva vdd gnd inv 
xinvb b    invb vdd gnd inv 

xnanda b   inva  clk out1 vdd gnd nand 
xinv1  out1       lt   vdd gnd inv

xnandb a    invb clk out2 vdd gnd nand 
xinv2 out2       gt   vdd gnd inv

xnor  lt gt clk eq vdd gnd nor 

.ends

xcomp a b clk gt1 lt1 eq1 vdd gnd  comp
xe1  eq1       eq2   vdd gnd inv *wp=6.5u
xe2  eq2       eq3    vdd gnd inv *wp=6.5u
xe3  eq3       eq4   vdd gnd inv *wp=6.5u
xe4  eq4       eq5    vdd gnd inv *wp=6.5u
xe5  eq5       eq6   vdd gnd inv *wp=6.5u
xe6  eq6       eq7    vdd gnd inv *wp=6.5u
xe7  eq7       eq8   vdd gnd inv *wp=6.5u
xe8  eq8       eq    vdd gnd inv *wp=6.5u


xg1  gt1       gt2   vdd gnd inv *wp=6.5u
xg2  gt2       gt3    vdd gnd inv *wp=6.5u
xg3  gt3       gt4   vdd gnd inv *wp=6.5u
xg4  gt4       gt    vdd gnd inv *wp=6.5u

xl1  lt1       lt2   vdd gnd inv *wp=6.5u
xl2  lt2       lt3    vdd gnd inv *wp=6.5u
xl3  lt3       lt4   vdd gnd inv *wp=6.5u
xl4  lt4       lt    vdd gnd inv *wp=6.5u

cload1 gt gnd 0.5p
cload2 lt gnd 0.5p
cload3 eq gnd 0.5p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*Input pattern：
va a    gnd   pulse(1.8 0  1n   0.5n  0.5n 99.5n 200n)
vb b    gnd   pulse(1.8 0  1n   0.5n  0.5n 199.5n 400n)
vclk clk  gnd   pulse(1.8 0  1n   0.5n  0.5n 49.5n 100n)

.meas tran delay10 trig v(clk)    val=0.9 rise=2
+                  targ v(eq)     val=0.9 fall=1

.meas tran delay01 trig v(clk)    val=0.9 rise=3
+                  targ v(eq)     val=0.9 fall=2


.tran 0.1n 400n
.end
