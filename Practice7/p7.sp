pratice7 comp_pseudo from lab7-1 (loading c=0.5p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd m1=1 wp=6u wn=1.5u
mp		out		in		vdd		vdd		P_18		l=0.18u	w=wp
mn		out		in		gnd		gnd		N_18		l=0.18u	w=wn
.ends

.subckt  nand  a b  out vdd gnd m1=1
mp0		out		0		vdd		vdd		P_18		l=0.18u   w=8u m=m1

mn0		out		a		net		0		N_18		l=0.18u   w=8u m=m1
mn1		net	 	b		0		0		N_18		l=0.18u   w=8u m=m1
.ends

.subckt  nor  a b  out  vdd gnd
*定義了一個名為nor的子電路
*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mp0		out		0		vdd		vdd		P_18		l=0.18u 	w=8u 

mn0		out		a		0   	0		N_18		l=0.18u  	w=8u 
mn1		out		b		0		0		N_18		l=0.18u  	w=8u  
.ends

.subckt comp a b gt lt eq vdd gnd 
xinva a    inva vdd gnd inv 
xinvb b    invb vdd gnd inv 

xnanda b   inva   out1 vdd gnd nand 
xinv1  out1       lt   vdd gnd inv 

xnandb a    invb out2 vdd gnd nand 
xinv2 out2       gt   vdd gnd inv 

xnor  lt gt eq vdd gnd nor 

.ends

xcomp a b gt lt eq vdd gnd  comp

cload1 gt gnd 0.5p
cload2 lt gnd 0.5p
cload3 eq gnd 0.5p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*Input pattern：
va 	 a  0  pulse(1.8 0  1n  0.5n  0.5n   19.5n  	40n)
vb 	 b  0  pulse(1.8 0  1n  0.5n  0.5n   39.5n   80n)

.meas tran delay10 trig v(a)    val=0.9 rise=1
+                  targ v(eq)   val=0.9 fall=1

.meas tran delay11 trig v(a)    val=0.9 rise=2
+                  targ v(eq)   val=0.9 rise=1

.meas tran delay01_gt trig v(a)    val=0.9 fall=2
+                     targ v(gt)   val=0.9 fall=1

.meas tran delay01_lt trig v(a)    val=0.9 fall=2
+                     targ v(lt)   val=0.9 rise=1


.tran 0.05n 80n
.end
