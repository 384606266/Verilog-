//File?tb_ALU.v

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