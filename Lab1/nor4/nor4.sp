4-input nor (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  nor  a b c d out

mp0		net0	a		vdd		vdd		P_18		l=0.18u 	w='8*k'
mp1		net1	b		net0	vdd		P_18		l=0.18u	    w='8*k'
mp2		net2	c		net1	vdd		P_18		l=0.18u 	w='8*k'
mp3		out		d		net2	vdd		P_18		l=0.18u	   w='8*k'
mn0		out		a		0   	0		N_18		l=0.18u     w='k'
mn1		out		b		0		0		N_18		l=0.18u  	w='k'
mn2		out		c		0   	0		N_18		l=0.18u  	w='k'
mn3		out		d		0		0		N_18		l=0.18u  	w='k'
.ends

xnor4 a b c d out nor
c1 out gnd 0.01p

vvdd	vdd		0		1.8
vgnd	gnd		0		0


vin		in		0		pulse(0	1.8	5n		0.01n	0.01n	2.49n	5n)
va		a		0		pulse(0	1.8	5n		0.01n	0.01n	4.99n	10n)
vb		b		0		pulse(0	1.8	5n		0.01n	0.01n	9.99n	20n)
vc		c		0		pulse(0	1.8	5n		0.01n	0.01n	19.99n	40n)
vd		d		0		pulse(0	1.8	5n		0.01n	0.01n	39.99n	80n)

.meas	tran	delayN	trig	v(a)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n (sweep 	k 	0.25u  2.5u   0.05u)
.end
