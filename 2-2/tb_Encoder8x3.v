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
  
  
