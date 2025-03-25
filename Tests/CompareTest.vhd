--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:22:46 03/14/2025
-- Design Name:   
-- Module Name:   /home/ise/Lab1/CompareTest.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CompareModule
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
 
ENTITY CompareTest IS
END CompareTest;
 
ARCHITECTURE behavior OF CompareTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CompareModule
    PORT(
         Enable : IN  std_logic;
         In1 : IN  std_logic_vector(4 downto 0);
         In2 : IN  std_logic_vector(4 downto 0);
         Output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Enable : std_logic := '0';
   signal In1 : std_logic_vector(4 downto 0) := (others => '0');
   signal In2 : std_logic_vector(4 downto 0) := (others => '0');
	
	--Outputs
   signal Output : std_logic := '0';
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CompareModule PORT MAP (
          Enable => Enable,
          In1 => In1,
          In2 => In2,
          Output => Output
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		
		Enable <= '0';
		In1 <= "00001";
		In2 <= "00001";
		wait for 10 ns;
		
		Enable <= '1';
		wait for 10 ns;
		
		In1 <= "00000";
		
      wait for 10 ns;

      -- insert stimulus here 

   end process;

END;
