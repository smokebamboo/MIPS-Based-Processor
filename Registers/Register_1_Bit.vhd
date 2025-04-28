----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:08:28 04/19/2025 
-- Design Name: 
-- Module Name:    Register_1_Bit - Behavioral 
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

entity Register_1_Bit is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIN : in  STD_LOGIC;
           DataOUT : out  STD_LOGIC);
end Register_1_Bit;

architecture Behavioral of Register_1_Bit is

begin
	process
	begin
		wait until rising_edge(CLK);
		if (RST = '1') then
			DataOUT <= '0';
		elsif (WE = '1') then
			DataOUT <= DataIN;
		end if;
	end process;

end Behavioral;

