----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:40:23 03/14/2025 
-- Design Name: 
-- Module Name:    MUX_32_to_1 - Behavioral 
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

entity MUX_32_to_1 is
    Port ( Addr : in  STD_LOGIC_VECTOR (4 downto 0);
			  Din0, Din1, Din2, Din3, Din4, Din5, Din6, Din7, Din8, Din9,
			  Din10, Din11, Din12, Din13, Din14, Din15, Din16, Din17, Din18, Din19,
			  Din20, Din21, Din22, Din23, Din24, Din25, Din26, Din27, Din28, Din29,
			  Din30, Din31 : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_32_to_1;

architecture Behavioral of MUX_32_to_1 is

begin
	Dout <= Din0 when Addr = "00000" else
			  Din1 when Addr = "00001" else
			  Din2 when Addr = "00010" else
			  Din3 when Addr = "00011" else
           Din4 when Addr = "00100" else
           Din5 when Addr = "00101" else
           Din6 when Addr = "00110" else
           Din7 when Addr = "00111" else
           Din8 when Addr = "01000" else
           Din9 when Addr = "01001" else
           Din10 when Addr = "01010" else
			  Din11 when Addr = "01011" else
           Din12 when Addr = "01100" else
           Din13 when Addr = "01101" else
           Din14 when Addr = "01110" else
           Din15 when Addr = "01111" else
           Din16 when Addr = "10000" else
           Din17 when Addr = "10001" else
           Din18 when Addr = "10010" else
           Din19 when Addr = "10011" else
           Din20 when Addr = "10100" else
			  Din21 when Addr = "10101" else
           Din22 when Addr = "10110" else
           Din23 when Addr = "10111" else
           Din24 when Addr = "11000" else
           Din25 when Addr = "11001" else
           Din26 when Addr = "11010" else
           Din27 when Addr = "11011" else
           Din28 when Addr = "11100" else
           Din29 when Addr = "11101" else
           Din30 when Addr = "11110" else
           Din31 when Addr = "11111" else
    		  (others => '0');

end Behavioral;

