4-input nand (loading c=0.05p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  nand  a b c d out
mp0		out		a		vdd		vdd		P_18		l=0.18u 	w=1u
mp1		out		b		vdd		vdd		P_18		l=0.18u	    w=1u
mp2		out		c		vdd		vdd		P_18		l=0.18u 	w=1u
mp3		out		d		vdd		vdd		P_18		l=0.18u	    w=1u
mn0		out		d		net		0		N_18		l=0.18u  	w=1u
mn1		net		c		net1		0		N_18		l=0.18u  	w=1u
mn2		net1    b		net2		0		N_18		l=0.18u  	w=1u
mn3		net2    a		0		0		N_18		l=0.18u  	w=1u
.ends

xnand4 a b c d out nand
*電容元件名為C1，其兩個端口分別為 out 和 gnd 電容值為 0.05pF。
c1   out  gnd  0.05p 

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*vin		in		0		pulse(0	1.8 5n		0.01n	0.01n	2.49n	5n)
va		a		0		pulse(1.8	0  0.1n		0.1n	0.1n	9.9n	20n)
vb		b		0		1.8
vc		c		0		1.8
vd		d		0		1.8

.meas	tran	delayN	trig	v(a)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 80n *(sweep 	k 	0.3u  5u   0.1u)
.end

