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
    
      