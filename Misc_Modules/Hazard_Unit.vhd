----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:12:18 05/21/2025 
-- Design Name: 
-- Module Name:    Hazard_Unit - Behavioral 
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

entity Hazard_Unit is
	Port(rf_a : in STD_LOGIC_VECTOR (4 downto 0);
		  rf_b : in STD_LOGIC_VECTOR (4 downto 0);
		  exmem_wraddr : in STD_LOGIC_VECTOR (4 downto 0);
		  memwb_wraddr : in STD_LOGIC_VECTOR (4 downto 0);
		  idex_wraddr : in STD_LOGIC_VECTOR (4 downto 0);
		  rf_a_addr_to_stall : in STD_LOGIC_VECTOR (4 downto 0);
		  rf_b_addr_to_stall : in STD_LOGIC_VECTOR (4 downto 0);
		  idex_mem_read : in STD_LOGIC;		  
		
		  sel : out STD_LOGIC_VECTOR (3 downto 0);
		  pc_en : out STD_LOGIC;
		  ifid_en : out STD_LOGIC;
		  control_mux_en : out STD_LOGIC);
end Hazard_Unit;

architecture Behavioral of Hazard_Unit is

begin

	process(rf_a, rf_b, exmem_wraddr, memwb_wraddr)
	begin
		if (exmem_wraddr /= "00000") 
			 and (exmem_wraddr = rf_a) then
			
			sel(1 downto 0) <= "01";

		elsif (memwb_wraddr /= "00000")
				 and (memwb_wraddr = rf_a) then
			 
			sel(1 downto 0) <= "10";
	
		else
		
			sel(1 downto 0) <= "00";
		
		end if;
	
		if (exmem_wraddr /= "00000") 
			 and (exmem_wraddr = rf_b) then
		 
			sel(3 downto 2) <= "01";

		elsif (memwb_wraddr /= "00000")
				 and (memwb_wraddr = rf_b) then
			 
			sel(3 downto 2) <= "10";
		
		else
		
			sel(3 downto 2) <= "00";
		
		end if;
	end process;
	
	process(idex_mem_read, idex_wraddr, idex_wraddr, rf_a_addr_to_stall, rf_a_addr_to_stall)
	begin
		if (idex_mem_read = '1' AND
			 idex_wraddr /= "00000" AND
			 (idex_wraddr = rf_a_addr_to_stall OR
			 idex_wraddr = rf_b_addr_to_stall)) then
			 
			pc_en <= '0';
			ifid_en <= '0';
			control_mux_en <= '1';
			
		else
			pc_en <= '1';
			ifid_en <= '1';
			control_mux_en <= '0';
			
		end if;
	end process;
	
end Behavioral;

