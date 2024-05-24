LAB4-1 n=3 inv  (loading inverter)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd wp=0.6u wn=0.25u m1=1
mp1		out		in		vdd		vdd		P_18		l=0.18u	w=wp m=m1
mn1		out		in		gnd		gnd		N_18		l=0.18u	w=wn m=m1
.ends

.subckt  load  in  out
*       D       G       S
mpc		out		in		vdd		vdd		P_18		l=0.18u	w=2.4u  m=16
mnc		out		in		gnd		gnd		N_18		l=0.18u	w=1u    m=16
.ends

xinv1  in     net1 vdd gnd inv 
xinv2  net1   net2 vdd gnd inv  m1=4
xinv3  net2   out vdd gnd inv   m1=16
*xinv4  net3   out  vdd gnd inv   m1=22.6
xload out gnd load


vvdd	vdd		0		1.8
vgnd	gnd		0		0

*VCLK    CLK 	GND      PULSE(VL  VH    delay  trise  tfall  pulse_width  period)
vin		in		0		pulse(1.8	 0	 0.1n   0.1n	 0.1n	4.9n	     10n)

*.meas	tran	delayn1	    trig	v(in)	val=0.9	fall=2
*+						    targ	v(out)	val=0.9	rise=2
*.meas	tran	delayn2   trig	v(in)	val=0.9	fall=2
*+						  targ	v(out)	val=0.9	fall=2
.meas	tran	delayn3	  trig	v(in)	val=0.9	fall=2
+						  targ	v(out)	val=0.9	rise=2
*.meas	tran	delayn4	  trig	v(in)	val=0.9	fall=2
*+						  targ	v(out)	val=0.9	fall=2

.meas tran pw avg power

.tran 0.1n 50n
.end
