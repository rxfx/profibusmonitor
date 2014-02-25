library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NIB4_7SEG_SRC is

    Port ( NIB0      : in std_logic_vector(3 downto 0); -- Nibble Ziffer 0
           NIB1      : in std_logic_vector(3 downto 0); -- Nibble Ziffer 1
           NIB2      : in std_logic_vector(3 downto 0); -- Nibble Ziffer 2
           NIB3      : in std_logic_vector(3 downto 0); -- Nibble Ziffer 3

           CLK_DISPL : in std_logic; -- Umschaltfrequenz empfohlen: 1 kHz
          
           ZI0 : out std_logic; -- 1: Ziffer 0 soll leuchten
           ZI1 : out std_logic; -- 1: Ziffer 1 soll leuchten
           ZI2 : out std_logic; -- 1: Ziffer 2 soll leuchten
           ZI3 : out std_logic; -- 1: Ziffer 3 soll leuchten

           BA  : out std_logic;  -- 0: Segment A soll leuchten
           BB  : out std_logic;  -- 0: Segment B soll leuchten
           BC  : out std_logic;  -- 0: Segment C soll leuchten
           BD  : out std_logic;  -- 0: Segment D soll leuchten
           BE  : out std_logic;  -- 0: Segment E soll leuchten
           BF  : out std_logic;  -- 0: Segment F soll leuchten
           BG  : out std_logic); -- 0: Segment G soll leuchten

end NIB4_7SEG_SRC;

architecture Behavioral of NIB4_7SEG_SRC is
	signal 	COUNTER : std_logic_vector(1 downto 0);
	signal	NIB_ANZ : std_logic_vector(3 downto 0);

begin
	process(CLK_DISPL, NIB3, NIB2, NIB1, NIB0, NIB_ANZ, COUNTER)
	begin
	    
	     If (CLK_DISPL'event and CLK_DISPL = '1')
	     then COUNTER <= COUNTER +1;
	     end if;
	   
		case COUNTER is
			when "00" => ZI0 <= '1';
					ZI1 <= '0';
					ZI2 <= '0';
					ZI3 <= '0';

					NIB_ANZ <= NIB0;
						
			when "01" => ZI0 <= '0';
					ZI1 <= '1';
					ZI2 <= '0';
					ZI3 <= '0';
					
					NIB_ANZ <= NIB1;
					
			when "10" => ZI0 <= '0';
					ZI1 <= '0';
					ZI2 <= '1';
					ZI3 <= '0';
					
					NIB_ANZ <= NIB2;
					
			when "11" => ZI0 <= '0';
					ZI1 <= '0';
					ZI2 <= '0';
					ZI3 <= '1';
					
					NIB_ANZ <= NIB3;
			when others => ZI0 <= '1';
					ZI1 <= '0';
					ZI2 <= '0';
					ZI3 <= '0';
					
					NIB_ANZ <= NIB0;				
		end case;

		case NIB_ANZ is

			when "0000" => BG <= '1'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '0';	--0
			when "0001" => BG <= '1'; BF <= '1'; BE <= '1'; BD <= '1'; BC <= '0'; BB <= '0'; BA <= '1';	--1
			when "0010" => BG <= '0'; BF <= '1'; BE <= '0'; BD <= '0'; BC <= '1'; BB <= '0'; BA <= '0';	--2
			when "0011" => BG <= '0'; BF <= '1'; BE <= '1'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '0';	--3
			when "0100" => BG <= '0'; BF <= '0'; BE <= '1'; BD <= '1'; BC <= '0'; BB <= '0'; BA <= '1';	--4
			when "0101" => BG <= '0'; BF <= '0'; BE <= '1'; BD <= '0'; BC <= '0'; BB <= '1'; BA <= '0';	--5
			when "0110" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '1'; BA <= '0';	--6
			when "0111" => BG <= '1'; BF <= '1'; BE <= '1'; BD <= '1'; BC <= '0'; BB <= '0'; BA <= '0';	--7
			when "1000" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '0';	--8
			when "1001" => BG <= '0'; BF <= '0'; BE <= '1'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '0';	--9
			when "1010" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '1'; BC <= '0'; BB <= '0'; BA <= '0';	--A
			when "1011" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '1'; BA <= '1';	--B
			when "1100" => BG <= '0'; BF <= '1'; BE <= '0'; BD <= '0'; BC <= '1'; BB <= '1'; BA <= '1';	--C
			when "1101" => BG <= '0'; BF <= '1'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '1';	--D
			when "1110" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '1'; BB <= '1'; BA <= '0';	--E
			when "1111" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '1'; BC <= '1'; BB <= '1'; BA <= '0';	--F
							
			when others =>	BG <= '1'; BF <= '1'; BE <= '1'; BD <= '1'; BC <= '1'; BB <= '1'; BA <= '1';	
										
		end case;		

	end process;

end Behavioral;
