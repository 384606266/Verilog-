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