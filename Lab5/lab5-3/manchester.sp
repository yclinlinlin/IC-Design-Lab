LAB5-3 Dynamic Manchester Carry-Generation Chain (loading c=0.05p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

.subckt  and  ina inb  out
*       D       G       S
mp0		out0		ina		vdd		vdd		P_18		l=0.18u 	w=1u
mp1		out0		inb		vdd		vdd		P_18		l=0.18u	    w=1u
mn0		out0		ina		net		0	k	N_18		l=0.18u  	w=1u
mn1		net	    	inb		0		0		N_18		l=0.18u  	w=1u
xinv0 out0 out inv
.ends

.subckt xor ina inb out
xinvina ina inaout inv
xinvinb inb inbout inv

mp1 net0 ina    vdd    vdd p_18 l=0.18u w=2u
mp2 out  inbout net0   vdd p_18 l=0.18u w=2u
mp3 net1 inaout vdd    vdd p_18 l=0.18u w=2u
mp4 out  inb    net1   vdd p_18 l=0.18u w=2u
mn1 out  inaout net2   gnd n_18 l=0.18u w=1u
mn2 net2 inbout gnd    gnd n_18 l=0.18u w=1u
mn3 out  ina    net3   gnd n_18 l=0.18u w=1u
mn4 net3 inb    gnd    gnd n_18 l=0.18u w=1u
.ends

.subckt add ina inb cin clk out invout wp=2u wn=1u m1=1
xand ina   inb  g      and
xxor ina   inb  p      xor 

mp0 out  clk  vdd   vdd  p_18  l=0.18u  w=wp m=m1

mn0 out  g    net1   gnd   n_18  l=0.18u  w=wn m1=1
mn1 net1 clk  0      gnd   n_18  l=0.18u  w=wn m1=1
mn2 out  p    cin    gnd   n_18  l=0.18u  w=wn m1=1

xinv3 out invout inv
.ends

xinvci ci ciout inv
xadd0 a  b  ciout clk out0 c0 add m1=4.5
xadd1 a1 b1 out0  clk out1 c1 add m1=4
xadd2 a2 b2 out1  clk out2 c2 add m1=3.5
xadd3 a3 b3 out2  clk out3 c3 add m1=3
xadd4 a4 b4 out3  clk out4 c4 add m1=2.5
xadd5 a5 b5 out4  clk out5 c5 add m1=2
xadd6 a6 b6 out5  clk out6 c6 add m1=1.5
xadd7 a7 b7 out6  clk out7 c7 add 

c0   c0  gnd  0.05p 
c1   c1  gnd  0.05p 
c2   c2  gnd  0.05p 
c3   c3  gnd  0.05p 
c4   c4  gnd  0.05p 
c5   c5  gnd  0.05p 
c6   c6  gnd  0.05p
c7   c7  gnd  0.05p 
 
vvdd	vdd		0		1.8
vgnd	gnd		0		0

vck clk gnd pulse(0 1.8 2.1n 0.1n 0.1n 1.9n  4n )
va  a   gnd pulse(1.8 0 0.1n 0.1n 0.1n 3.9n  8n )
vb  b   gnd pulse(1.8 0 0.1n 0.1n 0.1n 7.9n  16n)
vci ci gnd 0
va1 a1 gnd 1.8
vb1 b1 gnd 1.8
va2 a2 gnd 1.8
vb2 b2 gnd 1.8
va3 a3 gnd 1.8
vb3 b3 gnd 1.8
va4 a4 gnd 1.8
vb4 b4 gnd 1.8
va5 a5 gnd 1.8
vb5 b5 gnd 1.8
va6 a6 gnd 1.8
vb6 b6 gnd 1.8
va7 a7 gnd 1.8
vb7 b7 gnd 1.8


.meas	tran	delay1	trig	v(clk)	    val=0.9	rise=4
+						targ	v(c0)	    val=0.9	rise=1

.meas	tran	delay2	trig	v(clk)	    val=0.9	rise=1
+					    targ	v(c1)	    val=0.9	rise=1

.meas	tran	delay3	trig	v(clk)	    val=0.9	rise=1
+						targ	v(c2)	    val=0.9	rise=1

.meas	tran	delay4	trig	v(clk)	    val=0.9	rise=1
+						targ	v(c3)	    val=0.9	rise=1

.meas	tran	delay4	trig	v(clk)	    val=0.9	rise=1
+						targ	v(c4)	    val=0.9	rise=1

.meas	tran	delay6	trig	v(clk)	    val=0.9	rise=1
+						targ	v(c5)	    val=0.9	rise=1

.meas	tran	delay7	trig	v(clk)	    val=0.9	rise=1
+						targ	v(c6)	    val=0.9	rise=1

.meas	tran	delay8	trig	v(clk)	    val=0.9	rise=1
+						targ	v(c7)	    val=0.9	rise=1

.meas tran pw avg power

.tran 0.1n 40n
.end

