//File comb_str.v

`timescale 1ns/1ns

module comb_str(y,sel,A,B,C,D);
  output y;
  input sel,A,B,C,D;
  
  wire s1,s2;
  
  nand #(3) a(s1,A,B);
  nand #(4) b(s2,C,D);
  bufif1 c(y,s2,sel);
  bufif0 d(y,s1,sel);
  
endmodule
