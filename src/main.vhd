-- main file with all the modules
library ieee;		
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;  

entity ELEVATOR is
	port(
	   CLK_BOARD, RESET, SPEED_SELECT, WRITE_ENABLE, PERSON_IN_DOOR, MAX_WEIGHT_REACHED: in std_logic;
	   INPUT_FLOOR: in std_logic_vector (3 downto 0);
	   ANODE_MSB, ANODE_LSB: out std_logic_vector (6 downto 0);
	   ANODE: out std_logic_vector (3 downto 0);
	   UP_LED, DOWN_LED, BUZZER: out std_logic
    );
end ELEVATOR;

architecture A_STRUCTURAL of ELEVATOR is
-- individual components
    component AND2 is 	
        port (A, B: in std_logic;
        D: out std_logic);	
    end component;
    
    component BCD is
        port(Input: in std_logic_vector (3 downto 0);
        Display_first: out std_logic_vector (6 downto 0);
        Display_last: out std_logic_vector (6 downto 0));
    end component;
    
    component COUNTER_MOD2 is
        port (CLK, RESET: in std_logic;
        TC: out std_logic);
    end component;
    
    component COUNTER_MOD4 is
        port (CLK, RESET: in std_logic;
        TC: out std_logic);	
    end component;
    
    component COUNTER_MOD4_UDUNIT is	
        port (CLK, RESET, ENABLE: in std_logic;
        TC: out std_logic);			  
    end component;
    
    component COUNTER_MOD13 is	
        port (CLK, RESET, ENABLE, C_UP, C_DOWN, FREEZE: in std_logic;
              UP, DOWN: out std_logic;
              CURRENT_FLOOR: out std_logic_vector (3 downto 0));
    end component;
    
    component FREQUENCY_DIVIDER is
        port(CLK_EXT, RESET: in std_logic;
        CLK_OUT: out std_logic);
    end component;
    
    component RAM is
        port(INPUT_FLOOR: in std_logic_vector (3 downto 0);
        TO_ERASE: in std_logic_vector (3 downto 0);
        OK_ERASE, RESET: in std_logic;
        OK: in std_logic;
        OUT_CONTENT: out std_logic_vector (0 to 12));	
    end component;
    
    component DECISION_UNIT is
        port(FLOOR_IN: in std_logic_vector(0 to 12);
        RESET, UP, DOWN: in std_logic;
        CURRENT: in std_logic_vector (3 downto 0);
        WANTED: out std_logic_vector (3 downto 0));
    end component;
    
    component LOCKER is
        port(CLK, EQUALITY: in std_logic; 
        FREEZE: out std_logic);
    end component;
    
    component MUX_2_1 is
        port(I1, I2, SELECTION: in std_logic;
        OUTPUT: out std_logic);	
    end component;
    
    component NOT_GATE is
        port(A: in std_logic;
        NOT_A: out std_logic);	
    end component;
    
    component OR3 is
        port( A, B, C: in std_logic;
        D: out std_logic);
    end component;
    
    component UP_DOWN_MANAGER is
        port(CURRENT_FLOOR: in std_logic_vector (3 downto 0);
        TC: in std_logic;
        UP, DOWN: out std_logic);
    end component;
    
    component WEIGHT_DOORS_UNIT is
        port ( Person_in_door: in std_logic;
        Max_weight_reached: in std_logic;
        BUZZER:  out std_logic;
        Start_OK: out std_logic);	
    end component;
    
    component COMPARATOR is
        port(A, B: in std_logic_vector (3 downto 0);
        L, G, E: out std_logic);
    end component;
    
    
    signal CLK_INTER: std_logic;
    signal CLK_FLOORS: std_logic;
    signal MEMORY_CONTENT: std_logic_vector (0 to 12);
    signal UP_FRONT: std_logic;
    signal DOWN_FRONT: std_logic;
    signal CURRENT_FLOOR: std_logic_vector (3 downto 0);
    signal WANTED_FLOOR: std_logic_vector (3 downto 0);
    signal L_TEMP: std_logic;
    signal E_TEMP: std_logic;
    signal NOT_E: std_logic;
    signal G_TEMP: std_logic;
    signal ENABLE: std_logic;
    signal FINISHED_COUNT4: std_logic;
    signal FREEZE: std_logic;
    signal FINISHED_COUNT4_UDUNIT: std_logic;
    signal RESET_UDUNIT: std_logic;
    signal START_OK_WDU: std_logic;
    
begin
	ANODE <= "1111";
	
	C1: FREQUENCY_DIVIDER port map (
	   CLK_EXT => CLK_BOARD, 
	   RESET => RESET,
	   CLK_OUT => CLK_INTER
	);
	
	C2: RAM port map (
            INPUT_FLOOR => INPUT_FLOOR,
            TO_ERASE => CURRENT_FLOOR,
            OK_ERASE => E_TEMP,
            RESET => RESET,
            OK => WRITE_ENABLE,
            OUT_CONTENT => MEMORY_CONTENT
        );
	
	C3: DECISION_UNIT port map (
	   FLOOR_IN => MEMORY_CONTENT, 
	   RESET => RESET, 
	   UP => UP_FRONT, 
	   DOWN => DOWN_FRONT, 
	   CURRENT => CURRENT_FLOOR, 
	   WANTED => WANTED_FLOOR
	);
	
	C4: COMPARATOR port map (
	   A => CURRENT_FLOOR, 
	   B => WANTED_FLOOR, 
	   L => L_TEMP, 
	   G => G_TEMP, 
	   E => E_TEMP
	);
	
	C5: NOT_GATE port map (
	   A => E_TEMP,
	   NOT_A => NOT_E
	);
	
	C6: COUNTER_MOD13 port map (
	   CLK => CLK_FLOORS,
	   RESET => RESET, 
	   ENABLE => ENABLE, 
	   C_UP => L_TEMP, 
	   C_DOWN => G_TEMP, 
	   FREEZE => FREEZE, 
	   UP => UP_LED, 
	   DOWN => DOWN_LED, 
	   CURRENT_FLOOR => CURRENT_FLOOR --TODO: maybe deal with the reset = 1 and freeze =1 
    );
	
	C7: COUNTER_MOD4 port map (
	   CLK => CLK_INTER, 
	   RESET => RESET, 
	   TC => FINISHED_COUNT4
	);
	
	C8: MUX_2_1 port map (
	   I1 => CLK_INTER, 
	   I2 => FINISHED_COUNT4, 
	   SELECTION => SPEED_SELECT, 
	   OUTPUT => CLK_FLOORS
	);    
	
	C9: LOCKER port map (
	   CLK => CLK_INTER, 
	   EQUALITY => E_TEMP, 
	   FREEZE => FREEZE
	);
	
	C10: UP_DOWN_MANAGER port map (
	   CURRENT_FLOOR => CURRENT_FLOOR, 
	   TC => FINISHED_COUNT4_UDUNIT, 
	   UP => UP_FRONT, 
	   DOWN => DOWN_FRONT
	);
	
	C11: COUNTER_MOD4_UDUNIT port map (
	   CLK => CLK_INTER, 
	   RESET => RESET_UDUNIT, 
	   ENABLE => E_TEMP, 
	   TC => FINISHED_COUNT4_UDUNIT
    );
	
	C12: OR3 port map (
	   A => L_TEMP, 
	   B => G_TEMP, 
	   C => RESET, 
	   D => RESET_UDUNIT
    );
	
	C13: WEIGHT_DOORS_UNIT port map (
	   Person_in_door => PERSON_IN_DOOR, 
	   Max_weight_reached => MAX_WEIGHT_REACHED, 
	   BUZZER => BUZZER, 
	   Start_OK => START_OK_WDU
	);
	
	C14: AND2 port map (
	   A => START_OK_WDU, 
	   B => NOT_E, 
	   D => ENABLE
	   );
	
	C15: BCD port map (
        Input => CURRENT_FLOOR, 
        Display_first => ANODE_MSB, 
        Display_last => ANODE_LSB
	);
	
end A_STRUCTURAL;
