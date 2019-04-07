library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.deferred.all;

entity alu is
  -- should be synced w/ clock?
  -- sign extensions?
  -- multiplexers?
  --zeroflag
  Port ( clk : in std_logic;
         opcode : in std_logic_vector(3 downto 0);
         input_a : in std_logic_vector(15 downto 0);
         input_b : in std_logic_vector(15 downto 0);
         rst : in std_logic;
         result : out std_logic_vector(15 downto 0);
         zero_flag : out std_logic);
end alu;

architecture Behavioral of alu is

    signal result_int : std_logic_vector(15 downto 0) := "0000000000000000"; -- clear?
    --signal result_int_num : integer; --:= to_integer(signed(result_int));
    signal input_a_num : integer; --:= to_integer(signed(input_a));
    signal input_b_num : integer; --:= to_integer(signed(input_b));


begin

--    process begin
--        --result_int_num <= to_integer(signed(result_int));
--        input_a_num <= to_integer(signed(input_a));
--        input_b_num <= to_integer(signed(input_b));
--    end process;
    
    process(clk) begin
        if (rising_edge(clk)) then
            case opcode is
                when ADD => result_int <= std_logic_vector(to_signed(input_a_num + input_b_num, result_int'length));
                when SUB => result_int <= std_logic_vector(to_signed(input_a_num - input_b_num, result_int'length));
                when ANDD => result_int <= (input_a AND input_b);
                when ORR => result_int <= input_a OR input_b;
                when SLT => result_int <= std_logic_vector(to_signed(input_a_num - input_b_num, result_int'length));
                when SRLL => result_int <= std_logic_vector(shift_left(signed(input_a), input_b_num));
                when SRR => result_int <= std_logic_vector(shift_right(signed(input_a), input_b_num));
                when ADI => result_int <= std_logic_vector(to_signed(input_a_num + input_b_num, result_int'length));
                
                -- BNE, BEQ, JMP, RET, LDR, STR should all just add
                when others => result_int <= std_logic_vector(to_signed(input_a_num + input_b_num, result_int'length));
            end case;
        end if;
    end process;
    
    input_a_num <= to_integer(signed(input_a));
    input_b_num <= to_integer(signed(input_b));
    
    result <= result_int when rst = '0' else "0000000000000000";
    
    zero_flag <= '1' when result_int = "0000000000000000" or rst = '1' else '0';


end Behavioral;
















