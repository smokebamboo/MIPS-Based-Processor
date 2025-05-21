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
			  rf_a_addr : out STD_LOGIC_VECTOR (4 downto 0);
			  rf_b_addr : out STD_LOGIC_VECTOR (4 downto 0);
			  exmem_wraddr : out STD_LOGIC_VECTOR (4 downto 0);
			  memwb_wraddr : out STD_LOGIC_VECTOR (4 downto 0);
			  hazard_select : in STD_LOGIC_VECTOR (3 downto 0);
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
				RF_Wr_Addr : in STD_LOGIC_VECTOR (4 downto 0);
          	RF_B_sel : in  STD_LOGIC;
		   	Immed_sel : in STD_LOGIC_VECTOR (1 downto 0);
           	CLK : in  STD_LOGIC;
           	RST : in  STD_LOGIC;
           	Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           	RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           	RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
				RF_Wr_Data : out STD_LOGIC_VECTOR (31 downto 0);
				Read_A_Addr : out STD_LOGIC_VECTOR (4 downto 0);
				Read_B_Addr : out STD_LOGIC_VECTOR (4 downto 0));
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
			  Write_Register_Input : in STD_LOGIC_VECTOR (4 downto 0);
			  Read_Register_A_Input : in STD_LOGIC_VECTOR(4 downto 0);
			  Read_Register_B_Input : in STD_LOGIC_VECTOR(4 downto 0);
			  WB_ControlOut : out STD_LOGIC_VECTOR (31 downto 0);
			  M_ControlOut : out STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Bin_Sel : out STD_LOGIC;
			  ALU_func : out STD_LOGIC_VECTOR (3 downto 0);
			  RF_A_DataOut : out STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_DataOut : out STD_LOGIC_VECTOR (31 downto 0);
			  Immediate_DataOut : out STD_LOGIC_VECTOR (31 downto 0);
			  Write_Register_Out : out STD_LOGIC_VECTOR (4 downto 0);
			  Read_Register_A_Out : out STD_LOGIC_VECTOR(4 downto 0);
			  Read_Register_B_Out : out STD_LOGIC_VECTOR(4 downto 0)
			  );
	end component;
	
	component EXMEM_Cluster is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  WB_ControlIn : in STD_LOGIC_VECTOR (31 downto 0);
			  M_ControlIn : in STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Data_Input : in STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_Data_Input : in STD_LOGIC_VECTOR (31 downto 0);
			  Write_Register_Input : in STD_LOGIC_VECTOR (4 downto 0);
			  --Read_Register_A_Input : in STD_LOGIC_VECTOR(4 downto 0);
			  --Read_Register_B_Input : in STD_LOGIC_VECTOR(4 downto 0);
			  WB_ControlOut : out STD_LOGIC_VECTOR (31 downto 0);
			  MEM_WrEn : out STD_LOGIC;
			  Byte_ExtrEn : out STD_LOGIC;
			  ALU_Data : out STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_DataOut : out STD_LOGIC_VECTOR (31 downto 0);
			  Write_Register_Out : out STD_LOGIC_VECTOR (4 downto 0)
			  --Read_Register_A_Out : out STD_LOGIC_VECTOR(4 downto 0);
			  --Read_Register_B_Out : out STD_LOGIC_VECTOR(4 downto 0)
			  );
	end component;
	
	component MEMWB_Cluster is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  WB_ControlIn : in STD_LOGIC_VECTOR(31 downto 0);
			  Mem_Data_Input : in STD_LOGIC_VECTOR(31 downto 0);
			  ALU_Data_input : in STD_LOGIC_VECTOR(31 downto 0);
			  Write_Register_Input : in STD_LOGIC_VECTOR (4 downto 0);
			  --Read_Register_A_Input : in STD_LOGIC_VECTOR(4 downto 0);
			  --Read_Register_B_Input : in STD_LOGIC_VECTOR(4 downto 0);
           RF_Wr_DataSel : out  STD_LOGIC;
			  RF_WrEn : out STD_LOGIC;
			  Mem_Data : out STD_LOGIC_VECTOR(31 downto 0);
			  ALU_Data : out STD_LOGIC_VECTOR(31 downto 0);
			  Write_Register_Out : out STD_LOGIC_VECTOR (4 downto 0)
			  --Read_Register_A_Out : out STD_LOGIC_VECTOR(4 downto 0);
			  --Read_Register_B_Out : out STD_LOGIC_VECTOR(4 downto 0)
			  );
	end component;
	
	component MUX_3_to_1_32bit is
    Port ( In0 : in STD_LOGIC_VECTOR (31 downto 0);
           In1 : in STD_LOGIC_VECTOR (31 downto 0);
			  In2 : in STD_LOGIC_VECTOR (31 downto 0);
           Sel : in STD_LOGIC_VECTOR (1 downto 0);
           Dout : out STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal dont_care_vector : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal dont_care : STD_LOGIC := '0';
	
	signal InstrRegEn : STD_LOGIC;
	signal instruction : STD_LOGIC_VECTOR (31 downto 0); -- The instruction from the ROM, forwarded to the decoding stage and the Control
	
	signal alu_zero_signal : STD_LOGIC;
	signal pc_sel : STD_LOGIC;
	
	signal instruction_to_reg : STD_LOGIC_VECTOR (31 downto 0);
	
	signal WB_Control_to_exmem : STD_LOGIC_VECTOR (31 downto 0);
	signal M_Control_to_exmem : STD_LOGIC_VECTOR (31 downto 0);
	signal write_reg_to_exmem : STD_LOGIC_VECTOR (4 downto 0);
	
	signal WB_Control_to_memwb : STD_LOGIC_VECTOR (31 downto 0);
	signal write_reg_to_memwb : STD_LOGIC_VECTOR (4 downto 0);
	
	signal ALU_Bin_sel : STD_LOGIC;
	signal ALU_func : STD_LOGIC_VECTOR (3 downto 0);
	signal immed_to_cluster : STD_LOGIC_VECTOR (31 downto 0);
	signal rf_a_to_cluster : STD_LOGIC_VECTOR (31 downto 0);
	signal rf_b_to_cluster : STD_LOGIC_VECTOR (31 downto 0);
	
	signal alu_out_to_exmem : STD_LOGIC_VECTOR (31 downto 0);
	signal rf_a_to_exec : STD_LOGIC_VECTOR (31 downto 0);
	signal rf_b_to_exec : STD_LOGIC_VECTOR (31 downto 0);
	signal immed_to_exec : STD_LOGIC_VECTOR (31 downto 0);
	
	signal MEM_WrEn : STD_LOGIC;
	signal Byte_ExtrEn : STD_LOGIC;
	
	signal alu_out : STD_LOGIC_VECTOR (31 downto 0);
	
	signal MEM_DataIn : STD_LOGIC_VECTOR (31 downto 0);
	signal MEM_DataOut : STD_LOGIC_VECTOR (31 downto 0);
	
	signal RF_Wr_DataSel : STD_LOGIC;
	signal RF_WrEn : STD_LOGIC;
	
	signal MEM_writeback : STD_LOGIC_VECTOR (31 downto 0);
	signal ALU_writeback : STD_LOGIC_VECTOR (31 downto 0);
	signal RF_Wr_Addr : STD_LOGIC_VECTOR (4 downto 0);
	
	signal RF_Wr_Data : STD_LOGIC_VECTOR (31 downto 0);
	
	signal rf_a_to_alu : STD_LOGIC_VECTOR (31 downto 0);
	signal rf_b_to_alu : STD_LOGIC_VECTOR (31 downto 0);
	
	signal Read_A_Addr_to_idex : STD_LOGIC_VECTOR (4 downto 0);
	signal Read_B_Addr_to_idex : STD_LOGIC_VECTOR (4 downto 0);
	
	signal Read_A_Addr_Out : STD_LOGIC_VECTOR (4 downto 0);
	signal Read_B_Addr_Out : STD_LOGIC_VECTOR (4 downto 0);
	
begin
	pc_sel <= (Branch_Eq AND alu_zero_signal) OR 
				 (Branch_not_Eq AND (NOT alu_zero_signal));

	if_stage : IFSTAGE port map(PC_Immed => dont_care_vector, 
										 PC_sel => pc_sel, 
										 PC_LdEn => PC_LdEn, 
									    RST => RST, 
										 CLK => CLK, 
										 Instr => instruction_to_reg
										 );

	Instr <= instruction;
	
	instruction_register : Rgster port map(CLK => CLK, 
														RST => RST, 
														WE => '1', 
														DataIN => instruction_to_reg, 
														DataOUT => instruction
														);
	
	dec_stage : DECSTAGE port map(Instr => instruction, 
											RF_WrEn => RF_WrEn, 
											ALU_out => ALU_writeback, 
											MEM_out => MEM_writeback, 
											RF_WrData_sel => RF_Wr_DataSel,
											RF_B_sel => RF_B_sel,
											RF_Wr_Addr => RF_Wr_Addr,
											Immed_sel => Immed_sel, 
											CLK => CLK, 
											RST => RST, 
											Immed => immed_to_cluster, 
											RF_A => rf_a_to_cluster, 
											RF_B => rf_b_to_cluster,
											RF_Wr_Data => RF_Wr_Data,
											Read_A_Addr => Read_A_Addr_to_idex,
											Read_B_Addr => Read_B_Addr_to_idex
											);
											
	id_ex : IDEX_Cluster port map(CLK => CLK,
											RST => RST,
											WB_ControlIn => WB_Control,
											M_ControlIn => M_Control,
											EX_ControlIn => EX_Control,
											RF_A_Data_Input => rf_a_to_cluster,
											RF_B_Data_Input => rf_b_to_cluster,
											Immediate_Data_Input => immed_to_cluster,
											Write_Register_Input => instruction(20 downto 16),
											Read_Register_A_Input => Read_A_Addr_to_idex,
											Read_Register_B_Input => Read_B_Addr_to_idex,
											WB_ControlOut => WB_Control_to_exmem,
											M_ControlOut => M_Control_to_exmem,
											ALU_Bin_Sel => ALU_Bin_Sel,
											ALU_func => ALU_func,
											RF_A_DataOut => rf_a_to_exec,
											RF_B_DataOut => rf_b_to_exec,
											Immediate_DataOut => immed_to_exec,
											Write_Register_Out => write_reg_to_exmem,
											Read_Register_A_Out => rf_a_addr,
											Read_Register_B_Out => rf_b_addr
											);
											
	rf_a_mux : MUX_3_to_1_32bit port map(In0 => rf_a_to_exec,
													 In1 => alu_out,
													 In2 => RF_Wr_Data,
													 Sel => hazard_select(1 downto 0),
													 Dout => rf_a_to_alu
													 );
													 
	rf_b_mux : MUX_3_to_1_32bit port map(In0 => rf_b_to_exec,
													 In1 => alu_out,
													 In2 => RF_Wr_Data,
													 Sel => hazard_select(3 downto 2),
													 Dout => rf_b_to_alu
													 );
	
	alu_stage : ALUSTAGE port map(RF_A => rf_a_to_alu, 
											RF_B => rf_b_to_alu, 
											Immed => immed_to_exec, 
											ALU_Bin_sel => ALU_Bin_Sel, 
											ALU_func => ALU_func, 
											ALU_out => alu_out_to_exmem,
											Zero => alu_zero_signal,
											Cout => Cout,
											Ovf => Ovf
											);
											
	ex_mem : EXMEM_Cluster port map(CLK => CLK,
											  RST => RST,
											  WB_ControlIn => WB_Control_to_exmem,
											  M_ControlIn => M_Control_to_exmem,
											  ALU_Data_Input => alu_out_to_exmem,
											  RF_B_Data_Input => rf_b_to_alu,
											  Write_Register_Input => write_reg_to_exmem,
											  --Read_Register_A_Input =>
											  --Read_Register_B_Input =>
											  WB_ControlOut => WB_Control_to_memwb,
											  MEM_WrEn => MEM_WrEn,
											  Byte_ExtrEn => Byte_ExtrEn,
											  ALU_Data => alu_out,
											  RF_B_DataOut => MEM_Datain,
											  Write_Register_Out => write_reg_to_memwb
											  --Read_Register_A_Out =>
											  --Read_Register_B_Out =>
											  );
											  
	exmem_wraddr <= write_reg_to_memwb;
		
	mem_stage : MEMSTAGE port map(CLK => CLK, 
											Mem_WrEn => MEM_WrEn,
											ALU_MEM_Addr => alu_out,
											Byte_ExtrEn => Byte_ExtrEn,
											MEM_DataIn => MEM_DataIn, 
											MEM_DataOut => MEM_DataOut
											);
											
	mem_wb : MEMWB_Cluster port map(CLK => CLK,
											  RST => RST,
											  WB_ControlIn => WB_Control_to_memwb,
											  Mem_Data_Input => MEM_DataOut,
											  ALU_Data_Input => alu_out,
											  Write_Register_Input => write_reg_to_memwb,
											  --Read_Register_A_Input =>
											  --Read_Register_B_Input =>
											  RF_Wr_DataSel => RF_Wr_DataSel,
											  RF_WrEn => RF_WrEn,
											  Mem_Data => MEM_writeback,
											  ALU_Data => ALU_writeback,
											  Write_Register_Out => RF_Wr_Addr
											  --Read_Register_A_Out =>
											  --Read_Register_B_Out =>
											  );
											  
	memwb_wraddr <= RF_Wr_Addr;
										  
end Behavioral;
