--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:57:54 03/13/2025
-- Design Name:   
-- Module Name:   /home/ise/Lab1/RegisterTest.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Rgster
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
 
ENTITY RegisterTest IS
END RegisterTest;
 
ARCHITECTURE behavior OF RegisterTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Rgster
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         WE : IN  std_logic;
         DataIN : IN  std_logic_vector(31 downto 0);
         DataOUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal WE : std_logic := '0';
   signal DataIN : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal DataOUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Rgster PORT MAP (
          CLK => CLK,
          RST => RST,
          WE => WE,
          DataIN => DataIN,
          DataOUT => DataOUT
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
      wait for 100 ns;	
			RST <= '1';
			wait for CLK_period;
			RST <= '0';
			DataIN <= (others => '1');
			WE <= '1';
			wait for CLK_period;
			RST <= '1';
      wait for 10 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
