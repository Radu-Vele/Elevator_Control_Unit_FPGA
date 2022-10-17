library ieee;
use ieee.std_logic_1164.all;

entity BCD is
	
	port(Input: in std_logic_vector (3 downto 0);

	Display_first: out std_logic_vector (6 downto 0);

	Display_last: out std_logic_vector (6 downto 0));

-- 7 bits for forming numbers and 1(last one) for a dot


end BCD;



architecture arch_display of BCD is


	begin
	
		
	process(Input)
		
		
		begin
			
				
		case Input is
				
					
		when "0000" =>Display_first <= "0000001";
		
					
					Display_last <= "0000001";--00.
					
					
		when "0001" =>Display_first <= "0000001";
					
					
		Display_last <= "1001111"; --01.
					
					
		when "0010" =>Display_first <= "0000000";
		
					
					Display_last <= "0010010"; --02.
		
					
					when "0011" =>Display_first <= "0000001";
		
					
					Display_last <= "0000110"; --03.
					
					
		when "0100" =>Display_first <= "0000001";
					
		
					Display_last <= "1001100"; --04.
					
					
		when "0101" =>Display_first <= "0000001";
					
		Display_last <= "0100100"; --05.
		
					
					when "0110" =>Display_first <= "0000001";
					
		Display_last <= "0100000"; 
					--06.
		
					
					when "0111" =>Display_first <="0000001";
					
					Display_last <= "0001111"; --07.
		
					
					when "1000" =>Display_first <= "0000001";
		
					
					Display_last <= "0000000"; --08.
					
					
		when "1001" =>Display_first <= "0000001";
					
					
		Display_last <= "0000100";
					
					--09
					
					
		when "1010" =>Display_first <= "0010010";
					
		  Display_last <= "0000000"; --10.
					
					
		when "1011"	=>Display_first <= "0010010";
		
					
					Display_last <= "1001111"; --11.
					
					
		when "1100" =>Display_first <= "0010010";
					
					
		Display_last <= "0010010"; --12.
					
					
		when others =>Display_first <= "1111111";
		 
					Display_last <= "1111111"; --nullnull.
				
				
		end case;
	
		
	end process;


end arch_display;
