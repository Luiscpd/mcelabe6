----------------------------------------------------------------------------------
-- Company: Universidad de San Carlos de Guatemala	
-- Engineer: Luis Paniagua
-- 
-- Create Date: 10/23/2022 
-- Module Name:    MUX - Behavioral 
-- Project Name: Medidor de Calidad y Energía
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is

	Port(
--		data_1, data_2 : std_logic_vector(7 donwto 0);
--		salida : out std_logic_vector(7 donwto 0);
		Channel0, Channel1 : std_logic;
		Selector : out std_logic;
		sel : std_logic
		);

end MUX;

architecture Behavioral of MUX is

begin

	Selector <= Channel0 when sel = '0' else
				   Channel1 when sel = '1';


--	salida <= data_1 when sel = '0' else 
--				 data_2 when sel = '1';


end Behavioral;

