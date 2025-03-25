----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:47:07 03/16/2025 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

	component MUX_2_to_1 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  En : in STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Adder_32_bit is
    Port ( Input : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Adder_Immediate is
    Port ( Input : in  STD_LOGIC_VECTOR (31 downto 0);
           Immediate : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component InstructionMemory is
    port ( a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			  spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	end component;
	
	component Rgster is
    Port ( CLK : in  STD_LOGIC;
			  RST : in STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIN : in  STD_LOGIC_VECTOR (31 downto 0);
           DataOUT : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal PC_Incr : STD_LOGIC_VECTOR(31 downto 0); -- The incremented by 4 bytes PC number
	signal PC_Incr_Immed : STD_LOGIC_VECTOR(31 downto 0); -- The incremented by 4+Immed bytes PC number
	signal PC_DataIn : STD_LOGIC_VECTOR(31 downto 0); -- The new PC value
	signal Instr_Addr : STD_LOGIC_VECTOR(31 downto 0); -- The PC value which also shows which address the instruction is located in
begin
	PC_MUX : MUX_2_to_1 port map (In0 => PC_Incr, In1 => PC_Incr_Immed, En => PC_Sel, Dout => PC_DataIn);
	
	PC : Rgster port map (CLK => CLK, RST => RST, WE => PC_LdEn, DataIN => PC_DataIn, DataOUT => Instr_Addr);
	
	PC_Incrementor : Adder_32_bit port map (Input => Instr_Addr, Output => PC_Incr);
	
	Immediate_Adder : Adder_Immediate port map (Input => PC_Incr, Immediate => PC_Immed, Output => PC_Incr_Immed);
	
	Instruction_Memory : InstructionMemory port map (a => Instr_Addr(11 downto 2), spo => Instr);

end Behavioral;

