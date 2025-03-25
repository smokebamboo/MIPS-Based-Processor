----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:07:46 03/13/2025 
-- Design Name: 
-- Module Name:    Register - Behavioral 
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

entity Rgster is
    Port ( CLK : in  STD_LOGIC;
			  RST : in STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIN : in  STD_LOGIC_VECTOR (31 downto 0);
           DataOUT : out  STD_LOGIC_VECTOR (31 downto 0));
end Rgster;

architecture Behavioral of Rgster is

begin
	process
	begin
		wait until rising_edge(CLK);
		if (RST = '1') then
			DataOUT <= (others => '0');
		elsif (WE = '1') then
			DataOUT <= DataIN;
		end if;
	end process;

end Behavioral;

