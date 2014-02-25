-- CTRL_InAB_INPUT
-- Einlesen des Datenstroms von InAB und Ausgabe als Einzelnes Bit, sowie Signalisierung das Byte komplet
-- Projekt: PROFIBUS MONITOR
-- Ersteller: Martin Harndt
-- Erstellt: 09.10.2012
-- Bearbeiter: mharndt
-- Geaendert: 29.01.2013
-- Umstellung auf: rising_edge(CLK) und falling_edge(CLK) und http://www.sigasi.com/content/clock-edge-detection 
-- Optimierungen aus: http://www.lothar-miller.de/s9y/categories/37-FSM

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CTRL_InAB_INPUT_VHDL is
    Port (InAB         : in  std_logic; --Eingangsvariable, Eingang Profibussignal
          CHOSE_VALUE  : in  std_logic; --Eingangsvariable, Z‰hlerwert aendern
          EN_BIT_i : out std_logic_vector (8 downto 0); --Ausgangsvariable, Enable Bit i, 9bit
          BIT_VALUE : out std_logic; --Ausgangsvariable, Bitwert
          BYTE_CMPLT: out std_logic; --Ausgangsvariabel, Byte empfangen und komplett
          PAUSE_END : out std_logic; --Ausgangssignal, Pause zu Ende

           CLK         : in  std_logic; --Taktvariable
--          CLK_IO       : in  std_logic; --Tanktvariable,
                              --Ein- und Ausgangsregister
          IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang mˆglich
          RESET       : in std_logic;   --1: Initialzustand annehmen

          DISPL1_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl1, bin‰rzahl
          DISPL2_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl2, bin‰rzahl
          DISPL1_n_SV  : out std_logic_vector (3 downto 0); --Folgezustand Zahl1, bin‰rzahl
          DISPL2_n_SV    : out std_logic_vector (3 downto 0));  --Folgezustand Zahl2, bin‰rzahl 

end CTRL_InAB_INPUT_VHDL;

architecture Behavioral of CTRL_InAB_INPUT_VHDL is

type TYPE_STATE is 
           (ST_CTRL_00, --Zustaende CTRL_9P6_50MHZ
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
            ST_CTRL_0F);--15

signal SV  : TYPE_STATE := ST_CTRL_00; --Zustandsvariable
signal n_SV: TYPE_STATE := ST_CTRL_00; --Zustandsvariable, neuer Wert
signal SV_M: TYPE_STATE := ST_CTRL_00; --Zustandsvariable, Ausgang Master

signal COUNT_L   : std_logic_vector (19 downto 0) := x"00000"; --groﬂer Zaehler, Vektor, 20 Bit
signal n_COUNT_L : std_logic_vector (19 downto 0) := x"00000"; --groﬂer Zaehler, neuer Wert, Vektor, 20 Bit
signal COUNT_L_M : std_logic_vector (19 downto 0) := x"00000"; --groﬂer Zaehler, Ausgang Master, Vektor, 20 Bit

signal COUNT_S   : std_logic_vector (15 downto 0) := x"0000"; --kleiner Zaehler, Vektor, 16 Bit
signal n_COUNT_S : std_logic_vector (15 downto 0) := x"0000"; --kleiner Zaehler, neuer Wert, Vektor, 16 Bit
signal COUNT_S_M : std_logic_vector (15 downto 0) := x"0000"; --kleiner Zaehler, Ausgang Master, Vektor, 16 Bit

signal InAB_S    : std_logic := '0'; --Eingangsvariable
                    --Zwischengespeichert im Eingangsregister

--signal not_CLK   : std_logic; --negierte Taktvariable
--signal not_CLK_IO: std_logic; --negierte Taktvariable
                  --Ein- und Ausgangsregister

signal STATE_SV   : std_logic_vector (7 downto 0); -- aktueller Zustand in 8 Bit, bin‰r
signal STATE_n_SV : std_logic_vector (7 downto 0); -- Folgezustand in 8 Bit, bin‰r

signal EN_BIT_0    : std_logic := '0'; --BIT0
signal EN_BIT_1    : std_logic := '0'; --BIT1
signal EN_BIT_2    : std_logic := '0'; --BIT2
signal EN_BIT_3    : std_logic := '0'; --BIT3
signal EN_BIT_4    : std_logic := '0'; --BIT4
signal EN_BIT_5    : std_logic := '0'; --BIT5
signal EN_BIT_6    : std_logic := '0'; --BIT6
signal EN_BIT_7    : std_logic := '0'; --BIT7
signal EN_BIT_8    : std_logic := '0'; --Parit‰tsbit

signal CNTS30 : std_logic_vector (19 downto 0) := x"00000"; --Z‰hlerwerte
signal CNTT01 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT02 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT03 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT04 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT05 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT06 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT07 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT08 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT09 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT10 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT11 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT12 : std_logic_vector (15 downto 0) := x"0000";
signal CNTT13 : std_logic_vector (15 downto 0) := x"0000";

--Konstanten, lang
constant long_CNTS30 : std_logic_vector := x"2625A"; --20 Bit
constant long_CNTT01 : std_logic_vector := x"0A2C";  --16 Bit
constant long_CNTT02 : std_logic_vector := x"1E84";  --usw.
constant long_CNTT03 : std_logic_vector := x"32DC";
constant long_CNTT04 : std_logic_vector := x"4735";
constant long_CNTT05 : std_logic_vector := x"5B8B";
constant long_CNTT06 : std_logic_vector := x"6FE4";
constant long_CNTT07 : std_logic_vector := x"8441";
constant long_CNTT08 : std_logic_vector := x"9872";
constant long_CNTT09 : std_logic_vector := x"ACEE";
constant long_CNTT10 : std_logic_vector := x"C147";
constant long_CNTT11 : std_logic_vector := x"D59F";
constant long_CNTT12 : std_logic_vector := x"D9B1";
constant long_CNTT13 : std_logic_vector := x"E5E6";


--Konstanten, kurz
constant short_CNTS30 : std_logic_vector := x"0000A"; --10
constant short_CNTT01 : std_logic_vector := x"0003"; --3
constant short_CNTT02 : std_logic_vector := x"0006"; --6
constant short_CNTT03 : std_logic_vector := x"0009"; --9
constant short_CNTT04 : std_logic_vector := x"000C"; --12
constant short_CNTT05 : std_logic_vector := x"000F"; --15
constant short_CNTT06 : std_logic_vector := x"0012"; --18
constant short_CNTT07 : std_logic_vector := x"0015"; --21
constant short_CNTT08 : std_logic_vector := x"0018"; --24
constant short_CNTT09 : std_logic_vector := x"001B"; --27
constant short_CNTT10 : std_logic_vector := x"001E"; --30
constant short_CNTT11 : std_logic_vector := x"0021"; --33
constant short_CNTT12 : std_logic_vector := x"0024"; --36
constant short_CNTT13 : std_logic_vector := x"002A"; --42

begin

--NOT_CLK_PROC: process (CLK) --negieren Taktvariable
--begin
--  not_CLK <= not CLK;
--end process;
---NOT_CLK_IO_PROC: process (CLK_IO) --negieren Taktvaraible
                                     --Ein- und Ausgangsregister
--begin
--  not_CLK_IO <= not CLK_IO;
--end process;

IREG_PROC: process (InAB, InAB_S, CLK) --Eingangsregister
begin
 if falling_edge(CLK) --Eingangsregister
   then InAB_S <= InAB;
 end if;
end process;

SREG_M_PROC: process (RESET, n_SV, n_COUNT_L,n_COUNT_S, CLK) --Master
begin
  if (RESET ='1')
   then SV_M    <= ST_CTRL_00;
        COUNT_L_M <= x"00000";
        COUNT_S_M <= x"0000";   
   else
     if rising_edge(CLK)
    then
      if (IN_NEXT_STATE = '1')
       then SV_M    <= n_SV;
            COUNT_L_M <= n_COUNT_L;
            COUNT_S_M <= n_COUNT_S;
       else SV_M    <= SV_M;
            COUNT_L_M <= COUNT_L_M;
            COUNT_S_M <= COUNT_S_M;
        end if;
   end if;
  end if;
end process;

SREG_S_PROC: process (RESET, SV_M, COUNT_L_M, COUNT_S_M, CLK) --Slave
begin
  if (RESET = '1')
   then SV    <= ST_CTRL_00;
        COUNT_L <= x"00000";
        COUNT_S <= x"0000";
   else
     if falling_edge(CLK)
    then SV    <= SV_M;
          COUNT_L <= COUNT_L_M;
         COUNT_S <= COUNT_S_M;
     end if;
   end if;
end process;

IL_OL_PROC: process (InAB_S, SV, COUNT_L,COUNT_S, CNTS30, CNTT01, CNTT02, CNTT03, CNTT04, CNTT05, CNTT06, CNTT07, CNTT08, CNTT09, CNTT10, CNTT11, CNTT12, CNTT13)
begin
  case SV is
   when ST_CTRL_00 =>    
    if (InAB_S = '1')
     then
     -- VAS00
      PAUSE_END <= '0';
      n_COUNT_L <= x"00000"; -- groﬂer Zaehler Neustart
      n_COUNT_S <= x"0000";  -- kleiner Zaehler Neustart
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
      BYTE_CMPLT <= '0'; 
      n_SV <= ST_CTRL_01; -- Zustandsuebgergang
     else
     --VAS00
      PAUSE_END <= '0';
      n_COUNT_L <= x"00000"; -- groﬂer Zaehler nullen
      n_COUNT_S <= x"0000";  -- kleiner Zaehler nullen
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
      BYTE_CMPLT <= '0';
      n_SV <= ST_CTRL_00; --InAB = '0'
    end if;

  when ST_CTRL_01 =>
   if (InAB_S = '1')
    then 
     if (COUNT_L = CNTS30) --156250 -- if (COUNT >=3)
      then
       -- VAS00
       PAUSE_END <= '0';
       n_COUNT_L <= x"00000";
       n_COUNT_S <= x"0000";
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
       BYTE_CMPLT <= '0';
       n_SV <= ST_CTRL_02; -- Zustandsuebgergang
      else --not COUNT_L = CNTS30
       --VAS01
       PAUSE_END <= '0';
       n_COUNT_L <= COUNT_L+1;
       n_COUNT_S <= x"0000";
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
       BYTE_CMPLT <= '0'; 
       n_SV <= ST_CTRL_01; --Zaehlschleife
     end if;
    else --InAB_S = '1'
     --VAS00
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= x"0000";
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_00; -- Zustandsuebgergang
   end if;

  when ST_CTRL_02 =>
    if (InAB_S = '0')
    then
     -- VAS03
     PAUSE_END <= '1';
     n_COUNT_L <= x"00000"; -- Zaehler Neustart
     n_COUNT_S <= x"0000";
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
     BYTE_CMPLT <= '0'; 
     n_SV <= ST_CTRL_03; -- Zustandsuebgergang
    else            -- InAB_S = '1'
     --VAS00
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= x"0000"; 
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_02; --warte ab bis InAB wieder NUll wird
    end if;

    when ST_CTRL_03 =>
     if (COUNT_S = CNTT01) --2604
      then
        if (InAB_S = '0') -- Startbit erkannt
        then
         -- VAS02
         PAUSE_END <= '0';
         n_COUNT_L <= x"00000";
         n_COUNT_S <= COUNT_S+1;
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
         BYTE_CMPLT <= '0';
         n_SV <= ST_CTRL_04; -- Zustandsuebgergang
        else                 --InAB_S = '1'
         -- VAS00
         PAUSE_END <= '0';
         n_COUNT_L <= x"00000";
         n_COUNT_S <= x"0000";
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
         BYTE_CMPLT <= '0';
         n_SV <= ST_CTRL_00; 
       end if;
      else
       -- VAS02
       PAUSE_END <= '0';
       n_COUNT_L <= x"00000";
       n_COUNT_S <= COUNT_S+1;
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
       BYTE_CMPLT <= '0';
       n_SV <= ST_CTRL_03; -- Zustandsuebgergang
     end if;

    when ST_CTRL_04 =>
     if (COUNT_S = CNTT02) --7812
    then
    -- VAS04
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_05; -- Zustandsuebgergang
    else                 --n_COUNT < CNTT02
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_04; --Zaehlschleife
    end if;

    when ST_CTRL_05 =>
     if (COUNT_S = CNTT03) --13020
    then
    -- VAS05
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_06; -- Zustandsuebgergang
    else                 --n_COUNT < CNTT03
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_05; --Zaehlschleife
    end if;

    when ST_CTRL_06 =>
     if (COUNT_S = CNTT04) --18229
    then
    -- VAS06
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_07; -- Zustandsuebgergang
    else                 --n_COUNT < CNTT04
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_06; --Zaehlschleife
    end if;

    when ST_CTRL_07 =>
     if (COUNT_S = CNTT05) --23435
    then
    -- VAS07
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_08; -- Zustandsuebgergang
    else                 --n_COUNT < CNTT05
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_07; --Zaehlschleife
    end if;

    when ST_CTRL_08 =>
     if (COUNT_S = CNTT06) --28644
    then
    -- VAS08
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_09; -- Zustandsuebgergang
    else                 --n_COUNT < CNTT06
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_08; --Zaehlschleife
    end if;

    when ST_CTRL_09 =>
     if (COUNT_S = CNTT07) --33854
    then
    -- VAS09
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_0A; -- Zustandsuebgergang
    else                 --n_COUNT < CNTT07
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_09; --Zaehlschleife
    end if;

    when ST_CTRL_0A =>
     if (COUNT_S = CNTT08) --39062
    then
    -- VAS10
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_0B; -- Zustandsuebgergang
    else                 --n_COUNT < CNTT08
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_0A; --Zaehlschleife
    end if;

    when ST_CTRL_0B =>
     if (COUNT_S = CNTT09) --44270
    then
    -- VAS11
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_0C; -- Zustandsuebgergang
    else                 --n_COUNT < CNTT09
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_0B; --Zaehlschleife
    end if;

    when ST_CTRL_0C =>
     if (COUNT_S = CNTT10) --49479
    then
    -- VAS12
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_0D; -- Zustandsuebgergang
    else                 --n_COUNT < CNTT10
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_0C; --Zaehlschleife
    end if;

    when ST_CTRL_0D =>
     if (COUNT_S = CNTT11) --54687
      then
        if (InAB_S = '0')
         then
          -- VAS03
          PAUSE_END <= '0';
          n_COUNT_L <= x"00000";
          n_COUNT_S <= COUNT_S+1;
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
          BYTE_CMPLT <= '0';
          n_SV <= ST_CTRL_00; -- Error: Kein Stoppbit, vormals ST_CTRL_05
         else                 --InAB_S = '1'
          -- VAS13
          PAUSE_END <= '0';
          n_COUNT_L <= x"00000";
          n_COUNT_S <= COUNT_S+1;
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
          BYTE_CMPLT <= '1';
          n_SV <= ST_CTRL_0E; --Stoppbit erkannt
        end if; --InAB_S = '0'
       else --not COUNT_S = CNTT11
        -- VAS02
        PAUSE_END <= '0';
        n_COUNT_L <= x"00000";
        n_COUNT_S <= COUNT_S+1;
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
        BYTE_CMPLT <= '0';
        n_SV <= ST_CTRL_0D; --Zaehlschleife
     end if; --COUNT_S = CNTT11

    when ST_CTRL_0E =>
     if (COUNT_S = CNTT12) --60937
    then
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_0F; -- Zustandsuebgergang
    else                 -- n_COUNT < CNTT12
    -- VAS02
     PAUSE_END <= '0';
     n_COUNT_L <= x"00000";
     n_COUNT_S <= COUNT_S+1;
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
     BYTE_CMPLT <= '0';
     n_SV <= ST_CTRL_0E; --Zaehlschleife
    end if;

    when ST_CTRL_0F =>
     if (InAB_S = '1') --Startbot bisher ncoh nicht gefunden
      then
       if (COUNT_S = CNTT13) --64062
        then
         -- VAS00
         PAUSE_END <= '0';
         n_COUNT_L <= x"00000"; -- Zaehler nullen
         n_COUNT_S <= x"0000"; -- Zaehler nullen
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
         BYTE_CMPLT <= '0';
         n_SV <= ST_CTRL_00; -- Kein Startbit gefunden (neues SYN?)
        else --not COUNT_S = CNTT13
         -- VAS02
         PAUSE_END <= '0';
         n_COUNT_L <= x"00000";
         n_COUNT_S <= COUNT_S+1;
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
         BYTE_CMPLT <= '0';
         n_SV <= ST_CTRL_0F; --Zaehlschleife
       end if; --COUNT_S = CNTT13
      else --InAB_S = '0'
       -- Startbit gefunden
       -- VAS00 
       PAUSE_END <= '0';
       n_COUNT_L <= x"00000"; -- Zaehler Neustart
       n_COUNT_S <= x"0000"; -- Zaehler Neustart
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
       BYTE_CMPLT <= '0';
       n_SV <= ST_CTRL_03; -- Zustandsuebgergang
     end if;

    when others => 
       -- VAS00
   PAUSE_END <= '0';
   n_COUNT_L <= x"00000"; -- Zaehler Neustart
   n_COUNT_S <= x"0000"; -- Zaehler Neustart
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
   BYTE_CMPLT <= '0';
   n_SV <= ST_CTRL_00;
   end case;
end process;

--BYTE_IN_PROC: process (EN_BIT_0, EN_BIT_1, EN_BIT_2, EN_BIT_3, EN_BIT_4, EN_BIT_5, EN_BIT_6, EN_BIT_7, EN_BIT_8) --Umwandlung einzelnes Bit EIN_BIT_0_S bis 8_S in Vector EN_BIT_i
-- begin
  EN_BIT_i(0) <= EN_BIT_0;
  EN_BIT_i(1) <= EN_BIT_1;
  EN_BIT_i(2) <= EN_BIT_2;
  EN_BIT_i(3) <= EN_BIT_3;
  EN_BIT_i(4) <= EN_BIT_4;
  EN_BIT_i(5) <= EN_BIT_5;
  EN_BIT_i(6) <= EN_BIT_6;
  EN_BIT_i(7) <= EN_BIT_7;
  EN_BIT_i(8) <= EN_BIT_8;
--end process;

STATE_DISPL_PROC: process (SV, n_SV, STATE_SV, STATE_n_SV) -- Zustandsanzeige
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

  --Folgezustand anzeigen
  DISPL1_n_SV(0)  <= STATE_n_SV(0);
  DISPL1_n_SV(1)  <= STATE_n_SV(1);
  DISPL1_n_SV(2)  <= STATE_n_SV(2);
  DISPL1_n_SV(3)  <= STATE_n_SV(3);
  
  DISPL2_n_SV(0)  <= STATE_n_SV(4);
  DISPL2_n_SV(1)  <= STATE_n_SV(5);
  DISPL2_n_SV(2)  <= STATE_n_SV(6);
  DISPL2_n_SV(3)  <= STATE_n_SV(7);
end process;

SWITCH_VALUES_PROC: process (CHOSE_VALUE) --Schaltet zw. langen und kurzem Zaehler um
 begin
  if (CHOSE_VALUE = '0')
   then
    --normale Werte
    CNTS30 <= long_CNTS30; 
    CNTT01 <= long_CNTT01;
    CNTT02 <= long_CNTT02;
    CNTT03 <= long_CNTT03;
    CNTT04 <= long_CNTT04;
    CNTT05 <= long_CNTT05;
    CNTT06 <= long_CNTT06;
    CNTT07 <= long_CNTT07;
    CNTT08 <= long_CNTT08;
    CNTT09 <= long_CNTT09;
    CNTT10 <= long_CNTT10;
    CNTT11 <= long_CNTT11;
    CNTT12 <= long_CNTT12;
    CNTT13 <= long_CNTT13;
   else
    --kurze Werte
    CNTS30 <= short_CNTS30; 
    CNTT01 <= short_CNTT01;
    CNTT02 <= short_CNTT02;
    CNTT03 <= short_CNTT03;
    CNTT04 <= short_CNTT04;
    CNTT05 <= short_CNTT05;
    CNTT06 <= short_CNTT06;
    CNTT07 <= short_CNTT07;
    CNTT08 <= short_CNTT08;
    CNTT09 <= short_CNTT09;
    CNTT10 <= short_CNTT10;
    CNTT11 <= short_CNTT11;
    CNTT12 <= short_CNTT12;
    CNTT13 <= short_CNTT13;
  end if;
end process;   

end Behavioral;