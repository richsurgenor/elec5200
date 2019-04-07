library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity pc is
  Port ( clk, rst : in std_logic;
         pc_in : in std_logic_vector(15 downto 0);
         pc : out std_logic_vector(15 downto 0));
end pc;

architecture Behavioral of pc is

    signal pc_out_int : std_logic_vector(15 downto 0);

begin

    process (clk) begin
        if(rising_edge(clk)) then
            pc_out_int <= pc_in;
        end if;
    end process;
    
    pc <= pc_out_int when rst = '0' else "0000000000000000";


end Behavioral;
