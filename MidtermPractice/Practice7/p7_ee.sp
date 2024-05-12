Miderm_Pratice_Seven

*Pseudo_Comparator

.PROT
.LIB 'cic018.l' TT
.UNPROT
.GLOBAL VSS VDD

VDD VDD 0 1.8
VSS VSS 0 0

.SUBCKT INV Vin Vout
 MP0 Vout VSS VDD VDD P_18 L=0.18u W=0.5u
 MN0 Vout Vin VSS VSS N_18 L=0.18u W=1.0u
.ENDS

X0 A Abar INV
X1 B Bbar INV

.SUBCKT NAND_A_BIGGER In1 In2 Vbar Vout 
MP0   Vbar  VSS  VDD  VDD  P_18  L=0.18u  W=0.5u
MN0   Vbar  In1  n0   VSS  N_18  L=0.18u  W=2.0u
MN1    n0   In2  VSS  VSS  N_18  L=0.18u  W=2.0u

MPINV Vout  VSS  VDD  VDD  P_18  L=0.18u  W=1.60u
MNINV Vout  Vbar VSS  VSS  N_18  L=0.18u  W=1.245u   
.ENDS

.SUBCKT NAND_B_BIGGER In1 In2 Vbar Vout 
MP0   Vbar  VSS  VDD  VDD  P_18  L=0.18u  W=0.5u
MN0   Vbar  In1  n0   VSS  N_18  L=0.18u  W=2.0u
MN1    n0   In2  VSS  VSS  N_18  L=0.18u  W=2.0u

MPINV Vout  VSS  VDD  VDD  P_18  L=0.18u  W=1.50u
MNINV Vout  Vbar VSS  VSS  N_18  L=0.18u  W=1.225u   
.ENDS

.SUBCKT Exclusive In0 In1 In2 In3 Vbar Vout
MP0 Vbar VSS VDD VDD P_18 L=0.18u W=0.5u
MN0 Vbar In0 n0  VSS N_18 L=0.18u W=2.0u
MN1  n0  In1 VSS VSS N_18 L=0.18u W=2.0u
MN2 Vbar In2 n1  VSS N_18 L=0.18u W=2.0u
MN3  n1  In3 VSS VSS N_18 L=0.18u W=2.0u

MPINV Vout  VSS  VDD  VDD  P_18  L=0.18u  W=1.665u
MNINV Vout  Vbar VSS  VSS  N_18  L=0.18u  W=1.32u
.ENDS
  
X2 Abar B B_BIGGER_BAR B_BIGGER NAND_B_BIGGER
X3 Bbar A A_BIGGER_BAR A_BIGGER NAND_A_BIGGER
X4 A_BIGGER B_BIGGER A_BIGGER_BAR B_BIGGER_BAR Equal_BAR Equal Exclusive

C0 B_BIGGER VSS 0.5p
C1 A_BIGGER VSS 0.5p
C2 Equal    VSS 0.5p

VA   A  0   pulse(1.8	0  1n  0.5n  0.5n  19.5n    40n)
VB   B  0   pulse(1.8	0  1n  0.5n  0.5n   9.5n    20n)

.MEAS tran gt_delay10    trig v(B)          val=0.9 FALL = 2
+                        targ v(A_BIGGER)   val=0.9 RISE = 1

.MEAS tran gt_delay11    trig v(B)          val=0.9 RISE = 2
+                        targ v(A_BIGGER)   val=0.9 FALL = 1

.MEAS tran lt_delay01    trig v(B)          val=0.9 RISE = 1
+                        targ v(B_BIGGER)   val=0.9 RISE = 1

.MEAS tran lt_delay10    trig v(B)          val=0.9 FALL = 2
+                        targ v(B_BIGGER)   val=0.9 FALL = 1

.MEAS tran eq_delay11    trig v(B)          val=0.9 RISE = 2
+                        targ v(Equal)      val=0.9 RISE = 1

.MEAS tran eq_delay01    trig v(B)          val=0.9 RISE = 1
+                        targ v(Equal)      val=0.9 FALL = 1


.MEAS tran pw avg power

.OPTION post = 2

.TRAN	0.05n	40n

.END

