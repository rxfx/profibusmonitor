-- PROFI_9P6_50MHZ_REC_BYTE
-- PROFIBUS MONITOR
-- Ersteller: Martin Harndt
-- Erstellt: 09.10.2012
-- Bearbeiter: mharndt
-- Geaendert: 25.10.2012 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CTRL_9P6_50MHZ_VHDL is
    Port (   InAB         : in  std_logic; --Eingangsvariable, Eingang Profibussignal
             ERROR_QUIT   : in  std_logic; --Eingangsvariable, Fehler beenden
		   CTRL_ERROR   : out std_logic; --Ausgangsvariable, Fehler anzeigen

		   EN_BIT_0	 : out std_logic; --Ausgangsvariable
		   EN_BIT_1	 : out std_logic; --Ausgangsvariable
		   EN_BIT_2	 : out std_logic; --Ausgangsvariable
		   EN_BIT_3	 : out std_logic; --Ausgangsvariable
		   EN_BIT_4	 : out std_logic; --Ausgangsvariable
		   EN_BIT_5	 : out std_logic; --Ausgangsvariable
		   EN_BIT_6	 : out std_logic; --Ausgangsvariable
		   EN_BIT_7	 : out std_logic; --Ausgangsvariable
		   EN_BIT_8	 : out std_logic; --Ausgangsvariable

		   BIT_VALUE	 : out std_logic; --Ausgangsvariable, Bitwert
		   BYTE_OK	 : out std_logic; --Ausgangsvariable, Byte vollständig

 		   CLK	      : in  std_logic; --Taktvariable
		   CLK_IO       : in  std_logic; --Tanktvariable,
		   						   --Ein- und Ausgangsregister
		   IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
		   RESET		 : in std_logic;   --1: Initialzustand annehmen
		   
		   DISPL1_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl1, binärzahl
		   DISPL2_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl2, binärzahl
		   DISPL1_n_SV  : out std_logic_vector (3 downto 0); --Folgezustand Zahl1, binärzahl
		   DISPL2_n_SV	 : out std_logic_vector (3 downto 0)  --Folgezustand Zahl2, binärzahl 	
 		);
end CTRL_9P6_50MHZ_VHDL;

architecture Behavioral of CTRL_9P6_50MHZ_VHDL is

type TYPE_STATE is (ST_CTRL_00, --Zustaende
				ST_CTRL_01,
				ST_CTRL_02,
				ST_CTRL_03,
				ST_CTRL_04,
				ST_CTRL_05,
				ST_CTRL_06,
				ST_CTRL_07,
				ST_CTRL_08,
				ST_CTRL_09,
				ST_CTRL_0A, --10
				ST_CTRL_0B, --11
				ST_CTRL_0C, --12
				ST_CTRL_0D, --13
				ST_CTRL_0E, --14
				ST_CTRL_0F, --15
				ST_CTRL_10, --16
				ST_CTRL_11, --17
				ST_CTRL_12, --18
				ST_CTRL_13); --19

signal SV  : TYPE_STATE; --Zustandsvariable
signal n_SV: TYPE_STATE; --Zustandsvariable, neuer Wert
signal SV_M: TYPE_STATE; --Zustandsvariable, Ausgang Master

signal COUNT   : std_logic_vector (19 downto 0);  --Zaehler, Vektor, 20 Bit
signal n_COUNT : std_logic_vector (19 downto 0); --Zaehler, neuer Wert, Vektor, 20 Bit
signal COUNT_M : std_logic_vector (19 downto 0); --Zaehler, Ausgang Master, Vektor, 20 Bit

signal LONG_STATE_SV   : std_logic_vector (7 downto 0); -- aktueller Zustand in 8 Bit, binär
signal LONG_STATE_n_SV : std_logic_vector (7 downto 0); -- Folgezustand in 8 Bit, binär
 
signal InAB_S    : std_logic; --Eingangsvariable
					     --Zwischengespeichert im Eingangsregister

signal not_CLK   : std_logic; --negierte Taktvariable
signal not_CLK_IO: std_logic; --negierte Taktvariable
						--Ein- und Ausgangsregister

constant CNTS30 : std_logic_vector := x"2625A"; --Konstanten
constant CNTT01 : std_logic_vector := x"00A2C";
constant CNTT02 : std_logic_vector := x"01E84";
constant CNTT03 : std_logic_vector := x"032DC";
constant CNTT04 : std_logic_vector := x"04735";
constant CNTT05 : std_logic_vector := x"05B8B";
constant CNTT06 : std_logic_vector := x"06FE4";
constant CNTT07 : std_logic_vector := x"08441";
constant CNTT08 : std_logic_vector := x"09872";
constant CNTT09 : std_logic_vector := x"0ACEE";
constant CNTT10 : std_logic_vector := x"0C147";
constant CNTT11 : std_logic_vector := x"0D59F";
constant CNTT12 : std_logic_vector := x"0EE09";
constant CNTT13 : std_logic_vector := x"0FA3E";

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

IREG_PROC: process (InAB, InAB_S, not_CLK_IO) --Eingangsregister
begin
 if (not_CLK_IO'event and not_CLK_IO = '1') --Eingangsregister
   then InAB_S <= InAB;
end if;
end process;

SREG_M_PROC: process (RESET, n_SV, n_COUNT, CLK) --Master
begin
  if (RESET ='1')
   then SV_M <= ST_CTRL_00;
   else
     if (CLK'event and CLK = '1')
	 then
	   if (IN_NEXT_STATE = '1')
	    then SV_M <= n_SV;
		    COUNT_M <= n_COUNT;
	    else SV_M <= SV_M;
	         COUNT_M <= COUNT_M;
        end if;
	end if;
  end if;
end process;

SREG_S_PROC: process (RESET, SV_M, COUNT_M, not_CLK) --Slave
begin
  if (RESET = '1')
   then SV <= ST_CTRL_00;
   else
     if (not_CLK'event and not_CLK = '1')
	 then SV <= SV_M;
	 	 COUNT <= COUNT_M;
     end if;
   end if;
end process;

IL_OL_PROC: process (InAB_S, SV)
begin
  case SV is
    when ST_CTRL_00 =>
   	-- VAS00
    	COUNT <= x"00000"; -- Zaehler nullen
	   EN_BIT_0 <= '0';
   	EN_BIT_1 <= '0';
	   EN_BIT_2 <= '0';
   	EN_BIT_3 <= '0';
   	EN_BIT_4 <= '0';
   	EN_BIT_5 <= '0';
   	EN_BIT_6 <= '0';
   	EN_BIT_7 <= '0';
   	EN_BIT_8 <= '0';
   	BIT_VALUE <= '0';
   	BYTE_OK <= '0';
	   CTRL_ERROR <= '0';
	 
      if (InAB_S = '1')
	  then
	  -- VAS00
	   COUNT <= x"00000"; -- Zaehler Neustart
	   EN_BIT_0 <= '0';
	   EN_BIT_1 <= '0';
	   EN_BIT_2 <= '0';
	   EN_BIT_3 <= '0';
	   EN_BIT_4 <= '0';
	   EN_BIT_5 <= '0';
	   EN_BIT_6 <= '0';
	   EN_BIT_7 <= '0';
	   EN_BIT_8 <= '0';
	   BIT_VALUE <= '0';
	   BYTE_OK <= '0';
	   CTRL_ERROR <= '0'; 
	   n_SV <= ST_CTRL_01; -- Zustandsuebgergang
	  else 
	   n_SV <= ST_CTRL_00; --InAB = '0'
	 end if;

    when ST_CTRL_01 =>
     if (n_COUNT >= CNTS30) --156250
	 then
	 -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_02; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTS30
    --VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_01; --Zaehlschleife
	 end if;

    when ST_CTRL_02 =>
 	 if (InAB_S = '0')
	 then
	 -- VAS00
	  COUNT <= x"00000"; -- Zaehler Neustart
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_03; -- Zustandsuebgergang
	 else 			  -- InAB_S = '1'
    --VAS01
	  n_COUNT <= COUNT+1; -- dieser Zähler wird nicht abgefragt! (Sinnlos?) 
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_02; --warte tsyn30 ab
	 end if;

    when ST_CTRL_03 =>
     if (n_COUNT >= CNTT01) --2604
	 then
	 -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_04; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT01
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_03; --Zaehlschleife
	 end if;

    when ST_CTRL_04 =>
 	 if (InAB_S = '0') -- Startbit erkannt
	 then
	 -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_06; -- Zustandsuebgergang
	 else                 --InAB_S = '1'
    -- VAS02
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '1'; 
	  n_SV <= ST_CTRL_05; --Error
	 end if;

    when ST_CTRL_05 =>
 	 if (ERROR_QUIT = '0') -- Error nicht bestätigt
	 then
	 -- VAS02
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '1'; 
	  n_SV <= ST_CTRL_05; -- Fehlerschleife
	 else                 --ERROR_QUIT = '1'
    -- VAS00
	  n_SV <= ST_CTRL_00; --Zurueck zum Initialzustand
	 end if;

    when ST_CTRL_06 =>
     if (n_COUNT >= CNTT02) --7812
	 then
	 -- VAS03
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '1';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= InAB_S;
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_07; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT02
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_06; --Zaehlschleife
	 end if;

    when ST_CTRL_07 =>
     if (n_COUNT >= CNTT03) --13020
	 then
	 -- VAS04
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '1';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= InAB_S;
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_08; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT03
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_07; --Zaehlschleife
	 end if;

    when ST_CTRL_08 =>
     if (n_COUNT >= CNTT04) --18229
	 then
	 -- VAS05
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '1';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= InAB_S;
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_09; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT04
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_08; --Zaehlschleife
	 end if;

    when ST_CTRL_09 =>
     if (n_COUNT >= CNTT05) --23435
	 then
	 -- VAS06
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '1';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= InAB_S;
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0A; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT05
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_09; --Zaehlschleife
	 end if;

    when ST_CTRL_0A =>
     if (n_COUNT >= CNTT06) --28644
	 then
	 -- VAS07
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '1';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= InAB_S;
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0B; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT06
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0A; --Zaehlschleife
	 end if;

    when ST_CTRL_0B =>
     if (n_COUNT >= CNTT07) --33854
	 then
	 -- VAS08
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '1';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= InAB_S;
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0C; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT07
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0B; --Zaehlschleife
	 end if;

    when ST_CTRL_0C =>
     if (n_COUNT >= CNTT08) --39062
	 then
	 -- VAS09
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '1';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= InAB_S;
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0B; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT08
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0C; --Zaehlschleife
	 end if;

    when ST_CTRL_0D =>
     if (n_COUNT >= CNTT09) --44270
	 then
	 -- VAS10
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '1';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= InAB_S;
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0E; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT09
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0D; --Zaehlschleife
	 end if;

    when ST_CTRL_0E =>
     if (n_COUNT >= CNTT10) --49479
	 then
	 -- VAS11
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '1';
	  BIT_VALUE <= InAB_S;
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0F; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT10
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0E; --Zaehlschleife
	 end if;

    when ST_CTRL_0F =>
     if (n_COUNT >= CNTT11) --54687
	 then
	 -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_10; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT11
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_0F; --Zaehlschleife
	 end if;

    when ST_CTRL_10 =>
 	 if (InAB_S = '0')
	 then
	 -- VAS02
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '1'; 
	  n_SV <= ST_CTRL_05; -- Error: Kein Stoppbit
	 else                 --InAB_S = '1'
    -- VAS12
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '1';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_11; --Stoppbit erkannt
	 end if;

    when ST_CTRL_11 =>
     if (n_COUNT >= CNTT12) --60937
	 then
	 -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_12; -- Zustandsuebgergang
	 else                 -- n_COUNT < CNTT12
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_11; --Zaehlschleife
	 end if;

    when ST_CTRL_12 =>
     if (InAB_S = '0') -- Startbit gefunden
	 then
	 -- VAS00
	  COUNT <= x"00000"; -- Zaehler Neustart
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_03; -- Zustandsuebgergang
	 else                 -- InAB_S = '1'
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_13; --Zaehlschleife Teil 1
	 end if;

    when ST_CTRL_13 =>
     if (n_COUNT >= CNTT13) --64062
	 then
	 -- VAS00
	  n_SV <= ST_CTRL_00; -- Kein Startbit gefunden (neues SYN?)
	 else                 -- n_COUNT < CNTT13
    -- VAS01
	  n_COUNT <= COUNT+1;
	  EN_BIT_0 <= '0';
	  EN_BIT_1 <= '0';
     EN_BIT_2 <= '0';
	  EN_BIT_3 <= '0';
	  EN_BIT_4 <= '0';
	  EN_BIT_5 <= '0';
	  EN_BIT_6 <= '0';
	  EN_BIT_7 <= '0';
	  EN_BIT_8 <= '0';
	  BIT_VALUE <= '0';
	  BYTE_OK <= '0';
	  CTRL_ERROR <= '0'; 
	  n_SV <= ST_CTRL_12; --Zaehlschleife Teil 2
	 end if;

    when others => n_SV <= ST_CTRL_00;
   end case;
end process; 

STATE_DISPL_PROC: process (SV, n_SV) -- Zustandsanzeige
 begin
  LONG_STATE_SV   <= conv_std_logic_vector(TYPE_STATE'pos(  SV),8); --Zustandsumwandlung in 8 Bit
  LONG_STATE_n_SV <= conv_std_logic_vector(TYPE_STATE'pos(n_SV),8);
   
  DISPL1_SV(0) <= LONG_STATE_SV(0); --Bit0
  DISPL1_SV(1) <= LONG_STATE_SV(1); --Bit1
  DISPL1_SV(2) <= LONG_STATE_SV(2); --Bit2
  DISPL1_SV(3) <= LONG_STATE_SV(3); --Bit3

  DISPL2_SV(0) <= LONG_STATE_SV(4); --usw.
  DISPL2_SV(1) <= LONG_STATE_SV(5);
  DISPL2_SV(2) <= LONG_STATE_SV(6);
  DISPL2_SV(3) <= LONG_STATE_SV(7);

  DISPL1_n_SV(0)  <= LONG_STATE_n_SV(0);
  DISPL1_n_SV(1)  <= LONG_STATE_n_SV(1);
  DISPL1_n_SV(2)  <= LONG_STATE_n_SV(2);
  DISPL1_n_SV(3)  <= LONG_STATE_n_SV(3);
   
  DISPL2_n_SV(0)  <= LONG_STATE_n_SV(4);
  DISPL2_n_SV(1)  <= LONG_STATE_n_SV(5);
  DISPL2_n_SV(2)  <= LONG_STATE_n_SV(6);
  DISPL2_n_SV(3)  <= LONG_STATE_n_SV(7);
end process;   
	   
end Behavioral;
