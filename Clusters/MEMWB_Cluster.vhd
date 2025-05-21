----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:30 05/14/2025 
-- Design Name: 
-- Module Name:    MEMWB_Cluster - Behavioral 
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

entity MEMWB_Cluster is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  WB_ControlIn : in STD_LOGIC_VECTOR(31 downto 0);
			  Mem_Data_Input : in STD_LOGIC_VECTOR(31 downto 0);
			  ALU_Data_input : in STD_LOGIC_VECTOR(31 downto 0);
			  Write_Register_Input : in STD_LOGIC_VECTOR(4 downto 0);
			  --Read_Register_A_Input : in STD_LOGIC_VECTOR(4 downto 0);
			  --Read_Register_B_Input : in STD_LOGIC_VECTOR(4 downto 0);
			  
           RF_Wr_DataSel : out  STD_LOGIC;
			  RF_WrEn : out STD_LOGIC;
			  Mem_Data : out STD_LOGIC_VECTOR(31 downto 0);
			  ALU_Data : out STD_LOGIC_VECTOR(31 downto 0);
			  Write_Register_Out : out STD_LOGIC_VECTOR(4 downto 0)
			  );
end MEMWB_Cluster;

architecture Behavioral of MEMWB_Cluster is

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
	
	signal WB_ControlOut : STD_LOGIC_VECTOR (31 downto 0);
begin
	WB_Register : Rgster port map(CLK => CLK,
											RST => RST,
											WE => '1',
											DataIN => WB_ControlIn,
											DataOUT => WB_ControlOut);
												
	mem_data_register : Rgster port map(CLK => CLK, 
													RST => RST, 
													WE => '1', 
													DataIN => Mem_Data_Input, 
													DataOUT => Mem_Data);
	
	alu_out_register : Rgster port map(CLK => CLK, 
												  RST => RST, 
												  WE => '1', 
												  DataIN => ALU_Data_Input, 
												  DataOUT => ALU_Data);
	
	destination_register : Register_5bit port map (CLK => CLK,
																  RST => RST,
																  WE => '1',
																  DataIN => Write_Register_Input,
																  DataOUT => Write_Register_Out);
																  
	--read_A_register : Register_5bit port map (CLK => CLK,
	--															  RST => RST,
	--															  WE => '1',
	--															  DataIN => Read_Register_B_Input,
	--															  DataOUT => Read_Register_A_Out);
																  
	--read_B_register : Register_5bit port map (CLK => CLK,
	--															  RST => RST,
	--															  WE => '1',
	--															  DataIN => Read_Register_B_Input,
	--															  DataOUT => Read_Register_A_Out);
																  
	RF_Wr_DataSel <= WB_ControlOut(0);
	RF_WrEn <= WB_ControlOut(1);
	
end Behavioral;

