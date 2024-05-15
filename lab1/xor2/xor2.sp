2-input XOR (loading c=0.01p)
.option post=2
.prot
.lib 'cic018.l' tt
.unprot
.global vdd gnd

.subckt inv in out
mp1 out in vdd vdd p_18 l=0.18u w='2*k'
mn1 out in gnd gnd n_18 l=0.18u w='k'
.ends

.subckt xor a b out
xinva a aout inv
xinvb b bout inv

mp1 net0 a    vdd    vdd p_18 l=0.18u w='2*k'
mp2 out  bout net0   vdd p_18 l=0.18u w='2*k'
mp3 net1 aout vdd    vdd p_18 l=0.18u w='2*k'
mp4 out  b    net1   vdd p_18 l=0.18u w='2*k'
mn1 out  aout net2   gnd n_18 l=0.18u w='k'
mn2 net2 bout gnd    gnd n_18 l=0.18u w='k'
mn3 out  a    net3   gnd n_18 l=0.18u w='k'
mn4 net3 b    gnd    gnd n_18 l=0.18u w='k'
.ends

xxor2 a b out xor
c1 out gnd 0.01p

vvdd vdd 0 1.8
vgnd gnd 0 0

vin in 0 pulse(0 1.8 5n 0.01n 0.01n 2.49n 5n)
va a 0 pulse(0 1.8 5n 0.01n 0.01n 4.99n 10n)
vb b 0 pulse(0 1.8 5n 0.01n 0.01n 9.99n 20n)

.meas tran delayN trig v(a) val=0.9 fall=1
+ targ v(out) val=0.9 rise=1

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran 0.1n 50n (sweep k 0.3u 5u 0.1u)
.end
