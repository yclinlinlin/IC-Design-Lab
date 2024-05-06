pratice9  pass_reansistor (loading c=2p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd  wp=2u wn=1.2u
mp		out		in		vdd		vdd		P_18		l=0.18u	w=wp
mn		out		in		gnd		gnd		N_18		l=0.18u	w=wn
.ends

.subckt  and  a b  out vdd gnd m1=1
invb b bout vdd gnd inv

mn0		out		bout	0	0	N_18	l=0.18u   w=2u m=m1
mn1		out	    b	    a	0	N_18	l=0.18u   w=2u m=m1
.ends

.subckt  nor  a b  out  vdd gnd
inva a aout vdd gnd inv
invb b bout vdd gnd inv

*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mn0		out		bout  aout   	0		N_18		l=0.18u  	w=2u 
mn1		out		b	  0		    0		N_18		l=0.18u  	w=2u 
.ends

.subckt comp a b gt lt eq vdd gnd 
xinva a    inva vdd gnd inv 
xinvb b    invb vdd gnd inv 

xand1 b   inva  lt vdd gnd and 

xand2 a   invb gt vdd gnd and 

xnor  lt gt  eq vdd gnd nor 

.ends

xcomp a b  gt lt eq vdd gnd  comp
xe1  eq1       eq2   vdd gnd inv *wp=6.5u
xe2  eq2       eq3    vdd gnd inv *wp=6.5u
xe3  eq3       eq4   vdd gnd inv *wp=6.5u
xe4  eq4       eq5    vdd gnd inv *wp=6.5u
xe5  eq5       eq6   vdd gnd inv *wp=6.5u
xe6  eq6       eq7    vdd gnd inv *wp=6.5u
xe7  eq7       eq8   vdd gnd inv *wp=6.5u
xe8  eq8       eq    vdd gnd inv *wp=6.5u


xg1  gt1       gt2   vdd gnd inv *wp=6.5u
xg2  gt2       gt3    vdd gnd inv *wp=6.5u
xg3  gt3       gt4   vdd gnd inv *wp=6.5u
xg4  gt4       gt    vdd gnd inv *wp=6.5u

xl1  lt1       lt2   vdd gnd inv *wp=6.5u
xl2  lt2       lt3    vdd gnd inv *wp=6.5u
xl3  lt3       lt4   vdd gnd inv *wp=6.5u
xl4  lt4       lt    vdd gnd inv *wp=6.5u

cload1 gt gnd 0.5p
cload2 lt gnd 0.5p
cload3 eq gnd 0.5p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*Input pattern：
va a    gnd   pulse(1.8 0  1n   0.5n  0.5n 99.5n 200n)
vb b    gnd   pulse(1.8 0  1n   0.5n  0.5n 199.5n 400n)
vclk clk  gnd   pulse(1.8 0  1n   0.5n  0.5n 49.5n 100n)

.meas tran delay10 trig v(clk)    val=0.9 rise=2
+                  targ v(eq)     val=0.9 fall=1

.meas tran delay01 trig v(clk)    val=0.9 rise=3
+                  targ v(eq)     val=0.9 fall=2


.tran 0.1n 400n
.end
