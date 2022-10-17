library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity COUNTER_MOD4 is
	
	port (CLK, RESET: in std_logic;
		  TC: out std_logic);
		  
end COUNTER_MOD4;

architecture A_COUNT of COUNTER_MOD4 is 
	signal TEMP_CURRENT: std_logic_vector (1 downto 0);
begin	
	
	p_count: process (CLK, RESET)
	
	begin
	 
	 	if (RESET = '1') then TEMP_CURRENT <= "00";
			 TC <= '0';
		
		else
			
			if (CLK'EVENT and CLK = '1') then
	 			
				if (TEMP_CURRENT = "11") then TEMP_CURRENT <= "00";
					TC <= '1';
				
				else TEMP_CURRENT <= TEMP_CURRENT + 1;
					 TC <= '0';
				end if;
			end if;
			
			if (CLK'EVENT and CLK = '0') then TEMP_CURRENT <= TEMP_CURRENT; TC <= '0'; end if;
		
			if (CLK = '0') then TEMP_CURRENT <= TEMP_CURRENT; TC <= '0'; end if;	
			
		
		end if;			
	 
	end process;
	
end A_COUNT;
