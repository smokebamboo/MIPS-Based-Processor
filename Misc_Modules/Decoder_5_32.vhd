----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:17:12 03/13/2025 
-- Design Name: 
-- Module Name:    Decoder_5_32 - Behavioral 
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

entity Decoder_5_32 is
    Port ( DecodeIn : in  STD_LOGIC_VECTOR (4 downto 0);
           DecodeOut : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder_5_32;

architecture Behavioral of Decoder_5_32 is

begin
	
	DecodeOut <= "00000000000000000000000000000001" when (DecodeIn = "00000") else
					 "00000000000000000000000000000010" when (DecodeIn = "00001") else
					 "00000000000000000000000000000100" when (DecodeIn = "00010") else
					 "00000000000000000000000000001000" when (DecodeIn = "00011") else
					 "00000000000000000000000000010000" when (DecodeIn = "00100") else
					 "00000000000000000000000000100000" when (DecodeIn = "00101") else
					 "00000000000000000000000001000000" when (DecodeIn = "00110") else
					 "00000000000000000000000010000000" when (DecodeIn = "00111") else
					 "00000000000000000000000100000000" when (DecodeIn = "01000") else
					 "00000000000000000000001000000000" when (DecodeIn = "01001") else
					 "00000000000000000000010000000000" when (DecodeIn = "01010") else
					 "00000000000000000000100000000000" when (DecodeIn = "01011") else
					 "00000000000000000001000000000000" when (DecodeIn = "01100") else
					 "00000000000000000010000000000000" when (DecodeIn = "01101") else
					 "00000000000000000100000000000000" when (DecodeIn = "01110") else
					 "00000000000000001000000000000000" when (DecodeIn = "01111") else
					 "00000000000000010000000000000000" when (DecodeIn = "10000") else
					 "00000000000000100000000000000000" when (DecodeIn = "10001") else
					 "00000000000001000000000000000000" when (DecodeIn = "10010") else
					 "00000000000010000000000000000000" when (DecodeIn = "10011") else
					 "00000000000100000000000000000000" when (DecodeIn = "10100") else
					 "00000000001000000000000000000000" when (DecodeIn = "10101") else
					 "00000000010000000000000000000000" when (DecodeIn = "10110") else
					 "00000000100000000000000000000000" when (DecodeIn = "10111") else
					 "00000001000000000000000000000000" when (DecodeIn = "11000") else
					 "00000010000000000000000000000000" when (DecodeIn = "11001") else
					 "00000100000000000000000000000000" when (DecodeIn = "11010") else
					 "00001000000000000000000000000000" when (DecodeIn = "11011") else
					 "00010000000000000000000000000000" when (DecodeIn = "11100") else
					 "00100000000000000000000000000000" when (DecodeIn = "11101") else
					 "01000000000000000000000000000000" when (DecodeIn = "11110") else
					 "10000000000000000000000000000000" when (DecodeIn = "11111") else
					 "00000000000000000000000000000000";
end Behavioral;

