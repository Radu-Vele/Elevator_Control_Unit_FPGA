library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity comparator is
	port(A, B: in std_logic_vector (3 downto 0);
	L, G, E: out std_logic);
	
end comparator;

architecture a1 of comparator is
begin 
	p1: process	(A, B)
	
	variable temp_l: std_logic;
	variable temp_g: std_logic;
	variable temp_e: std_logic;
	
	begin	
		if (A < B) then temp_l := '1'; temp_g := '0'; temp_e := '0'; 
		else
			if (A > B) then temp_l := '0'; temp_g := '1'; temp_e := '0';
			else
				temp_l := '0'; temp_g := '0'; temp_e := '1';
			end if;
		
		end if;
			
		L <= temp_l;
		G <= temp_g;
		E <= temp_e;
		
	end process;
	
end a1;
