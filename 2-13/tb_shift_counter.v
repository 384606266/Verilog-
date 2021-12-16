//File?tb_shift_counter.v

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
            
    
