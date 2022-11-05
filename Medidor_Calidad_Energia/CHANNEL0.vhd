----------------------------------------------------------------------------------
-- Company: Universidad de San Carlos de Guatemala	
-- Engineer: Luis Paniagua
-- 
-- Create Date: 10/23/2022 
-- Module Name:    CHANNEL0 - Behavioral 
-- Project Name: Medidor de Calidad y Energía
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CHANNEL0 is

	port(
		CLK : in std_logic;
		INPUT : in std_logic;
		RESET : in std_logic;
		MOSI : out std_logic
		);
		
end CHANNEL0;

architecture Behavioral of CHANNEL0 is

	type state_type is (Sleep, Start, SGLD, D2, D1, D0, Close);
	signal state : state_type;
	
begin

	process (clk, reset)
	begin
		if RESET = '1' then
		state <= Sleep;
--		elsif (rising_edge(CLK)) then		
		elsif (falling_edge(CLK)) then
		
			case state is
				when Sleep =>
					if input = '1' then
						state <= Start;
					else
						state <= Sleep;
					end if;
					
				when Start =>
					if input = '1' then
						state <= SGLD;
					else
						state <= Start;
					end if;
				
				when SGLD =>
					if input = '1' then
						state <= D2;
					else 
						state <= SGLD;
					end if;
				
				when D2 =>
					if input = '1' then
						state <= D1;
					else 
						state <= D2;
					end if;
					
				when D1 =>
					if input = '1' then
						state <= D0;
					else
						state <= D1;
				end if;	
					
				when D0 =>
					if input = '1' then
						state <= Close;
					else
						state <= D0;
					end if;
				when Close =>
					if input = '1' then
						state <= Sleep;
					else 
						state <= Close;
					end if;
					
			end case;
		end if;
	end process;
	
	process (state)
	begin
		case state is
			when Sleep =>
				MOSI <= '0';
			when Start =>
				MOSI <= '1';
			when SGLD =>
				MOSI <= '1';
			when D2 =>
				MOSI <= '0';
			when D1 =>
				MOSI <= '0';
			when D0 =>
				MOSI <= '0';
			when Close =>
				MOSI <= '0';
		end case;
	end process;
					

end Behavioral;
