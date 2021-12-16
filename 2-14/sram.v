//File?sram.v

`timescale 1ns/1ns

module sram( dout, din, addr, wr, rd, cs );
  output reg [7:0] dout;
  input [7:0] din,addr;
  input wr,rd,cs;
  
  reg [7:0] sram [255:0];
  
  always @(posedge wr) begin
    if (cs) sram[addr] <= din;
  end
  
  always @(rd) begin
    if (cs && !rd) dout <= sram[addr];
  end
  
endmodule  
    
    