//File?tb_counter8b_updown.v

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
