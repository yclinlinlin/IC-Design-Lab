pratice6 A*B+C*(B*D+A*E)(loading c=0.5p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out vdd gnd wp=2.2u wn=1u 
mp0  out  in  vdd  vdd  P_18  l=0.18u  w=wp 
mn0  out  in  gnd  gnd  N_18  l=0.18u  w=wn 
.ends

.subckt  and  a b  out vdd gnd wn=5u
xinvb b bout vdd gnd inv 

mn0		out		bout	gnd	0	N_18	l=0.18u   w=wn 
mn1		out	    b	    a	0	N_18	l=0.18u   w=wn 
.ends

.subckt  or  a b  out  vdd gnd
xinvb b bout vdd gnd inv 

*MP0    Drain   Gate    Source  Body  Model-name     Length     Width
mn0		out		  bout    a   	0		N_18		l=0.18u  	w=5u 
mn1		out		   b	  vdd	    0		N_18		l=0.18u  	w=5u 
.ends

.subckt logic a b c d e out vdd gnd
xAB a b  n1 vdd gnd and
xAE a e  n2 vdd gnd and
xBD b d  n3 vdd gnd and

xAEBD n2 n3  n4  vdd gnd or

xCAEBD n4 c n5 vdd gnd and wn=4.3u

xABCAEBD n1 n5  out  vdd gnd or
.ends

xout a b c d e out1 vdd gnd logic

x1  out1      out2   vdd gnd inv *wp=10u
x2  out2      out    vdd gnd inv *wp=10u


cload  out  gnd   0.5p

vvdd	vdd		0		1.8
vgnd	gnd		0		0


*VCLK  CLK  GND   PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
vine   e    gnd   0
vind   d    gnd   0
vinc   c    gnd   pulse(1.8 0  1n   0.5n  0.5n 99.5n  200n)
vinb   b    gnd   pulse(1.8 0  1n   0.5n  0.5n 49.5n  100n)
vina   a    gnd   pulse(1.8 0  1n   0.5n  0.5n 24.5n  50n)


.meas tran delay000 trig v(a)   val=0.9 fall=1
+                   targ v(out) val=0.9 fall=1

.meas tran delay110 trig v(a)   val=0.9 rise=2
+                   targ v(out) val=0.9 rise=1

.meas tran delay001 trig v(a)   val=0.9 fall=3
+                   targ v(out) val=0.9 fall=2

.meas tran delay111 trig v(a)   val=0.9 rise=4
+                   targ v(out) val=0.9 rise=2



.meas tran pw avg power

.tran 0.1n 200n
.end

