----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:12:19 03/08/2025 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

begin
	process (A, B, Op)
	
	variable ext_result : std_logic_vector(32 downto 0);
	variable result : std_logic_vector(31 downto 0);
	variable temp_carry : std_logic;
	variable temp_ovf : std_logic;
	
	begin
		case (Op) is
			when ("0000") =>
				ext_result := ('0' & A) + ('0' & B);
				
				result := ext_result(31 downto 0);
				Cout <= ext_result(32);
				Ovf <= (A(31) XNOR B(31)) AND (A(31) XOR ext_result(31));
			when ("0001") =>
				ext_result := '0' & (A - B);
				if (A < B) then
					Cout <= '1';
				end if;
				
				result := ext_result(31 downto 0);
				Ovf <= (A(31) XOR B(31)) AND (A(31) XOR ext_result(31));
			when ("0010") =>
				result := A AND B;
			when ("0011") =>
				result := A OR B;
			when ("0100") =>
				result := NOT A;
			when ("1000") =>
				result := std_logic_vector(shift_right(signed(A), 1));
			when ("1001") =>
				result := std_logic_vector(shift_right(unsigned(A), 1));
			when ("1010") =>
				result := std_logic_vector(shift_left(unsigned(A), 1));
			when ("1100") =>
				result := std_logic_vector(rotate_left(unsigned(A), 1));
			when ("1101") =>
				result := std_logic_vector(rotate_right(unsigned(A), 1));
			when others =>
		end case;
		
		if (result = "00000000000000000000000000000000") then
			Zero <= '1';
		else
			Zero <= '0';
		end if;
		
		Output <= result;
	end process;
end Behavioral;

