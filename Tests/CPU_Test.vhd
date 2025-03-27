--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:17:42 03/26/2025
-- Design Name:   
-- Module Name:   /home/vlassisioa/Random Stuff/Comp Organization and Design/Lab1/vhd_files/Tests/CPU_Test.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Single_CPU
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
 
ENTITY CPU_Test IS
END CPU_Test;
 
ARCHITECTURE behavior OF CPU_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Single_CPU
    PORT(
         Ovf : OUT  std_logic;
         Cout : OUT  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal Ovf : std_logic;
   signal Cout : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Single_CPU PORT MAP (
          Ovf => Ovf,
          Cout => Cout,
          CLK => CLK,
          RST => RST
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.	
		RST <= '1';
      wait for CLK_period;
		RST <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
