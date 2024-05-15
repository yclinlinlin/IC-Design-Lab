2-input nand cascade(loading c=0.02p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  nand  a b  out
mp0		out		a		vdd		vdd		P_18		l=0.18u 	w=1u
mp1		out		b		vdd		vdd		P_18		l=0.18u	w=1u
mn0		out		b		net		0		N_18		l=0.18u  	w=1u
mn1		net		a		0		0		N_18		l=0.18u  	w=1u
.ends

xnand20 a   b     out1 nand
xnand21 c  out1   out2 nand
xnand22 d  out2   out3 nand
xnand23 e  out3   out4 nand
c1   out1  gnd  0.02p 
c2   out2  gnd  0.02p
c3   out3  gnd  0.02p
c4   out4  gnd  0.02p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

va		a		0		pulse(1.8	0  0.1n		0.1n	0.1n	9.9n	20n)
vb		b		0		1.8
vc		c		0		1.8
vd		d		0		1.8
ve		e		0		1.8

.meas	tran	delayN1	trig	v(a)	   val=0.9	rise=1
+						   targ	v(out1)	val=0.9	fall=1
.meas	tran	delayN2  trig	v(a)	   val=0.9	rise=1
+						   	targ	v(out2)	val=0.9	rise=1
.meas	tran	delayN3 trig	   v(a)	   val=0.9	rise=1
+						  targ	   v(out3)	val=0.9	fall=1
.meas	tran	delayN4	trig	v(a)	   val=0.9	rise=1
+						   targ	v(out4)	val=0.9	rise=1
.meas tran pw avg power

.tran 0.1n 80n
.end

