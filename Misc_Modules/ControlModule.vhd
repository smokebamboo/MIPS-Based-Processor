----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:18:39 03/22/2025 
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
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
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
			  Branch_not_Eq : out STD_LOGIC);
end ControlModule;

architecture Behavioral of ControlModule is

	signal opcode : STD_LOGIC_VECTOR (5 downto 0);
	signal func : STD_LOGIC_VECTOR (5 downto 0);
	type state is (alu_op, li_op, lui_op, addi_op, andi_op, ori_op, b_op, beq_op, bne_op, lb_op, lw_op, sw_op, error);
	signal control_state : state;
begin
	opcode <= Instr(31 downto 26);
	func <= Instr(5 downto 0);
	
	process(opcode)
	begin
		case opcode is
			when "100000" =>
				control_state <= alu_op;			
			when "111000" =>
				control_state <= li_op;
			when "111001" =>
				control_state <= lui_op;
			when "110000" =>
				control_state <= addi_op;
			when "110010" =>
				control_state <= andi_op;
			when "110011" =>
				control_state <= ori_op;
			when "111111" =>
				control_state <= b_op;
			when "010000" =>
				control_state <= beq_op;
			when "010001" =>
				control_state <= bne_op;
			when "000011" =>
				control_state <= lb_op;
			when "001111" =>
				control_state <= lw_op;
			when "011111" =>
				control_state <= sw_op;
			when others =>
				control_state <= error;
		end case;
	end process;
		
	PC_LdEn <= '1';
	
	Immed_sel <= "11" when (control_state = lui_op) else
					 "10" when (control_state = andi_op) OR (control_state = ori_op) else
					 "01" when (control_state = b_op) OR (control_state = beq_op) OR (control_state = bne_op) else
					 "00";
	
	RF_WrEn <= '1' when (control_state = alu_op) OR (control_state = li_op) OR (control_state = lui_op)
								OR (control_state = addi_op) OR (control_state = andi_op) OR (control_state = ori_op)
								OR (control_state = lb_op) OR (control_state = lw_op) else '0';

	RF_WrData_sel <= '1' when (control_state = lb_op) OR (control_state = lw_op) else '0';

	RF_B_sel <= '1' when (control_state = beq_op) OR (control_state = bne_op) OR (control_state = sw_op) else '0';

	ALU_Bin_sel <= '1' when (control_state = li_op) OR (control_state = lui_op) OR (control_state = addi_op) OR (control_state = andi_op) OR (control_state = ori_op) OR
									(control_state = lb_op) OR (control_state = lw_op) OR (control_state = sw_op) else '0';

	ALU_func <= func(3 downto 0) when (control_state = alu_op) else
					opcode(3 downto 0) when (control_state = addi_op) OR (control_state = andi_op) OR (control_state = ori_op) else
					"0001" when (control_state = beq_op) OR (control_state = bne_op) OR (control_state = b_op) else
					"0000";
					
	Mem_WrEn <= '1' when (control_state = sw_op) else '0';
	
	Byte_ExtrEn <= '1' when (control_state = lb_op) else '0';
		
	Branch_Eq <= '1' when (control_state = beq_op) OR (control_state = b_op) else '0';
	
	Branch_not_Eq <= '1' when (control_state = bne_op) else '0';
	
end Behavioral;

