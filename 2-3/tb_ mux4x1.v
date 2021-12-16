// File: tb_mux4x1.v

`include "mux4x1.v"

module tb_mux4x1;
  wire dout;
  reg [1:0] sel;
  reg [3:0] din;
  
  mux4x1 a(dout,sel,din);
  
  initial begin
    din = 4'b0001;
    sel = 2'b00;
    repeat(3) #1 sel = sel + 1;
    repeat(3) 
    begin
      #1 din = din << 1;
      sel = 2'b00;
      repeat(3) #1 sel = sel + 1;
    end
  end
  
  initial begin
    $monitor("At time %4t, din=%b, sel=%b, dout=%b",$time, din, sel, dout);
  end

endmodule