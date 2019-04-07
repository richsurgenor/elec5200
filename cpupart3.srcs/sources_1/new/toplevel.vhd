library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
--use UNISIM.VComponents.all;

entity toplevel is
	Port (       
				clk : in std_logic;
				
				--input
				--data_read_bus : in std_logic_vector(15 downto 0); 
				instruction_read_bus : in std_logic_vector(15 downto 0);
				data_read_bus : in std_logic_vector(15 downto 0);
				
				--output
				instruction_address_bus : out std_logic_vector (9 downto 0); -- 10 bit branch?
				data_address_bus : out std_logic_vector(15 downto 0);
				data_write_bus : out std_logic_vector(15 downto 0);
				mem_write_enable : out std_logic
				
		 );
end toplevel;

architecture Hierarchical of toplevel is

	
	--Instruction decoding
	signal instruction_bus_int : std_logic_vector(15 downto 0);
	
	--pc
	signal pc_out_int : std_logic_vector(15 downto 0);
	signal pc_in_int : std_logic_vector(15 downto 0);
	
	--control signals internal
	signal jump_int, brancheq_int, branchneq_int, memread_int, memwrite_int, memtoreg_int, aluimm_int, regwrite_int, retrn_int, halt_int : std_logic := '0';
	
	--register multiplexing for jump
	signal rs_int : std_logic_vector(3 downto 0); -- init to 0?
	signal rd_int : std_logic_vector(3 downto 0);
	signal write_data_int : std_logic_vector (15 downto 0);
	signal q1_int : std_logic_vector (15 downto 0);
	signal q2_int : std_logic_vector (15 downto 0);
	
	--alu
	signal alu_opcode : std_logic_vector(3 downto 0);
	signal alu_input_a : std_logic_vector(15 downto 0);
    signal alu_input_b : std_logic_vector(15 downto 0);
    signal alu_rst : std_logic;
    signal alu_result : std_logic_vector(15 downto 0);
	signal zero_flag_int : std_logic;
	
	--intemediary
	signal pc_control_1 : std_logic;
	signal pc_control_2 : std_logic;
	signal branch_control_logic : std_logic;
	
	
begin

--controller: entity work.controller
--	port map
	
	pc: entity work.pc
	   port map (
	               clk => clk,
	               pc => pc_out_int,
	               pc_in => pc_in_int,
	               rst => '0' 
	               );
	
    register_bank: entity work.register_bank
        port map (
                    clk => clk,
                    RegWrite => regwrite_int,
                    rs => rs_int,
                    rt => instruction_bus_int(3 downto 0),
                    rd => rd_int,
                    DIN => write_data_int,
                    q1 => q1_int,
                    q2 => q2_int
                    );
    
    alu: entity work.alu
        port map (
                    clk => clk,
                    opcode => instruction_bus_int(15 downto 12),
                    input_a => alu_input_a,
                    input_b => alu_input_b,
                    rst => alu_rst,
                    result => alu_result,
                    zero_flag => zero_flag_int
                    );
                    
    controller: entity work.controller
        port map (
                    clk => clk,
                    rst => '0',
                    opcode => instruction_bus_int(15 downto 12),
                    jump => jump_int,
                    brancheq => brancheq_int,
                    branchneq => branchneq_int,
                    memread => memread_int,
                    memwrite => memwrite_int,
                    memtoreg => memtoreg_int,
                    aluimm => aluimm_int,
                    regwrite => regwrite_int,
                    retrn => retrn_int,
                    halt => halt_int
                    );
                    
    
    -- assignments -- 
    
    --register file
    process (clk) begin
        if (rising_edge(clk)) then
            --pc_control_logic
            if (jump_int = '1') then -- jump
                pc_in_int <= "000000" & instruction_bus_int(11 downto 2); 
            elsif (branch_control_logic = '1') then -- branch TODO, fix sign ext.
                pc_in_int <= ( std_logic_vector(to_unsigned(to_integer(signed(pc_out_int)) + 1 + to_integer(signed(q2_int)), pc_in_int'length)) );
            elsif (retrn_int = '1') then -- retrn from function call (may be buggy)
                pc_in_int <= q1_int; 
            else
                -- rtype
                pc_in_int <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_out_int)) + 1, pc_in_int'length));
            end if;
                
            -- jump
            if (jump_int = '0') then
                if (memtoreg_int = '1') then
                    write_data_int <= data_read_bus; -- <-- external
                else
                    write_data_int <= alu_result;
                end if;
                rd_int <= instruction_bus_int(11 downto 8);
                --TODO OTHER JUMP TOP RIGHT -- i think this is handled?
            else
                write_data_int <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_out_int)) + 1, pc_in_int'length)); 
                rd_int <= "1111"; -- 15
            end if;
            
            -- return
            if (retrn_int = '0') then
                rs_int <= instruction_bus_int(7 downto 4);
                --TODO other retrn connect to pc
            else
                rs_int <= "1111"; -- 15
            end if;
        
            --ALUImm
            if (aluimm_int = '0') then
                alu_input_b <= q2_int;
            else
                alu_input_b(15 downto 0) <= (others => instruction_bus_int(3)); -- sign extend
                alu_input_b(3 downto 0) <= instruction_bus_int(3 downto 0);
            end if;
        end if;
       
    end process;
    
    --TODO process for branching/pc inc
    
    --assignments
    --alu
    alu_input_a <= q1_int;
    instruction_bus_int <= instruction_read_bus;
    
    instruction_address_bus <=  pc_out_int(9 downto 0);
    mem_write_enable <= memwrite_int;
    data_address_bus <= alu_result;
    
    pc_control_1 <= (zero_flag_int and brancheq_int);
    pc_control_2 <= (zero_flag_int and branchneq_int);
    branch_control_logic <= pc_control_1 or pc_control_2;
    --branch

end Hierarchical;
