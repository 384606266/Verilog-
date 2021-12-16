//File: moore.v ?????

`timescale 1ns/1ns

module moore(flag, din, clk, rst);
  input din,clk,rst;
  output reg flag;
  
  parameter S0 = 4'b0000;
  parameter S1 = 4'b0001;
  parameter S2 = 4'b0010;
  parameter S3 = 4'b0011;
  parameter S4 = 4'b0100;
  parameter S5 = 4'b0101;
  parameter S6 = 4'b0110;
  parameter S7 = 4'b0111;
  parameter S8 = 4'b1000;
  
  reg [3:0] state;
  
  always @(posedge clk) begin
    if (rst) begin
      flag <= 0;
      state <= S0;
    end
    else begin
      flag <= (state == S8) ? 1'b1 : 1'b0;
      case (state)
        S0: state <= (din)? S0:S1;
        S1: state <= (din)? S2:S1;
        S2: state <= (din)? S0:S3; 
        S3: state <= (din)? S4:S1; 
        S4: state <= (din)? S0:S5; 
        S5: state <= (din)? S6:S1;
        S6: state <= (din)? S0:S7;
        S7: state <= (din)? S8:S1;
        S8: state <= (din)? S0:S7;
        default:  begin state <= S0; flag <= 1'b0; end
      endcase
    end
  end
  
endmodule
