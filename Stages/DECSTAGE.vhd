----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:56:53 03/16/2025 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECSTAGE is
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
end DECSTAGE;

architecture Behavioral of DECSTAGE is

	component MUX_2_to_1 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  En : in STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component MUX_2_to_1_5bit is
    Port ( In0 : in  STD_LOGIC_VECTOR (4 downto 0);
           In1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Sel : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	
	component RegisterFile is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           WrEn : in  STD_LOGIC;
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component ImmedHandler is
    Port ( Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           ImmedIn : in  STD_LOGIC_VECTOR (15 downto 0);
           ImmedOut : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal Ard2 : STD_LOGIC_VECTOR (4 downto 0);
	signal Din : STD_LOGIC_VECTOR (31 downto 0);
begin
	Reg_MUX : MUX_2_to_1_5bit port map (In0 => Instr(15 downto 11), In1 => Instr(20 downto 16), Sel => RF_B_sel, Dout => Ard2);
	
	Data_Write_MUX : MUX_2_to_1 port map (In0 => ALU_out, In1 => MEM_out, En => RF_WrData_sel, Dout => Din);
	
	RF : RegisterFile port map (CLK => CLK, RST => RST, Ard1 => Instr(25 downto 21), Ard2 => Ard2, WrEn => RF_WrEn, Awr => Instr(20 downto 16), Din => Din, Dout1 => RF_A, Dout2 => RF_B);
	
	Immediate_Handler : ImmedHandler port map (Sel => Immed_sel, ImmedIn => Instr(15 downto 0), ImmedOut => Immed);
end Behavioral;

