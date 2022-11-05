----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:52:38 11/05/2022 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is

	Port(

		clk_12 : in std_logic; --Reloj FPGA
		RXIN :  std_logic; --Entrada de datos UART
		R_data : out std_logic; 
		RXDATA : out std_logic_vector(7 downto 0);
		entrada : in std_logic;
		Salida : out std_logic;
		rst : in std_logic
	);

end top;

architecture Behavioral of top is
begin

	RX:
		entity work.recepcion
			port map(
							clk => clk_12,
							input => entrada,
							reset => rst,
							out_rx_in => Salida -- Salida para entrada UART
						);

	UART_RX:
		entity work.UART
			port map(		
							clk => clk_12,
							rx_in => RXIN, --Entrada de datos UART
							read_data => R_data,
							rx_data => RXDATA		
						);
						

end Behavioral;

