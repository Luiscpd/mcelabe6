----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:19:57 10/03/2022 
-- Design Name: 
-- Module Name:    SPI - Behavioral 
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

entity SPI is
	generic(
		n_bits : integer := 12; -- Cantidad de bits a recibir
		timer : integer := 2 -- Tiempo entre muestras
	);
	
	port(
		CLK : in std_logic; -- Entrada de reloj para el módulo
		RST : in std_logic; -- Botón reset
		EN : in std_logic; -- Habilitar o deshabilitar móduo
		CS : out std_logic := '1';
		MISO: in std_logic; -- MISO (Master In Slave Out)
		SCLK_OUT : out std_logic; -- Salida clock SPI, se puede cambiar (divisor de frecuencia)
		READ_DATA : out std_logic; -- Indica cuando el dato está listo para leer
--		RX : out std_logic; -- Solo para simulación (Inidica cuando la data se escribe)
		DATA_OUT : out std_logic_vector(n_bits - 1 downto 0) -- Datos recibidos
		
	);
end SPI;

architecture Behavioral of SPI is
	type SPI_STATES is (idle, data, sync); -- idle: recepcion de la espera
	signal estados : SPI_STATES;
	signal indice : integer range 0 to n_bits - 1 := 0;
	signal contador : integer range 0 to timer - 1 := 0;
	signal SS : std_logic := '0'; -- Slave Select
begin

	SCLK_OUT <= CLK and SS; -- Salida de reloj SPI solo cuando SS = '1'
	
	process (RST, CLK)
	begin
		if (RST = '1') then
			estados <= idle;
			indice <= 0;
			DATA_OUT <= (others => '0');
			SS <= '0';
			CS <= '1';
--			RX <= '0';
			contador <= 0;
			READ_DATA <= '0';
--		elsif (rising_edge(CLK)) then
		elsif (falling_edge(CLK)) then
				case estados is
				
					when idle =>
						indice <= 0 ;
--						RX <= '0';
						contador <= 0;
						SS <= '1';
						if (EN ='1') then
							CS <= '0';
							SS <= '1';
							if (contador = timer - 1) then
								estados <= data;
								DATA_OUT <= (others => '0');
								READ_DATA <= '0';
						else
							SS <= '0';
							contador <= contador + 1;
							estados <= idle;
						end if;
					else
						estados <= idle;
					end if;
					
					when data =>
						DATA_OUT(indice) <= MISO;
						if indice = n_bits - 1 then
							indice <= 0;
							estados <= sync;
						else
							indice <= indice + 1 ;
--							RX <= '1';
							estados <= data;
						end if;
						
					when sync =>
						SS <= '0';
						indice <= 0;
						contador <= 0;
--						RX <= '0';
						READ_DATA <= '1';
						estados <= idle;
					
					when others =>
						indice <= 0;
						contador <= 0;
						estados <= idle;
					end case;
				end if;
			end process;	
			
end Behavioral;

