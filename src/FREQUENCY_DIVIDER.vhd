library ieee;	--divides the board clock frequency to have a clock with one second period
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FREQUENCY_DIVIDER is
	port(
	   CLK_EXT, RESET: in std_logic;
	   CLK_OUT: out std_logic 
    );
	
end FREQUENCY_DIVIDER;

architecture A1 of FREQUENCY_DIVIDER is	

component COUNTER_MOD2 is
	port (CLK, RESET: in std_logic;
		  TC: out std_logic);
end component;


begin
	 C1: COUNTER_MOD2 port map (CLK_EXT, RESET, CLK_OUT);
end A1;
