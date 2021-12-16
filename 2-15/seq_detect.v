//File?seq_detect.v

`timescale 1ns/1ns

module seq_detect(flag,din,clk,rst_n);
  output reg flag;
  input clk,rst_n,din;
  
  parameter S0 = 3'b000;    //default
  parameter S1 = 3'b001;    //state_1
  parameter S2 = 3'b010;    //state_2
  parameter S3 = 3'b011;    //state_3
  parameter S4 = 3'b100;    //state_4
  
  reg [2:0] state1;   //1101
  reg [2:0] state2;   //0110
  reg flag1,flag2;
  
  always @(*) flag <= flag1 | flag2;
  
  always @(negedge clk) begin
    if (!rst_n) begin
      flag1 <= 0;
      state1 <= S0;
    end
    else begin
      flag1 <= (state1 == S4) ? 1'b1 : 1'b0;
      case(state1)
        S0: state1 <= (din)? S1:S0;
        S1: state1 <= (din)? S2:S0;
        S2: state1 <= (din)? S2:S3;
        S3: state1 <= (din)? S4:S0;
        S4: state1 <= (din)? S2:S0;
        default: begin state1 <= S0; flag1 <= 0; end
      endcase
    end
  end
  
  always @(negedge clk) begin
    if (!rst_n) begin
      flag2 <= 0;
      state2 <= S0;
    end
    else begin
      flag2 <= (state2 == S4) ? 1'b1 : 1'b0;
      case(state2)
        S0: state2 <= (din)? S0:S1;
        S1: state2 <= (din)? S2:S1;
        S2: state2 <= (din)? S3:S1;
        S3: state2 <= (din)? S0:S4;
        S4: state2 <= (din)? S2:S1;
        default: begin state2 <= S0; flag2 <= 0; end
      endcase
    end
  end
      
endmodule      
