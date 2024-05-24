2-input nor (loading c=0.05p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  nor  a b  out  
*定義了一個名為nor的子電路
*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mp0		net0	a		vdd		vdd		P_18		l=0.18u 	w=1u
mp1		out		b		net0	vdd		P_18		l=0.18u	    w=1u
mn0		out		a		0   	0		N_18		l=0.18u  	w=1u
mn1		out		b		0		0		N_18		l=0.18u  	w=1u
.ends

xnor2 a  b   out  nor
c1   out gnd 0.05p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

va		a		0		pulse(1.8	0  0.1n		0.1n	0.1n	9.9n	20n)
vb		b		0		0

.meas	tran	delayN	trig	v(a)	val=0.9	fall=2
+						targ	v(out)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran 0.1n 80n
.end
