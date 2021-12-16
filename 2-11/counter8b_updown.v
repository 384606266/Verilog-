//File?counter8b_updown.v

`timescale 1ns/1ns

module counter8b_updown(count,clk,reset,dir);
  input clk,reset,dir;
  output reg [7:0] count;
  
  always @(posedge clk) begin
    if (reset) count <= 8'b0;
    else begin
      count <=(dir)? (count + 8'b1) : (count - 8'b1);
    end
  end
  
endmodule
