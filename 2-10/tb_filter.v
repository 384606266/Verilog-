//File?tb_filter.v

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
