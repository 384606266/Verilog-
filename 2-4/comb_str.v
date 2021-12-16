// File: comb_str.v

module comb_str(Y,A,B,C,D);
  output Y;
  input A,B,C,D;
  
  wire S1,S2,S3,S4,S5;
  
  or (S1,A,D);
  not (S2,S1),
      (S3,D);
  and (S4,B,C,S3),
      (S5,S4,S2);
  buf (Y,S5);

endmodule  
