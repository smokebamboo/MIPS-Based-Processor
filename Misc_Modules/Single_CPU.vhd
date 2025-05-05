----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:12:22 03/26/2025 
-- Design Name: 
-- Module Name:    Single_CPU - Behavioral 
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

entity Single_CPU is
		Port ( Ovf : out STD_LOGIC;
				 Cout : out STD_LOGIC;
				 CLK : in STD_LOGIC;
				 RST : in STD_LOGIC);
end Single_CPU;

architecture Behavioral of Single_CPU is
	component ControlModule is
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
			  MemDataRegEn : out STD_LOGIC);
	end component;
	
	component DATAPATH is
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
			  Branch_not_Eq : in STD_LOGIC;
			  InstrRegEn : in STD_LOGIC;
			  RF_A_RegEn : in STD_LOGIC;
			  RF_B_RegEn : in STD_LOGIC;
			  ImmedRegEn : in STD_LOGIC;
			  ALU_RegEn : in STD_LOGIC;
			  MemDataRegEn : in STD_LOGIC);
	end component;
	
	signal instruction : STD_LOGIC_VECTOR (31 downto 0); -- The current instruction
	signal pc_load_enable : STD_LOGIC; -- Whether the program advances or is stalled
	signal immediate_sel : STD_LOGIC_VECTOR (1 downto 0); -- Selects the format of the Immediate for instructions
	signal rf_write_enable : STD_LOGIC; -- Whether to write data to register or not
	signal rf_write_data_sel : STD_LOGIC; -- Determines where to take data from, to write to register
	signal rf_B_sel : STD_LOGIC; -- Determines the second register file input
	signal alu_bin_sel : STD_LOGIC; -- Determines the second alu operand
	signal alu_function : STD_LOGIC_VECTOR (3 downto 0); -- Selects the function the ALU will perform
	signal mem_write_enable : STD_LOGIC; -- Enables writing in the RAM
	signal byte_extractor_enable : STD_LOGIC; -- Enables the extraction of bytes or lw operation
	signal branch_eq_sig : STD_LOGIC; -- Signal for the beq and b operations
	signal branch_not_eq_sig : STD_LOGIC; -- Signal for the bne operation
	signal InstrRegEn_sig : STD_LOGIC; -- Signal controlling the register that holds the instruction
	signal RF_A_RegEn_sig : STD_LOGIC; -- Signal controlling the register that holds the output A of the DECSTAGE
	signal RF_B_RegEn_sig : STD_LOGIC; -- Signal controlling the register that holds the output B of the DECSTAGE
	signal ImmedRegEn_sig : STD_LOGIC; -- Signal controlling the register that holds the immediate from the DECSTAGE
	signal ALU_RegEn_sig : STD_LOGIC; -- Signal controlling the register that holds the output data of the ALU
	--signal PC_SelRegEn_sig : STD_LOGIC; -- Signal controlling the register that holds the value of PC_Sel
	signal MemDataRegEn_sig : STD_LOGIC; -- Signal controlling the register that holds the output data of MEMSTAGE
	
begin
	control : ControlModule port map(CLK => CLK,
												RST => RST, 
												Instr => instruction, 
												PC_LdEn => pc_load_enable, 
												Immed_sel => immediate_sel,
												RF_WrEn => rf_write_enable, 
												RF_WrData_sel => rf_write_data_sel, 
												RF_B_sel => rf_B_sel,
												ALU_Bin_sel => alu_bin_sel, 
												ALU_func => alu_function, 
												Mem_WrEn => mem_write_enable,
												Byte_ExtrEn => byte_extractor_enable, 
												Branch_Eq => branch_eq_sig, 
												Branch_not_Eq => branch_not_eq_sig,
												InstrRegEn => InstrRegEn_sig, 
												RF_A_RegEn => RF_A_RegEn_sig, 
												RF_B_RegEn => RF_B_RegEn_sig,
												ImmedRegEn => ImmedRegEn_sig, 
												ALU_RegEn => ALU_RegEn_sig,
												MemDataRegEn => MemDataRegEn_sig);
	
	path : DATAPATH port map(Instr => instruction, 
									 Ovf => Ovf, 
									 Cout => Cout, 
									 CLK => CLK, 
									 RST => RST, 
									 PC_LdEn => pc_load_enable, 
									 Immed_sel => immediate_sel, 
									 RF_WrEn => rf_write_enable,
									 RF_WrData_sel => rf_write_data_sel, 
									 RF_B_sel => rf_B_sel, 
									 ALU_Bin_sel => alu_bin_sel, 
									 ALU_func => alu_function, 
									 Mem_WrEn => mem_write_enable,
									 Byte_ExtrEn => byte_extractor_enable, 
									 Branch_eq => branch_eq_sig, 
									 Branch_not_Eq => branch_not_eq_sig,
									 InstrRegEn => InstrRegEn_sig, 
									 RF_A_RegEn => RF_A_RegEn_sig, 
									 RF_B_RegEn => RF_B_RegEn_sig,
									 ImmedRegEn => ImmedRegEn_sig, 
									 ALU_RegEn => ALU_RegEn_sig,
									 MemDataRegEn => MemDataRegEn_sig);
end Behavioral;

