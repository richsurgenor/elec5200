library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

--need 16 regs
--regwrite bit
--rs bit source register
--rt transfer register
--q1 - reg 1 value
--q2 - reg 2 value
--writedata

entity register_bank is
    generic (N: integer:=16; -- number of bits per word
             M: integer:=4); -- number of address bits (4 bc registers 0-15)
    port (  
            clk: in std_logic;
            RegWrite: in std_logic; -- active high write enable
            rs: in std_logic_vector (M-1 downto 0); -- rs register
            rt: in std_logic_vector (M-1 downto 0); -- rt register
            rd: in std_logic_vector (M-1 downto 0); -- WRITE RAM address
            DIN: in std_logic_vector (N-1 downto 0); -- write data
            Q1: out std_logic_vector (N-1 downto 0); -- read data
            Q2: out std_logic_vector (N-1 downto 0)); -- read data
end entity register_bank;

architecture registers of register_bank is

subtype WORD is std_logic_vector ( N-1 downto 0); -- define size of WORD
type MEMORY is array (0 to 2**M-1) of WORD; -- define size of MEMORY
signal REGVAR: MEMORY; -- define RAMVAR as signal of type MEMORY

begin

process (clk) --(RegWrite, DIN, rs, rd) -- need to use clk?

begin
    if (rising_edge(clk)) then
        if (RegWrite='1') then -- write operation to RAM
            REGVAR ( conv_integer (rd) ) <= DIN ;
        end if;
        
        Q1 <= REGVAR ( conv_integer (rs) ); -- always does read operation
        Q2 <= REGVAR ( conv_integer (rt) ); -- always does read operation
    end if;
end process;


end architecture registers; 
