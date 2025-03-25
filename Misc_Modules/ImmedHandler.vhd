----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:35:37 03/21/2025 
-- Design Name: 
-- Module Name:    ImmedHandler - Behavioral 
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

entity ImmedHandler is
    Port ( Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           ImmedIn : in  STD_LOGIC_VECTOR (15 downto 0);
           ImmedOut : out  STD_LOGIC_VECTOR (31 downto 0));
end ImmedHandler;

architecture Behavioral of ImmedHandler is

	signal zero_vector : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin

	with sel select
		ImmedOut <= STD_LOGIC_VECTOR(resize(signed(ImmedIn), 32)) when "00", -- SignExtend(Imm)
						STD_LOGIC_VECTOR(shift_left(resize(signed(ImmedIn), 32), 2)) when "01", -- SignExtend(Imm) << 2
						(zero_vector & ImmedIn) when "10", -- ZeroFill(Imm)
						(ImmedIn & zero_vector) when others; -- Imm << 16

end Behavioral;

