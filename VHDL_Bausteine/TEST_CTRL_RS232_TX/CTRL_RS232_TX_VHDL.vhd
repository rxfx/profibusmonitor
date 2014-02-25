-- CTRL_RS232_TX
-- Input wird bitweise via RS232 versendet
-- Projekt: PROFIBUS MONITOR
-- Ersteller: Martin Harndt
-- Erstellt: 10.01.2013
-- Bearbeiter: mharndt
-- Geaendert: 10.01.2013 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CTRL_RS232_TX_VHDL is
    Port(SEND_BYTE : in std_logic_vector (7 downto 0); --Eingangsvariable, zu Daten Input, 8 bit
         SEND : in std_logic; --Eingangsvariable, Byte OK
         TX : out std_logic; --Ausgangsvariable, Transmit Bit
         READY: out std_logic; --Ausgangsvariable, bereit zum Senden
         CLK         : in  std_logic; --Taktvariable
         CLK_IO       : in  std_logic; --Tanktvariable,
                              --Ein- und Ausgangsregister
         IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
         RESET       : in std_logic;   --1: Initialzustand annehmen
         CHOSE_VALUE  : in  std_logic; --Eingangsvariable, Zählerwert aendern
         DISPL_COUNT  : in  std_logic; --Eingangsvariable, Counter anzeigen
         DISPL1_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl1, binärzahl
         DISPL2_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl2, binärzahl
         DISPL1_n_SV  : out std_logic_vector (3 downto 0); --Folgezustand Zahl1, binärzahl
         DISPL2_n_SV    : out std_logic_vector (3 downto 0));  --Folgezustand Zahl2, binärzahl 
end CTRL_RS232_TX_VHDL;

architecture Behavioral of CTRL_RS232_TX_VHDL is

type TYPE_STATE is 
              (ST_TX_00, --Zustaende CTRL_RS232_TX
               ST_TX_01,
               ST_TX_02,
               ST_TX_03,
               ST_TX_04,
               ST_TX_05,
               ST_TX_06,
               ST_TX_07,
               ST_TX_08,
               ST_TX_09,
               ST_TX_10,
               ST_TX_11);

signal SV  : TYPE_STATE; --Zustandsvariable
signal n_SV: TYPE_STATE; --Zustandsvariable, neuer Wert
signal SV_M: TYPE_STATE; --Zustandsvariable, Ausgang Master
signal not_CLK   : std_logic; --negierte Taktvariable
signal not_CLK_IO: std_logic; --negierte Taktvariable
                  --Ein- und Ausgangsregister
signal STATE_SV   : std_logic_vector (7 downto 0); -- aktueller Zustand in 8 Bit, binär
signal STATE_n_SV : std_logic_vector (7 downto 0); -- Folgezustand in 8 Bit, binär
signal SEND_BYTE_S : std_logic_vector (7 downto 0); --Eingangsvariable, Zwischengespeichern im Eingangsregister
signal SEND_S :   std_logic; --Eingangsvariable, Zwischengespeichern im Eingangsregister
signal COUNT   : std_logic_vector (15 downto 0); --Zaehler, Vektor, 16 Bit
signal n_COUNT : std_logic_vector (15 downto 0); --Zaehler, neuer Wert, Vektor, 16 Bit
signal COUNT_M : std_logic_vector (15 downto 0); --Zaehler, Ausgang Master, Vektor, 16 Bit

signal CNT01 : std_logic_vector (15 downto 0);
signal CNT02 : std_logic_vector (15 downto 0);
signal CNT03 : std_logic_vector (15 downto 0);
signal CNT04 : std_logic_vector (15 downto 0);
signal CNT05 : std_logic_vector (15 downto 0);
signal CNT06 : std_logic_vector (15 downto 0);
signal CNT07 : std_logic_vector (15 downto 0);
signal CNT08 : std_logic_vector (15 downto 0);
signal CNT09 : std_logic_vector (15 downto 0);
signal CNT10 : std_logic_vector (15 downto 0);

--Konstanten, lang
constant long_CNT01 : std_logic_vector := x"1458";  --16 Bit
constant long_CNT02 : std_logic_vector := x"2C98";  --usw.
constant long_CNT03 : std_logic_vector := x"3D08";
constant long_CNT04 : std_logic_vector := x"5160";
constant long_CNT05 : std_logic_vector := x"65B8";
constant long_CNT06 : std_logic_vector := x"7A10";
constant long_CNT07 : std_logic_vector := x"8E68";
constant long_CNT08 : std_logic_vector := x"A2C0";
constant long_CNT09 : std_logic_vector := x"B718";
constant long_CNT10 : std_logic_vector := x"CB70";

--Konstanten, kurz
constant short_CNT01 : std_logic_vector := x"0003"; --3
constant short_CNT02 : std_logic_vector := x"0006"; --6
constant short_CNT03 : std_logic_vector := x"0009"; --9
constant short_CNT04 : std_logic_vector := x"000C"; --12
constant short_CNT05 : std_logic_vector := x"000F"; --15
constant short_CNT06 : std_logic_vector := x"0012"; --18
constant short_CNT07 : std_logic_vector := x"0015"; --21
constant short_CNT08 : std_logic_vector := x"0018"; --24
constant short_CNT09 : std_logic_vector := x"001B"; --27
constant short_CNT10 : std_logic_vector := x"001E"; --30

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
   then SEND_BYTE_S <= SEND_BYTE;
        SEND_S <= SEND;
end if;
end process;

SREG_M_PROC: process (RESET, n_SV, CLK) --Master
begin
  if (RESET ='1')
   then SV_M    <= ST_TX_00;   
   else
    if (CLK'event and CLK = '1')
     then
      if (IN_NEXT_STATE = '1')
       then SV_M    <= n_SV;
            COUNT_M <= n_COUNT;
       else SV_M    <= SV_M;
            COUNT_M <= COUNT_M;
      end if;
    end if;
  end if;
end process;

SREG_S_PROC: process (RESET, SV_M, not_CLK) --Slave
begin
  if (RESET = '1')
   then SV    <= ST_TX_00;
   else
     if (not_CLK'event and not_CLK = '1')
      then SV    <= SV_M;
         COUNT <= COUNT_M;
     end if;
  end if;
end process;

CTRL_RS232_TX_PROC:process (SV, COUNT, SEND_S, SEND_BYTE_S, CNT01, CNT02, CNT03, CNT04, CNT05, CNT06, CNT07, CNT08, CNT09, CNT10) --Daten über RS232 senden
begin
 case SV is
  when ST_TX_00 =>
   if (SEND_S = '1')
    then
     --TX01
     n_COUNT <= x"0000";  -- kleiner Zaehler Neustart
     TX <= '0'; --Startbit
     READY <= '0';
     n_SV <= ST_TX_01; --Zustandsübergang
    else
     --TX00
     n_COUNT <= x"0000";  -- kleiner Zaehler Neustart
     TX <= '1'; --Idle
     READY <= '1'; --Bereit zum Senden
     n_SV <= ST_TX_00; --bleibt im gleichen Zustand
   end if;

  when ST_TX_01 =>
   if (COUNT = CNT01) --Zaehler = 5208
    then
     --TX03
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE_S(0); --Bit 0
     READY <= '0';
     n_SV <= ST_TX_02; --Zustandsübergang
    else
     --TX02
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= '0'; --Startbit
     READY <= '0';
     n_SV <= ST_TX_01; --bleibt im gleichen Zustand
   end if;

  when ST_TX_02 =>
   if (COUNT = CNT02) --Zaehler = 11416
    then
     --TX05
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE_S(1); --Bit 1
     READY <= '0';
     n_SV <= ST_TX_03; --Zustandsübergang
    else
     --TX04
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE_S(0); --Bit 0
     READY <= '0';
     n_SV <= ST_TX_02; --bleibt im gleichen Zustand
   end if;

  when ST_TX_03 =>
   if (COUNT = CNT03) --Zaehler = 15624
    then
     --TX07
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE_S(2); --Bit 2
     READY <= '0';
     n_SV <= ST_TX_04; --Zustandsübergang
    else
     --TX06
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE_S(1); --Bit 1
     READY <= '0';
     n_SV <= ST_TX_03; --bleibt im gleichen Zustand
   end if;

  when ST_TX_04 =>
   if (COUNT = CNT04) --Zaehler = 20832
    then
     --TX09
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE_S(3); --Bit 3
     READY <= '0';
     n_SV <= ST_TX_05; --Zustandsübergang
    else
     --TX08
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE_S(2); --Bit 2
     READY <= '0';
     n_SV <= ST_TX_04; --bleibt im gleichen Zustand
   end if;

  when ST_TX_05 =>
   if (COUNT = CNT05) --Zaehler = 26040
    then
     --TX11
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE_S(4); --Bit 4
     READY <= '0';
     n_SV <= ST_TX_06; --Zustandsübergang
    else
     --TX10
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE_S(3); --Bit 3
     READY <= '0';
     n_SV <= ST_TX_05; --bleibt im gleichen Zustand
   end if;

  when ST_TX_06 =>
   if (COUNT = CNT06) --Zaehler = 31248
    then
     --TX13
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE_S(5); --Bit 5
     READY <= '0';
     n_SV <= ST_TX_07; --Zustandsübergang
    else
     --TX12
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE_S(4); --Bit 4
     READY <= '0';
     n_SV <= ST_TX_06; --bleibt im gleichen Zustand
   end if;

  when ST_TX_07 =>
   if (COUNT = CNT07) --Zaehler = 36456
    then
     --TX15
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE_S(6); --Bit 6
     READY <= '0';
     n_SV <= ST_TX_08; --Zustandsübergang
    else
     --TX14
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE_S(5); --Bit 5
     READY <= '0';
     n_SV <= ST_TX_07; --bleibt im gleichen Zustand
   end if;

  when ST_TX_08 =>
   if (COUNT = CNT08) --Zaehler = 41664
    then
     --TX17
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE_S(7); --Bit 7
     READY <= '0';
     n_SV <= ST_TX_09; --Zustandsübergang
    else
     --TX16
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE_S(6); --Bit 6
     READY <= '0';
     n_SV <= ST_TX_08; --bleibt im gleichen Zustand
   end if;

  when ST_TX_09 =>
   if (COUNT = CNT09) --Zaehler = 46872
    then
     --TX19
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= '1'; --Stoppbit
     READY <= '0';
     n_SV <= ST_TX_10; --Zustandsübergang
    else
     --TX18
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE_S(7); --Bit 7
     READY <= '0';
     n_SV <= ST_TX_09; --bleibt im gleichen Zustand
   end if;

  when ST_TX_10 =>
   if (COUNT = CNT10) --Zaehler = 52080
    then
     --TX21
     n_COUNT <= x"0000";  -- Zaehler neustart
     TX <= '1'; --Idle
     READY <= '0';
     n_SV <= ST_TX_11; --Zustandsübergang
    else
     --TX20
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= '1'; --Stoppbit
     READY <= '0';
     n_SV <= ST_TX_10; --bleibt im gleichen Zustand
   end if;

  when ST_TX_11 =>
   if (SEND_S = '0') -- Wenn SEND=0 dann warten auf SEND sonst Idle senden 
    then
     --TX00
     n_COUNT <= x"0000";  -- Zaehler neustart
     TX <= '1'; --Idle
     READY <= '1';--Bereit zum Senden
     n_SV <= ST_TX_00; --Zustandsübergang
    else
     --TX22
     n_COUNT <= x"0000";  -- Zaehler neustart 
     TX <= '1'; --Idle
     READY <= '0';
     n_SV <= ST_TX_11; --bleibt im gleichen Zustand
   end if;

    when others =>
    -- TX00
    n_COUNT <= x"0000";  -- kleiner Zaehler Neustart
    TX <= '1'; --Idle
    READY <= '0';
    n_SV <= ST_TX_00; --Zustandsübergang
 end case;
end process;

STATE_DISPL_PROC: process (SV, n_SV, DISPL_COUNT, STATE_SV, STATE_n_SV,COUNT) -- Zustandsanzeige
 begin
  STATE_SV   <= conv_std_logic_vector(TYPE_STATE'pos(  SV),8); --Zustandsumwandlung in 8 Bit
  STATE_n_SV <= conv_std_logic_vector(TYPE_STATE'pos(n_SV),8);
  --aktuellen Zustand anzeigen   
  DISPL1_SV(0) <= STATE_SV(0); --Bit0
  DISPL1_SV(1) <= STATE_SV(1); --Bit1
  DISPL1_SV(2) <= STATE_SV(2); --Bit2
  DISPL1_SV(3) <= STATE_SV(3); --Bit3

  DISPL2_SV(0) <= STATE_SV(4); --usw.
  DISPL2_SV(1) <= STATE_SV(5);
  DISPL2_SV(2) <= STATE_SV(6);
  DISPL2_SV(3) <= STATE_SV(7);

  if (DISPL_COUNT ='0')
   then --Folgezustand anzeigen
    DISPL1_n_SV(0)  <= STATE_n_SV(0);
    DISPL1_n_SV(1)  <= STATE_n_SV(1);
    DISPL1_n_SV(2)  <= STATE_n_SV(2);
    DISPL1_n_SV(3)  <= STATE_n_SV(3);
   
    DISPL2_n_SV(0)  <= STATE_n_SV(4);
    DISPL2_n_SV(1)  <= STATE_n_SV(5);
    DISPL2_n_SV(2)  <= STATE_n_SV(6);
    DISPL2_n_SV(3)  <= STATE_n_SV(7);

   else  --Zähler anzeigen
    DISPL1_n_SV(0) <= COUNT(0);
    DISPL1_n_SV(1) <= COUNT(1);
    DISPL1_n_SV(2) <= COUNT(2);
    DISPL1_n_SV(3) <= COUNT(3);
    
    DISPL2_n_SV(0) <= COUNT(4);
    DISPL2_n_SV(1) <= COUNT(5);
    DISPL2_n_SV(2) <= COUNT(6);
    DISPL2_n_SV(3) <= COUNT(7);
  end if;
 end process;

SWITCH_VALUES_PROC: process (CHOSE_VALUE) --Schaltet zw. langen und kurzem Zaehler um
 begin
  if (CHOSE_VALUE = '0')
   then
    --normale Werte
    CNT01 <= long_CNT01;
    CNT02 <= long_CNT02;
    CNT03 <= long_CNT03;
    CNT04 <= long_CNT04;
    CNT05 <= long_CNT05;
    CNT06 <= long_CNT06;
    CNT07 <= long_CNT07;
    CNT08 <= long_CNT08;
    CNT09 <= long_CNT09;
    CNT10 <= long_CNT10;
   else
    --kurze Werte
    CNT01 <= short_CNT01;
    CNT02 <= short_CNT02;
    CNT03 <= short_CNT03;
    CNT04 <= short_CNT04;
    CNT05 <= short_CNT05;
    CNT06 <= short_CNT06;
    CNT07 <= short_CNT07;
    CNT08 <= short_CNT08;
    CNT09 <= short_CNT09;
    CNT10 <= short_CNT10;
  end if;
end process;   
end Behavioral;
