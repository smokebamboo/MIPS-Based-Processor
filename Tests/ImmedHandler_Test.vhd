--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:49:12 03/21/2025
-- Design Name:   
-- Module Name:   /home/vlassisioa/Lab1/ImmedHandler_Test.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ImmedHandler
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
 
ENTITY ImmedHandler_Test IS
END ImmedHandler_Test;
 
ARCHITECTURE behavior OF ImmedHandler_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ImmedHandler
    PORT(
         Sel : IN  std_logic_vector(5 downto 0);
         ImmedIn : IN  std_logic_vector(15 downto 0);
         ImmedOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Sel : std_logic_vector(5 downto 0) := (others => '0');
   signal ImmedIn : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal ImmedOut : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ImmedHandler PORT MAP (
          Sel => Sel,
          ImmedIn => ImmedIn,
          ImmedOut => ImmedOut
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		ImmedIn <= "1111111111111111";
		
		-- Sign Extend
		Sel <= "111000";
		wait for 10 ns;
		
		-- Imm << 16
		Sel <= "111001";
      wait for 10 ns;
		
		-- Sign Extend
		Sel <= "110000";
		wait for 10 ns;
		
		-- ZeroFill
		Sel <= "110010";
		wait for 10 ns;
		
		-- ZeroFill
		Sel <= "110011";
		wait for 10 ns;
		
		-- SignExtend << 2
		Sel <= "111111";
		wait for 10 ns;
		
		-- SignExtend << 2
		Sel <= "010000";
		wait for 10 ns;
		
		-- SignExtend << 2
		Sel <= "010001";
		wait for 10 ns;
		
		-- SignExtend
		Sel <= "000011";
		wait for 10 ns;
		
		-- SignExtend
		Sel <= "000111";
		wait for 10 ns;
		
		-- SignExtend
		Sel <= "001111";
		wait for 10 ns;
		
		-- SignExtend
		Sel <= "011111";
		wait for 10 ns;
		

      -- insert stimulus here 

      wait;
   end process;

END;
