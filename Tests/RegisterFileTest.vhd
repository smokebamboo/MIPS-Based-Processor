--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:29:42 03/15/2025
-- Design Name:   
-- Module Name:   /home/ise/Lab1/RegisterFileTest.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegisterFile
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
 
ENTITY RegisterFileTest IS
END RegisterFileTest;
 
ARCHITECTURE behavior OF RegisterFileTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         WrEn : IN  std_logic;
         Awr : IN  std_logic_vector(4 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
	
	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout2 : std_logic_vector(31 downto 0) := (others => '0');

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          CLK => CLK,
          RST => RST,
          Ard1 => Ard1,
          Ard2 => Ard2,
          WrEn => WrEn,
          Awr => Awr,
          Din => Din,
          Dout1 => Dout1,
          Dout2 => Dout2
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
      wait for 10 ns;	
		
		-- Reset in the beginning to instantiate
		RST <= '1';
		wait for clk_period;
		RST <= '0';
		
		-- Write "11111111111111111111111111111111" in "00010"
		-- Dout1 should be all '0's
		-- Dout2 should be "11111111111111111111111111111111"
		WrEn <= '1';
		Awr <= "00010";
		Din <= "11111111111111111111111111111111";
		Ard2 <= "00010";
		wait for clk_period;
		
		-- Read from "00010"
		-- Dout1, Dout2 should be all '1's
		WrEn <= '0';
		Ard1 <= "00010";
      wait for CLK_period;
		
		-- Attempt to write "11111111100011110001110001111111" at "00000" (register 0)
		-- Normally, we would except Dout1 to show the new input of the Register, but Register 0 is always '0's
		-- Dout1 should be all '0's, Dout2 continues reading from "00010", should be all '1's
		WrEn <= '1';
		Ard1 <= "00000";
		Awr <= "00000";
		Din <= "11111111100011110001110001111111";
		wait for clk_period;
		
		-- Write "10101010101010101010101010101010" in "10000"
		-- Write "11001100110011001100110011001100" in "01110"
		WrEn <= '1';
		Awr <= "10000";
		Din <= "10101010101010101010101010101010";
		wait for clk_period;
		Awr <= "01110";
		Din <= "11001100110011001100110011001100";
		wait for clk_period;
		
		-- We attempt to write "01010101010101010101010101010101" in "00001" while reading from "10000" and "01110"
		-- Dout1 should be "10101010101010101010101010101010"
		-- Dout2 should be "11001100110011001100110011001100"
		-- Next cycle we read "00001" and "00000", Dout1 should be "01010101010101010101010101010101" and Dout2 should not have been written before so all '0's
		Awr <= "00001";
		Din <= "01010101010101010101010101010101";
		Ard1 <= "10000";
		Ard2 <= "01110";
		wait for clk_period;
		Ard1 <= "00001";
		Ard2 <= "00000";
		wait for clk_period;

		-- We reset the registers and read register "00010" and "01110" to see if they reset
		-- Both outputs should be all '0's
		RST <= '1';
		WrEn <= '0';
		Ard1 <= "00010";
		Ard2 <= "01110";
		wait;
   end process;

END;
