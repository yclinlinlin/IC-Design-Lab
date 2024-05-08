8-Bit Comparator (loading c=0.1p)
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

.subckt comp4 a3 a2 a1 a0 b3 b2 b1 b0  lt eq gt vdd gnd
xcomp1 a3 a2 b3 b2  net0 net1 net2 vdd gnd  comp2
xcomp2 a1 a0 b1 b0  net3 net4 net5 vdd gnd  comp2
xnf1 net1 net3 netf1 nand 
xf1 netf1 f1 inv 

xnf2 net1 net5 netf2 nand 
xf2 netf2 f2 inv 

xnf3 net0 f1 netf3 nor 
xf3 netf3 lt inv 

xnf4 net1 net4 netf4 nand 
xf4 netf4 eq inv 

xnf5 net2 f2 netf5 nor 
xf5 netf5 gt inv 
.ends

x41 a7 a6 a5 a4 b7 b6 b5 b4  net0 net1 net2 vdd gnd comp4
x42 a3 a2 a1 a0 b3 b2 b1 b0  net3 net4 net5 vdd gnd comp4
xnf1 net1 net3 netf1 nand 
xf1 netf1 f1 inv 

xnf2 net1 net5 netf2 nand 
xf2 netf2 f2 inv 

xnf3 net0 f1 netf3 nor 
xf3 netf3 lt inv 

xnf4 net1 net4 netf4 nand 
xf4 netf4 eq inv 

xnf5 net2 f2 netf5 nor 
xf5 netf5 gt inv 
cload1 gt gnd 0.1p
cload2 lt gnd 0.1p
cload3 eq gnd 0.1p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*Input pattern：
*va0  a0  0  pulse(1.8 0 1n  0.1n  0.1n 2.4n 5n)
*va1  a1  0  pulse(1.8 0 1n  0.1n  0.1n 4.9n 10n)
*va2  a2  0  pulse(1.8 0 1n  0.1n  0.1n 9.9n 20n)
*va3  a3  0  pulse(1.8 0 1n  0.1n  0.1n 19.9n 40n)
*va4  a4  0  pulse(1.8 0 1n  0.1n  0.1n 39.9n 80n)
*va5  a5  0  pulse(1.8 0 1n  0.1n  0.1n 79.9n 160n)
*va6  a6  0  pulse(1.8 0 1n  0.1n  0.1n 159.9n 320n)
*va7  a7  0  pulse(1.8 0 1n  0.1n  0.1n 319.9n 640n)
*
*vb7  b7  0  pulse(1.8 0 1n  0.1n  0.1n 2.4n 5n)
*vb6  b6  0  pulse(1.8 0 1n  0.1n  0.1n 4.9n 10n)
*vb5  b5  0  pulse(1.8 0 1n  0.1n  0.1n 9.9n 20n)
*vb4  b4  0  pulse(1.8 0 1n  0.1n  0.1n 19.9n 40n)
*vb3  b3  0  pulse(1.8 0 1n  0.1n  0.1n 39.9n 80n)
*vb2  b2  0  pulse(1.8 0 1n  0.1n  0.1n 79.9n 160n)
*vb1  b1  0  pulse(1.8 0 1n  0.1n  0.1n 159.9n 320n)
*vb0  b0  0  pulse(1.8 0 1n  0.1n  0.1n 319.9n 640n)

va7 a7    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  2.4n 5n)
va6 a6    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  9.9n 20n)
va5 a5    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  39.9n 80n)
va4 a4    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  159.9n 320n)
va3 a3    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  639.9n 1280n)
va2 a2    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  2559.9n 5120n)
va1 a1    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  10239.9n 20480n)
va0 a0    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  40959.9n 81920n)

vb7 b7    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  4.9n 10n)
vb6 b6    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  19.9n 40n)
vb5 b5    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  79.9n 160n)
vb4 b4    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  319.9n 640n)
vb3 b3    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  1279.9n 2560n)
vb2 b2    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  5119.9n 10240n)
vb1 b1    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  20479.9n 40960n)
vb0 b0    gnd   pulse(1.8 0  0.1n   0.1n  0.1n  81919.9n 163840n)

.meas	tran	delay_lt trig	v(a7)	val=0.9	rise=1
+						 targ	v(lt)	val=0.9	rise=1
.meas	tran	delay_eq trig	v(a7)	val=0.9	rise=1
+						 targ	v(eq)	val=0.9	fall=1
.meas	tran	delay_gt trig	v(a7)	val=0.9	fall=9
+						 targ	v(gt)	val=0.9	rise=1


.meas tran pw avg power

.tran 5n 5120n
.end
