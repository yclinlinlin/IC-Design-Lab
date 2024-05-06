pratice10  pass_reansistor (loading c=2p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd  wp=10u wn=4u
mp		out		in		vdd		vdd		P_18		l=0.18u	w=wp
mn		out		in		gnd		gnd		N_18		l=0.18u	w=wn
.ends

.subckt  and  a b  out vdd gnd wn=8u
xinvb b bout vdd gnd inv wp=15u

mn0		out		bout	0	0	N_18	l=0.18u   w=wn 
mn1		out	    b	    a	0	N_18	l=0.18u   w=wn 
.ends

.subckt  or  a b  out  vdd gnd
xinvb b bout vdd gnd inv wp=11u wn=3.5u

*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mn0		out		  bout    a   	0		N_18		l=0.18u  	w=13u 
mn1		out		   b	  vdd	   0		N_18		l=0.18u  	w=13u 
.ends

.subckt multiplexer a b s out vdd gnd 
xinvs s sout vdd gnd inv

x1 a b n1 vdd gnd or
x2 a b n2 vdd gnd and

mn0		out		  sout    n1  0		N_18		l=0.18u  	w=10u 
mn1		out		   s	   n2	0		N_18		l=0.18u  	w=10u 
.ends

x1 a b s out1 vdd gnd multiplexer

xbuffer1  out1       out2  vdd gnd inv wp=10u
xbuffer2  out2       out   vdd gnd inv wp=10u

cload1 out gnd 2p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*Input pattern：
va a    gnd   pulse(1.8 0  1n   0.5n  0.5n 49.5n 100n)
vb b    gnd   pulse(1.8 0  1n   0.5n  0.5n 99.5n 200n)
vs s    gnd   pulse(1.8 0  1n   0.5n  0.5n 199.5n 400n)

.meas tran delay00  trig v(a)    val=0.9 fall=1
+                   targ v(out)  val=0.9 fall=1

.meas tran delay10  trig v(a)    val=0.9 rise=1
+                   targ v(out)  val=0.9 rise=1

.meas tran delay00_1 trig v(a)    val=0.9 fall=3
+                    targ v(out)  val=0.9 fall=2

.meas tran delay11 trig v(a)    val=0.9 rise=4
+                  targ v(out)  val=0.9 rise=2


.tran 0.1n 400n
.end
