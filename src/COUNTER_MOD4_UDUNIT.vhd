library ieee;  --counts the number of seconds in which the up down unit waits to see if there are further floors on the same front it was (up/down)
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity COUNTER_MOD4_UDUNIT is
	
	port (CLK, RESET, ENABLE: in std_logic;
		  TC: out std_logic);
		  
end COUNTER_MOD4_UDUNIT;

architecture A_COUNT of COUNTER_MOD4_UDUNIT is 
	signal TEMP_CURRENT: std_logic_vector (1 downto 0);
begin	
	
	p_count: process (CLK, RESET, ENABLE)
	
	begin
	 
	 	if (RESET = '1') then TEMP_CURRENT <= "00";
			 TC <= '0';
			 
		else
			if ENABLE = '1' then
				
				if (CLK'EVENT and CLK = '1') then
			 			
					if (TEMP_CURRENT = "11") then TEMP_CURRENT <= "00";
						TC <= '1';
					
					else TEMP_CURRENT <= TEMP_CURRENT + 1;
						 TC <= '0';
					end if;
					 
				end if;
				
				if (CLK'EVENT and CLK = '0') then TC <= '0'; end if;
				if (CLK = '0') then TC <= '0'; end if;
					
			end if;
				
		
		end if;			
	 
	end process;
	
end A_COUNT;
