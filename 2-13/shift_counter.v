//File?shift_counter.v

`timescale 1ns/1ns

module shift_counter(count,clk,reset);
  input clk,reset;
  output reg [7:0] count;
  
  reg dir;
  
  always @(posedge clk) begin
    if (reset) begin
      count <= 8'd1;
      dir <= 1;
    end
    else begin
      if (dir) count <= count << 1;
      else count <= count >> 1;
    end
  end
  
  always @ ( posedge count[0] ) begin
    dir <= 1'b1;
  end

  always @ ( posedge count[7] ) begin
   dir <= 1'b0;
  end
  
endmodule
      
