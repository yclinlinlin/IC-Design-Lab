pratice7 comp_pseudo from lab7-1 (loading c=0.5p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd  vdd   0 1.8 
vgnd  gnd   0  0 

*INV
.SUbCKT INV IN OUT VDD GND
MP		OUT		IN		VDD		VDD		P_18		L=0.18U	W=10U
MN		OUT		IN		GND		GND		N_18		L=0.18U	W=9U   
.ENDS
.SUbCKT INV2 IN OUT VDD GND
MP		OUT		IN		VDD		VDD		P_18		L=0.18U	W=10U
MN		OUT		IN		GND		GND		N_18		L=0.18U	W=9U   
.ENDS
.SUbCKT INVb IN OUT VDD GND
MP		OUT		IN		VDD		VDD		P_18		L=0.18U	W=3U
MN		OUT		IN		GND		GND		N_18		L=0.18U	W=1.5U
.ENDS
.SUbCKT INVb_2 IN OUT VDD GND
MP		OUT		IN		VDD		VDD		P_18		L=0.18U	W=9.5U
MN		OUT		IN		GND		GND		N_18		L=0.18U	W=4.5U
.ENDS
.SUbCKT INVb_3 IN OUT VDD GND
MP		OUT		IN		VDD		VDD		P_18		L=0.18U	W=1.5U
MN		OUT		IN		GND		GND		N_18		L=0.18U	W=1.5U
.ENDS
.SUbCKT INVb_4 IN OUT VDD GND
MP		OUT		IN		VDD		VDD		P_18		L=0.18U	W=9.5U
MN		OUT		IN		GND		GND		N_18		L=0.18U	W=3.8U
.ENDS
.SUbCKT bUF  IN OUT VDD GND
XINV1	IN	IN_	VDD	GND	INVb
XINV2	IN_	OUT	VDD	GND	INVb_2 
.ENDS
.SUbCKT bUF2  IN OUT VDD GND
XINV1	IN	IN_	VDD	GND	INVb_3
XINV2	IN_	OUT	VDD	GND	INVb_4
.ENDS

*NaND
.SUbCKT NaND	a	b	OUT	VDD	GND
MP	OUT	GND	VDD	VDD	P_18	L=0.18U 	W=3.5U
MN1 	OUT  	b  	N1    	GND  	N_18 	L=0.18U  	W=12U
MN2 	N1 		a  	GND  	GND  	N_18 	L=0.18U  	W=12U
.ENDS

*aND
.SUbCKT aND	a	b	OUT	VDD	GND
MP	OUT_	GND	VDD	VDD	P_18	L=0.18U 	W=3.5U
MN1 	OUT_  	b  	N1    	GND  	N_18 	L=0.18U  	W=8.5U
MN2 	N1 		a  	GND  	GND  	N_18 	L=0.18U  	W=8.5U
XINV	OUT_	OUT	VDD	GND	INV
.ENDS

*NOR
.SUbCKT NOR	a	b	OUT	VDD	GND
MP	OUT	GND	VDD	VDD	P_18	L=0.18U 	W=15U
MN1 	OUT  	a  	GND    GND  	N_18 	L=0.18U  	W=7U
MN2 	OUT 	b  	GND  	GND  	N_18 	L=0.18U  	W=7U
.ENDS

.SUbCKT COMP	a	b	lt	eq	gt	VDD	GND	
XINVa	a	a_	VDD	 GND  INV2
XINVb	b	b_	VDD	 GND  INV2
XaND1	a_	b	lt_	 VDD  GND	aND
XaND2	a	b_	gt_	 VDD  GND	aND
XNOR1	lt_	gt_	eq_	 VDD  GND	NOR
XbUF1	lt_	lt	VDD	 GND  bUF2
XbUF2	gt_	gt	VDD	 GND  bUF2
XbUF3	eq_	eq	VDD	 GND  bUF
.ENDS
XCOMP	a	b	lt	eq	gt	VDD	GND	COMP

*cload
cload1 lt gnd 2p 
cload2 eq gnd 2p 
cload3 gt gnd 2p 

*square wave
Va 	 a  0  pulse(1.8 0  1n  0.5n  0.5n   2n  	5n)
Vb 	 b  0  pulse(1.8 0  1n  0.5n  0.5n   4.5n  10n)

.tran  0.05n 15n

*delay
.meas tran delay_0_f trig v(a)    val=0.9 RISE=1
+                  targ v(eq)  val=0.9 FaLL=1
.meas tran delay_1_r trig v(a)    val=0.9 FaLL=2
+                  targ v(lt)  val=0.9 RISE=1
.meas tran delay_1_f trig v(a)    val=0.9 RISE=2
+                  targ v(lt)  val=0.9 FaLL=1
.meas tran delay_2_r trig v(a)    val=0.9 RISE=2
+                  targ v(eq)  val=0.9 RISE=1
.meas tran delay_3_r trig v(a)    val=0.9 RISE=1
+                  targ v(gt)  val=0.9 RISE=1
.meas tran delay_3_f trig v(a)    val=0.9 FaLL=2
+                  targ v(gt)  val=0.9 FaLL=1
.end
