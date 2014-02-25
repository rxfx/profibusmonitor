-- CTRL_TELEGRAM_CHECK
-- Profibus Telegramtyp ermitteln, aktuelle Laenge und Telegram komplett anzeigen
-- Projekt: PROFIBUS MONITOR
-- Ersteller: Martin Harndt
-- Erstellt: 02.01.2013
-- Bearbeiter: mharndt
-- Geaendert: 28.01.2013
-- Umstellung auf: rising_edge(CLK) und falling_edge(CLK) und http://www.sigasi.com/content/clock-edge-detection 
-- Optimierungen aus: http://www.lothar-miller.de/s9y/categories/37-FSM



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CTRL_TELEGRAM_CHECK is

    Port (TELEGRAM_RUN : in std_logic; --Eingangsvariable, Naechstes Telegram
          BYTE_IN  : in std_logic_vector (7 downto 0); --Eingangsvariable, Byte, 8bit
          PARITY_OK : in std_logic; --Eingangsvariable, Paritaet i.O.
          BYTE_CMPLT : in std_logic; --Eingangsvariable, BYTE komplett empfangen
          PAUSE_END : in std_logic; --Eingangsvariable, Pause erkannt und beendet
          TELEGRAM_STOP : in std_logic; --Eingangsvariable, nach Telegramm stoppen
          ERROR_CTRL : in std_logic; --Eingangsvariable, Fehlerkontrolle 

          T_END : out std_logic; --Ausgangsvariable, Telegramm zu Ende
          T_LENGTH : out std_logic_vector (7 downto 0); --Ausgangsvariable, Telegramlaenge, 8bit
          T_TYPE : out std_logic_vector (3 downto 0); --Ausgangsvariable, Telegramtyp, 4bit
          SEND_OUT : out std_logic; --Ausgangsvariable, Senden
          PARITY_FAIL : out std_logic; --Ausgangsvariable, Paritaetsprüfung fehlerhaft
          NO_ED : out std_logic; --Ausgangsvariable, kein Enddelimiter festgestellt
          WORKING : out std_logic; --Ausgangsvariable, TELEGRAM_CHECK arbeitet
          KNOWN_T : out std_logic; --Ausgangsvariable, Telegramm erkannt
          UNKNOWN_BYTE : out std_logic; --Ausgangsvariable, BYTE nicht erkannt 

 		    CLK	      : in  std_logic; --Taktvariable

		    IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
		    RESET		 : in std_logic;   --1: Initialzustand annehmen

          DISPL_COUNT : in std_logic; --Eingangsvariable, Zähler anzeigen
          DISPL1_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl1, binärzahl
		    DISPL2_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl2, binärzahl
		    DISPL1_n_SV  : out std_logic_vector (3 downto 0); --Folgezustand Zahl1, binärzahl
		    DISPL2_n_SV	 : out std_logic_vector (3 downto 0));  --Folgezustand Zahl2, binärzahl 

end CTRL_TELEGRAM_CHECK;

architecture Behavioral of CTRL_TELEGRAM_CHECK is

type TYPE_STATE is 
              (ST_TC_00, --Zustaende TELEGRAM_CHECK
               ST_TC_01,
               ST_TC_02,
               ST_TC_03,
               ST_TC_04,
               ST_TC_05,
               ST_TC_06,
               ST_TC_07,
               ST_TC_08, 
               ST_TC_09,
               ST_TC_10,
               ST_TC_11);

signal SV  : TYPE_STATE := ST_TC_00; --Zustandsvariable
signal n_SV: TYPE_STATE := ST_TC_00; --Zustandsvariable, neuer Wert
signal SV_M: TYPE_STATE := ST_TC_00; --Zustandsvariable, Ausgang Master


signal COUNT   : std_logic_vector (7 downto 0) := x"00"; -- Vektor, Telegrammlaenge, 8bit
signal n_COUNT   : std_logic_vector (7 downto 0) := x"00"; -- Vektor, Telegrammlaenge, 8bit, neuer Wert
signal COUNT_M   : std_logic_vector (7 downto 0) := x"00"; -- Vektor, Telegrammlaenge, 8bit, Ausgang Master

signal STATE_SV   : std_logic_vector (7 downto 0) :=  x"00"; -- aktueller Zustand in 8 Bit, binär
signal STATE_n_SV : std_logic_vector (7 downto 0) :=  x"00"; -- Folgezustand in 8 Bit, binär

begin


SREG_M_PROC: process (RESET, n_SV, n_COUNT, CLK) --Master
begin
  if (RESET ='1')
   then SV_M <= ST_TC_00;
        COUNT_M <= x"00";
  else
   if rising_edge(CLK)
	then
	  if (IN_NEXT_STATE = '1')
	   then 
       SV_M <= n_SV;
       COUNT_M <= n_COUNT;           
	   else 
       SV_M <= SV_M;
       COUNT_M <= COUNT_M;
     end if;
    end if;
   end if;
end process;

SREG_S_PROC: process (RESET, SV_M, CLK) --Slave
begin
  if (RESET = '1')
   then 
    SV <= ST_TC_00;
    COUNT <= x"00";
   else
    if falling_edge(CLK)
	  then 
      SV <= SV_M;
      COUNT <= COUNT_M;     
    end if;
  end if;
end process;

TELEGRAM_CHECK_PROC: process (SV, COUNT, TELEGRAM_RUN, PAUSE_END, BYTE_CMPLT, PARITY_OK, BYTE_IN, TELEGRAM_STOP, ERROR_CTRL) --Telegramme erkennen und Ende Telegram erkennen und ausgeben
begin
 case SV is
  when ST_TC_00 =>	 
   if (TELEGRAM_RUN = '1')
	 then
	  if (PAUSE_END = '1')
      then
       --TC01
       n_COUNT <= COUNT; --Zaehler erhöhen
       T_END <= '0'; 
       T_LENGTH <= COUNT;
       T_TYPE <= "0000";
       SEND_OUT <= '0';
       PARITY_FAIL <= '0';
       NO_ED <= '0';
       WORKING <= '1'; --arbeitet
       KNOWN_T <= '0';
       UNKNOWN_BYTE <= '0';
       n_SV <= ST_TC_01; --Zustandsübergang
      else
       --TC00
       n_COUNT <= x"00";
       T_END <= '0'; 
       T_LENGTH <= x"00";
       T_TYPE <= "0000";
       SEND_OUT <= '0';
       PARITY_FAIL <= '0';
       NO_ED <= '0';
       WORKING <= '0';
       KNOWN_T <= '0';
       UNKNOWN_BYTE <= '0';
       n_SV <= ST_TC_00;
     end if;
    else --TELEGRAM_RUN = '0' 
     -- TC00
     n_COUNT <= x"00";
     T_END <= '0'; 
     T_LENGTH <= x"00";
     T_TYPE <= "0000";
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '0';
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0';
     n_SV <= ST_TC_00;
   end if;

  when ST_TC_01 =>
   if (BYTE_CMPLT = '1')
    then
     if (PARITY_OK = '1')
      then
       if (BYTE_IN = x"10") --SD1 erkannt
        then
         --TC02
         n_COUNT <= COUNT+1; --Zaehler erhöhen
         T_END <= '0'; 
         T_LENGTH <= COUNT;
         T_TYPE <= "0001"; --SD1
         SEND_OUT <= '1'; --senden
         PARITY_FAIL <= '0';
         NO_ED <= '0';
         WORKING <= '1'; --arbeitet
         KNOWN_T <= '0';
         UNKNOWN_BYTE <= '0';
         n_SV <= ST_TC_02; --Zustandsübergang
        else
         if (BYTE_IN = x"68") --SD2 erkannt
          then
           --TC05
           n_COUNT <= COUNT+1; --Zaehler erhöhen
           T_END <= '0'; 
           T_LENGTH <= COUNT;
           T_TYPE <= "0010"; --SD2
           SEND_OUT <= '1'; --senden
           PARITY_FAIL <= '0';
           NO_ED <= '0';
           WORKING <= '1'; --arbeitet
           KNOWN_T <= '0';
           UNKNOWN_BYTE <= '0';
           n_SV <= ST_TC_03; --Zustandsübergang
          else
           if (BYTE_IN = x"A2") --SD3 erkannt
            then
             --TC08
             n_COUNT <= COUNT+1; --Zaehler erhöhen
             T_END <= '0'; 
             T_LENGTH <= COUNT;
             T_TYPE <= "0011"; --SD3
             SEND_OUT <= '1'; --senden
             PARITY_FAIL <= '0';
             NO_ED <= '0';
             WORKING <= '1'; --arbeitet
             KNOWN_T <= '0';
             UNKNOWN_BYTE <= '0';
             n_SV <= ST_TC_04; --Zustandsübergang       
            else
             if (BYTE_IN = x"DC") --SD4 erkannt
              then
               --TC11
               n_COUNT <= COUNT+1; --Zaehler erhöhen
               T_END <= '0'; 
               T_LENGTH <= COUNT;
               T_TYPE <= "0100"; --SD4
               SEND_OUT <= '1'; --senden
               PARITY_FAIL <= '0';
               NO_ED <= '0';
               WORKING <= '1'; --arbeitet
               KNOWN_T <= '0';
               UNKNOWN_BYTE <= '0';
               n_SV <= ST_TC_05; --Zustandsübergang         
              else
               if (BYTE_IN = x"E5") --SC erkannt
                then
                 --TC14
                 n_COUNT <= COUNT+1; --Zaehler erhöhen
                 T_END <= '1'; --Telgeram Ende
                 T_LENGTH <= COUNT;
                 T_TYPE <= "1000"; --SC
                 SEND_OUT <= '1'; --senden
                 PARITY_FAIL <= '0';
                 NO_ED <= '0';
                 WORKING <= '1'; --arbeitet
                 KNOWN_T <= '0';
                 UNKNOWN_BYTE <= '0';
                 n_SV <= ST_TC_07; --Zustandsübergang
                else
                 if (TELEGRAM_STOP = '1')
                  then
                   --TC15
                   n_COUNT <= COUNT; --Zaehler bleibt gleich
                   T_END <= '0'; --Telgeram Ende
                   T_LENGTH <= COUNT;
                   T_TYPE <= "0000";
                   SEND_OUT <= '0'; 
                   PARITY_FAIL <= '0';
                   NO_ED <= '0';
                   WORKING <= '0'; 
                   KNOWN_T <= '0';
                   UNKNOWN_BYTE <= '1'; --Unbekanntes BYTE
                   n_SV <= ST_TC_06; --Zustandsübergang
                  else
                   --TC00
                   n_COUNT <= x"00";
                   T_END <= '0'; 
                   T_LENGTH <= x"00";
                   T_TYPE <= "0000";
                   SEND_OUT <= '0';
                   PARITY_FAIL <= '0';
                   NO_ED <= '0';
                   WORKING <= '0';
                   KNOWN_T <= '0';
                   UNKNOWN_BYTE <= '0';
                   n_SV <= ST_TC_00;
                 end if; --TELEGRAM_STOP
               end if; --BYTE_IN =x"E5"
             end if; --BYTE_IN = x"DC"
           end if; --BYTE_IN = x"A2"
         end if; --BYTE_IN = x"68"
       end if; --BYTE_IN = x"10"
      else ----PARITY_OK = '0'
       --TC17
       n_COUNT <= COUNT;
       T_END <= '0'; 
       T_LENGTH <= COUNT;
       T_TYPE <= "0000";
       SEND_OUT <= '0';
       PARITY_FAIL <= '1'; --Paritaets Fehler
       NO_ED <= '0';
       WORKING <= '0';
       KNOWN_T <= '0';
       UNKNOWN_BYTE <= '0';
       n_SV <= ST_TC_08; --Zustandsuebergang
     end if; --PARITY_OK = '1'
    else --BYTE_CMPLT = '0'
     --TC01
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0000";
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '1'; --laeuft
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0';
     n_SV <= ST_TC_01;
   end if; --BYTE_CMPLT = '1'

  when ST_TC_02 =>
   if (BYTE_CMPLT = '1')
    then
     if (PARITY_OK = '1') 
      then
       if (COUNT = x"05")
        then
         if (BYTE_IN = x"16")
          then
           --TC04
           n_COUNT <= COUNT;
           T_END <= '1'; --Telegrammende erkannt 
           T_LENGTH <= COUNT;
           T_TYPE <= "0001"; --SD1
           SEND_OUT <= '1'; --senden
           PARITY_FAIL <= '0'; 
           NO_ED <= '0'; 
           WORKING <= '1'; --arbeitet
           KNOWN_T <= '0'; 
           UNKNOWN_BYTE <= '0';
           n_SV <= ST_TC_07; --Zustandsuebergang
          else
           --TC18
           n_COUNT <= COUNT;
           T_END <= '0'; 
           T_LENGTH <= COUNT;
           T_TYPE <= "0000";
           SEND_OUT <= '1'; --senden
           PARITY_FAIL <= '0'; 
           NO_ED <= '1'; --kein Enddelimiter
           WORKING <= '0';
           KNOWN_T <= '0';
           UNKNOWN_BYTE <= '0';
           n_SV <= ST_TC_10; --Zustandsuebergang
         end if; --BYTE_IN = x"16"
        else --not COUNT = x"05" 
         --TC02
         n_COUNT <= COUNT+1;
         T_END <= '0'; 
         T_LENGTH <= COUNT;
         T_TYPE <= "0001"; --SD1
         SEND_OUT <= '1'; --senden
         PARITY_FAIL <= '0'; 
         NO_ED <= '0';
         WORKING <= '1'; --arbeitet
         KNOWN_T <= '0';
         UNKNOWN_BYTE <= '0';
         n_SV <= ST_TC_02;
       end if; --COUNT = x"05"
      else --PARITY_OK = '0'
       --TC17
       n_COUNT <= COUNT;
       T_END <= '0'; 
       T_LENGTH <= COUNT;
       T_TYPE <= "0000";
       SEND_OUT <= '0';
       PARITY_FAIL <= '1'; --Paritaets Fehler
       NO_ED <= '0';
       WORKING <= '0';
       KNOWN_T <= '0';
       UNKNOWN_BYTE <= '0';
       n_SV <= ST_TC_08; --Zustandsuebergang
     end if; --PARITY_OK = '1'
    else --BYTE_CMPLT = '0'
     --TC03
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0001"; --SD1
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '1'; --laeuft
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0';
     n_SV <= ST_TC_02;
   end if; --BYTE_CMPLT = '1'

  when ST_TC_03 =>
   if (BYTE_CMPLT = '1')
    then
     if (PARITY_OK = '1')
      then
       if (BYTE_IN = x"16")
        then
         --TC07
         n_COUNT <= COUNT;
         T_END <= '1'; --Telegrammende erkannt 
         T_LENGTH <= COUNT;
         T_TYPE <= "0010"; --SD2
         SEND_OUT <= '1'; --senden
         PARITY_FAIL <= '0'; 
         NO_ED <= '0';
         WORKING <= '1'; --laeuft
         KNOWN_T <= '0';
         UNKNOWN_BYTE <= '0';
         n_SV <= ST_TC_07; --Zustandsuebergang
        else 
         if (COUNT = x"FE") --254
          then
           --TC18
           n_COUNT <= COUNT;
           T_END <= '0'; 
           T_LENGTH <= COUNT;
           T_TYPE <= "0000"; 
           SEND_OUT <= '1'; --senden
           PARITY_FAIL <= '0'; 
           NO_ED <= '1'; --kein Enddelimiter
           WORKING <= '0'; 
           KNOWN_T <= '0';
           UNKNOWN_BYTE <= '0';
           n_SV <= ST_TC_10; --Zustandsuebergang
          else --not COUNT = x"FE"
           --TC05
           n_COUNT <= COUNT+1;
           T_END <= '0'; 
           T_LENGTH <= COUNT;
           T_TYPE <= "0010"; --SD2
           SEND_OUT <= '1'; --senden
           PARITY_FAIL <= '0'; 
           NO_ED <= '0';
           WORKING <= '1'; --laeuft
           KNOWN_T <= '0';
           UNKNOWN_BYTE <= '0';
           n_SV <= ST_TC_03;
         end if; --COUNT = x"FE"
       end if; --BYTE_IN = x"16"
      else --PARITY_OK = '0'
       --TC17
       n_COUNT <= COUNT;
       T_END <= '0'; 
       T_LENGTH <= COUNT;
       T_TYPE <= "0000";
       SEND_OUT <= '0';
       PARITY_FAIL <= '1'; --Paritaets Fehler
       NO_ED <= '0';
       WORKING <= '0';
       KNOWN_T <= '0';
       UNKNOWN_BYTE <= '0';
       n_SV <= ST_TC_08; --Zustandsuebergang
     end if; --PARITY_OK = '1'
    else --BYTE_CMPLT = '0'
     --TC06
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0010"; --SD2
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '1'; --laeuft
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0';
     n_SV <= ST_TC_03;
   end if; --BYTE_CMPLT = '1'

  when ST_TC_04 =>
   if (BYTE_CMPLT = '1')
    then
     if (PARITY_OK = '1')
      then
       if (COUNT = x"0D") --13
        then
         if (BYTE_IN = x"16")
          then
           --TC10
           n_COUNT <= COUNT;
           T_END <= '1'; --Telegrammende erkannt
           T_LENGTH <= COUNT;
           T_TYPE <= "0011"; --SD3
           SEND_OUT <= '1'; --senden
           PARITY_FAIL <= '0'; 
           NO_ED <= '0';
           WORKING <= '1'; --laeuft
           KNOWN_T <= '0';
           UNKNOWN_BYTE <= '0';
           n_SV <= ST_TC_07; --Zustandsuebergang
          else --not BYTE_IN = x"16"
           --TC18
           n_COUNT <= COUNT;
           T_END <= '0'; 
           T_LENGTH <= COUNT;
           T_TYPE <= "0000"; 
           SEND_OUT <= '1'; --senden
           PARITY_FAIL <= '0'; 
           NO_ED <= '1'; --kein Enddelimiter
           WORKING <= '0'; 
           KNOWN_T <= '0';
           UNKNOWN_BYTE <= '0';
           n_SV <= ST_TC_10; --Zustandsuebergang
         end if; --BYTE_IN = x"16"
        else --not COUNT = x"0D"
         --TC08
         n_COUNT <= COUNT+1;
         T_END <= '0'; 
         T_LENGTH <= COUNT;
         T_TYPE <= "0011"; --SD3
         SEND_OUT <= '1'; --senden
         PARITY_FAIL <= '0';
         NO_ED <= '0';
         WORKING <= '1'; --laeuft
         KNOWN_T <= '0';
         UNKNOWN_BYTE <= '0';
         n_SV <= ST_TC_04; 
       end if; --COUNT = x"0D"
      else --PARITY_OK = '0'
       --TC17
       n_COUNT <= COUNT;
       T_END <= '0'; 
       T_LENGTH <= COUNT;
       T_TYPE <= "0000";
       SEND_OUT <= '0';
       PARITY_FAIL <= '1'; --Paritaets Fehler
       NO_ED <= '0';
       WORKING <= '0';
       KNOWN_T <= '0';
       UNKNOWN_BYTE <= '0';
       n_SV <= ST_TC_08; --Zustandsuebergang
     end if; --PARITY_OK = '1'
    else --BYTE_CMPLT = '0'
     --TC09   
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0011"; --SD3
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '1'; --laeuft
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0';
     n_SV <= ST_TC_04;
   end if; --BYTE_CMPLT = '1'

  when ST_TC_05 =>
   if (BYTE_CMPLT = '1')
    then
     if (PARITY_OK = '1')
      then
       if (COUNT = x"02") --bei Byte 3
        then
         --TC13
         n_COUNT <= COUNT;
         T_END <= '1'; --Telegrammende erkannt 
         T_LENGTH <= COUNT;
         T_TYPE <= "0100"; --SD4
         SEND_OUT <= '1'; --senden
         PARITY_FAIL <= '0';
         NO_ED <= '0';
         WORKING <= '1'; --laeuft
         KNOWN_T <= '0';
         UNKNOWN_BYTE <= '0';
         n_SV <= ST_TC_07; --Zustandsuebergang
        else --not COUNT = x"02"
         --TC11 
         n_COUNT <= COUNT+1;
         T_END <= '0'; 
         T_LENGTH <= COUNT;
         T_TYPE <= "0100"; --SD4
         SEND_OUT <= '1'; --senden
         PARITY_FAIL <= '0'; 
         NO_ED <= '0';
         WORKING <= '1'; --laeuft
         KNOWN_T <= '0';
         UNKNOWN_BYTE <= '0';
         n_SV <= ST_TC_05;
       end if; --COUNT = x"02"          
      else --PARITY_OK = '0'
       --TC17
       n_COUNT <= COUNT;
       T_END <= '0'; 
       T_LENGTH <= COUNT;
       T_TYPE <= "0000";
       SEND_OUT <= '0';
       PARITY_FAIL <= '1'; --Paritaets Fehler
       NO_ED <= '0';
       WORKING <= '0';
       KNOWN_T <= '0';
       UNKNOWN_BYTE <= '0';
       n_SV <= ST_TC_08; --Zustandsuebergang
     end if; --PARITY_OK = '1'
    else --BYTE_CMPLT = '0'
     --TC12
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0100"; --SD4
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '1'; --laeuft
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0';
     n_SV <= ST_TC_05;  
   end if; --BYTE_CMPLT = '1'

  when ST_TC_06 =>
   if (TELEGRAM_STOP = '1')
    then
     --TC15
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0000"; 
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '0'; 
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '1'; --Kein bekanntes Startdelimiter-Byte gefunden
     n_SV <= ST_TC_06;
    else
     --TC00
     n_COUNT <= x"00";
     T_END <= '0'; 
     T_LENGTH <= x"00";
     T_TYPE <= "0000";
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '0';
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0';
     n_SV <= ST_TC_00; --Zustandsuebergang
   end if; 

  when ST_TC_07 =>
   if (TELEGRAM_STOP = '1')
    then
     --TC16
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0000"; 
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '0'; 
     KNOWN_T <= '1'; --Bekanntes Telegramm gefunden
     UNKNOWN_BYTE <= '0'; 
     n_SV <= ST_TC_07;
    else
     --TC00
     n_COUNT <= x"00";
     T_END <= '0'; 
     T_LENGTH <= x"00";
     T_TYPE <= "0000";
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '0';
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0';
     n_SV <= ST_TC_00; --Zustandsuebergang
   end if;                

  when ST_TC_08 =>
   if (ERROR_CTRL = '1')
    then 
     --TC17
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0000"; 
     SEND_OUT <= '0';
     PARITY_FAIL <= '1'; --Paritaetsfehler festgestellt
     NO_ED <= '0';
     WORKING <= '0'; 
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0'; 
     n_SV <= ST_TC_09; --Zustandsuebergang
    else
     --TC17
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0000"; 
     SEND_OUT <= '0';
     PARITY_FAIL <= '1'; --Paritaetsfehler festgestellt
     NO_ED <= '0';
     WORKING <= '0'; 
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0'; 
     n_SV <= ST_TC_08;
   end if;

  when ST_TC_09 =>
   if (ERROR_CTRL = '1')
    then 
     --TC17
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0000"; 
     SEND_OUT <= '0';
     PARITY_FAIL <= '1'; --Paritaetsfehler festgestellt
     NO_ED <= '0';
     WORKING <= '0'; 
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0'; 
     n_SV <= ST_TC_09; 
    else
     -- TC00
     n_COUNT <= x"00";
     T_END <= '0'; 
     T_LENGTH <= x"00";
     T_TYPE <= "0000";
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '0';
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0';
     n_SV <= ST_TC_00; --Zustandsuebergang
   end if;

  when ST_TC_10 =>
   if (ERROR_CTRL = '1')
    then 
     --TC19
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0000"; 
     SEND_OUT <= '0';
     PARITY_FAIL <= '0'; 
     NO_ED <= '1'; --Fehlendes Enddelimiter festgestellt
     WORKING <= '0'; 
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0'; 
     n_SV <= ST_TC_11; --Zustandsuebergang
    else
     --TC19
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0000"; 
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '1'; --Fehlendes Enddelimiter festgestellt
     WORKING <= '0'; 
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0'; 
     n_SV <= ST_TC_10;
   end if;

  when ST_TC_11 =>
   if (ERROR_CTRL = '1')
    then 
     --TC19
     n_COUNT <= COUNT;
     T_END <= '0'; 
     T_LENGTH <= COUNT;
     T_TYPE <= "0000"; 
     SEND_OUT <= '0';
     PARITY_FAIL <= '0'; 
     NO_ED <= '1'; --Fehlendes Enddelimiter festgestellt
     WORKING <= '0'; 
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0'; 
     n_SV <= ST_TC_11; 
    else
     -- TC00
     n_COUNT <= x"00";
     T_END <= '0'; 
     T_LENGTH <= x"00";
     T_TYPE <= "0000";
     SEND_OUT <= '0';
     PARITY_FAIL <= '0';
     NO_ED <= '0';
     WORKING <= '0';
     KNOWN_T <= '0';
     UNKNOWN_BYTE <= '0';
     n_SV <= ST_TC_00; --Zustandsuebergang
   end if;

  when others => 
   -- TC00
   n_COUNT <= x"00";
   T_END <= '0'; 
   T_LENGTH <= x"00";
   T_TYPE <= "0000";
   SEND_OUT <= '0';
   PARITY_FAIL <= '0';
   NO_ED <= '0';
   WORKING <= '0';
   KNOWN_T <= '0';
   UNKNOWN_BYTE <= '0';
   n_SV <= ST_TC_00;
 end case;
end process;

STATE_DISPL_PROC: process (SV, n_SV, STATE_SV, STATE_n_SV, DISPL_COUNT, COUNT) -- Zustandsanzeige
 begin
  STATE_SV   <= conv_std_logic_vector(TYPE_STATE'pos(  SV),8); --Zustandsumwandlung in 8 Bit
  STATE_n_SV <= conv_std_logic_vector(TYPE_STATE'pos(n_SV),8);
     
  DISPL1_SV(0) <= STATE_SV(0); --Bit0
  DISPL1_SV(1) <= STATE_SV(1); --Bit1
  DISPL1_SV(2) <= STATE_SV(2); --Bit2
  DISPL1_SV(3) <= STATE_SV(3); --Bit3

  DISPL2_SV(0) <= STATE_SV(4); --usw.
  DISPL2_SV(1) <= STATE_SV(5);
  DISPL2_SV(2) <= STATE_SV(6);
  DISPL2_SV(3) <= STATE_SV(7);

  if (DISPL_COUNT = '1')
   then
    -- Zaehler anzeigen
    DISPL1_n_SV(0)  <= COUNT(0);
    DISPL1_n_SV(1)  <= COUNT(1);
    DISPL1_n_SV(2)  <= COUNT(2);
    DISPL1_n_SV(3)  <= COUNT(3);
  
    DISPL2_n_SV(0)  <= COUNT(4);
    DISPL2_n_SV(1)  <= COUNT(5);
    DISPL2_n_SV(2)  <= COUNT(6);
    DISPL2_n_SV(3)  <= COUNT(7);
   else 
    --Folgezustand anzeigen
    DISPL1_n_SV(0)  <= STATE_n_SV(0);
    DISPL1_n_SV(1)  <= STATE_n_SV(1);
    DISPL1_n_SV(2)  <= STATE_n_SV(2);
    DISPL1_n_SV(3)  <= STATE_n_SV(3);
  
    DISPL2_n_SV(0)  <= STATE_n_SV(4);
    DISPL2_n_SV(1)  <= STATE_n_SV(5);
    DISPL2_n_SV(2)  <= STATE_n_SV(6);
    DISPL2_n_SV(3)  <= STATE_n_SV(7);
  end if;
end process;

end Behavioral;
