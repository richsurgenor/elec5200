library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.deferred.all;


entity controller is
  Port ( clk : in std_logic;
         rst : in std_logic;
         opcode : in std_logic_vector(3 downto 0);
         jump, brancheq, branchneq, memread, memwrite, memtoreg, aluimm, regwrite, retrn, halt : out std_logic := '0');
  
end controller;

architecture Behavioral of controller is
    
	signal jump_int : std_logic := '0';
	signal brancheq_int : std_logic := '0';
	signal branchneq_int : std_logic := '0';
	signal  memread_int : std_logic := '0';
	signal memwrite_int : std_logic := '0';
	signal  memtoreg_int : std_logic := '0';
	signal aluimm_int : std_logic := '0';
	signal regwrite_int : std_logic := '0';
	signal retrn_int : std_logic := '0';
	signal halt_int : std_logic := '0';
	
begin

   process(clk) begin
        if (rising_edge(clk)) then
            case opcode is
				when ADD | SUB | ANDD | ORR | SLT  => 
					jump_int 	  <= '0';
					brancheq_int  <= '0';
					branchneq_int <= '0';
					memread_int	  <= '0';
					memwrite_int  <= '0';
					memtoreg_int  <= '0';
					aluimm_int    <= '0';
					regwrite_int  <= '1';
					retrn_int	  <= '0';
					halt_int      <= '0';
				when SRLL | SRR | ADI =>
					jump_int 	  <= '0';
					brancheq_int  <= '0';
					branchneq_int <= '0';
					memread_int	  <= '0';
					memwrite_int  <= '0';
					memtoreg_int  <= '0';
					aluimm_int    <= '1';
					regwrite_int  <= '1';
					retrn_int	  <= '0';
					halt_int      <= '0';
				when BNE  => 
					jump_int 	  <= '0';
					brancheq_int  <= '0';
					branchneq_int <= '1';
					memread_int	  <= '0';
					memwrite_int  <= '0';
					memtoreg_int  <= '0';
					aluimm_int    <= '0';
					regwrite_int  <= '0';
					retrn_int	  <= '0';
					halt_int      <= '0';
				when BEQ  => 
					jump_int 	  <= '0';
					brancheq_int  <= '1';
					branchneq_int <= '0';
					memread_int	  <= '0';
					memwrite_int  <= '0';
					memtoreg_int  <= '0';
					aluimm_int    <= '0';
					regwrite_int  <= '0';
					retrn_int	  <= '0';
					halt_int      <= '0';
				when JMP  =>
					jump_int 	  <= '1';
					brancheq_int  <= '0';
					branchneq_int <= '0';
					memread_int	  <= '0';
					memwrite_int  <= '0';
					memtoreg_int  <= '0';
					aluimm_int    <= '0';
					regwrite_int  <= '0';
					retrn_int	  <= '0';
					halt_int      <= '0';
				when RET  =>
					jump_int 	  <= '0';
					brancheq_int  <= '0';
					branchneq_int <= '0';
					memread_int	  <= '0';
					memwrite_int  <= '0';
					memtoreg_int  <= '0';
					aluimm_int    <= '0';
					regwrite_int  <= '0';
					retrn_int	  <= '1';
					halt_int      <= '0';
				when LDR  =>
					jump_int 	  <= '0';
					brancheq_int  <= '0';
					branchneq_int <= '0';
					memread_int	  <= '1';
					memwrite_int  <= '0';
					memtoreg_int  <= '1';
					aluimm_int    <= '1';
					regwrite_int  <= '1';
					retrn_int	  <= '0';
					halt_int      <= '0';
				when STR  =>
					jump_int 	  <= '0';
					brancheq_int  <= '0';
					branchneq_int <= '0';
					memread_int	  <= '0';
					memwrite_int  <= '1';
					memtoreg_int  <= '0';
					aluimm_int    <= '1';
					regwrite_int  <= '0';
					retrn_int	  <= '0';
					halt_int      <= '0';
				when HLT  =>
					jump_int 	  <= '0';
					brancheq_int  <= '0';
					branchneq_int <= '0';
					memread_int	  <= '0';
					memwrite_int  <= '0';
					memtoreg_int  <= '0';
					aluimm_int    <= '0';
					regwrite_int  <= '0';
					retrn_int	  <= '0';
					halt_int      <= '1';
                when others => -- instruction 16 does not exist
                    jump_int 	  <= '0';
                    brancheq_int  <= '0';
                    branchneq_int <= '0';
                    memread_int   <= '0';
                    memwrite_int  <= '0';
                    memtoreg_int  <= '0';
                    aluimm_int    <= '0';
                    regwrite_int  <= '0';
                    retrn_int     <= '0';
                    halt_int      <= '0';
            end case;
        end if;
    end process;
        

    jump <= jump_int;
	brancheq <= brancheq_int;
	branchneq <= branchneq_int;
	memread <= memread_int;
	memwrite <= memwrite_int;
	memtoreg <= memtoreg_int;
	aluimm <= aluimm_int;
	regwrite <= regwrite_int;
	retrn <= retrn_int;
	halt <= halt_int;
		
end Behavioral;
