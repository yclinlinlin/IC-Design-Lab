4-input nor (loading c=0.02p~0.3p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  nor  a b c d out

mp0		net0	a		vdd		vdd		P_18		l=0.18u 	w=1u
mp1		net1	b		net0	vdd		P_18		l=0.18u	    w=1u
mp2		net2	c		net1	vdd		P_18		l=0.18u 	w=1u
mp3		out		d		net2	vdd		P_18		l=0.18u	   w=1u
mn0		out		a		0   	0		N_18		l=0.18u     w=1u
mn1		out		b		0		0		N_18		l=0.18u  	w=1u
mn2		out		c		0   	0		N_18		l=0.18u  	w=1u
mn3		out		d		0		0		N_18		l=0.18u  	w=1u
.ends

xnor4 a b c d out nor
c1 out gnd k

vvdd	vdd		0		1.8
vgnd	gnd		0		0

va		a		0		pulse(1.8	0  0.1n		0.1n	0.1n	9.9n	20n)
vb		b		0		0
vc		c		0		0
vd		d		0		0

.meas	tran	delayN	trig	v(a)	val=0.9	fall=2
+						targ	v(out)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 80n (sweep 	k 	0.02p  0.3p   0.04p)
.end
