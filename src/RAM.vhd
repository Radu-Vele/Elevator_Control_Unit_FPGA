library ieee;	  -- the memory that keeps track of the called floors
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity RAM is
	port(INPUT_FLOOR: in std_logic_vector (3 downto 0);
	TO_ERASE: in std_logic_vector (3 downto 0);
	OK_ERASE, RESET: in std_logic;
	OK: in std_logic;
	OUT_CONTENT: out std_logic_vector (0 to 12));	
	
end RAM;

architecture A_BEHAV of RAM is 
begin
	
	p1: process (INPUT_FLOOR, OK, OK_ERASE, TO_ERASE)
	
	variable index: integer;
	variable content: std_logic_vector (0 to 12) := ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
	variable index2: integer;
	begin 				   
		
		index := to_integer(unsigned(INPUT_FLOOR));
		index2:= to_integer(unsigned(TO_ERASE));
					  
		if RESET = '1' then
			
			 content := ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
			
		else
		
			if OK = '1' then
				content(index) := '1';
			end if;
			
			if OK_ERASE = '1' then
				content(index2) := '0';
			end if;
			
		end if;
		
		
		OUT_CONTENT <= content;
		
	end process;
	
	
end A_BEHAV;
