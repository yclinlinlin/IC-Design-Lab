# 112-2-IC-Design-Lab Practice 5

- 可參考 Lab6-1 與 Lab5
- delay time 全部符合
- **注意:**
  
    *VCLK    CLK  GND    PULSE(VL　VH　delay　trise　tfall　 pulse_width　period)

    vclk　clk　0　　pulse(1.8　0　　1n　　0.5n　0.5n　9.5n　　　　　20n)
    > tfall+pulse_width=period/2 
    >
    > 即0.5n+9.5n= 20n/2 =10n
- 備註: 
    - 助教要求 delay time 需測量圖中的 s 與 Co
    - delay time 全部符合
    - p5_old.sp 僅各找到4個delay
- 題目與節點
    > ![alt text](p5_node.jpg)
- delay time
    > p5.sp
    > ![alt text](p5_delay.png)
    > p5_old.sp
    > ![alt text](p5_delay_old.png)
- 波型
    > p5.sp
    > ![alt text](p5_wave.png)
    > p5_old.sp
    > ![alt text](p5_wave_old.png)
