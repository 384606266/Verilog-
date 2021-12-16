library verilog;
use verilog.vl_types.all;
entity testbech_comb is
    generic(
        STEP            : integer := 16
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of STEP : constant is 1;
end testbech_comb;
