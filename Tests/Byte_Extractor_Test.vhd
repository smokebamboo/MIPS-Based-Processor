--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:51:25 03/25/2025
-- Design Name:   
-- Module Name:   /home/vlassisioa/Lab1/Byte_Extractor_Test.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Byte_Extractor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Byte_Extractor_Test IS
END Byte_Extractor_Test;
 
ARCHITECTURE behavior OF Byte_Extractor_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Byte_Extractor
    PORT(
         Sel : IN  std_logic_vector(1 downto 0);
         WordIn : IN  std_logic_vector(31 downto 0);
         Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Sel : std_logic_vector(1 downto 0) := (others => '0');
   signal WordIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Byte_Extractor PORT MAP (
          Sel => Sel,
          WordIn => WordIn,
          Output => Output
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		WordIn <= "01010101111111111010101011001100";
      wait for 10 ns;	
		Sel <= "00";
      wait for 10 ns;
		Sel <= "01";
		wait for 10 ns;
		Sel <= "10";
		wait for 10 ns;
		Sel <= "11";

      -- insert stimulus here 

      wait;
   end process;

END;
