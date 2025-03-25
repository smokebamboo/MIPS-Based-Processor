----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:20:54 03/14/2025 
-- Design Name: 
-- Module Name:    CompareModule - Behavioral 
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

entity CompareModule is
    Port ( Enable : in STD_LOGIC;
           In1 : in STD_LOGIC_VECTOR (4 downto 0);
           In2 : in STD_LOGIC_VECTOR (4 downto 0);
           Output : out STD_LOGIC);
end CompareModule;

architecture Behavioral of CompareModule is

begin

Output <= '1' when (Enable = '1' AND (In1 /= "00000") AND (In1 = In2)) else
			 '0';

end Behavioral;

