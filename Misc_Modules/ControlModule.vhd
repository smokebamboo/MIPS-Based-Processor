----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:14:36 04/19/2025 
-- Design Name: 
-- Module Name:    ControlModule - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlModule is
    Port ( CLK : in STD_LOGIC;
			  RST : in STD_LOGIC;
			  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  PC_LdEn : out STD_LOGIC;
			  Immed_sel : out STD_LOGIC_VECTOR (1 downto 0);
			  RF_WrEn : out STD_LOGIC;
			  RF_WrData_sel : out STD_LOGIC;
			  RF_B_sel : out STD_LOGIC;
			  ALU_Bin_sel : out STD_LOGIC;
			  ALU_func : out STD_LOGIC_VECTOR (3 downto 0);
			  Mem_WrEn : out STD_LOGIC;
			  Byte_ExtrEn : out STD_LOGIC;
			  Branch_Eq : out STD_LOGIC;
			  Branch_not_Eq : out STD_LOGIC;
			  InstrRegEn : out STD_LOGIC;
			  RF_A_RegEn : out STD_LOGIC;
			  RF_B_RegEn : out STD_LOGIC;
			  ImmedRegEn : out STD_LOGIC;
			  ALU_RegEn : out STD_LOGIC;
			  PC_SelRegEn : out STD_LOGIC;
			  MemDataRegEn : out STD_LOGIC);
end ControlModule;

architecture Behavioral of ControlModule is
	type cycle_type is (fetch, branch, branchNE, dec, r_exec, i_exec, memread, memreadbyte, memwrite, alu_writeback, mem_writeback);
	signal cycle_state : cycle_type;
	
	signal opcode : STD_LOGIC_VECTOR (5 downto 0);
	type instr_type is (alu_op, li_op, lui_op, addi_op, andi_op, ori_op, b_op, beq_op, bne_op, lb_op, lw_op, sw_op, NOP);
	signal instr_state : instr_type;
	
	signal func : STD_LOGIC_VECTOR (5 downto 0);

begin
	opcode <= Instr(31 downto 26);
	func <= Instr(5 downto 0);

	
	process(opcode)
	begin
		case opcode is
			when "100000" =>
				instr_state <= alu_op;			
			when "111000" =>
				instr_state <= li_op;
			when "111001" =>
				instr_state <= lui_op;
			when "110000" =>
				instr_state <= addi_op;
			when "110010" =>
				instr_state <= andi_op;
			when "110011" =>
				instr_state <= ori_op;
			when "111111" =>
				instr_state <= b_op;
			when "010000" =>
				instr_state <= beq_op;
			when "010001" =>
				instr_state <= bne_op;
			when "000011" =>
				instr_state <= lb_op;
			when "001111" =>
				instr_state <= lw_op;
			when "011111" =>
				instr_state <= sw_op;
			when others =>
				instr_state <= NOP;
		end case;
	end process;

	process
	begin
		wait until rising_edge(CLK);
		if RST = '1' then
			cycle_state <= fetch;
		else
			case cycle_state is
				when fetch =>
					cycle_state <= dec;
				when dec =>
					if instr_state = NOP then
						cycle_state <= fetch;
					elsif instr_state = li_op or instr_state = lui_op or instr_state = addi_op or instr_state = andi_op or instr_state = ori_op or
											  instr_state = sw_op or instr_state = lw_op or instr_state = lb_op then
						cycle_state <= i_exec;
					elsif instr_state = bne_op then
						cycle_state <= branchNE;
					elsif instr_state = b_op or instr_state = beq_op then
						cycle_state <= branch;
					else
						cycle_state <= r_exec;
					end if;
				when r_exec =>
					cycle_state <= alu_writeback;
				when i_exec =>
					if instr_state = lw_op then
						cycle_state <= memread;
					elsif instr_state = lb_op then
						cycle_state <= memreadbyte;
					elsif instr_state = sw_op then
						cycle_state <= memwrite;
					else
						cycle_state <= alu_writeback;
					end if;
				when branch =>
					cycle_state <= fetch;
				when branchNE =>
					cycle_state <= fetch;
				when memread =>
					cycle_state <= mem_writeback;
				when memreadbyte =>
					cycle_state <= mem_writeback;
				when memwrite =>
					cycle_state <= fetch;
				when alu_writeback =>
					cycle_state <= fetch;
				when mem_writeback =>
					cycle_state <= fetch;
			end case;
		end if;
		
		
	end process;
	
	PC_LdEn <= '1' when (cycle_state = fetch) else '0';
	
	Immed_sel <= "11" when (instr_state = lui_op) else
					 "10" when (instr_state = andi_op) OR (instr_state = ori_op) else
					 "01" when (instr_state = b_op) OR (instr_state = beq_op) OR (instr_state = bne_op) else
					 "00";
	
	RF_WrEn <= '1' when (cycle_state = alu_writeback) OR (cycle_state = mem_writeback) else '0';
	
	RF_WrData_Sel <= '1' when (cycle_state = mem_writeback) else '0';
	
	RF_B_sel <= '1' when (instr_state = beq_op) OR (instr_state = bne_op) OR (instr_state = b_op) OR (instr_state = sw_op) else '0';
	
	ALU_Bin_sel <= '1' when (cycle_state = i_exec) else '0';
	
	ALU_func <= func(3 downto 0) when (instr_state = alu_op) else
					opcode(3 downto 0) when (instr_state = addi_op) OR (instr_state = andi_op) OR (instr_state = ori_op) else
					"0001" when (instr_state = beq_op) OR (instr_state = bne_op) OR (instr_state = b_op) else
					"0000";
					
	Mem_WrEn <= '1' when (cycle_state = memwrite) else '0';
	
	Byte_ExtrEn <= '1' when (cycle_state = memreadbyte) else '0';
	
	Branch_Eq <= '1' when (cycle_state = branch) else '0';
	
	Branch_not_Eq <= '1' when (cycle_state = branchNE) else '0';
	
	InstrRegEn <= '1' when (cycle_state = fetch) else '0';
	
	RF_A_RegEn <= '1' when (cycle_state = dec) else '0';
	
	RF_B_RegEn <= '1' when (cycle_state = dec) else '0';
	
	ImmedRegEn <= '1' when (cycle_state = dec) else '0';
	
	ALU_RegEn <= '1' when (cycle_state = r_exec) OR (cycle_state = i_exec) else '0';
	
--	PC_SelRegEn <= '1' when (cycle_state = branch) OR (cycle_state = branchNE) else '0';
	PC_SelRegEn <= '1';
	
	MemDataRegEn <= '1' when (cycle_state = memread) OR (cycle_state = memreadbyte) else '0';
end Behavioral;
