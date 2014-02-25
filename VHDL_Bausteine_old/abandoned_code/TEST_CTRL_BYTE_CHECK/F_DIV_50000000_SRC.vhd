
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity F_DIV50000000 is
 Port ( F_IN :  in std_logic;   -- Eingangsfrequenz
        F_OUT : out std_logic); -- Ausgangsfrequen
	                           --	FOUT ändert sich mit der
                                --	0/1-Flanke von F_IN
end F_DIV50000000;
       
architecture Behavioral of F_DIV50000000 is
 signal COUNTER :	integer;
					-- Maximalwert: Teilungsfaktor - 1
begin
 process (F_IN,COUNTER )
 begin
  if (F_IN'event and F_IN = '1')
  then	-- am Eingang des Frequenzteilers ist eine 0/1-Flanke aufgetreten 
   if   COUNTER = 0	
   then COUNTER <= 49999999; -- Teilungsfaktor -1
   else COUNTER <= COUNTER -1;
   end if;
  end if;

  if   COUNTER <  25000000	-- Teilungsfaktor / 2 (abgerundet)
  then F_OUT <= '0';
  else F_OUT <= '1';
  end if;
 end process;
end Behavioral;

