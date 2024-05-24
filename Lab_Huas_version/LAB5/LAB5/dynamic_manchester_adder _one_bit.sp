dynamic_manchester_adder_one_bit
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd  vdd  0 1.8 
vgnd  gnd  0  0

*MOSFET

*Manchester


*cload


vck	clk	gnd	pulse(0		1.8	1.1n	0.1n	0.1n	1.9n	4n)
va	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	3.9n	8n)
vb	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	7.9n	16n)
vci	ci	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	15.9n	32n)

.tran 0.1n 80n

.meas tran delayN1 trig v(clk)  val=0.9 rise=2
+                  targ v(cout) val=0.9 rise=1

.meas tran pw avg power

.meas tran pdp = param('pw*delayN1')

.end