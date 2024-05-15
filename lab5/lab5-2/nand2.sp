LAB5-2 Cascaded Dynamic NAND (loading c=0.1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

.subckt  nand  a b  clk out  
*      D       G       S
mp0     out		clk		vdd		vdd		P_18		l=0.18u 	w=1u

mn0		out		a		net		0		N_18		l=0.18u  	w=1u
mn1		net		b		net1	0		N_18		l=0.18u  	w=1u
mn2		net1	clk		0		0		N_18		l=0.18u  	w=1u
.ends

xnand1  a       b        clk out1 nand
xinv1   out1    invout1  inv

xnand2  c       invout1  clk out2 nand
xinv2   out2    invout2  inv

xnand3  d       invout2  clk out3 nand
xinv3   out3    invout3  inv

xnand4  e       invout3  clk out4 nand
xinv4   out4    invout4  inv

c1   invout1  gnd  0.1p 
c2   invout2  gnd  0.1p 
c3   invout3  gnd  0.1p 
c4   invout4  gnd  0.1p 

vvdd	vdd		0		1.8
vgnd	gnd		0		0

va   a   0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vb   b   0 1.8
vc   c   0 1.8
vd   d   0 1.8
ve   e   0 1.8
vclk clk 0 pulse(0 1.8 2.1n 0.1n 0.1n 1.9n 4n)


.meas	tran	delaynand1	trig	v(clk)	    val=0.9	rise=3
+						    targ	v(invout1)	val=0.9	rise=1

.meas	tran	delaynand2	trig	v(clk)	    val=0.9	rise=3
+						    targ	v(invout2)	val=0.9	rise=1

.meas	tran	delaynand3	trig	v(clk)	    val=0.9	rise=3
+						    targ	v(invout3)	val=0.9	rise=1

.meas	tran	delaynand4	trig	v(clk)	    val=0.9	rise=3
+						    targ	v(invout4)	val=0.9	rise=1
.meas tran pw avg power

.tran 0.1n 40n
.end

