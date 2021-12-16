library verilog;
use verilog.vl_types.all;
entity LFSR is
    port(
        q               : out    vl_logic_vector(1 to 26);
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        load            : in     vl_logic;
        din             : in     vl_logic_vector(1 to 26)
    );
end LFSR;
