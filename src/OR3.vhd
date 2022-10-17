library ieee; -- or gate with 3 inputs
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity OR3 is
	port( A, B, C: in std_logic;
	D: out std_logic);
end OR3;

architecture a1 of OR3 is
begin
	p1: process (A, B, C)
	begin
		D <= A or B or C;
	end process;
	
end	a1;
