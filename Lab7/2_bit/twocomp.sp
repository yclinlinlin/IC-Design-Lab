2-Bit Comparator (loading c=0.1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out  m1=1
mp		out		in		vdd		vdd		P_18		l=0.18u	w=8u m=m1
mn		out		in		gnd		gnd		N_18		l=0.18u	w=2u m=m1
.ends

.subckt  nand  a b  out  m1=1
mp0		out		a		vdd		vdd		P_18		l=0.18u   w=4u m=m1
mp1		out		b		vdd		vdd		P_18		l=0.18u	  w=4u m=m1
mn0		out		a		net		0		N_18		l=0.18u   w=2u m=m1
mn1		net	 	b		0		0		N_18		l=0.18u   w=2u m=m1
.ends

.subckt  nor  a b  out   m1=1
*定義了一個名為nor的子電路
*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mp0		net0	a		vdd		vdd		P_18		l=0.18u 	w=4u m=m1
mp1		out		b		net0	vdd		P_18		l=0.18u	    w=4u m=m1
mn0		out		a		0   	0		N_18		l=0.18u  	w=2u  m=m1
mn1		out		b		0		0		N_18		l=0.18u  	w=2u  m=m1
.ends

.subckt comp2 a1 a0 b1 b0  lt eq gt vdd gnd
xinva1 a1           inva1 inv
xinva0 a0           inva0 inv
xc1    inva1 b1     c1    nor
xc2    inva1 b1     c2    nand
xc3    b0    inva0  c3    nand
xnc4   c1    c3     netc4 nor
xc4    netc4        c4    inv   
xc5    c4    c2     lt    nand
   
xinvb1 b1           invb1 inv
xinvb0 b0           invb0 inv
xd2    a1    invb1  d2    nand
xd3    a0    invb0  d3    nand
xd1    invb1 a1     d1    nor
xnd4   d3    d1     netd4 nor
xd4    netd4        d4    inv 
xd5    d2    d4     gt    nand
   
xe1    lt    gt     eq    nor

.ends
xcomp2 a1 a0 b1 b0  lt eq gt vdd gnd  comp2

cload1 gt gnd 0.1p
cload2 lt gnd 0.1p
cload3 eq gnd 0.1p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*Input pattern：
va1 a1    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  2.4n  5n)
va0 a0    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)

vb1 b1    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n  10n)
vb0 b0    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  19.9n 40n)

.meas	tran	delayN1	trig	v(a1)	val=0.9	rise=1
+						targ	v(eq)	val=0.9	fall=1
.meas	tran	delayN2	trig	v(a1)	val=0.9	rise=2
+						targ	v(eq)	val=0.9	rise=1
.meas	tran	delayN3	trig	v(a1)	val=0.9	fall=3
+						targ	v(eq)	val=0.9	fall=2
.meas	tran	delayN4	trig	v(a1)	val=0.9	fall=7
+						targ	v(eq)	val=0.9	rise=2
.meas	tran	delayN5	trig	v(a1)	val=0.9	rise=7
+						targ	v(eq)	val=0.9	fall=3
.meas	tran	delayN6	trig	v(a1)	val=0.9	rise=8
+						targ	v(eq)	val=0.9	rise=3
.meas tran pw avg power

.tran 0.05n 40n
.end
