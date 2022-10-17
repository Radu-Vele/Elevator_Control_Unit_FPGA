library ieee;	-- THE COUNTER THAT TELLS US AT WHICH FLOOR WE ARE
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 


entity COUNTER_MOD13 is
	
	port (CLK, RESET, ENABLE, C_UP, C_DOWN, FREEZE: in std_logic;
		  UP, DOWN: out std_logic;
		  CURRENT_FLOOR: out std_logic_vector (3 downto 0));
		  
end COUNTER_MOD13;

architecture A_COUNT of COUNTER_MOD13 is 
begin	
	
	p_count: process (CLK, RESET, ENABLE)
	variable TEMP_CURRENT: std_logic_vector (3 downto 0);
	begin
	 
		
		if(FREEZE = '1') then TEMP_CURRENT := TEMP_CURRENT;
		else
			
			if (RESET = '1') then TEMP_CURRENT := "0000";
				 
		 	elsif (ENABLE = '1') then
				
				 if (CLK'EVENT and CLK = '1') then
		 			
					 if (C_UP = '1') then
						 if (TEMP_CURRENT = "1100") then TEMP_CURRENT := "1100";
							 UP <= '1';
							 DOWN <= '0';
						 else TEMP_CURRENT := TEMP_CURRENT + 1;
							 UP <= '1';
							 DOWN <= '0';
						 end if;
						 
					end if;
					
					if (C_DOWN = '1') then
						 if (TEMP_CURRENT = "0000") then TEMP_CURRENT := "0000";
						 	DOWN <= '1';
							UP <= '0';
						 else TEMP_CURRENT := TEMP_CURRENT - 1;
							DOWN <= '1';
							UP <= '0';
							
						 end if;
					end if;
				
				end if;
				
				if (CLK'EVENT and CLK = '0') then
					TEMP_CURRENT := TEMP_CURRENT;
				end if;
				
				
				if (CLK = '0') then
					TEMP_CURRENT := TEMP_CURRENT;
				end if;				
				
				
			
			else
				TEMP_CURRENT := TEMP_CURRENT;
			
			end if;
			
		end if;
	 
		CURRENT_FLOOR <= TEMP_CURRENT;
	 
	end process;
	
end A_COUNT;
