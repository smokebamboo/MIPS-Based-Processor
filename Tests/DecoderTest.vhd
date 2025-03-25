--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:55:01 03/13/2025
-- Design Name:   
-- Module Name:   /home/ise/Lab1/DecoderTest.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder_5_32
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
 
ENTITY DecoderTest IS
END DecoderTest;
 
ARCHITECTURE behavior OF DecoderTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder_5_32
    PORT(
         DecodeIn : IN  std_logic_vector(4 downto 0);
         DecodeOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DecodeIn : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal DecodeOut : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder_5_32 PORT MAP (
          DecodeIn => DecodeIn,
          DecodeOut => DecodeOut
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
			DecodeIn <= "01100";
      wait for 10 ns;
			DecodeIn <= "11000";
		wait for 10 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
