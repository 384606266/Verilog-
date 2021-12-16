<h1 align = "center">数字系统设计作业</h1>

<h4 align = "center"> 学号:591030910124 &emsp; 姓名：郭进尧 &emsp; 日期：2021.12.16</h4> 

#### 第1题

##### （1）设计模块

###### `wavegen` 模块

```verilog
// File: wavegen.v

`timescale 1 ns / 1 ns

module wavegen;

    reg clk;

    initial begin
        clk = 1'b0;
        #2 clk = 1'b1;
        #1 clk = 1'b0;
        #9 clk = 1'b1;
        #10 clk = 1'b0;
        #2 clk = 1'b1;
        #3 clk = 1'b0;
        #5 clk = 1'b1;
    end

endmodule
```

##### （3）测试波形图

<img src="D:\GuoJinyao\homework\2-1\img.png" style="zoom:50%;" />



#### 第2题

##### （1）设计模块

###### `Encoder8x3` 模块

```verilog
//File: Encoder8x3.v

`timescale 10 ns / 1 ns

module Encoder8x3(code, data);
  input [7:0] data;
  output reg [2:0] code;
  
  always @(data)
  begin
    case(data)
      8'b0000_0001: code <= 3'd0;
      8'b0000_0010: code <= 3'd1;
      8'b0000_0100: code <= 3'd2;
      8'b0000_1000: code <= 3'd3;
      8'b0001_0000: code <= 3'd4;
      8'b0010_0000: code <= 3'd5;
      8'b0100_0000: code <= 3'd6;
      8'b1000_0000: code <= 3'd7;
    endcase
  end
  
endmodule
```

##### （2）测试模块

###### `tb_Encoder8x3` 测试模块

```verilog
//File: tb_Encoder8x3.v

`timescale 10 ns / 1 ns

`include "encoder8x3.v"

module tb_Encoder8x3;
  
  wire [2:0] code;
  reg [7:0] data;
  
  Encoder8x3 a(.data(data), .code(code));
  
  initial
  begin
    data = 8'b0000_0001;
    repeat(7) #1 data = data << 1;
  end
  
  initial
  $monitor("At time %4t, data=%b, code=%d",$time, data, code);
  
endmodule
```

##### （3）测试波形图

<img src="D:\GuoJinyao\homework\2-2\img1.png" style="zoom:50%;" />



#### 第3题

##### （1）设计模块

###### `mux2x1` 模块

```verilog
// File: mux2x1.v

module mux2x1(dout, sel, din);

    output dout;
    input sel;
    input [1:0] din;

    bufif0 (dout, din[0], sel);
    bufif1 (dout, din[1], sel);

endmodule
```



###### `mux4x1` 模块

```verilog
// File: mux4x1.v
`include "mux2x1.v"

module mux4x1(dout, sel, din);
    output dout;
    input [1:0] sel;
    input [3:0] din;
    
    wire t1,t2;
    
    mux2x1 a(t1,sel[0],din[1:0]),
           b(t2, sel[0], din[3:2]),
           c(dout, sel[1], {t1, t2});
           
endmodule
```

##### （2）测试模块

###### `tb_mux2x1` 测试模块

```verilog
// File: tb_mux2x1.v

`include "mux2x1.v"

module tb_mux2x1();
  wire dout;
  reg [1:0] din;
  reg sel;
  
  mux2x1 a(dout,sel,din);
  
  initial begin
    sel = 1'b0;
    repeat(1) #1 sel = sel + 1'b1;
  end
  
  initial begin
    din = 2'b01;
  end
  
  initial begin
    $monitor("At time %4t, din=%b, sel=%b, dout=%b", $time, din, sel, dout);
  end
  
endmodule
```



###### `tb_mux4x1` 测试模块

```verilog
// File: tb_mux4x1.v

`include "mux4x1.v"

module tb_mux4x1();
  wire dout;
  reg [1:0] sel;
  reg [3:0] din;
  
  mux4x1 a(dout,sel,din);
  
  initial begin
    din = 4'b0001;
    sel = 2'b00;
    repeat(3) #1 sel = sel + 1;
    repeat(3) 
    begin
      #1 din = din << 1;
      sel = 2'b00;
      repeat(3) #1 sel = sel + 1;
    end
  end
  
  initial begin
    $monitor("At time %4t, din=%b, sel=%b, dout=%b",$time, din, sel, dout);
  end

endmodule
```

##### （3）测试波形图

###### mux2x1 波形图

<img src="D:\GuoJinyao\homework\2-3\img2.png" style="zoom: 40%;" />



###### mux4x1 波形图

<img src="D:\GuoJinyao\homework\2-3\img.png" style="zoom: 50%;" />



#### 第4题

##### （1）设计模块

###### `comb_str` 模块

```verilog
// File: comb_str.v

module comb_str(Y,A,B,C,D);
  output Y;
  input A,B,C,D;
  
  wire S1,S2,S3,S4,S5;
  
  or (S1,A,D);
  not (S2,S1),
      (S3,D);
  and (S4,B,C,S3),
      (S5,S4,S2);
  buf (Y,S5);

endmodule  
```



###### `comb_dataflow` 模块

```verilog
// File: comb_dataflow.v

module comb_dataflow(Y,A,B,C,D);
  output Y;
  input A,B,C,D;
  
  assign Y = ~(A | D) & (B & C & (~D));
  
endmodule
```



###### `comb_behavior` 模块

```verilog
// File: comb_behavior.v

module comb_behavior(Y,A,B,C,D);
  output reg Y;
  input A,B,C,D;
  
  always @ ( * ) begin
    Y = ~(A | D) & (B & C & ~D);
  end

endmodule
```



###### `comb_prim` 模块

```verilog
// File: comb_prim.v

primitive comb_prim(Y, A, B, C, D);

    output Y;
    input A, B, C, D;

    table
    //  A  B  C  D : Y ;
        0  0  ?  ? : 0 ;
        0  1  0  ? : 0 ;
        0  1  1  0 : 1 ;
        0  1  1  1 : 0 ;
        1  ?  ?  ? : 0 ;
    endtable

endprimitive
```

##### （2）测试模块

###### `testbech_comb` 测试模块

```verilog
// File: testbech_comb.v

`include "comb_str.v"
`include "comb_dataflow.v"
`include "comb_behaviour.v"
`include "comb_prim.v"

module testbech_comb;

    parameter STEP = 16;
    integer k;

    wire Y1, Y2, Y3, Y4;
    reg A, B, C, D;

    comb_str a(Y1, A, B, C, D);
    comb_dataflow b(Y2, A, B, C, D);
    comb_behaviour c(Y3, A, B, C, D);
    comb_prim d(Y4, A, B, C, D);

    initial begin
        {A, B, C, D} = 4'b0;
        for ( k=1; k<STEP; k=k+1 )
            #1 {A, B, C, D} = {A, B, C, D} + 1'b1;
    end

    initial begin
        $monitor("At time %4t, A=%b, B=%b, C=%b, D=%b, Y1=%b, Y2=%b, Y3=%b, Y4=%b",
                    $time, A, B, C, D, Y1, Y2, Y3, Y4);
    end

endmodule
```

##### （3）测试波形图

![](D:\GuoJinyao\homework\2-4\2-4-1.png)



##### （4）控制台输出

<img src="D:\GuoJinyao\homework\2-4\2-4-2.png" style="zoom: 80%;" />



#### 第5题

##### （1）设计模块

###### `comb_Y1` 模块

```verilog
// File: comb_Y1.v

module comb_Y1(Y, A, B, C);

    output Y;
    input A, B, C;

    assign Y = (~A & ~B & C) | (~A & B & ~C) |
                (A & ~B & ~C) | (A & ~B & C);

endmodule
```



###### `comb_Y2` 模块

```verilog
// File: comb_Y2.v

module comb_Y2(Y, A, B, C, D);

    output Y;
    input A, B, C, D;

    assign Y = (~A & B & ~C & ~D) | (~A & B & ~C & D) |
                (~A & B & C & ~D) | (~A & B & C & D) |
                (A & ~B & C & D) | (A & B & ~C & ~D) |
                (A & B & ~C & D);

endmodule
```

##### （2）测试模块

###### `tb_comb_Y1` 模块

```verilog
// File: tb_comb_Y1.v

`include "comb_Y1.v"

module tb_comb_Y1;
    wire Y;
    reg A, B, C;

    comb_Y1 a(Y, A, B, C);

    initial begin
        {A, B, C} = 3'b0;
        repeat(7) #1 {A, B, C} = {A, B, C} + 1'b1;
    end

    initial begin
        $monitor("At time %4t, A=%b, B=%b, C=%b, Y=%b",$time, A, B, C, Y);
    end

endmodule
```



###### `tb_comb_Y2` 模块

```verilog
// File: tb_comb_Y2.v

`include "comb_Y2.v"

module tb_comb_Y2;
    wire Y;
    reg A, B, C, D;

    comb_Y2 a(Y, A, B, C, D);

    initial begin
        {A, B, C, D} = 4'b0;
        repeat(15)  #1 {A, B, C, D} = {A, B, C, D} + 1'b1;
    end

    initial begin
        $monitor("At time %4t, A=%b, B=%b, C=%b, D=%b, Y=%b",$time, A, B, C, D, Y);
    end

endmodule
```

##### （3）测试结果

###### `tb_comb_Y1` 测试结果

<img src="D:\GuoJinyao\homework\2-5\img1.png" style="zoom: 50%;" />



###### `tb_comb_Y2` 测试结果

<img src="D:\GuoJinyao\homework\2-5\img2.png" style="zoom:50%;" />



#### 第6题

##### （1）设计模块

###### `ones_count` 模块

```verilog
//File: ones_count.v

`timescale 1ns / 1ns

module ones_count(count, dat_in);
  input [7:0] dat_in;
  output reg [3:0] count;
  
  parameter SIZE = 8;
  integer k;
  
  always @(*) begin
    count = 4'b0;
    for(k=0;k<SIZE; k = k+1) begin
      count = count + dat_in[k];
    end
  end
  
endmodule
```

##### （2）测试模块

###### `tb_ones_count` 测试台模块

```verilog
//File: tb_ones_count.v

`timescale 1ns / 1ns
`include "ones_count.v"

module tb_ones_count();
  wire [3:0] count;
  reg [7:0] dat_in;
  
  parameter SIZE = 8;
  integer k;
  
  ones_count a(.count(count), .dat_in(dat_in));
  
  initial begin
    dat_in = 8'b0;
    for(k=0;k<SIZE; k = k+1) begin
      #1 dat_in[k] = 1;
    end
 end
 
 initial begin
 $monitor("At time %4t, dat_in=%b, count=%b",
          $time, dat_in, count);
  end
  
endmodule
```

##### （3）测试结果

<img src="D:\GuoJinyao\homework\2-6\img1.png" style="zoom:50%;" />



#### 第7题

##### （1）设计模块

###### `dec_counter` 模块

```verilog
//File dec_counter.v

`timescale 1ns / 1ns

module dec_counter(count,clk,reset);
  input clk,reset;
  output reg [3:0] count;
  
  always @(posedge clk) begin
    if (reset) count <= 4'd0;
    else begin
      case (count)
        4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,
        4'd7,4'd8,4'd9: count <= count + 1;
        4'd10 : count <= 4'd0;
        default: count <= 4'd0;
      endcase
    end
  end
  
endmodule
```

##### （2）测试模块

###### `tb_dec_counter` 模块

```verilog
//File tb_dec_counter.v

`include "dec_counter.v"

`timescale 1ns / 1ns

module tb_dec_counter();
  wire [3:0] count;
  reg clk, reset;
  
  dec_counter a(.count(count), .clk(clk), .reset(reset));
  
  initial begin : clk_loop
    clk = 0;
    forever #10 clk = ~clk;
  end
  
  initial begin
    reset = 1;
    #50 reset = 0;
  end
  
  initial begin
    $monitor("At time %4t, reset=%b, count=%d",
              $time, reset, count);
  end
  
  initial #400 disable clk_loop;

endmodule
```

##### （3）测试结果

<img src="D:\GuoJinyao\homework\2-7\img1.png" style="zoom:50%;" />



#### 第8题

##### （1）设计模块

###### `comb_str` 模块

```verilog
//File comb_str.v

`timescale 1ns/1ns

module comb_str(y,sel,A,B,C,D);
  output y;
  input sel,A,B,C,D;
  
  wire s1,s2;
  
  nand #(3) a(s1,A,B);
  nand #(4) b(s2,C,D);
  bufif1 c(y,s2,sel);
  bufif0 d(y,s1,sel);
  
endmodule
```

##### （2）测试模块

###### `tb_comb_str` 模块

```verilog
//File tb_comb_str.v

`timescale 1ns/1ns

`include "comb_str.v"

module tb_comb_str();
  reg A,B,C,D,sel;
  wire y;
  
  comb_str a(y,sel,A,B,C,D);
  
  initial begin
    sel = 1'b0;
    #50 sel = 1'b1;
  end
  
  initial begin
    {A,B,C,D} = 4'b0;
    repeat(100) #2 {A,B,C,D} = {A,B,C,D} + 1;
  end
  
  initial begin
    $monitor("At time %4t, sel=%b, A=%b, B=%b, C=%b, D=%b, y=%b",
              $time, sel, A, B, C, D, y);
  end

endmodule
```

##### （3）测试结果

<img src="D:\GuoJinyao\homework\2-8\img.png" style="zoom:50%;" />



#### 第9题

##### （1）设计模块

###### `LFSR` 模块

```verilog
//File: LFSR.v

`timescale 1ns/1ns

module LFSR(output reg [1:26] q,  // 26 bit data output.
            input clk,            // Clock input.
            input rst_n,          // Synchronous reset input
            input load,           // Synchronous load input.
            input [1:26] din      // 26 bit parallel data input.
            );      
    
  always @(posedge clk) begin
    if (!rst_n)  q <= 26'b0;
    else begin
      if (load) q <= |din? din : 26'b1;
      else begin
        if (q == 26'b0) q <= 26'b1;
        else begin
         q <= q << 1;
         q[26] <= q[26]+q[8]+q[7]+q[1]+1'b1;
        end
      end
    end
  end

endmodule
```

##### （2）测试模块

###### `tb_LFSR` 模块

```verilog
//File: tb_LFSR.v

`timescale 1ns/1ns

`include "LFSR.v"

module tb_LFSR();
  wire [1:26] q;
  reg clk, rst_n, load;
  reg [1:26] din;
  
  LFSR a(q,clk,rst_in,load,din);
  
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    rst_n = 1'b0;
    #20 rst_n = 1'b1;
  end
  
  initial begin
    load = 1'b0;
    din = 26'b1_1010;
    #50 load = 1'b1;
    #20 load = 1'b0;
  end

  initial begin
    $monitor("At time %4t, rst_n=%b, load=%b, q=%b",
              $time, rst_n, load, q);
  end

endmodule
```

##### （3）测试结果

###### 测试波形图

<img src="D:\GuoJinyao\homework\2-9\img1.png" style="zoom: 50%;" />

###### 测试结果

<img src="D:\GuoJinyao\homework\2-9\img2.png" style="zoom:50%;" />



#### 第10题

##### （1）设计模块

###### `filter` 模块

```verilog
//File: filter.v

`timescale 1ns/1ns

module filter(sig_out,clock,reset,sig_in);
  output reg sig_out;
  input sig_in,clock,reset;
  
  reg [1:4] D;
  wire J,K;
  assign J = &D[2:4];
  assign K = &(~D[2:4]);
  
  always @(posedge clock) begin
    if(!reset) D <= 4'd0;
    else begin
      D[1:4] <= {sig_in,D[1:3]};
    end
  end
  
  always @(posedge clock) begin
    if(!reset) sig_out <= 1'b0;
    else begin
      case ({J,K})
        2'b00: sig_out <= sig_out;
        2'b01: sig_out <= 1'b0;
        2'b10: sig_out <= 1'b1;
        2'b11: sig_out <= ~sig_out;
        default: sig_out <= 1'bx;
      endcase
    end
  end
  
endmodule
```

##### （2）测试模块

###### `tb_filter` 模块

```verilog
//File: tb_filter.v

`timescale 1ns/1ns

`include "filter.v"

module tb_filter();
  wire sig_out;
  reg sig_in,clock,reset;
  
  filter a(sig_out,clock,reset,sig_in);
  
  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock;
  end
  
  initial begin
    reset = 0;
    #100 reset = 1;
    #200 reset = 0;
  end
  
  initial begin
    sig_in = 1'b1;
    forever #10 sig_in = $random % 2;
  end
  
endmodule
```

##### （3）测试波形图

<img src="D:\GuoJinyao\homework\2-10\img.png" style="zoom:50%;" />



#### 第11题

##### （1）设计模块

###### `counter8b_updown` 模块

```verilog
//File: counter8b_updown.v

`timescale 1ns/1ns

module counter8b_updown(count,clk,reset,dir);
  input clk,reset,dir;
  output reg [7:0] count;
  
  always @(posedge clk) begin
    if (reset) count <= 8'b0;
    else begin
      count <=(dir)? (count + 8'b1) : (count - 8'b1);
    end
  end
  
endmodule
```

##### （2）测试模块

###### `tb_counter8b_updown` 模块

```verilog
//File: tb_counter8b_updown.v

`timescale 1ns/1ns

`include "counter8b_updown.v"

module tb_counter8b_updown();
  wire [7:0] count;
  reg clk,reset,dir;
  
  counter8b_updown a(count, clk, reset, dir);
  
  initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
  end
  
  initial begin
    reset = 1;
    #50 reset = 0;
  end
  
  initial begin
    dir = 1'b1;
    #150 dir = ~dir;
  end
  
  initial begin
    $monitor("At time %4t, reset=%b, dir=%b, count=%d",
              $time, reset, dir, count);
  end
  
endmodule
```

##### （3）测试结果

<img src="D:\GuoJinyao\homework\2-11\img.png" style="zoom:50%;" />



#### 第12题

##### （1）设计模块

###### `ALU` 模块

```verilog
//File: ALU.v

`timescale 1ns/1ns

module ALU(c_out, sum, oper, a, b, c_in);
  input [7:0] a,b;
  input c_in;
  input [2:0] oper;
  output reg [7:0] sum;
  output reg c_out;
  
  always @(*) begin
    case (oper)
      3'b000 : {c_out,sum} = a + b + c_in;    //and
      3'b001 : {c_out,sum} = a + ~b + c_in;   //subtract
      3'b010 : {c_out,sum} = b + ~a + ~c_in;  //subtract_a
      3'b011: {c_out, sum} = {1'b0, a | b};  // or_ab
      3'b100: {c_out, sum} = {1'b0, a & b};  // and_ab
      3'b101: {c_out, sum} = {1'b0, ~a & b}; // not_ab
      3'b110: {c_out, sum} = {1'b0, a ^ b};  // exor
      3'b111: {c_out, sum} = {1'b0, a ~^ b}; // exnor
      default: {c_out, sum} = 9'bx;
    endcase
  end
  
endmodule  
```

##### （2）测试模块

###### `tb_ALU` 模块

```verilog
//File: tb_ALU.v

`timescale 1ns/1ns

`include "ALU.v"

module tb_ALU();
  reg [7:0] a,b;
  reg c_in;
  reg [2:0] oper;
  wire [7:0] sum;
  wire c_out;
  
  ALU f(c_out, sum, oper, a, b, c_in);
  
  initial begin
    a = 8'b0011_1011;
    b = 8'b0110_0110;
    c_in = 1'b1;
    oper = 3'b0;
    repeat(7) #10 oper = oper + 1'b1;
  end
  
  initial begin
    $monitor("At time %4t, oper=%b, a=%b, b=%b, c_in=%b, c_out=%b, sum=%b,",
              $time, oper, a, b, c_in, c_out, sum);
  end
endmodule
```

##### （3）测试结果

<img src="D:\GuoJinyao\homework\2-12\img.png" style="zoom:50%;" />



#### 第13题

##### （1）设计模块

###### `shift_counter` 模块

```verilog
//File: shift_counter.v

`timescale 1ns/1ns

module shift_counter(count,clk,reset);
  input clk,reset;
  output reg [7:0] count;
  
  reg dir;
  
  always @(posedge clk) begin
    if (reset) begin
      count <= 8'd1;
      dir <= 1;
    end
    else begin
      if (dir) count <= count << 1;
      else count <= count >> 1;
    end
  end
  
  always @ ( posedge count[0] ) begin
    dir <= 1'b1;
  end

  always @ ( posedge count[7] ) begin
   dir <= 1'b0;
  end
  
endmodule
```

##### （2）测试模块

###### `tb_shift_counter` 模块

```verilog
//File: tb_shift_counter.v

`timescale 1ns/1ns

`include "shift_counter.v"

module tb_shift_counter();
  reg clk,reset;
  wire [7:0] count;
  
  shift_counter a(count, clk, reset );
  
  initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
  end
  
  initial begin
    reset = 1;
    #50 reset = 0;
  end
  
  initial begin
    $monitor("At time %4t, reset=%b, count=%b,",
              $time, reset, count);
  end
  
endmodule
```

##### （3）测试结果

<img src="D:\GuoJinyao\homework\2-13\img.png" style="zoom:50%;" />



#### 第14题

##### （1）设计模块

###### `sram` 模块

```verilog
//File: sram.v

`timescale 1ns/1ns

module sram( dout, din, addr, wr, rd, cs );
  output reg [7:0] dout;
  input [7:0] din,addr;
  input wr,rd,cs;
  
  reg [7:0] sram [255:0];
  
  always @(posedge wr) begin
    if (cs) sram[addr] <= din;
  end
  
  always @(rd) begin
    if (cs && !rd) dout <= sram[addr];
  end
  
endmodule 
```

##### （2）测试模块

###### `tb_sram` 模块

```verilog
//File: tb_sram.v

`timescale 1ns/1ns

`include "sram.v"

module tb_sram();
  reg [7:0] din,addr;
  wire [7:0] dout;
  reg wr,rd,cs;
  
  sram a( dout, din, addr, wr, rd, cs );
  
  initial begin
    cs = 1'b0;
    #10 cs = 1'b1;
  end

  initial begin
    din = 8'b1010_0101;
    addr = 8'b0101_1010;
    #100 addr = 8'b1010_0101;
  end

  initial begin
    wr = 1'b0;
    rd = 1'b1;
    forever begin
        #10;
        wr = $random % 2;
        rd = $random % 2;
    end
  end

  initial begin
    $monitor("At time %4t, din=%b, addr=%b, cs=%b, wr=%b, rd=%b, dout=%b",
              $time, din, addr, cs, wr, rd, dout);
  end

endmodule
```

##### （3）测试结果

<img src="D:\GuoJinyao\homework\2-14\img.png" style="zoom:50%;" />



#### 第15题

##### （1）设计模块

###### `seq_detect` 模块

```verilog
//File: seq_detect.v

`timescale 1ns/1ns

module seq_detect(flag,din,clk,rst_n);
  output reg flag;
  input clk,rst_n,din;
  
  parameter S0 = 3'b000;    //default
  parameter S1 = 3'b001;    //state_1
  parameter S2 = 3'b010;    //state_2
  parameter S3 = 3'b011;    //state_3
  parameter S4 = 3'b100;    //state_4
  
  reg [2:0] state1;   //1101
  reg [2:0] state2;   //0110
  reg flag1,flag2;
  
  always @(*) flag <= flag1 | flag2;
  
  always @(negedge clk) begin
    if (!rst_n) begin
      flag1 <= 0;
      state1 <= S0;
    end
    else begin
      flag1 <= (state1 == S4) ? 1'b1 : 1'b0;
      case(state1)
        S0: state1 <= (din)? S1:S0;
        S1: state1 <= (din)? S2:S0;
        S2: state1 <= (din)? S2:S3;
        S3: state1 <= (din)? S4:S0;
        S4: state1 <= (din)? S2:S0;
        default: begin state1 <= S0; flag1 <= 0; end
      endcase
    end
  end
  
  always @(negedge clk) begin
    if (!rst_n) begin
      flag2 <= 0;
      state2 <= S0;
    end
    else begin
      flag2 <= (state2 == S4) ? 1'b1 : 1'b0;
      case(state2)
        S0: state2 <= (din)? S0:S1;
        S1: state2 <= (din)? S2:S1;
        S2: state2 <= (din)? S3:S1;
        S3: state2 <= (din)? S0:S4;
        S4: state2 <= (din)? S2:S1;
        default: begin state2 <= S0; flag2 <= 0; end
      endcase
    end
  end
      
endmodule
```

##### （2）测试模块

###### `tb_seq_detect` 模块

```verilog
//File: tb_seq_detect.v

`timescale 1ns/1ns

`include "seq_detect.v"

module tb_seq_detect();
  reg din,clk,rst_n;
  wire flag;
  reg [31:0] data;
  
  seq_detect a(flag,din,clk,rst_n);
  
  initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
  end
  
  initial begin
    rst_n = 0;
    #50 rst_n = 1;
  end
  
  initial begin
    data = 32'b1100_0110_0100_0110_1010_0100_1010_0010;
    repeat(31) begin
      #20;
      din = data[31];
      data = data << 1;
    end
  end
    
endmodule
```

##### （3）测试波形图

![](D:\GuoJinyao\homework\2-15\img.png)

##### （4）状态转移图示

<img src="D:\GuoJinyao\homework\2-15\img2.jpg" style="zoom: 33%;" />



#### 第16题

##### （1）设计模块

###### `mealy` 模块

```verilog
//File: mealy.v  without a final state

`timescale 1ns/1ns

module mealy(flag, din, clk, rst);
  input din,clk,rst;
  output reg flag;
  
  parameter S0 = 4'b0000;
  parameter S1 = 4'b0001;
  parameter S2 = 4'b0010;
  parameter S3 = 4'b0011;
  parameter S4 = 4'b0100;
  parameter S5 = 4'b0101;
  parameter S6 = 4'b0110;
  parameter S7 = 4'b0111;
  
  reg [3:0] state;
  
  always @(posedge clk) begin
    if (rst) begin
      flag <= 0;
      state <= S0;
    end
    else begin
      case (state)
        S0: begin state <= (din)? S0:S1; flag<=0;end
        S1: begin state <= (din)? S2:S1; flag<=0;end
        S2: begin state <= (din)? S0:S3; flag<=0;end
        S3: begin state <= (din)? S4:S1; flag<=0;end
        S4: begin state <= (din)? S0:S5; flag<=0;end
        S5: begin state <= (din)? S6:S1; flag<=0;end
        S6: begin state <= (din)? S0:S7; flag<=0;end
        S7: if (din) begin state <= S6; flag <= 1;end
            else begin state <= S1; flag<= 0; end
        default:  begin state <= S0; flag <= 0; end
      endcase
    end
  end
```



###### `moore` 模块

```verilog
//File: moore.v with a final state

`timescale 1ns/1ns

module moore(flag, din, clk, rst);
  input din,clk,rst;
  output reg flag;
  
  parameter S0 = 4'b0000;
  parameter S1 = 4'b0001;
  parameter S2 = 4'b0010;
  parameter S3 = 4'b0011;
  parameter S4 = 4'b0100;
  parameter S5 = 4'b0101;
  parameter S6 = 4'b0110;
  parameter S7 = 4'b0111;
  parameter S8 = 4'b1000;
  
  reg [3:0] state;
  
  always @(posedge clk) begin
    if (rst) begin
      flag <= 0;
      state <= S0;
    end
    else begin
      flag <= (state == S8) ? 1'b1 : 1'b0;
      case (state)
        S0: state <= (din)? S0:S1;
        S1: state <= (din)? S2:S1;
        S2: state <= (din)? S0:S3; 
        S3: state <= (din)? S4:S1; 
        S4: state <= (din)? S0:S5; 
        S5: state <= (din)? S6:S1;
        S6: state <= (din)? S0:S7;
        S7: state <= (din)? S8:S1;
        S8: state <= (din)? S0:S7;
        default:  begin state <= S0; flag <= 1'b0; end
      endcase
    end
  end
  
endmodule
```

##### （2）测试模块

###### `top` 模块

```verilog
//File: top.v 

`timescale 1ns/1ns

`include "mealy.v"
`include "moore.v"

module top();
  reg clk,rst,din;
  wire mealy_flag, moore_flag;
  reg [31:0] data;
  
  moore a(moore_flag, din, clk, rst);
  mealy b(mealy_flag, din, clk, rst);
  
  initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
  end
  
  initial begin
    rst = 1'b1;
    #20 rst = 1'b0;
  end
  
  initial begin
    data = 32'b0110_1010_1010_0011_0110_0001_0101_0101;
    repeat(32) begin
      #20
      din = data[0];
      data = data >> 1;
    end
  end
  
  initial 
    $monitor("At time %4t, din=%b, rst=%b, moore_flag=%b, mealy_flag=%b ",
              $time, din, rst, moore_flag, mealy_flag); 
  
endmodule
```

##### （3）测试结果

![](D:\GuoJinyao\homework\2-16\img.png)

##### （4）状态转移图示

###### mealy——无最终状态

<img src="D:\GuoJinyao\homework\2-16\mealy.jpg" style="zoom: 45%;" />

###### moore——有最终状态

<img src="D:\GuoJinyao\homework\2-16\moore.png" style="zoom:45%;" />