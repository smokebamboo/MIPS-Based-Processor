----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:41:51 05/15/2025 
-- Design Name: 
-- Module Name:    IDEX_Cluster - Behavioral 
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

entity IDEX_Cluster is
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
end IDEX_Cluster;

architecture Behavioral of IDEX_Cluster is

	component Rgster is
		Port (CLK : in  STD_LOGIC;
				RST : in STD_LOGIC;
				WE : in  STD_LOGIC;
				DataIN : in  STD_LOGIC_VECTOR (31 downto 0);
				DataOUT : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Register_5bit is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIN : in  STD_LOGIC_VECTOR (4 downto 0);
           DataOUT : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	
	signal EX_ControlOut : STD_LOGIC_VECTOR (31 downto 0);
begin
	
	WB_Register : Rgster port map(CLK => CLK,
											RST => RST,
											WE => '1',
											DataIN => WB_ControlIn,
											DataOUT => WB_ControlOut);
											
	M_Register : Rgster port map(CLK => CLK,
										  RST => RST,
										  WE => '1',
										  DataIN => M_ControlIn,
										  DataOUT => M_ControlOut);
										  
	EX_Register : Rgster port map(CLK => CLK,
											RST => RST,
											WE => '1',
											DataIN => EX_ControlIn,
											DataOUT => EX_ControlOut);
											
	rf_A_register : Rgster port map(CLK => CLK, 
											  RST => RST, 
											  WE => '1', 
											  DataIN => RF_A_Data_Input, 
											  DataOUT => RF_A_DataOut);
											  
	rf_B_register : Rgster port map(CLK => CLK, 
											  RST => RST, 
											  WE => '1', 
											  DataIN => RF_B_Data_Input, 
											  DataOUT => RF_B_DataOut);
											  
	immediate_register : Rgster port map(CLK => CLK, 
													 RST => RST, 
													 WE => '1', 
													 DataIN => Immediate_Data_Input, 
													 DataOUT => Immediate_DataOut);
													 
	destination_register : Register_5bit port map (CLK => CLK,
																  RST => RST,
																  WE => '1',
																  DataIN => Write_Register_Input,
																  DataOUT => Write_Register_Out);
																  
	read_A_register : Register_5bit port map (CLK => CLK,
															RST => RST,
															WE => '1',
															DataIN => Read_Register_A_Input,
															DataOUT => Read_Register_A_Out);
																  
	read_B_register : Register_5bit port map (CLK => CLK,
															RST => RST,
															WE => '1',
															DataIN => Read_Register_B_Input,
															DataOUT => Read_Register_B_Out);
	
	ALU_Bin_Sel <= EX_ControlOut(0);
	ALU_func <= EX_ControlOut(4 downto 1);
	
end Behavioral;

