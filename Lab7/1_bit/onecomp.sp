One-Bit Comparator (loading c=0.1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd m1=1
mp		out		in		vdd		vdd		P_18		l=0.18u	w=8u m=m1
mn		out		in		gnd		gnd		N_18		l=0.18u	w=2u m=m1
.ends

.subckt  nand  a b  out vdd gnd m1=1
mp0		out		a		vdd		vdd		P_18		l=0.18u   w=4u m=m1
mp1		out		b		vdd		vdd		P_18		l=0.18u	  w=4u m=m1
mn0		out		a		net		0		N_18		l=0.18u   w=2u m=m1
mn1		net	 	b		0		0		N_18		l=0.18u   w=2u m=m1
.ends

.subckt  nor  a b  out  vdd gnd m1=1
*定義了一個名為nor的子電路
*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mp0		net0	a		vdd		vdd		P_18		l=0.18u 	w=4u m=m1
mp1		out		b		net0	vdd		P_18		l=0.18u	    w=4u m=m1
mn0		out		a		0   	0		N_18		l=0.18u  	w=2u  m=m1
mn1		out		b		0		0		N_18		l=0.18u  	w=2u  m=m1
.ends

.subckt comp a b gt lt eq vdd gnd 
xinva a    inva vdd gnd inv 
xinvb b    invb vdd gnd inv 

xnanda b   inva   out1 vdd gnd nand 
xinv1  out1       lt   vdd gnd inv 

xnandb a    invb out2 vdd gnd nand 
xinv2 out2       gt   vdd gnd inv 
xnor  gt lt  eq vdd gnd nor 
.ends
xcomp a b gt lt eq vdd gnd  comp

cload1 gt gnd 0.1p
cload2 lt gnd 0.1p
cload3 eq gnd 0.1p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*Input pattern：
Va a 0 pulse(1.8 0 1n 0.1n 0.1n 2.4n 5n)
Vb b 0 pulse(1.8 0 1n 0.1n 0.1n 4.9n 10n)

.meas	tran	delayN1	trig	v(a)	val=0.9	rise=1
+						targ	v(eq)	val=0.9	fall=1
.meas	tran	delayN2	trig	v(a)	val=0.9	rise=2
+						targ	v(eq)	val=0.9	rise=1
.meas	tran	delayN3	trig	v(a)	val=0.9	rise=3
+						targ	v(eq)	val=0.9	fall=2
.meas tran pw avg power

.tran 0.05n 40n
.end
