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