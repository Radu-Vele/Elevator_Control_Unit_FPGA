library ieee;  -- It sends a signal that freezes the counting when we reach a called floor
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity LOCKER is
	port(CLK, EQUALITY: in std_logic; 
	FREEZE: out std_logic);
	
end LOCKER;

architecture A_BEHAV of LOCKER is 
begin
	
	p1: process (CLK, EQUALITY)
	
	variable STILL_GOING: std_logic := '0' ;
	variable TEMP_CURRENT: std_logic_vector(3 downto 0) := "0000";
	
	begin
		
		if (EQUALITY = '1') then STILL_GOING := '1'; FREEZE <= '1';
		
		end if;
		
		
	
		if(STILL_GOING = '1') then
			
			if (CLK'EVENT and CLK = '1') then
				
				if (TEMP_CURRENT = "1000") then STILL_GOING := '0'; FREEZE <= '0';
				else
					TEMP_CURRENT := TEMP_CURRENT + 1;
					FREEZE <= '1';
				
				end if;
			
			end if;
			
			if (CLK'EVENT and CLK = '0') then
				TEMP_CURRENT := TEMP_CURRENT;
				FREEZE <= '1';
			end if;
			
			if (CLK = '0') then
				TEMP_CURRENT := TEMP_CURRENT;
				FREEZE <= '1';
			end if;
			
			
		else
			TEMP_CURRENT := "0000";
			FREEZE <= '0';
			
		end if;
		
	
	end process;
	
	
end A_BEHAV;
