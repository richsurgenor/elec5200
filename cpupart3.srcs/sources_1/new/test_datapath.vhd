library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library work;
use work.all;

entity datapath_test_bench is
end datapath_test_bench;


architecture datapath_test of datapath_test_bench is

    signal read_data_bus : std_Logic_vector(15 downto 0);
    signal write_data_bus : std_logic_vector(15 downto 0);
    signal address_bus : std_logic_vector (15 downto 0);
    signal clk : std_logic := '0';
    signal instruction : std_logic_vector(15 downto 0) := "0000000000000000";
    signal pc_pointer : std_logic_vector(9 downto 0);
    signal data_memory_write_enable : std_logic;

begin

clk <= not clk after 50 ns;

UUT : entity work.toplevel
    port map(   data_read_bus => read_data_bus,
                instruction_read_bus => instruction,
                data_write_bus => write_data_bus,
                data_address_bus => address_bus,
                mem_write_enable => data_memory_write_enable,
                instruction_address_bus => pc_pointer,
                clk => clk
                );

    process
        -- Intermediate variables.
            variable reg_num            : std_logic_vector(3 downto 0);
            variable cond_num           : std_logic_vector(1 downto 0);
            
        -- Comparison variables.
        variable condition_compare  : std_logic_vector(1 downto 0);
        variable compare_value      : std_logic_vector(15 downto 0);
        variable pre_instruction_pc : std_logic_vector(9 downto 0);
    begin
    
    wait for 25 ns;
    
    
    instruction <= "0111" & "0000" & "0000" & "0001";
    
    wait for 100ns;
    
    end process;

end datapath_test;
