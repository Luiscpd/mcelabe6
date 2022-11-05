----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:02:38 11/05/2022 
-- Design Name: 
-- Module Name:    UART - Behavioral 
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


entity UART is
	generic(
		n_bits : integer := 8; -- Cantidad de bits del dato a recibir
		contador_bits : integer := 1250; -- 12 MHz/9600 bps
		contador_half_bits : integer := 625 -- (12 MHz/9600 bps)*0.5
	);
	port(
		clk : in std_logic; -- Entrada de reloj
		rx_in : std_logic; -- Entrada de datos uart_rx
		read_data : out std_logic; -- Indicará cuando un dato se encuentre listo
		rx_data : out std_logic_vector(n_bits - 1 downto 0) -- Dato recibido (8 bits por defecto)
	);
end UART;

architecture Behavioral of UART is
	type uart_rx is (idle, start, data, stop); -- FSM uart_rx
	signal estados : uart_rx;
	signal contador : integer range 0 to contador_bits - 1 := 0;
	signal indice : integer range 0 to n_bits - 1 := 0; -- #bits del dato

begin
	process (clk)
	begin
		if (falling_edge(clk)) then
			case estados is
				when idle =>
					contador <= 0;
					read_data <= '0';
					indice <= 0;
					if (rx_in = '0') then
						estados <= start;
					else
						estados <= idle;
					end if;
				when start =>
					if (contador = contador_half_bits - 1) then
						case rx_in is
							when '0' =>
								contador <= 0;
								estados <= data;
							when others =>
								estados <= idle;
						end case;
					else
						contador <= contador + 1;
						estados <= start;
					end if;
				when data =>
					if (contador = contador_bits - 1) then
						contador <= 0;
						rx_data(indice) <= rx_in;
						if (indice = n_bits - 1) then
							indice <= 0;
							estados <= stop;
						else
							indice <= indice + 1;
							estados <= data;
						end if;
					else
						contador <= contador + 1;
						estados <= data;
					end if;
				when stop =>
					if (contador = contador_bits - 1) then
						contador <= 0;
						estados <= idle;
						read_data <= '1';
					else
						contador <= contador + 1;
						estados <= stop;
					end if;
				when others =>
					estados <= idle;
			end case;
		end if;
	end process;
end Behavioral;



