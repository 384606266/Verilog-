library verilog;
use verilog.vl_types.all;
entity mealy is
    generic(
        S0              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        S1              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        S2              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        S3              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        S4              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        S5              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1);
        S6              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0);
        S7              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1)
    );
    port(
        flag            : out    vl_logic;
        din             : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of S0 : constant is 1;
    attribute mti_svvh_generic_type of S1 : constant is 1;
    attribute mti_svvh_generic_type of S2 : constant is 1;
    attribute mti_svvh_generic_type of S3 : constant is 1;
    attribute mti_svvh_generic_type of S4 : constant is 1;
    attribute mti_svvh_generic_type of S5 : constant is 1;
    attribute mti_svvh_generic_type of S6 : constant is 1;
    attribute mti_svvh_generic_type of S7 : constant is 1;
end mealy;
