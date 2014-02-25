-- CTRL_RS232_TX
-- Input wird bitweise via RS232 versendet
-- Projekt: PROFIBUS MONITOR
-- Ersteller: Martin Harndt
-- Erstellt: 10.01.2013
-- Bearbeiter: mharndt
-- Geaendert: 24.01.2013
-- Umstellung auf: rising_edge(CLK) und falling_edge(CLK) und http://www.sigasi.com/content/clock-edge-detection  

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CTRL_RS232_TX_VHDL is
    Port(SEND_BYTE : in std_logic_vector (7 downto 0); --Eingangsvariable, zu Daten Input, 8 bit
         SEND : in std_logic; --Eingangsvariable, Byte OK
         TX : out std_logic; --Ausgangsvariable, Transmit Bit
         READY: out std_logic; --Ausgangsvariable, bereit zum Senden

         CLK	      : in  std_logic; --Taktvariable
		   IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
		   RESET		 : in std_logic);   --1: Initialzustand annehmen

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

--signal not_CLK   : std_logic; --negierte Taktvariable



signal COUNT   : std_logic_vector (15 downto 0); --Zaehler, Vektor, 16 Bit
signal n_COUNT : std_logic_vector (15 downto 0); --Zaehler, neuer Wert, Vektor, 16 Bit
signal COUNT_M : std_logic_vector (15 downto 0); --Zaehler, Ausgang Master, Vektor, 16 Bit


--Konstanten, lang 9600 Baud, 1 Startbit, 8 Datenbit, 1 Stoppbit, keine Parität
--constant CNT01 : std_logic_vector := x"1458";  --16 Bit
--constant CNT02 : std_logic_vector := x"2C98";  --usw.
--constant CNT03 : std_logic_vector := x"3D08";
--constant CNT04 : std_logic_vector := x"5160";
--constant CNT05 : std_logic_vector := x"65B8";
--constant CNT06 : std_logic_vector := x"7A10";
--constant CNT07 : std_logic_vector := x"8E68";
--constant CNT08 : std_logic_vector := x"A2C0";
--constant CNT09 : std_logic_vector := x"B718";
--constant CNT10 : std_logic_vector := x"CB70";

--Konstanten, lang 19200 Baud, 1 Startbit, 8 Datenbit, 1 Stoppbit, keine Parität
constant CNT01 : std_logic_vector := x"0A2C";  --16 Bit
constant CNT02 : std_logic_vector := x"1458";  --usw.
constant CNT03 : std_logic_vector := x"1E84";
constant CNT04 : std_logic_vector := x"28B0";
constant CNT05 : std_logic_vector := x"32DC";
constant CNT06 : std_logic_vector := x"3D09";
constant CNT07 : std_logic_vector := x"4735";
constant CNT08 : std_logic_vector := x"5161";
constant CNT09 : std_logic_vector := x"5B8D";
constant CNT10 : std_logic_vector := x"65B9";

begin

--NOT_CLK_PROC: process (CLK) --negieren Taktvariable
--begin
--  not_CLK <= not CLK;
--end process;




SREG_M_PROC: process (RESET, n_SV, CLK) --Master
begin
  if (RESET ='1')
   then SV_M    <= ST_TX_00;	
   else
    if rising_edge(CLK)
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

SREG_S_PROC: process (RESET, SV_M, CLK) --Slave
begin
  if (RESET = '1')
   then SV    <= ST_TX_00;
   else
     if falling_edge(CLK)
	   then SV    <= SV_M;
		   COUNT <= COUNT_M;
     end if;
  end if;
end process;

CTRL_RS232_TX_PROC:process (SV, COUNT, SEND, SEND_BYTE) --Daten über RS232 senden
begin
 case SV is
  when ST_TX_00 =>
   if (SEND = '1')
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
     TX <= SEND_BYTE(0); --Bit 0
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
     TX <= SEND_BYTE(1); --Bit 1
     READY <= '0';
     n_SV <= ST_TX_03; --Zustandsübergang
    else
     --TX04
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE(0); --Bit 0
     READY <= '0';
     n_SV <= ST_TX_02; --bleibt im gleichen Zustand
   end if;

  when ST_TX_03 =>
   if (COUNT = CNT03) --Zaehler = 15624
    then
     --TX07
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE(2); --Bit 2
     READY <= '0';
     n_SV <= ST_TX_04; --Zustandsübergang
    else
     --TX06
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE(1); --Bit 1
     READY <= '0';
     n_SV <= ST_TX_03; --bleibt im gleichen Zustand
   end if;

  when ST_TX_04 =>
   if (COUNT = CNT04) --Zaehler = 20832
    then
     --TX09
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE(3); --Bit 3
     READY <= '0';
     n_SV <= ST_TX_05; --Zustandsübergang
    else
     --TX08
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE(2); --Bit 2
     READY <= '0';
     n_SV <= ST_TX_04; --bleibt im gleichen Zustand
   end if;

  when ST_TX_05 =>
   if (COUNT = CNT05) --Zaehler = 26040
    then
     --TX11
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE(4); --Bit 4
     READY <= '0';
     n_SV <= ST_TX_06; --Zustandsübergang
    else
     --TX10
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE(3); --Bit 3
     READY <= '0';
     n_SV <= ST_TX_05; --bleibt im gleichen Zustand
   end if;

  when ST_TX_06 =>
   if (COUNT = CNT06) --Zaehler = 31248
    then
     --TX13
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE(5); --Bit 5
     READY <= '0';
     n_SV <= ST_TX_07; --Zustandsübergang
    else
     --TX12
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE(4); --Bit 4
     READY <= '0';
     n_SV <= ST_TX_06; --bleibt im gleichen Zustand
   end if;

  when ST_TX_07 =>
   if (COUNT = CNT07) --Zaehler = 36456
    then
     --TX15
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE(6); --Bit 6
     READY <= '0';
     n_SV <= ST_TX_08; --Zustandsübergang
    else
     --TX14
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE(5); --Bit 5
     READY <= '0';
     n_SV <= ST_TX_07; --bleibt im gleichen Zustand
   end if;

  when ST_TX_08 =>
   if (COUNT = CNT08) --Zaehler = 41664
    then
     --TX17
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen
     TX <= SEND_BYTE(7); --Bit 7
     READY <= '0';
     n_SV <= ST_TX_09; --Zustandsübergang
    else
     --TX16
     n_COUNT <= COUNT+1;  -- Zaehler erhoehen 
     TX <= SEND_BYTE(6); --Bit 6
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
     TX <= SEND_BYTE(7); --Bit 7
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
   if (SEND = '0') -- Wenn SEND=0 dann warten auf SEND sonst Idle senden 
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

end Behavioral;
