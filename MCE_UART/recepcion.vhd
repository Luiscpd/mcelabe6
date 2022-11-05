----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:41:59 11/05/2022 
-- Design Name: 
-- Module Name:    recepcion - Behavioral 
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


entity recepcion is
	port(
		clk : in std_logic;
		input : in std_logic;
		reset : in std_logic;
--		OUTPUT : out std_logic_vector(4 downto 0);
		out_rx_in : out std_logic
		);	
end recepcion;

architecture Behavioral of recepcion is

	type state_type is (D7, D6, D5, D4, D3, D2, D1, D0);
	signal state : state_type;

begin
	
	process (clk, reset)
	begin
		if RESET = '1' then
		state <= D7;
		elsif (falling_edge(CLK)) then
			case state is
--				when Sleep =>
--					if input = '1' then
--						state <= D7;
--					else
--						state <= Sleep;
--					end if;
					
				when D7 =>
					if input = '1' then
						state <= D6;
					else
						state <= D7;
					end if;
				
				when D6 =>
					if input = '1' then
						state <= D6;
					else 
						state <= D5;
					end if;
				
				when D5 =>
					if input = '1' then
						state <= D4;
					else 
						state <= D5;
					end if;
					
				when D4 =>
					if input = '1' then
						state <= D3;
					else
						state <= D4;
				end if;	
					
				when D3 =>
					if input = '1' then
						state <= D2;
					else
						state <= D3;
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
						state <= D7;
					else
						state <= D0;
					end if;					
					
--				when Close =>
--					if input = '1' then
--						state <= Sleep;
--					else 
--						state <= Close;
--					end if;
			end case;
		end if;
	end process;
	
	process (state)
	begin
		case state is
--			when Sleep =>
--				out_rx_in <= '0';
			when D7 =>
				out_rx_in <= '1';
			when D6 =>
				out_rx_in <= '0';
			when D5 =>
				out_rx_in <= '1';
			when D4 =>
				out_rx_in <= '0';
			when D3 =>
				out_rx_in <= '0';
			when D2 =>
				out_rx_in <= '1';
			when D1 =>
				out_rx_in <= '0';
			when D0 =>
				out_rx_in <= '1';
--			when Close =>
--				out_rx_in <= '0';
		end case;
	end process;
					

end Behavioral;

