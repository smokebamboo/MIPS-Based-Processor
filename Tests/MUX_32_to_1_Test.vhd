--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:52:42 03/14/2025
-- Design Name:   
-- Module Name:   /home/ise/Lab1/MUX_32_to_1_Test.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX_32_to_1
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
 
ENTITY MUX_32_to_1_Test IS
END MUX_32_to_1_Test;
 
ARCHITECTURE behavior OF MUX_32_to_1_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX_32_to_1
    PORT(
         Addr : IN  std_logic_vector(4 downto 0);
         Din0 : IN  std_logic_vector(31 downto 0);
         Din1 : IN  std_logic_vector(31 downto 0);
         Din2 : IN  std_logic_vector(31 downto 0);
         Din3 : IN  std_logic_vector(31 downto 0);
         Din4 : IN  std_logic_vector(31 downto 0);
         Din5 : IN  std_logic_vector(31 downto 0);
         Din6 : IN  std_logic_vector(31 downto 0);
         Din7 : IN  std_logic_vector(31 downto 0);
         Din8 : IN  std_logic_vector(31 downto 0);
         Din9 : IN  std_logic_vector(31 downto 0);
         Din10 : IN  std_logic_vector(31 downto 0);
         Din11 : IN  std_logic_vector(31 downto 0);
         Din12 : IN  std_logic_vector(31 downto 0);
         Din13 : IN  std_logic_vector(31 downto 0);
         Din14 : IN  std_logic_vector(31 downto 0);
         Din15 : IN  std_logic_vector(31 downto 0);
         Din16 : IN  std_logic_vector(31 downto 0);
         Din17 : IN  std_logic_vector(31 downto 0);
         Din18 : IN  std_logic_vector(31 downto 0);
         Din19 : IN  std_logic_vector(31 downto 0);
         Din20 : IN  std_logic_vector(31 downto 0);
         Din21 : IN  std_logic_vector(31 downto 0);
         Din22 : IN  std_logic_vector(31 downto 0);
         Din23 : IN  std_logic_vector(31 downto 0);
         Din24 : IN  std_logic_vector(31 downto 0);
         Din25 : IN  std_logic_vector(31 downto 0);
         Din26 : IN  std_logic_vector(31 downto 0);
         Din27 : IN  std_logic_vector(31 downto 0);
         Din28 : IN  std_logic_vector(31 downto 0);
         Din29 : IN  std_logic_vector(31 downto 0);
         Din30 : IN  std_logic_vector(31 downto 0);
         Din31 : IN  std_logic_vector(31 downto 0);
         Dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Addr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din0 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din2 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din3 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din4 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din5 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din6 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din7 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din8 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din9 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din10 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din11 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din12 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din13 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din14 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din15 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din16 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din17 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din18 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din19 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din20 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din21 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din22 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din23 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din24 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din25 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din26 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din27 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din28 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din29 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din30 : std_logic_vector(31 downto 0) := (others => '0');
   signal Din31 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX_32_to_1 PORT MAP (
          Addr => Addr,
          Din0 => Din0,
          Din1 => Din1,
          Din2 => Din2,
          Din3 => Din3,
          Din4 => Din4,
          Din5 => Din5,
          Din6 => Din6,
          Din7 => Din7,
          Din8 => Din8,
          Din9 => Din9,
          Din10 => Din10,
          Din11 => Din11,
          Din12 => Din12,
          Din13 => Din13,
          Din14 => Din14,
          Din15 => Din15,
          Din16 => Din16,
          Din17 => Din17,
          Din18 => Din18,
          Din19 => Din19,
          Din20 => Din20,
          Din21 => Din21,
          Din22 => Din22,
          Din23 => Din23,
          Din24 => Din24,
          Din25 => Din25,
          Din26 => Din26,
          Din27 => Din27,
          Din28 => Din28,
          Din29 => Din29,
          Din30 => Din30,
          Din31 => Din31,
          Dout => Dout
        );

 
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Din3 <= "11111111111111111111111111111111";
		Addr <= "00011";
      wait for 10 ns;
		Addr <= "00001";

      -- insert stimulus here 

      wait;
   end process;

END;
