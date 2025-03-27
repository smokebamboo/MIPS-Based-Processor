----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:21:32 03/26/2025 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
	 Port ( Instr : out  STD_LOGIC_VECTOR (31 downto 0);
			  Ovf : out STD_LOGIC;
			  Cout : out STD_LOGIC;
			  CLK : in STD_LOGIC;
			  RST : in STD_LOGIC;
			  PC_LdEn : in STD_LOGIC;
			  Immed_sel : in STD_LOGIC_VECTOR (1 downto 0);
			  RF_WrEn : in STD_LOGIC;
			  RF_WrData_sel : in STD_LOGIC;
			  RF_B_sel : in STD_LOGIC;
			  ALU_Bin_sel : in STD_LOGIC;
			  ALU_func : in STD_LOGIC_VECTOR (3 downto 0);
			  Mem_WrEn : in STD_LOGIC;
			  Byte_ExtrEn : in STD_LOGIC;
			  Branch_Eq : in STD_LOGIC;
			  Branch_not_Eq : in STD_LOGIC);
end DATAPATH;

architecture Behavioral of DATAPATH is
	component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
			  Immed_sel : in STD_LOGIC_VECTOR (1 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : out STD_LOGIC;
			  Cout : out STD_LOGIC;
			  Ovf : out STD_LOGIC);
	end component;
	
	component MEMSTAGE is
    Port ( CLK : in STD_LOGIC;
			  Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
			  Byte_ExtrEn : in STD_LOGIC;
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal immediate : STD_LOGIC_VECTOR (31 downto 0); -- The immediate that's taken from the decoding stage in its correct format
	
	signal instruction : STD_LOGIC_VECTOR (31 downto 0); -- The instruction from the ROM, forwarded to the decoding stage and the Control
	
	signal alu_output : STD_LOGIC_VECTOR (31 downto 0); -- The output of the alu stage
	
	signal mem_output : STD_LOGIC_VECTOR (31 downto 0); -- The output of the memory stage
	
	signal register_read_1 : STD_LOGIC_VECTOR (31 downto 0); -- The output No.1 of the decoding stage
	signal register_read_2 : STD_LOGIC_VECTOR (31 downto 0); -- The output No.2 of the decoding stage
	
	signal alu_zero_signal : STD_LOGIC;
	signal pc_sel : STD_LOGIC;
begin
	pc_sel <= (Branch_Eq AND alu_zero_signal) OR (Branch_not_Eq AND (NOT alu_zero_signal));

	if_stage : IFSTAGE port map(PC_Immed => immediate, PC_sel => pc_sel, PC_LdEn => PC_LdEn, RST => RST, CLK => CLK, Instr => instruction);

	Instr <= instruction;
	
	dec_stage : DECSTAGE port map(Instr => instruction, RF_WrEn => RF_WrEn, ALU_out => alu_output, MEM_out => mem_output, RF_WrData_sel => RF_WrData_sel,
											RF_B_sel => RF_B_sel, Immed_sel => Immed_sel, CLK => CLK, RST => RST, Immed => immediate, RF_A => register_read_1, RF_B => register_read_2);
	
	alu_stage : ALUSTAGE port map(RF_A => register_read_1, RF_B => register_read_2, Immed => immediate, ALU_Bin_sel => ALU_Bin_sel, ALU_func => ALU_func, ALU_out => alu_output,
											Zero => alu_zero_signal, Cout => Cout, Ovf => Ovf);
											
	mem_stage : MEMSTAGE port map(CLK => CLK, Mem_WrEn => Mem_WrEn, ALU_MEM_Addr => alu_output, Byte_ExtrEn => Byte_ExtrEn,
										  MEM_DataIn => register_read_2, MEM_DataOut => mem_output);
end Behavioral;

