library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.all;
use work.deferred.all;

entity test_alu is
end test_alu;

architecture test of test_alu is
    signal clk : std_logic := '0';
    signal opcode : std_logic_vector(3 downto 0) ;
    signal input_a : std_logic_vector(15 downto 0);
    signal input_b : std_logic_vector(15 downto 0);
    signal result : std_logic_vector(15 downto 0);
    signal rst : std_logic := '0';

begin

UUT: entity work.alu
    port map(
        clk => clk,
        rst => rst,
        opcode => opcode,
        input_a => input_a,
        input_b => input_b,
        result => result);
        
    clk <= not clk after 500 us;
    
    process begin
        opcode <= ADD;
        input_a <= std_logic_vector(to_signed(1, input_a'length));
        input_b <= std_logic_vector(to_signed(2, input_a'length));
        wait for 1000us;
        assert (result = std_logic_vector(to_signed(3, input_a'length)))
            report "ADD failed."
            severity FAILURE;
            
        opcode <= SUB;
        input_a <= std_logic_vector(to_signed(2, input_a'length));
        input_b <= std_logic_vector(to_signed(3, input_a'length));
        wait for 1000us;
        assert (result = std_logic_vector(to_signed(-1, input_a'length)))
            report "SUB failed."
            severity FAILURE;            

        opcode <= ANDD;
        input_a <= std_logic_vector(to_signed(3, input_a'length));
        input_b <= std_logic_vector(to_signed(1, input_a'length));
        wait for 1000us;
        assert (result = std_logic_vector(to_signed(1, input_a'length)))
            report "ANDD failed."
            severity FAILURE;  	
	
        opcode <= ORR;
        input_a <= std_logic_vector(to_signed(16#1100#, input_a'length));
        input_b <= std_logic_vector(to_signed(16#1110#, input_a'length));
        wait for 1000us;
        assert (result = std_logic_vector(to_signed(16#1110#, input_a'length)))
            report "ORR failed."
            severity FAILURE; 

		opcode <= SLT;
        input_a <= std_logic_vector(to_signed(2, input_a'length));
        input_b <= std_logic_vector(to_signed(3, input_a'length));
        wait for 1000us;
        assert (result = std_logic_vector(to_signed(-1, input_a'length)))
            report "SUB failed."
            severity FAILURE;  
			
		opcode <= SRLL;
        input_a <= std_logic_vector(to_signed(16#0100#, input_a'length));
        input_b <= std_logic_vector(to_signed(16#0004#, input_a'length));
        wait for 1000us;
        assert (result = std_logic_vector(to_signed(16#1000#, input_a'length)))
            report "SRLL failed."
            severity FAILURE;
			
		opcode <= SRR;
        input_a <= std_logic_vector(to_signed(16#1100#, input_a'length));
        input_b <= std_logic_vector(to_signed(16#0004#, input_a'length));
        wait for 1000us;
        assert (result = std_logic_vector(to_signed(16#0110#, input_a'length)))
            report "SRR failed."
            severity FAILURE;
			
		opcode <= ADI;
        input_a <= std_logic_vector(to_signed(16#1100#, input_a'length));
        input_b <= std_logic_vector(to_signed(16#0001#, input_a'length));
        wait for 1000us;
        assert (result = std_logic_vector(to_signed(16#1101#, input_a'length)))
            report "ADI failed."
            severity FAILURE;
			
		--Other opcodes all ADD.
    end process;
   


end test;
