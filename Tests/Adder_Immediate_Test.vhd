--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:35:21 03/16/2025
-- Design Name:   
-- Module Name:   /home/vlassisioa/Lab1/Adder_Immediate_Test.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Adder_Immediate
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
 
ENTITY Adder_Immediate_Test IS
END Adder_Immediate_Test;
 
ARCHITECTURE behavior OF Adder_Immediate_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Adder_Immediate
    PORT(
         Input : IN  std_logic_vector(31 downto 0);
         Immediate : IN  std_logic_vector(31 downto 0);
         Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(31 downto 0) := (others => '0');
   signal Immediate : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adder_Immediate PORT MAP (
          Input => Input,
          Immediate => Immediate,
          Output => Output
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		
		Input <= "00000000000000001100010001100000";
		Immediate <= "00000000000000001000000001000000";
		
      wait for 10 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
