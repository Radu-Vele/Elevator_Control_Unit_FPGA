library IEEE;
use ieee.std_logic_1164.all;

entity AND2 is
	port (A, B: in std_logic;
    D: out std_logic);
end AND2;

architecture ARCH_AND of AND2 is


begin
	D <= A and B;
end ARCH_AND;
