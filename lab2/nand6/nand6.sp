6-input nand (loading c=0.05p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  nand  a b c d e f out
mp0		out		a		vdd		vdd		P_18		l=0.18u 	w=1u
mp1		out		b		vdd		vdd		P_18		l=0.18u	    w=1u
mp2		out		c		vdd		vdd		P_18		l=0.18u 	w=1u
mp3		out		d		vdd		vdd		P_18		l=0.18u	    w=1u
mp4		out		e		vdd		vdd		P_18		l=0.18u 	w=1u
mp5		out		f		vdd		vdd		P_18		l=0.18u	    w=1u
mn0		out		f		net		0		N_18		l=0.18u  	w=1u
mn1		net		e		net1	0		N_18		l=0.18u  	w=1u
mn2		net1    d		net2	0		N_18		l=0.18u  	w=1u
mn3		net2    c		net3	0		N_18		l=0.18u  	w=1u
mn4		net3    b		net4	0		N_18		l=0.18u  	w=1u
mn5		net4    a		0		0		N_18		l=0.18u  	w=1u
.ends

xnand6 a b c d e f out nand
*電容元件名為C1，其兩個端口分別為 out 和 gnd 電容值為 0.05pF。
c1   out  gnd  0.05p 

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*vin		in		0		pulse(0	1.8 5n		0.01n	0.01n	2.49n	5n)
va		a		0		pulse(1.8	0  0.1n		0.1n	0.1n	9.9n	20n)
vb		b		0		1.8
vc		c		0		1.8
vd		d		0		1.8
ve		e		0		1.8
vf		f		0		1.8

.meas	tran	delayN	trig	v(a)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 80n *(sweep 	k 	0.3u  5u   0.1u)
.end

