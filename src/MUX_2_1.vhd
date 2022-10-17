library ieee;	--standard multiplexer
use ieee.std_logic_1164.all;

entity MUX_2_1 is
	port(I1, I2, SELECTION: in std_logic;
		OUTPUT: out std_logic);
end MUX_2_1;

architecture A_MUX of MUX_2_1 is
begin
	p1: process (SELECTION, I1, I2)
		variable TEMP_OUTPUT: std_logic;
	begin
		case SELECTION is
			when '0' => TEMP_OUTPUT := I1;
			when '1' => TEMP_OUTPUT := I2;
			when others => TEMP_OUTPUT := TEMP_OUTPUT;
		end case;
	
	OUTPUT <= TEMP_OUTPUT;	
	end process;
	
end A_MUX;
