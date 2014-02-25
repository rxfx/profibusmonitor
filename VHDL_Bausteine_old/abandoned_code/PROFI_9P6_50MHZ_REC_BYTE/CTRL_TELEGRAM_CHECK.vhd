-- CTRL_TELEGRAM_CHECK
-- Profibus Telegramtyp ermitteln, aktuelle Laenge und Telegram komplett anzeigen
-- Ersteller: Martin Harndt
-- Erstellt: 02.01.2013
-- Bearbeiter: mharndt
-- Geaendert: 08.01.2013



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CTRL_TELEGRAM_CHECK is

    Port (BYTE_IN  : in std_logic_vector (7 downto 0); --Eingangsvariable, Byte, 8bit
         BYTE_NUM : in std_logic_vector (7 downto 0); --Eingangsvariable, Bytenummer, 8bit
         NEXT_TELEGRAM : in std_logic; --Eingangsvariable, naechstes Telegramm
         TELEGRAM_LENGTH : out std_logic_vector (7 downto 0); --Ausgangsvariable, Telegrammlaenge, 8bit
         TELEGRAM_TYPE : out std_logic_vector (3 downto 0); --Ausgangsvariable, Telegrammtyp, 4bit
         TELEGRAM_CMPLT : out std_logic; --Ausgangsvariable, Telegramm komplett

--		   DISPL_COUNT  : in  std_logic; --Eingangsvariable, Folgeszustand oder Bytezaehler anzeigen

 		   CLK	      : in  std_logic; --Taktvariable
		   CLK_IO       : in  std_logic; --Tanktvariable,
		   						   --Ein- und Ausgangsregister
		   IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
		   RESET		 : in std_logic);   --1: Initialzustand annehmen

         
		   
--		   DISPL1_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl1, binärzahl
--		   DISPL2_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl2, binärzahl
--		   DISPL1_n_SV  : out std_logic_vector (3 downto 0); --Folgezustand Zahl1, binärzahl
--		   DISPL2_n_SV	 : out std_logic_vector (3 downto 0));  --Folgezustand Zahl2, binärzahl

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
               ST_TC_11,
               ST_TC_12,
               ST_TC_13);

signal SV  : TYPE_STATE; --Zustandsvariable
signal n_SV: TYPE_STATE; --Zustandsvariable, neuer Wert
signal SV_M: TYPE_STATE; --Zustandsvariable, Ausgang Master


signal TELE_COUNT   : std_logic_vector (7 downto 0); -- Vektor, Telegrammlaenge, 8bit
signal n_TELE_COUNT : std_logic_vector (7 downto 0); -- Vektor, Telegrammlaenge, 8bit, neuer Wert
signal TELE_COUNT_M : std_logic_vector (7 downto 0); -- Vektor, Telegrammlaenge, 8bit, Ausgang Master

signal TELEGRAM_LE   : std_logic_vector (7 downto 0); -- Vektor, Telegrammlaenge, 8bit
signal n_TELEGRAM_LE : std_logic_vector (7 downto 0); -- Vektor, Telegrammlaenge, 8bit, neuer Wert
signal TELEGRAM_LE_M : std_logic_vector (7 downto 0); -- Vektor, Telegrammlaenge, 8bit, Ausgang Master

signal TELEGRAM_LEr   : std_logic_vector (7 downto 0); -- Vektor, Telegrammlaenge, 8bit
signal n_TELEGRAM_LEr : std_logic_vector (7 downto 0); -- Vektor, Telegrammlaenge, 8bit, neuer Wert
signal TELEGRAM_LEr_M : std_logic_vector (7 downto 0); -- Vektor, Telegrammlaenge, 8bit, Ausgang Master

signal BYTE_IN_S : std_logic_vector (7 downto 0); --Eingangsvariable, 8bit, zwischengespeichert im Eingangsregister
signal BYTE_NUM_S : std_logic_vector (7 downto 0); --Eingangsvariable, 8bit, zwischengespeichert im Eingangsregister
signal NEXT_TELEGRAM_S : std_logic; --Eingangsvariable, zwischengespeichert im Eingangsregister

Signal FIRST_4_BITS : std_logic_vector (3 downto 0); -- Zwischenspeicher der ersten 4 bit von BYTE_IN_S

--signal STATE_SV   : std_logic_vector (7 downto 0); -- aktueller Zustand, Anzeige, in 8 Bit, binär
--signal STATE_n_SV : std_logic_vector (7 downto 0); -- Folgezustand, Anzeige, in 8 Bit, binär

signal not_CLK   : std_logic; --negierte Taktvariable
signal not_CLK_IO: std_logic; --negierte Taktvariable
						--Ein- und Ausgangsregister

begin

NOT_CLK_PROC: process (CLK) --negieren Taktvariable
begin
  not_CLK <= not CLK;
end process;
NOT_CLK_IO_PROC: process (CLK_IO) --negieren Taktvaraible
						    --Ein- und Ausgangsregister
begin
  not_CLK_IO <= not CLK_IO;
end process;

IREG_PROC: process (not_CLK_IO) --Eingangsregister
begin
 if (not_CLK_IO'event and not_CLK_IO = '1') --Eingangsregister
   then BYTE_IN_S <= BYTE_IN;
        BYTE_NUM_S <= BYTE_NUM;
        NEXT_TELEGRAM_S <= NEXT_TELEGRAM;
end if;
end process;

SREG_M_PROC: process (RESET, n_SV, CLK) --Master
begin
  if (RESET ='1')
   then SV_M    <= ST_TC_00;	
   else
     if (CLK'event and CLK = '1')
	 then
	   if (IN_NEXT_STATE = '1')
	    then SV_M    <= n_SV;
            TELE_COUNT_M <= n_TELE_COUNT;
            TELEGRAM_LE_M <= n_TELEGRAM_LE;
            TELEGRAM_LEr_M <= n_TELEGRAM_LEr;
	    else SV_M    <= SV_M;
            TELE_COUNT_M <= TELE_COUNT_M;
            TELEGRAM_LE_M <= TELEGRAM_LE_M;
            TELEGRAM_LEr_M <= TELEGRAM_LEr_M;
        end if;
	end if;
  end if;
end process;

SREG_S_PROC: process (RESET, SV_M, not_CLK) --Slave
begin
  if (RESET = '1')
   then SV    <= ST_TC_00;
   else
     if (not_CLK'event and not_CLK = '1')
	 then SV    <= SV_M;
         TELE_COUNT <= TELE_COUNT_M;
         TELEGRAM_LE <= TELEGRAM_LE_M;
         TELEGRAM_LEr <= TELEGRAM_LEr_M;
     end if;
   end if;
end process;

TELEGRAM_CHECK_PROC:process (BYTE_IN_S, BYTE_NUM_S, NEXT_TELEGRAM_S, SV, TELE_COUNT, FIRST_4_BITS, TELEGRAM_LE, TELEGRAM_LEr) --Telegramtyp ermitteln, aktuelle Laenge und Telegram komplett anzeigen
begin
 case SV is
  when ST_TC_00 =>
   if (NEXT_TELEGRAM_S = '1')
    then
     -- TC01
     n_TELE_COUNT <= x"00"; --Null (hex) 
     TELEGRAM_LENGTH <= x"00"; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0000"; -- Null (bin)
     TELEGRAM_CMPLT <= '0'; -- Null (bin)
     n_SV <= ST_TC_01; -- Zustandsuebergang
    else
     -- TC00
     n_TELE_COUNT <= x"00"; --Null (hex) 
     TELEGRAM_LENGTH <= x"00"; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0000"; -- Null (bin)
     TELEGRAM_CMPLT <= '0'; -- Null (bin)
     n_SV <= ST_TC_00; -- bleibt im aktuellen Zustand
   end if;
  
  when ST_TC_01 =>
   if (BYTE_NUM_S = x"01") -- Eins
    then
     -- TC01
     n_TELE_COUNT <= x"00"; --Null (hex) 
     TELEGRAM_LENGTH <= x"00"; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0000"; -- Null (bin)
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_02; -- Zustandsuebergang
    else
     -- TC01
     n_TELE_COUNT <= x"00"; --Null (hex) 
     TELEGRAM_LENGTH <= x"00"; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0000"; -- Null (bin)
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_01; -- bleibt im aktuellen Zustand
    end if;

  when ST_TC_02 =>
   if (FIRST_4_BITS = "0001") -- SD1
    then
     -- TC02
     n_TELE_COUNT <= TELE_COUNT+1; -- erhoehen 
     TELEGRAM_LENGTH <= TELE_COUNT;
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00"; 
     TELEGRAM_TYPE <= "0001"; -- Eins fur SD1
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_03; -- Zustandsuebergang
    else
     -- TC01
     n_TELE_COUNT <= TELE_COUNT; --bleibt gleich 
     TELEGRAM_LENGTH <= x"00"; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0000"; -- Null (bin)
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_04; -- Zustandsuebergang
    end if;

  when ST_TC_03 =>
   if (BYTE_NUM_S = x"06") -- 6 Byte Laenge
    then
     -- TC04
     n_TELE_COUNT <= TELE_COUNT+1; -- erhoehen 
     TELEGRAM_LENGTH <= n_TELE_COUNT; -- n_TELE_COUNT um aktuellen Wert auszugeben da sonst eins zu niedrig
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00"; 
     TELEGRAM_TYPE <= "0001"; -- Eins fur SD1
     TELEGRAM_CMPLT <= '1'; -- komplett
     n_SV <= ST_TC_00; -- Zustandsuebergang
    else
     -- TC03
     n_TELE_COUNT <= TELE_COUNT+1; -- erhoehen 
     TELEGRAM_LENGTH <= TELE_COUNT; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0001"; -- Eins fur SD1
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_03; -- bleibt im aktuellen Zustand
    end if;

  when ST_TC_04 =>
   if (FIRST_4_BITS = "1010") -- SD3
    then
     -- TC05
     n_TELE_COUNT <= TELE_COUNT+1; -- erhoehen 
     TELEGRAM_LENGTH <= TELE_COUNT;
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0011"; -- 3 fuer SD3
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_05; -- Zustandsuebergang
    else
     -- TC01
     n_TELE_COUNT <= TELE_COUNT; -- bleibt gleich 
     TELEGRAM_LENGTH <= x"00"; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0000"; -- Null (bin)
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_06; -- Zustandsuebergang
    end if;
    
  when ST_TC_05 =>
   if (BYTE_NUM_S = x"07") -- 7 Byte Laenge
    then
     -- TC07
     n_TELE_COUNT <= TELE_COUNT+1; -- erhoehen 
     TELEGRAM_LENGTH <= n_TELE_COUNT; -- n_TELE_COUNT um aktuellen Wert auszugeben da sonst eins zu niedrig
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00"; 
     TELEGRAM_TYPE <= "0011"; -- 3 fuer SD3
     TELEGRAM_CMPLT <= '1'; -- komplett
     n_SV <= ST_TC_00; -- Zustandsuebergang
    else
     -- TC06
     n_TELE_COUNT <= TELE_COUNT+1; -- erhoehen 
     TELEGRAM_LENGTH <= TELE_COUNT; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0000"; -- 3 fuer SD3
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_05; -- bleibt im aktuellen Zustand
    end if;  

  when ST_TC_06 =>
   if (FIRST_4_BITS = "1101") -- SD4
    then
     -- TC08
     n_TELE_COUNT <= TELE_COUNT+1; -- erhoehen 
     TELEGRAM_LENGTH <= TELE_COUNT;
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00"; 
     TELEGRAM_TYPE <= "0100"; -- 4 fur SD4
     TELEGRAM_CMPLT <= '0';
     n_SV <= ST_TC_07; -- Zustandsuebergang
    else
     -- TC01
     n_TELE_COUNT <= TELE_COUNT; --bleibt gleich 
     TELEGRAM_LENGTH <= x"00"; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00"; 
     TELEGRAM_TYPE <= "0000"; -- Null (bin)
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_08; -- Zustandsuebergang
    end if;

  when ST_TC_07 =>
   if (BYTE_NUM_S = x"03") -- 3 Byte Laenge
    then
     -- TC10
     n_TELE_COUNT <= TELE_COUNT+1; -- erhoehen 
     TELEGRAM_LENGTH <= n_TELE_COUNT; -- n_TELE_COUNT um aktuellen Wert auszugeben da sonst eins zu niedrig
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";      
     TELEGRAM_TYPE <= "0100"; -- 4 fur SD4
     TELEGRAM_CMPLT <= '1'; -- komplett
     n_SV <= ST_TC_00; -- Zustandsuebergang
    else
     -- TC09
     n_TELE_COUNT <= TELE_COUNT+1; -- erhoehen 
     TELEGRAM_LENGTH <= TELE_COUNT;
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00"; 
     TELEGRAM_TYPE <= "0100"; -- 4 fur SD4)
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_07; -- Zustandsuebergang
    end if;

  when ST_TC_08 =>
   if (FIRST_4_BITS = "1110") -- SC
    then
     -- TC11
     n_TELE_COUNT <= TELE_COUNT+1; --erhoehen 
     TELEGRAM_LENGTH <= n_TELE_COUNT; -- n_TELE_COUNT um aktuellen Wert auszugeben da sonst eins zu niedrig
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "1000"; -- 8 fur SC
     TELEGRAM_CMPLT <= '1'; -- komplett
     n_SV <= ST_TC_00; -- Zustandsuebergang
    else
     -- TC01
     n_TELE_COUNT <= TELE_COUNT; --bleibt gleich 
     TELEGRAM_LENGTH <= x"00"; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0000"; -- Null (bin)
     TELEGRAM_CMPLT <= '0';
     n_SV <= ST_TC_09; -- Zustandsuebergang
    end if;

  when ST_TC_09 =>
   if (FIRST_4_BITS = "0110") -- SD2
    then
     -- TC12
     n_TELE_COUNT <= TELE_COUNT+1; --erhoehen 
     TELEGRAM_LENGTH <= TELE_COUNT; -- evtl. n_TELE_COUNT hier
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0010"; -- 2 fur SD2
     TELEGRAM_CMPLT <= '0';
     n_SV <= ST_TC_10; -- Zustandsuebergang
    else
     -- TC00
     n_TELE_COUNT <= x"00"; -- Null (hex) 
     TELEGRAM_LENGTH <= x"00"; -- Null (hex)
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0000"; -- Null (bin)
     TELEGRAM_CMPLT <= '0';
     n_SV <= ST_TC_00; -- Zustandsuebergang
    end if;

  when ST_TC_10 =>
   if (BYTE_NUM_S = x"02") -- 2. Byte
    then
     -- TC14
     n_TELE_COUNT <= TELE_COUNT+1; --erhoehen 
     TELEGRAM_LENGTH <= TELE_COUNT;
     n_TELEGRAM_LE <= BYTE_IN_S;
     n_TELEGRAM_LEr <= x"00"; 
     TELEGRAM_TYPE <= "0010"; -- 2 fur SD2
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_11; -- Zustandsuebergang
    else
     -- TC13
     n_TELE_COUNT <= TELE_COUNT+1; --erhoehen  
     TELEGRAM_LENGTH <= TELE_COUNT;
     n_TELEGRAM_LE <= x"00"; 
     n_TELEGRAM_LEr <= x"00";
     TELEGRAM_TYPE <= "0010"; -- 2 fur SD2
     TELEGRAM_CMPLT <= '0';
     n_SV <= ST_TC_10; -- bleibt im aktuellen Zustand
    end if;

  when ST_TC_11 =>
   if (BYTE_NUM_S = x"03") -- 3. Byte
    then
     -- TC16
     n_TELE_COUNT <= TELE_COUNT+1; --erhoehen 
     TELEGRAM_LENGTH <= TELE_COUNT;
     n_TELEGRAM_LE <= TELEGRAM_LE;
     n_TELEGRAM_LEr <= BYTE_IN_S; 
     TELEGRAM_TYPE <= "0010"; -- 2 fur SD2
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_12; -- Zustandsuebergang
    else
     -- TC15
     n_TELE_COUNT <= TELE_COUNT+1; --erhoehen  
     TELEGRAM_LENGTH <= TELE_COUNT;
     n_TELEGRAM_LE <= TELEGRAM_LE;
     n_TELEGRAM_LEr <= BYTE_IN_S;  
     TELEGRAM_TYPE <= "0010"; -- 2 fur SD2
     TELEGRAM_CMPLT <= '0';
     n_SV <= ST_TC_11; -- bleibt im aktuellen Zustand
    end if;

  when ST_TC_12 =>
   if (TELEGRAM_LE = TELEGRAM_LEr) -- Vergleich ob Laenge uebereinstimmt
    then
     -- TC17
     n_TELE_COUNT <= TELE_COUNT+1; --erhoehen 
     TELEGRAM_LENGTH <= TELE_COUNT;
     n_TELEGRAM_LE <= TELEGRAM_LE;
     n_TELEGRAM_LEr <= TELEGRAM_LEr;  
     TELEGRAM_TYPE <= "0010"; -- 2 fur SD2
     TELEGRAM_CMPLT <= '0'; 
     n_SV <= ST_TC_13; -- Zustandsuebergang
    else
     -- TC00
     n_TELE_COUNT <= x"00"; --Null (hex) 
     TELEGRAM_LENGTH <= x"00"; -- Null (hex)
     n_TELEGRAM_LE <= TELEGRAM_LE;
     n_TELEGRAM_LEr <= TELEGRAM_LEr; 
     TELEGRAM_TYPE <= "0000"; -- Null (bin)
     TELEGRAM_CMPLT <= '0'; -- Null (bin)
     n_SV <= ST_TC_00; -- bleibt im aktuellen Zustand
    end if;

  when ST_TC_13 =>
   if (BYTE_NUM_S = TELEGRAM_LE) -- Wenn ermittelte Laenge eintritt
    then
     -- TC19
     n_TELE_COUNT <= TELE_COUNT+1; --erhoehen 
     TELEGRAM_LENGTH <= n_TELE_COUNT; -- n_TELE_COUNT um aktuellen Wert auszugeben da sonst eins zu niedrig
     n_TELEGRAM_LE <= TELEGRAM_LE;
     n_TELEGRAM_LEr <= TELEGRAM_LEr; 
     TELEGRAM_TYPE <= "0010"; -- 2 fur SD2
     TELEGRAM_CMPLT <= '1'; -- komplett 
     n_SV <= ST_TC_00; -- Zustandsuebergang
    else
     -- TC18
     n_TELE_COUNT <= TELE_COUNT+1; --erhoehen  
     TELEGRAM_LENGTH <= TELE_COUNT;
     n_TELEGRAM_LE <= TELEGRAM_LE;
     n_TELEGRAM_LEr <= TELEGRAM_LEr;  
     TELEGRAM_TYPE <= "0010"; -- 2 fur SD2
     TELEGRAM_CMPLT <= '0';
     n_SV <= ST_TC_13; -- bleibt im aktuellen Zustand
    end if;

  when others =>
   -- TC00
    n_TELE_COUNT <= x"00"; --Null (hex) 
    TELEGRAM_LENGTH <= x"00"; -- Null (hex)
    n_TELEGRAM_LE <= x"00"; 
    n_TELEGRAM_LEr <= x"00";
    TELEGRAM_TYPE <= "0000"; -- Null (bin)
    TELEGRAM_CMPLT <= '0'; -- Null (bin)
    n_SV <= ST_TC_00; -- bleibt im aktuellen Zustand
 end case;

end process;

BYTE_IN_8_TO_4_PROC: process (BYTE_IN_S) -- Umwandlung von BYTE_IN zu FIRST_4_BITS
 begin
   FIRST_4_BITS(0) <= BYTE_IN_S(0);
   FIRST_4_BITS(1) <= BYTE_IN_S(1);
   FIRST_4_BITS(2) <= BYTE_IN_S(2);
   FIRST_4_BITS(3) <= BYTE_IN_S(3);

end process;

--STATE_DISPL_PROC: process (SV, n_SV, DISPL_COUNT, STATE_SV, STATE_n_SV, TELE_COUNT) -- Zustandsanzeige
-- begin
--  STATE_SV   <= conv_std_logic_vector(TYPE_STATE'pos(  SV),8); --Zustandsumwandlung in 8 Bit
--  STATE_n_SV <= conv_std_logic_vector(TYPE_STATE'pos(n_SV),8);
  --anktuellen Zustand anzeigen   
--  DISPL1_SV(0) <= STATE_SV(0); --Bit0
--  DISPL1_SV(1) <= STATE_SV(1); --Bit1
--  DISPL1_SV(2) <= STATE_SV(2); --Bit2
--  DISPL1_SV(3) <= STATE_SV(3); --Bit3

--  DISPL2_SV(0) <= STATE_SV(4); --usw.
--  DISPL2_SV(1) <= STATE_SV(5);
--  DISPL2_SV(2) <= STATE_SV(6);
--  DISPL2_SV(3) <= STATE_SV(7);

--  if (DISPL_COUNT ='0') --Original
--   then --Folgezustand anzeigen
--    DISPL1_n_SV(0)  <= STATE_n_SV(0);
--    DISPL1_n_SV(1)  <= STATE_n_SV(1);
--    DISPL1_n_SV(2)  <= STATE_n_SV(2);
--    DISPL1_n_SV(3)  <= STATE_n_SV(3);
   
--    DISPL2_n_SV(0)  <= STATE_n_SV(4);
--    DISPL2_n_SV(1)  <= STATE_n_SV(5);
--    DISPL2_n_SV(2)  <= STATE_n_SV(6);
--    DISPL2_n_SV(3)  <= STATE_n_SV(7);

--   else  --Telegrammzaehler anzeigen 
--    DISPL1_n_SV(0) <= TELE_COUNT(0);
--    DISPL1_n_SV(1) <= TELE_COUNT(1);
--    DISPL1_n_SV(2) <= TELE_COUNT(2);
--    DISPL1_n_SV(3) <= TELE_COUNT(3);
    
--    DISPL2_n_SV(0) <= TELE_COUNT(4);
--    DISPL2_n_SV(1) <= TELE_COUNT(5);
--    DISPL2_n_SV(2) <= TELE_COUNT(6);
--    DISPL2_n_SV(3) <= TELE_COUNT(7);
--  end if;
-- end process;

end Behavioral;
