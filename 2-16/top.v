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
      
  
  
  
