library ieee; --deals with the up and down signals that drive the decision unit
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity UP_DOWN_MANAGER is
	port(CURRENT_FLOOR: in std_logic_vector (3 downto 0);
	TC: in std_logic;
	UP, DOWN: out std_logic);
	
end UP_DOWN_MANAGER;

architecture a_behav of UP_DOWN_MANAGER is

begin
	proc1: process (TC, CURRENT_FLOOR)
	variable down_temp: std_logic;
	variable up_temp: std_logic;
	variable aux: std_logic;
	
	begin						  
		
		if CURRENT_FLOOR = "0000" then up_temp := '1'; down_temp := '0';
		else
			if CURRENT_FLOOR = "1100" then up_temp := '0'; down_temp := '1';
			
			else
				if (TC'EVENT and TC = '1') then aux := down_temp; down_temp := up_temp; up_temp := aux; end if;
			
			end if;
			
				
		end if;
		
		
		
		UP <= up_temp;
		DOWN <= down_temp;
		
	end process;
end a_behav;
