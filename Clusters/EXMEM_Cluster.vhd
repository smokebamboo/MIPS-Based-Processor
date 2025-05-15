----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:20:31 05/15/2025 
-- Design Name: 
-- Module Name:    EXMEM_Cluster - Behavioral 
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

entity EXMEM_Cluster is
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
end EXMEM_Cluster;

architecture Behavioral of EXMEM_Cluster is

	component Rgster is
		Port (CLK : in  STD_LOGIC;
				RST : in STD_LOGIC;
				WE : in  STD_LOGIC;
				DataIN : in  STD_LOGIC_VECTOR (31 downto 0);
				DataOUT : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal M_ControlOut : STD_LOGIC_VECTOR (31 downto 0);
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
										  
	alu_out_register : Rgster port map(CLK => CLK, 
												  RST => RST, 
												  WE => '1', 
												  DataIN => ALU_Data_Input, 
												  DataOUT => ALU_Data);
	
	MEM_WrEn <= M_ControlOut(0);
	Byte_ExtrEn <= M_ControlOut(1);
	
end Behavioral;

