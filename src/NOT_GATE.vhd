library ieee;		--simple not gate
use ieee.std_logic_1164.all;

entity NOT_GATE is
	port(A: in std_logic;
	NOT_A: out std_logic);
end NOT_GATE;			 

architecture A1 of NOT_GATE is
begin
	pr: process(A)
	begin
		if(A = '1') then NOT_A <= '0';
		else
			NOT_A <= '1';
		end if;
	end process;
	
end A1;

