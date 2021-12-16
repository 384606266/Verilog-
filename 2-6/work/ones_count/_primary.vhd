library verilog;
use verilog.vl_types.all;
entity ones_count is
    generic(
        SIZE            : integer := 8
    );
    port(
        count           : out    vl_logic_vector(3 downto 0);
        dat_in          : in     vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SIZE : constant is 1;
end ones_count;
