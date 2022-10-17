library ieee;		-- works as planned

use ieee.std_logic_1164.all;

use ieee.std_logic_unsigned.all;

use ieee.numeric_std.all;

entity DECISION_UNIT is
	port(FLOOR_IN: in std_logic_vector(0 to 12);
	RESET, UP, DOWN: in std_logic;
	CURRENT: in std_logic_vector (3 downto 0);
	WANTED: out std_logic_vector (3 downto 0));
	
end DECISION_UNIT;

architecture A_BEHAV of DECISION_UNIT is

begin
	p1: process	(CURRENT, FLOOR_IN, UP, DOWN)
	variable index: std_logic_vector (3 downto 0);
	variable temp: std_logic_vector (3 downto 0);
	variable aux: integer;
	variable not_found: std_logic;
	begin										 
		
		index := CURRENT;
		aux := to_integer(unsigned(index));
		temp := CURRENT;
		
		if (RESET = '1') then
			WANTED <= "0000";
			
		else
		
			if(UP = '1') then
								
--				l1: loop
--					if aux = 12 and FLOOR_IN(aux) = '0' then aux := to_integer(unsigned(index)); exit;
--					
--					else
--						
--						if FLOOR_IN(aux) = '1' then exit;
--						else
--							aux := aux + 1;
--						end if;
--						
--					end if;
--					
--				end loop; 

				for i in 0 to 12 loop
					
					if FLOOR_IN(i) = '1' and i > to_integer(unsigned(index))  then not_found:= '0'; aux := i; exit;  
						
					else
						not_found := '1';
						
					end if;
					
					if i = 12 and FLOOR_IN(i) = '0' then not_found := '1'; exit; end if;
								
				end loop;
				
				
			
			 	if not_found = '1' then aux:= to_integer(unsigned(index)); end if;
				 
					 
			
			elsif (DOWN = '1') then
				
--				l2: loop
--					
--					if FLOOR_IN(aux) = '0' and aux = 0 then aux := to_integer(unsigned(index)); exit;
--					else
--						
--						if FLOOR_IN(aux) = '1' then exit;
--						else
--							aux := aux - 1;
--						end if;
--						
--					end if;
--					
--				end loop;

				for i in 12 downto 0 loop
					
					if FLOOR_IN(i) = '1' and i <  to_integer(unsigned(index))  then not_found:= '0'; aux := i; exit;  
						
					else
						not_found := '1';
						
					end if;
					
					if i = 0 and FLOOR_IN(i) = '0' then not_found := '1'; exit; end if;
								
				end loop;

				if not_found = '1' then aux:= to_integer(unsigned(index)); end if;
					
			end if;
			
			
			temp := std_logic_vector(to_unsigned(aux, temp'length));  --changes when the input is changed
			
			if (UP = '1' or DOWN = '1') and FLOOR_IN(aux) = '1' then
				WANTED <= temp;
			end if;	
			
		end if;
			
		
		
		
	end process;
	
end A_BEHAV;

	
	
