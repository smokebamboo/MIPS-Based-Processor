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
			  RF_B_sel : in STD_LOGIC;
			  Branch_Eq : in STD_LOGIC;
			  Branch_not_Eq : in STD_LOGIC;
			  EX_Control : in STD_LOGIC_VECTOR (31 downto 0);
			  M_Control : in STD_LOGIC_VECTOR (31 downto 0);
			  WB_Control : in STD_LOGIC_VECTOR (31 downto 0));
end DATAPATH;

architecture Behavioral of DATAPATH is
	component IFSTAGE is
    	Port( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           	PC_sel : in  STD_LOGIC;
           	PC_LdEn : in  STD_LOGIC;
           	RST : in  STD_LOGIC;
           	CLK : in  STD_LOGIC;
           	Instr : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component DECSTAGE is
    	Port( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
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
    	Port( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
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
    	Port( CLK : in STD_LOGIC;
			   Mem_WrEn : in  STD_LOGIC;
			   ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
			   Byte_ExtrEn : in STD_LOGIC;
			   MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
			   MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Rgster is
    	Port( CLK : in  STD_LOGIC;
		      RST : in STD_LOGIC;
            WE : in  STD_LOGIC;
            DataIN : in  STD_LOGIC_VECTOR (31 downto 0);
            DataOUT : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component IDEX_Cluster is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  WB_ControlIn : in STD_LOGIC_VECTOR (31 downto 0);
			  M_ControlIn : in STD_LOGIC_VECTOR (31 downto 0);
			  EX_ControlIn : in STD_LOGIC_VECTOR (31 downto 0);
			  RF_A_Data_Input : in STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_Data_Input : in STD_LOGIC_VECTOR (31 downto 0);
			  Immediate_Data_Input : in STD_LOGIC_VECTOR (31 downto 0);
			  WB_ControlOut : out STD_LOGIC_VECTOR (31 downto 0);
			  M_ControlOut : out STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Bin_Sel : out STD_LOGIC;
			  ALU_func : out STD_LOGIC_VECTOR (3 downto 0);
			  RF_A_DataOut : out STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_DataOut : out STD_LOGIC_VECTOR (31 downto 0);
			  Immediate_DataOut : out STD_LOGIC_VECTOR (31 downto 0)
			  );
	end component;
	
	component EXMEM_Cluster is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  WB_ControlIn : in STD_LOGIC_VECTOR (31 downto 0);
			  M_ControlIn : in STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Data_Input : in STD_LOGIC_VECTOR (31 downto 0);
			  WB_ControlOut : out STD_LOGIC_VECTOR (31 downto 0);
			  MEM_WrEn : out STD_LOGIC;
			  Byte_ExtrEn : out STD_LOGIC;
			  ALU_Data : out STD_LOGIC_VECTOR (31 downto 0)
			  );
	end component;
	
	component MEMWB_Cluster is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  WB_ControlIn : in STD_LOGIC_VECTOR(31 downto 0);
			  Mem_Data_Input : in STD_LOGIC_VECTOR(31 downto 0);
			  ALU_Data_input : in STD_LOGIC_VECTOR(31 downto 0);
           RF_Wr_DataSel : out  STD_LOGIC;
			  RF_WrEn : out STD_LOGIC;
			  Mem_Data : out STD_LOGIC_VECTOR(31 downto 0);
			  ALU_Data : out STD_LOGIC_VECTOR(31 downto 0)
			  );
	end component;

	signal instruction : STD_LOGIC_VECTOR (31 downto 0); -- The instruction from the ROM, forwarded to the decoding stage and the Control
	
	signal alu_zero_signal : STD_LOGIC;
	signal pc_sel : STD_LOGIC;
	
	signal instruction_to_reg : STD_LOGIC_VECTOR (31 downto 0);
	
	signal WB_Control_to_exmem : STD_LOGIC_VECTOR (31 downto 0);
	signal M_Control_to_exmem : STD_LOGIC_VECTOR (31 downto 0);
	
	signal ALU_Bin_sel : STD_LOGIC;
	signal ALU_func : STD_LOGIC;
	
begin
	pc_sel <= (Branch_Eq AND alu_zero_signal) OR 
				 (Branch_not_Eq AND (NOT alu_zero_signal));

	if_stage : IFSTAGE port map(PC_Immed => immediate, 
										 PC_sel => pc_sel, 
										 PC_LdEn => PC_LdEn, 
									    RST => RST, 
										 CLK => CLK, 
										 Instr => instruction_to_reg);

	Instr <= instruction;
	
	instruction_register : Rgster port map(CLK => CLK, 
														RST => RST, 
														WE => InstrRegEn, 
														DataIN => instruction_to_reg, 
														DataOUT => instruction);
	
	dec_stage : DECSTAGE port map(Instr => instruction, 
											RF_WrEn => , 
											ALU_out => , 
											MEM_out => , 
											RF_WrData_sel => ,
											RF_B_sel => RF_B_sel, 
											Immed_sel => Immed_sel, 
											CLK => CLK, 
											RST => RST, 
											Immed => immed_to_cluster, 
											RF_A => rf_a_to_cluster, 
											RF_B => rf_b_to_cluster);
											
	id_ex : IDEX_Cluster port map(CLK => CLK,
											RST => RST,
											WB_ControlIn => WB_Control,
											M_ControlIn => M_Control,
											EX_ControlIn => EX_Control,
											RF_A_Data_Input => rf_a_to_cluster,
											RF_B_Data_Input => rf_b_to_cluster,
											Immediate_Data_Input => immed_to_cluster,
											WB_ControlOut => WB_Control_to_exmem,
											M_ControlOut => M_Control_to_exmem,
											ALU_Bin_Sel => ALU_Bin_Sel,
											ALU_func => ALU_func,
											RF_A_DataOut => ,
											RF_B_DataOut => ,
											Immediate_DataOut => 
											);
	
	alu_stage : ALUSTAGE port map(RF_A => , 
											RF_B => , 
											Immed => , 
											ALU_Bin_sel => ALU_Bin_Sel, 
											ALU_func => ALU_func, 
											ALU_out => ,
											Zero => alu_zero_signal, 
											Cout => Cout, 
											Ovf => Ovf);
											
	ex_mem : EXMEM_Cluster port map(CLK => CLK,
											  RST => RST,
											  WB_ControlIn => WB_Control_to_exmem,
											  M_ControlIn => M_Control_to_exmem,
											  ALU_Data_Input => ,
											  WB_ControlOut => ,
											  MEM_WrEn => ,
											  Byte_ExtrEn => ,
											  ALU_Data => );
		
	mem_stage : MEMSTAGE port map(CLK => CLK, 
											Mem_WrEn => , 
											ALU_MEM_Addr => , 
											Byte_ExtrEn => ,
											MEM_DataIn => , 
											MEM_DataOut => );
											
	mem_wb : MEMWB_Cluster port map(CLK => CLK,
											  RST => RST,
											  WB_ControlIn => ,
											  Mem_Data_Input => ,
											  ALU_Data_Input => ,
											  Wr_DataSel => ,
											  Mem_Data => ,
											  ALU_Data => );
										  
end Behavioral;

