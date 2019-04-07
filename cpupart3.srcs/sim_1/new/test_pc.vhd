library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.all;

entity test_pc is
end test_pc;

architecture test of test_pc is
    signal CLK : std_logic := '0';  
    signal RST : std_logic := '0';
    signal pc : std_logic_vector(15 downto 0);
    signal pc_in : std_logic_vector(15 downto 0);
    
    signal counter : integer := 0;
begin

    UUT: entity work.pc
        port map(
            clk => clk,
            rst => rst,
            pc => pc,
            pc_in => pc_in);
    --  Port ( );
    
    CLK <= not CLK after 500 us;
    
    process(CLK) begin
        if rising_edge(CLK) then
            --pc <= std_logic_vector(unsigned(pc) + 1);
            pc_in <= std_logic_vector(to_unsigned(counter + 1, pc_in'length));
            counter <= counter + 1;
--            if (to_integer(unsigned(pc)) = 4095) then
            if (counter = 65536) then
                assert (to_integer(unsigned(pc)) = 65535) 
                     report "PC did not match count."
                     severity FAILURE;
            end if;
            if (counter = 65536) then
                assert (to_integer(unsigned(pc)) = 0) 
                    report "PC did not rollover."
                    severity FAILURE;
                
                assert (0 = 1)
                    report "Test complete."
                    severity FAILURE;
            end if;
        end if;
    end process;
end test;