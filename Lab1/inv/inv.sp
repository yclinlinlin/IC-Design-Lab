2-input inv (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out

mp		out		in		vdd		vdd		P_18		l=0.18u	w='2*k'
mn		out		in		gnd		gnd		N_18		l=0.18u	w='k'
.ends

xinv in out inv


vvdd	vdd		0		1.8
vgnd	gnd		0		0


vin		in		0		pulse(0	1.8	5n		0.01n	0.01n	2.49n	5n)
va		a		0		pulse(0	1.8	5n		0.01n	0.01n	4.99n	10n)
vb		b		0		pulse(0	1.8	5n		0.01n	0.01n	9.99n	20n)

.meas	tran	delayN	trig	v(in)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n (sweep 	k 	0.3u  5u   0.1u)
.end
