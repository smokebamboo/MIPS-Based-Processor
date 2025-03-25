----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:46:09 03/22/2025 
-- Design Name: 
-- Module Name:    Byte_Extractor - Behavioral 
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

entity Byte_Extractor is
    Port ( Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           WordIn : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Byte_Extractor;

architecture Behavioral of Byte_Extractor is

	signal zero_vector : STD_LOGIC_VECTOR (23 downto 0) := (others => '0');
begin

	Output <= (zero_vector & WordIn(7 downto 0)) when Sel = "00" else
				 (zero_vector & WordIn(15 downto 8)) when Sel = "01" else
				 (zero_vector & WordIn(23 downto 16)) when Sel = "10" else
				 (zero_vector & WordIn(31 downto 24)) when Sel = "11";

end Behavioral;

