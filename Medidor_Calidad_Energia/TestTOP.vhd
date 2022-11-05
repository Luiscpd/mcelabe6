--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:40:02 10/23/2022
-- Design Name:   
-- Module Name:   D:/Documentos/USAC/2022/Segundo Semestre 2022/Electronica 6/Laboratorio Electronica 6/Proyecto/Medidor_Calidad_Energia/TestTOP.vhd
-- Project Name:  Medidor_Calidad_Energia
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
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
 
ENTITY TestTOP IS
END TestTOP;
 
ARCHITECTURE behavior OF TestTOP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk_12 : IN  std_logic;
         input_0 : IN  std_logic;
         input_1 : IN  std_logic;
         rst : IN  std_logic;
         DIN : OUT  std_logic;
         sel : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_12 : std_logic := '0';
   signal input_0 : std_logic := '0';
   signal input_1 : std_logic := '0';
   signal rst : std_logic := '0';
   signal sel : std_logic := '0';

 	--Outputs
   signal DIN : std_logic;

   -- Clock period definitions
   constant clk_12_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk_12 => clk_12,
          input_0 => input_0,
          input_1 => input_1,
          rst => rst,
          DIN => DIN,
          sel => sel
        );

   -- Clock process definitions
   clk_12_process :process
   begin
		clk_12 <= '0';
		wait for clk_12_period/2;
		clk_12 <= '1';
		wait for clk_12_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		sel <= '0';
		rst <= '0'; 
		wait for 10 ns;
		input_0 <= '1';
		wait for 100 ns;
		input_0 <= '0';
		wait for 100 ns;
		sel <='1';
		wait for 10 ns;
		input_1 <= '1';
		wait for 100 ns;
		input_1 <= '0';
		

      wait for clk_12_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
