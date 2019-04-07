library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package deferred is
  constant ADD : std_logic_vector(3 downto 0) := "0000";
  constant SUB : std_logic_vector(3 downto 0) := "0001";
  constant ANDD : std_logic_vector(3 downto 0) := "0010";
  constant ORR : std_logic_vector(3 downto 0) := "0011";
  constant SLT : std_logic_vector(3 downto 0) := "0100";
  constant SRLL : std_logic_vector(3 downto 0) := "0101";
  constant SRR : std_logic_vector(3 downto 0) := "0110";
  constant ADI : std_logic_vector(3 downto 0) := "0111";
  constant BNE : std_logic_vector(3 downto 0) := "1000";
  constant BEQ : std_logic_vector(3 downto 0) := "1001";
  constant JMP : std_logic_vector(3 downto 0) := "1010";
  constant RET : std_logic_vector(3 downto 0) := "1011";
  constant LDR : std_logic_vector(3 downto 0) := "1100";
  constant STR : std_logic_vector(3 downto 0) := "1101";
  constant HLT : std_logic_vector(3 downto 0) := "1110";
end deferred;

package body deferred is
  
end deferred;