----------------------------------------------------------------------------------
-- Company: Universidad de San Carlos de Guatemala
-- Engineer: Luis Paniagua
-- 
-- Create Date: 10/23/2022 
-- Module Name:    top - Behavioral 
-- Project Name: Medidor de Calidad y Energia
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is

	Port(
--		uart_1, uart_2 : in std_logic;
		clk_12 : in std_logic; -- Reloj FPGA
--		input_0 : in std_logic; -- Entrada para elegir Channel0
--		input_1 : in std_logic;	-- Entrada para elegir Channel1
		rst : in std_logic;	-- Reset general
		Chip_Select: out std_logic := '1';
		DIN : out std_logic; --MOSI
		Enable: in std_logic; -- Habilita o deshabilita el modulo 
		DOUT : in std_logic; -- MISO del ADC.
		SCLK : out std_logic; -- Salida clock SPI
		R_DATA : out std_logic; -- Indica cuando el dato esta listo para leer
		D_OUT : out std_logic_vector(11 downto 0) -- Datos recibidos
--		rd_1, rd_2 : out std_logic;
--		data : out std_logic_vector(7 downto 0);
--		sel : std_logic -- Selector que elige Channel (out)
		);
		
end top;

architecture Behavioral of top is
--	signal CH0, CH1 : std_logic;
						
begin
	
	CHL0:
		entity work.channel0
			port map(
						clk => clk_12,
						input => Enable,
						reset => rst,
						mosi => DIN
						);

--	CHL1:
--		entity work.channel1
--			port map(
--						clk => clk_12,
--						input => input_1,
--						reset => rst,
--						mosi => DIN
--						);


--	mux_1:
--		entity work.mux
--			port map(
--						Channel0 => CHANNEL0,
--						Channel1 => CHANNEL1,
--						sel => sel,
--						Selector => DIN
--						);

	ADC_SPI:
		entity work.SPI
			port map(
						CLK => clk_12,
						RST => rst,
						EN => Enable,
						CS => Chip_Select,
						MISO => DOUT,
						SCLK_OUT => SCLK,
						READ_DATA => R_DATA,
						DATA_OUT => D_OUT
						);


end Behavioral;

