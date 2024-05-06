pratice9  pass_reansistor (loading c=2p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd  wp=10u wn=3.5u
mp		out		in		vdd		vdd		P_18		l=0.18u	w=wp
mn		out		in		gnd		gnd		N_18		l=0.18u	w=wn
.ends

.subckt  and  a b  out vdd gnd wn=11u
xinvb b bout vdd gnd inv

mn0		out		bout	0	0	N_18	l=0.18u   w=wn 
mn1		out	    b	    a	0	N_18	l=0.18u   w=wn 
.ends

.subckt  nor  a b  out  vdd gnd
xinva a aout vdd gnd inv
xinvb b bout vdd gnd inv

*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mn0		out		bout  aout   	0		N_18		l=0.18u  	w=11u 
mn1		out		b	  0		    0		N_18		l=0.18u  	w=11u 
.ends

.subckt comp a b gt lt eq vdd gnd 
xinva a    inva vdd gnd inv 
xinvb b    invb vdd gnd inv 

xand1 b   inva  lt vdd gnd and 

xand2 a   invb gt vdd gnd and wp=8u

xnor  lt gt  eq vdd gnd nor 

.ends

xcomp a b  gt1 lt1 eq1 vdd gnd  comp
xe1  eq1       eq2   vdd gnd inv wp=9u
xe2  eq2       eq3    vdd gnd inv wp=9u
xe3  eq3       eq4   vdd gnd inv wp=9u
xe4  eq4       eq    vdd gnd inv *wp=9u

xg1  gt1       gt2   vdd gnd inv wp=9u
xg2  gt2       gt3    vdd gnd inv wp=9u
xg3  gt3       gt4   vdd gnd inv wp=9u
xg4 gt4      gt    vdd gnd inv wp=9u

xl1  lt1       lt2   vdd gnd inv wp=9u
xl2  lt2       lt3  vdd gnd inv wp=9u
xl3  lt3       lt4   vdd gnd inv wp=9u
xl4  lt4       lt   vdd gnd inv wp=9u


cload1 gt gnd 2p
cload2 lt gnd 2p
cload3 eq gnd 2p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*Input pattern：
va a    gnd   pulse(1.8 0  1n   0.5n  0.5n 99.5n 200n)
vb b    gnd   pulse(1.8 0  1n   0.5n  0.5n 199.5n 400n)

.meas tran delay10 trig v(a)    val=0.9 rise=1
+                  targ v(eq)   val=0.9 fall=1

.meas tran delay11 trig v(a)    val=0.9 rise=2
+                  targ v(eq)   val=0.9 rise=1


.tran 0.1n 400n
.end
