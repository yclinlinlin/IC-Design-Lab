4-input xor (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out 

mp0		out		in		vdd		vdd		P_18		l=0.18u	 w='2*k'
mn0		out		in		gnd		gnd		N_18		l=0.18u	 w='k'
.ends

.subckt  xor a b c d out 

xinva a aout inv
xinvb b bout inv
xinvc c cout inv
xinvd d dout inv

mp0		net0	a	   vdd		vdd		P_18 l=0.18u	 w='2*k'
mp1		net2	bout	net0	vdd		P_18 l=0.18u	 w='2*k'
mp2		net1	aout	vdd		vdd		P_18 l=0.18u	 w='2*k'
mp3		net2	b		net1	vdd		P_18 l=0.18u	 w='2*k'
mp4		net3	cout	net2	vdd		P_18 l=0.18u	 w='2*k'
mp5		out	   dout	net3	   vdd      P_18 l=0.18u	 w='2*k'

mp6		net4	aout	vdd		vdd		P_18		l=0.18u	 w='2*k'
mp7		net6	bout	net4	vdd		P_18		l=0.18u	 w='2*k'
mp8		net5	a   	vdd		vdd		P_18		l=0.18u	 w='2*k'
mp9 	net6	b		net5	vdd		P_18		l=0.18u	 w='2*k'
mp10	net3	c   	net6	vdd		P_18		l=0.18u	 w='2*k'

mp11	net7	aout	vdd		vdd		P_18		l=0.18u	 w='2*k'
mp12	net9	bout	net7    vdd	  P_18		l=0.18u	 w='2*k'
mp13	net8	a	    vdd	    vdd   P_18		l=0.18u	 w='2*k'
mp14	net9	b		net8	vdd	  P_18		l=0.18u	 w='2*k'
mp15	net10 cout   	net9	vdd	  P_18		l=0.18u	 w='2*k'
mp16 	out 	d   	net10	vdd		P_18		l=0.18u	 w='2*k'

mp17	net11	a	  vdd   vdd	P_18 l=0.18u	 w='2*k'
mp18	net13	bout net11 vdd  P_18 l=0.18u	 w='2*k'
mp19	net12	aout vdd   vdd  P_18 l=0.18u	 w='2*k'
mp20	net13	b	  net12 vdd	  P_18		l=0.18u	 w='2*k'
mp21	net10  c   net13  vdd	  P_18		l=0.18u	 w='2*k'

mn0		out	dout	n4	gnd		N_18		l=0.18u	w='k'
mn1		n4	cout	n3	gnd		N_18		l=0.18u	w='k'
mn2		n3	aout	n1	gnd		N_18		l=0.18u w='k'
mn3		n1	bout	gnd	gnd		N_18		l=0.18u	w='k'
mn4		n3	a   	n2	gnd		N_18		l=0.18u w='k'
mn5		n2	b   	gnd	gnd		N_18		l=0.18u	w='k'

mn6		n4	c   	n7	gnd		N_18		l=0.18u	 w='k'
mn7		n7	a   	n5	gnd		N_18		l=0.18u w='k'
mn8		n5	bout	gnd	gnd		N_18		l=0.18u	 w='k'
mn9 	n7	aout	n6	gnd		N_18		l=0.18u w='k'
mn10	n6	b	    gnd gnd		N_18		l=0.18u w='k'

mn11	out	d   	n11	gnd		N_18		l=0.18u	 w='k'
mn12	n11	cout	n10	gnd		N_18		l=0.18u	 w='k'
mn13	n10	a   	n8	gnd		N_18		l=0.18u w='k'
mn14	n8	bout	gnd	gnd		N_18		l=0.18u	 w='k'
mn15 	n10	aout	n9	gnd		N_18		l=0.18u w='k'
mn16	n9	b   	gnd	gnd		N_18		l=0.18u	 w='k'

mn17	n11	c   	n14	gnd		N_18		l=0.18u	 w='k'
mn18	n14	aout	n12	gnd		N_18		l=0.18u w='k'
mn19	n12	bout	gnd	gnd		N_18		l=0.18u	 w='k'
mn20 	n14	a   	n13	gnd		N_18		l=0.18u w='k'
mn21 	n13	b   	gnd gnd		N_18		l=0.18u w='k'

.ends


xxor4 a b c d out xor
c1 out gnd 0.01p

vvdd	vdd		0		1.8 *宣告一個直流電壓源
vgnd	gnd		0		0


vin		in		0		pulse(0	1.8 5n		0.01n	0.01n	2.49n	5n)
va		a		0		pulse(0	1.8 5n		0.01n	0.01n	4.99n	10n)
vb		b		0		pulse(0	1.8 5n		0.01n	0.01n	9.99n	20n)
vc		c		0		pulse(0	1.8 5n		0.01n	0.01n	19.99n	40n)
vd		d		0		pulse(0	1.8 5n		0.01n	0.01n	39.99n	80n)

.meas	tran	delayN	trig	v(a)   val=0.9	 fall=1
+						targ	v(out)     val=0.9 rise=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n (sweep 	k 	0.3u  5u   0.1u)
.end
