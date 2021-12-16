//File: mealy.v ?????

`timescale 1ns/1ns

module mealy(flag, din, clk, rst);
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
  
  reg [3:0] state;
  
  always @(posedge clk) begin
    if (rst) begin
      flag <= 0;
      state <= S0;
    end
    else begin
      case (state)
        S0: begin state <= (din)? S0:S1; flag<=0;end
        S1: begin state <= (din)? S2:S1; flag<=0;end
        S2: begin state <= (din)? S0:S3; flag<=0;end
        S3: begin state <= (din)? S4:S1; flag<=0;end
        S4: begin state <= (din)? S0:S5; flag<=0;end
        S5: begin state <= (din)? S6:S1; flag<=0;end
        S6: begin state <= (din)? S0:S7; flag<=0;end
        S7: if (din) begin state <= S6; flag <= 1;end
            else begin state <= S1; flag<= 0; end
        default:  begin state <= S0; flag <= 0; end
      endcase
    end
  end
  
endmodule
        
         
  
  
  
  
