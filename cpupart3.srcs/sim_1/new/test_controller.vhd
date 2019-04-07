library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.all;
use work.deferred.all;

entity test_controller is
end test_controller;

architecture test of test_controller is
    signal clk : std_logic := '0';
	signal rst : std_logic := '0';
    signal opcode : std_logic_vector(3 downto 0) ;
	signal jump, brancheq, branchneq, memread, memwrite, memtoreg, aluimm, regwrite, retrn, halt : std_logic;
    signal control_signals : std_logic_vector(9 downto 0) := "0000000000";
begin

UUT: entity work.controller
    port map(
        clk => clk,
        rst => rst,
        opcode => opcode,
        jump => jump,
		brancheq => brancheq,
		branchneq => branchneq,
		memread => memread,
		memwrite => memwrite,
		memtoreg => memtoreg,
		aluimm => aluimm,
		regwrite => regwrite,
		retrn => retrn,
		halt => halt);
        
    clk <= not clk after 500 us;
	
	process begin
		opcode <= ADD;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000000100")
            report "ADD failed."
            severity FAILURE;
			
		opcode <= SUB;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000000100")
            report "SUB failed."
            severity FAILURE;
			
		opcode <= ANDD;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000000100")
            report "ANDD failed."
            severity FAILURE;
			
		opcode <= ORR;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000000100")
            report "ORR failed."
            severity FAILURE;
			
		opcode <= SLT;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000000100")
            report "SLT failed."
            severity FAILURE;
			
		opcode <= SRLL;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000001100")
            report "SRLL failed."
            severity FAILURE;
			
		opcode <= SRR;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000001100")
            report "SRR failed."
            severity FAILURE;
			
		opcode <= ADI;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000001100")
            report "ADI failed."
            severity FAILURE;
			
		opcode <= BNE;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0010000000")
            report "BNE failed."
            severity FAILURE;
			
		opcode <= BEQ;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0100000000")
            report "BEQ failed."
            severity FAILURE;
			
		opcode <= JMP;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "1000000000")
            report "JMP failed."
            severity FAILURE;
			
		opcode <= RET;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000000010")
            report "RET failed."
            severity FAILURE;
			
		opcode <= LDR;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0001011100")
            report "LDR failed."
            severity FAILURE;
			
		opcode <= STR;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000101000")
            report "STR failed."
            severity FAILURE;
			
		opcode <= HLT;
		wait for 1000us;
		control_signals <= jump & brancheq & branchneq & memread & memwrite & memtoreg & aluimm & regwrite & retrn & halt;
		wait for 1000us;
		assert (control_signals = "0000000001")
            report "HLT failed."
            severity FAILURE;
			
		assert (0 = 1)
            report "All tests have passed."
            severity NOTE;
	end process;
	
end test;
