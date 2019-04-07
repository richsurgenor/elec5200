-- Implementation of read-only memory

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity instruction_memory is
    generic (N: integer:=16; -- number of bits per word
             M: integer:=10); -- 2^10 for 10 address bits
    port (
            R_ADDR: in std_logic_vector (M-1 downto 0); -- READ RAM address
            DOUT: out std_logic_vector (N-1 downto 0)); -- read data
end entity instruction_memory;

architecture memory of instruction_memory is

subtype WORD is std_logic_vector ( N-1 downto 0); -- define size of WORD
type MEMORY is array (0 to 2**M-1) of WORD; -- define size of MEMORY
signal MEMVAR: MEMORY; -- define RAMVAR as signal of type MEMORY

begin

process (R_ADDR)

begin
    DOUT <= MEMVAR ( conv_integer (R_ADDR) ); -- always does read operation
end process;


end architecture memory; 
