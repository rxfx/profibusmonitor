library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NIB2_7SEG_SRC is

    Port ( NIB0      : in std_logic_vector(7 downto 0); -- Nibble Ziffer 0
           NIB1      : in std_logic_vector(7 downto 0); -- Nibble Ziffer 1

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

end NIB2_7SEG_SRC;

architecture Behavioral of NIB2_7SEG_SRC is
	signal 	COUNTER : std_logic;
	signal	NIB_ANZ : std_logic_vector(7 downto 0);

begin
	process(CLK_DISPL, NIB1, NIB0, NIB_ANZ, COUNTER)
	begin
	    
	     If (CLK_DISPL'event and CLK_DISPL = '1')
	     then 
		 IF COUNTER = '0'
		 then COUNTER <= '1';
		 else COUNTER <= '0';
		 end if;
	     end if;
	   
		case COUNTER is
			when '0' =>    ZI0 <= '1';
					     ZI1 <= '0';
						ZI2 <= '1';
						ZI3 <= '0';
                              NIB_ANZ <= NIB0;
						
			when '1' =>    ZI0 <= '0';
					     ZI1 <= '1';
						ZI2 <= '0';
						ZI3 <= '1';
					     NIB_ANZ <= NIB1;
			
			when others => ZI0 <= '1';
					     ZI1 <= '0';
						ZI2 <= '1';
						ZI3 <= '0';
						NIB_ANZ <= NIB0;				
		end case;

		case NIB_ANZ is

			when "00000000" => BG <= '1'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '0';	--00
			when "00000001" => BG <= '1'; BF <= '1'; BE <= '1'; BD <= '1'; BC <= '0'; BB <= '0'; BA <= '1';	--01
			when "00000010" => BG <= '0'; BF <= '1'; BE <= '0'; BD <= '0'; BC <= '1'; BB <= '0'; BA <= '0';	--02
			when "00000011" => BG <= '0'; BF <= '1'; BE <= '1'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '0';	--03
			when "00000100" => BG <= '0'; BF <= '0'; BE <= '1'; BD <= '1'; BC <= '0'; BB <= '0'; BA <= '1';	--04
			when "00000101" => BG <= '0'; BF <= '0'; BE <= '1'; BD <= '0'; BC <= '0'; BB <= '1'; BA <= '0';	--05
			when "00000110" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '1'; BA <= '0';	--06
			when "00000111" => BG <= '1'; BF <= '1'; BE <= '1'; BD <= '1'; BC <= '0'; BB <= '0'; BA <= '0';	--07
			when "00001000" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '0';	--08
			when "00001001" => BG <= '0'; BF <= '0'; BE <= '1'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '0';	--09
			when "00001010" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '1'; BC <= '0'; BB <= '0'; BA <= '0';	--0A
			when "00001011" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '1'; BA <= '1';	--0B
			when "00001100" => BG <= '0'; BF <= '1'; BE <= '0'; BD <= '0'; BC <= '1'; BB <= '1'; BA <= '1';	--0C
			when "00001101" => BG <= '0'; BF <= '1'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '1';	--0D
			when "00001110" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '1'; BB <= '1'; BA <= '0';	--0E
			when "00001111" => BG <= '0'; BF <= '0'; BE <= '0'; BD <= '1'; BC <= '1'; BB <= '1'; BA <= '0';	--0F
			when "00010000" => BG <= '1'; BF <= '0'; BE <= '0'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '0';	--10
			when "00010001" => BG <= '1'; BF <= '1'; BE <= '1'; BD <= '1'; BC <= '0'; BB <= '0'; BA <= '1';	--11
			when "00010010" => BG <= '0'; BF <= '1'; BE <= '0'; BD <= '0'; BC <= '1'; BB <= '0'; BA <= '0';	--12
			when "00010011" => BG <= '0'; BF <= '1'; BE <= '1'; BD <= '0'; BC <= '0'; BB <= '0'; BA <= '0';	--13
							
			when others =>	BG <= '1'; BF <= '1'; BE <= '1'; BD <= '1'; BC <= '1'; BB <= '1'; BA <= '1';	
										
		end case;		

	end process;

end Behavioral;

