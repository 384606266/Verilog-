// File: mux4x1.v
`include "mux2x1.v"

module mux4x1(dout, sel, din);
    output dout;
    input [1:0] sel;
    input [3:0] din;
    
    wire t1,t2;
    
    mux2x1 a(t1,sel[0],din[1:0]),
           b(t2, sel[0], din[3:2]),
           c(dout, sel[1], {t1, t2});
           
endmodule