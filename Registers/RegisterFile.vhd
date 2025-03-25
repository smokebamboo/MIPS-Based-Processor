----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:01:21 03/15/2025 
-- Design Name: 
-- Module Name:    RegisterFile - Behavioral 
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

entity RegisterFile is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           WrEn : in  STD_LOGIC;
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is

	component Decoder_5_32 is
		Port ( DecodeIn : in  STD_LOGIC_VECTOR (4 downto 0);
				DecodeOut : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component Rgster is
		Port ( CLK : in  STD_LOGIC;
				RST : in STD_LOGIC;
				WE : in  STD_LOGIC;
				DataIN : in  STD_LOGIC_VECTOR (31 downto 0);
				DataOUT : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component MUX_32_to_1 is
    Port ( Addr : in  STD_LOGIC_VECTOR (4 downto 0);
			  Din0, Din1, Din2, Din3, Din4, Din5, Din6, Din7, Din8, Din9,
			  Din10, Din11, Din12, Din13, Din14, Din15, Din16, Din17, Din18, Din19,
			  Din20, Din21, Din22, Din23, Din24, Din25, Din26, Din27, Din28, Din29,
			  Din30, Din31 : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;


		-- FOR OPERATION WITH COMPARE MODULES UNCOMMENT THESE	
		
	--component MUX_2_to_1 is
   -- Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
   --        In1 : in  STD_LOGIC_VECTOR (31 downto 0);
	--		  En : in STD_LOGIC;
   --        Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	--end component;							  

	--component CompareModule is
   -- Port ( Enable : in STD_LOGIC;
   --        In1 : in STD_LOGIC_VECTOR (4 downto 0);
   --        In2 : in STD_LOGIC_VECTOR (4 downto 0);
   --        Output : out STD_LOGIC);
	--end component;

	signal decoder_output : STD_LOGIC_VECTOR (31 downto 0); -- The output of the decoder. The high bit shows the register to write.
	signal reg_wr_enabled : STD_LOGIC_VECTOR (31 downto 0); -- The output of the decoder AND if writing is enabled in the file.
	
	type register_data is array (0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
	signal reg_data : register_data; -- All the output data of the registers in an array for easy access.
	
	
		-- FOR OPERATION WITH COMPARE MODULES UNCOMMENT THESE								  

	--signal MuxOUT_input1 : STD_LOGIC_VECTOR (31 downto 0); -- The data from the register. Will be fead into the Output multiplexer.
	--signal MuxOUT_input2 : STD_LOGIC_VECTOR (31 downto 0);
	
	--signal MuxOUT_WrEn1 : STD_LOGIC; -- If '0' the output will be the output of the register. If '1' the output will be the new value that will be written in the register.
	--signal MuxOUT_WrEn2 : STD_LOGIC;
begin
	
	Wr_Decoder : Decoder_5_32 port map (DecodeIN => Awr, DecodeOUT => decoder_output);
	
	genWr: for i in 0 to 31 generate
		reg_wr_enabled(i) <= decoder_output(i) AND WrEn;
	end generate;
	
	Regstr : Rgster port map (CLK => CLK, RST => RST, WE => '0', DataIN => Din, DataOUT => reg_data(0));
	genRegs: for i in 1 to 31 generate
		Regstr : Rgster port map (CLK => CLK, RST => RST, WE => reg_wr_enabled(i), DataIN => Din, DataOUT => reg_data(i));
	end generate;
	
	ReadMUX1 : MUX_32_to_1 port map (Ard1, reg_data(0), reg_data(1), reg_data(2), reg_data(3), reg_data(4), reg_data(5), reg_data(6), reg_data(7), reg_data(8), reg_data(9),
										  reg_data(10), reg_data(11), reg_data(12), reg_data(13), reg_data(14), reg_data(15), reg_data(16), reg_data(17), reg_data(18), reg_data(19),
										  reg_data(20), reg_data(21), reg_data(22), reg_data(23), reg_data(24), reg_data(25), reg_data(26), reg_data(27), reg_data(28), reg_data(29),
										  reg_data(30), reg_data(31), Dout1);
									  
	ReadMUX2 : MUX_32_to_1 port map (Ard2, reg_data(0), reg_data(1), reg_data(2), reg_data(3), reg_data(4), reg_data(5), reg_data(6), reg_data(7), reg_data(8), reg_data(9),
										  reg_data(10), reg_data(11), reg_data(12), reg_data(13), reg_data(14), reg_data(15), reg_data(16), reg_data(17), reg_data(18), reg_data(19),
										  reg_data(20), reg_data(21), reg_data(22), reg_data(23), reg_data(24), reg_data(25), reg_data(26), reg_data(27), reg_data(28), reg_data(29),
										  reg_data(30), reg_data(31), Dout2);
		
		
		-- FOR OPERATION WITH COMPARE MODULES REPLACE WITH THESE ReadMUXes
	
	--ReadMUX1 : MUX_32_to_1 port map (Ard1, reg_data(0), reg_data(1), reg_data(2), reg_data(3), reg_data(4), reg_data(5), reg_data(6), reg_data(7), reg_data(8), reg_data(9),
	--									  reg_data(10), reg_data(11), reg_data(12), reg_data(13), reg_data(14), reg_data(15), reg_data(16), reg_data(17), reg_data(18), reg_data(19),
	--									  reg_data(20), reg_data(21), reg_data(22), reg_data(23), reg_data(24), reg_data(25), reg_data(26), reg_data(27), reg_data(28), reg_data(29),
	--									  reg_data(30), reg_data(31), MuxOUT_input1);
	--									  
	--ReadMUX2 : MUX_32_to_1 port map (Ard2, reg_data(0), reg_data(1), reg_data(2), reg_data(3), reg_data(4), reg_data(5), reg_data(6), reg_data(7), reg_data(8), reg_data(9),
	--									  reg_data(10), reg_data(11), reg_data(12), reg_data(13), reg_data(14), reg_data(15), reg_data(16), reg_data(17), reg_data(18), reg_data(19),
	--									  reg_data(20), reg_data(21), reg_data(22), reg_data(23), reg_data(24), reg_data(25), reg_data(26), reg_data(27), reg_data(28), reg_data(29),
	--									  reg_data(30), reg_data(31), MuxOUT_input2);
	--
	
	
		-- FOR OPERATION WITH COMPARE MODULES UNCOMMENT THESE								  
	
	--Comp_mod1 : CompareModule port map (Enable => WrEn, In1 => Awr, In2 => Ard1, Output => MuxOUT_WrEn1);
	--Comp_mod2 : CompareModule port map (Enable => WrEn, In1 => Awr, In2 => Ard2, Output => MuxOUT_WrEn2);
	
	--MuxOUT1 : MUX_2_to_1 port map (In0 => MuxOUT_input1, In1 => Din, En => MuxOUT_WrEn1, Dout => Dout1);
	--MuxOUT2 : MUX_2_to_1 port map (In0 => MuxOUT_input2, In1 => Din, En => MuxOUT_WrEn2, Dout => Dout2);
end Behavioral;

