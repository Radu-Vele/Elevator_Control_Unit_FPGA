library ieee;

use ieee.std_logic_1164.all;

use ieee.std_logic_unsigned.all;



entity weight_doors_unit is

	port ( Person_in_door: in std_logic;

	Max_weight_reached: in std_logic;

	BUZZER:  out std_logic;

	Start_OK: out std_logic);

	
end weight_doors_unit;



architecture WDU of weight_doors_unit is

	begin
		
	p1: process(Person_in_door,Max_weight_reached)
		
	begin
			
		if Person_in_door='1' OR Max_weight_reached='1'then
				
			BUZZER <='1';
		
					Start_OK <='0';
				
				
		else
					
		BUZZER <='0';
			
				Start_OK <='1';
			
		
		end if;
		
	
	end process;

	
end	WDU;
