library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.all;
use work.deferred.all;

entity test_registers is
    generic (N: integer:=16; -- number of bits per word
             M: integer:=4); -- number of address bits (4 bc registers 0-15)
end entity test_registers;

architecture test of test_registers is
    signal clk: std_logic;
    signal RegWrite: std_logic; -- active high write enable
    signal rs: std_logic_vector (M-1 downto 0); -- rs register
    signal rt: std_logic_vector (M-1 downto 0); -- rt register
    signal rd: std_logic_vector (M-1 downto 0); -- WRITE RAM address
    signal DIN: std_logic_vector (N-1 downto 0); -- write data
    signal Q1: std_logic_vector (N-1 downto 0); -- read data
    signal Q2: std_logic_vector (N-1 downto 0); -- read data
begin

UUT: entity work.register_bank
    port map(
        clk => clk,
		RegWrite => RegWrite,
		rs => rs,
		rt => rt,
		rd => rd,
		DIN => DIN,
		Q1 => Q1,
		Q2 => Q2);

    
    process 
                -- Input value to DUT and comparison variables for readability in read loop.
        variable my_in     : std_logic_vector((N - 1) downto 0):= (others => '0');
        variable x : std_logic_vector((N - 1) downto 0):= (others => '0');
        variable y : std_logic_vector((N - 1) downto 0):= (others => '0');
    
    begin
          
        for reg_num in 0 to ((2**M) - 1) loop
        
            my_in := std_logic_vector(to_unsigned(((2**M) - 1) - reg_num, N));
            DIN <= my_in;
            
            rd <= std_logic_vector(to_unsigned(reg_num, M));
            
            RegWrite <= '1';
            
            wait for 25 ns;
            RegWrite <= '0';
            wait for 25 ns;
            
        end loop;
        
        for reg_num in 0 to ((2**M) - 1) loop
        
            x := std_logic_vector(to_unsigned(((2**M) - 1) - reg_num, N));
            y := std_logic_vector(to_unsigned(reg_num, N));
            
            rs <= std_logic_vector(to_unsigned(reg_num, M));
            rt <= std_logic_vector(to_unsigned(((2**M) - 1) - reg_num, M));
            
            rd <= std_logic_vector(to_unsigned(reg_num, M));
            
            wait for 25 ns;
        
            assert(Q1 = x)
                report "Output data on port 1 not set correctly."
                severity FAILURE;
            
            assert(Q2 = y)
                report "Output data on port 2 not set correctly."
                severity FAILURE;
        
        end loop; 
        
        wait;
    end process;

end test;
