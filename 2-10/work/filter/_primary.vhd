library verilog;
use verilog.vl_types.all;
entity filter is
    port(
        sig_out         : out    vl_logic;
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        sig_in          : in     vl_logic
    );
end filter;
