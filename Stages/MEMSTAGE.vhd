----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:54:34 03/16/2025 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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

entity MEMSTAGE is
    Port ( CLK : in STD_LOGIC;
			  Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
			  Byte_ExtrEn : in STD_LOGIC;
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

	component MEMSTAGE_MEM is
	 port ( a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			  d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			  clk : IN STD_LOGIC;
			  we : IN STD_LOGIC;
			  spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END component;
	
	component Byte_Extractor is
    Port ( Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           WordIn : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component MUX_2_to_1 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  En : in STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal mem_word : STD_LOGIC_VECTOR (31 downto 0); -- The word as the memory module reads it
	
	signal extr_byte : STD_LOGIC_VECTOR (31 downto 0); -- The byte from the extractor

begin
	Mem : MEMSTAGE_MEM port map (a => ALU_MEM_Addr(11 downto 2), d => MEM_DataIn, clk => CLK, we => Mem_WrEn, spo => mem_word);
	
	Extractor : Byte_Extractor port map (Sel => ALU_MEM_Addr(1 downto 0), WordIn => mem_word, Output => extr_byte);
	
	Byte_Mux : MUX_2_to_1 port map(In0 => mem_word, In1 => extr_byte, En => Byte_ExtrEn, Dout => MEM_DataOut);

end Behavioral;

