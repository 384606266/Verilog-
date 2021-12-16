//File?tb_LFSR.v

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
  