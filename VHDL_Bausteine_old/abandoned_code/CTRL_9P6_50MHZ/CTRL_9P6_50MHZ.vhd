-- PROFI_9P6_50MHZ_REC_BYTE
-- PROFIBUS MONITOR
-- Ersteller: Martin Harndt
-- Erstellt: 09.10.2012
-- Bearbeiter: mharndt
-- Geaendert: 24.01.2013 
-- Umstellung auf: rising_edge(CLK) und falling_edge(CLK) http://www.sigasi.com/content/clock-edge-detection

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CTRL_9P6_50MHZ_VHDL is
    Port (InAB         : in  std_logic; --Eingangsvariable, Eingang Profibussignal
		   CHOSE_VALUE  : in  std_logic; --Eingangsvariable, Zählerwert aendern
		   DISPL_COUNT  : in  std_logic; --Eingangsvariable, Counter anzeigen
		   DISPL_COUNT_SWITCH    : in  std_logic; --Eingangsvariable, Counter wählen

		   
		   BYTE_OK	 : out std_logic; --Ausgangsvariable, Byte vollständig
		   BYTE_OUT     : out std_logic_vector (7 downto 0); --Ausgangsvariable, Vektor
         BYTE_NUM : out std_logic_vector (7 downto 0); --Ausgangswariable, Bytenummer

         NEXT_BYTE : in std_logic; --Eingangsvariable, naechstes Byte

 		   CLK	      : in  std_logic; --Taktvariable
--		   CLK_IO       : in  std_logic; --Tanktvariable,
		   						   --Ein- und Ausgangsregister
		   IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
		   RESET		 : in std_logic;   --1: Initialzustand annehmen
		   
		   DISPL1_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl1, binärzahl
		   DISPL2_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl2, binärzahl
		   DISPL1_n_SV  : out std_logic_vector (3 downto 0); --Folgezustand Zahl1, binärzahl
		   DISPL2_n_SV	 : out std_logic_vector (3 downto 0));  --Folgezustand Zahl2, binärzahl 


end CTRL_9P6_50MHZ_VHDL;

architecture Behavioral of CTRL_9P6_50MHZ_VHDL is

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
				ST_CTRL_0F, --15
				ST_CTRL_10, --16
				ST_CTRL_12, --18
				ST_CTRL_13,  --19
				ST_CTRL_14); --20

type TYPE_STATE_BR_BIT0 is 
              (ST_BR_EN_BIT0_0, --Zustaende BIT_REGISTER BIT0
				   ST_BR_EN_BIT0_1);

type TYPE_STATE_BR_BIT1 is 
              (ST_BR_EN_BIT1_0, --Zustaende BIT_REGISTER BIT1
				   ST_BR_EN_BIT1_1);

type TYPE_STATE_BR_BIT2 is 
              (ST_BR_EN_BIT2_0, --Zustaende BIT_REGISTER BIT2
				   ST_BR_EN_BIT2_1);

type TYPE_STATE_BR_BIT3 is 
              (ST_BR_EN_BIT3_0, --Zustaende BIT_REGISTER BIT3
				   ST_BR_EN_BIT3_1);

type TYPE_STATE_BR_BIT4 is 
              (ST_BR_EN_BIT4_0, --Zustaende BIT_REGISTER BIT4
				   ST_BR_EN_BIT4_1);

type TYPE_STATE_BR_BIT5 is 
              (ST_BR_EN_BIT5_0, --Zustaende BIT_REGISTER BIT5
				   ST_BR_EN_BIT5_1);

type TYPE_STATE_BR_BIT6 is 
              (ST_BR_EN_BIT6_0, --Zustaende BIT_REGISTER BIT6
				   ST_BR_EN_BIT6_1);

type TYPE_STATE_BR_BIT7 is 
              (ST_BR_EN_BIT7_0, --Zustaende BIT_REGISTER BIT7
				   ST_BR_EN_BIT7_1);

type TYPE_STATE_BR_BIT8 is 
              (ST_BR_EN_BIT8_0, --Zustaende BIT_REGISTER BIT8
				   ST_BR_EN_BIT8_1);

type TYPE_STATE_BYTE_CHECK is
              (ST_BC_00, --Zustaende BYTE_CHECK
               ST_BC_01,
               ST_BC_02);

signal SV  : TYPE_STATE; --Zustandsvariable
signal n_SV: TYPE_STATE; --Zustandsvariable, neuer Wert
signal SV_M: TYPE_STATE; --Zustandsvariable, Ausgang Master

signal SV_BR_BIT0  : TYPE_STATE_BR_BIT0; --Zustandsvariable BIT_REGSITER BIT0
signal n_SV_BR_BIT0: TYPE_STATE_BR_BIT0; --Zustandsvariable BIT_REGSITER BIT0, neuer Wert
signal SV_BR_BIT0_M: TYPE_STATE_BR_BIT0; --Zustandsvariable BIT_REGSITER BIT0, Ausgang Master

signal SV_BR_BIT1  : TYPE_STATE_BR_BIT1; --Zustandsvariable BIT_REGSITER BIT1
signal n_SV_BR_BIT1: TYPE_STATE_BR_BIT1; --Zustandsvariable BIT_REGSITER BIT1, neuer Wert
signal SV_BR_BIT1_M: TYPE_STATE_BR_BIT1; --Zustandsvariable BIT_REGSITER BIT1, Ausgang Master

signal SV_BR_BIT2  : TYPE_STATE_BR_BIT2; --Zustandsvariable BIT_REGSITER BIT2
signal n_SV_BR_BIT2: TYPE_STATE_BR_BIT2; --Zustandsvariable BIT_REGSITER BIT2, neuer Wert
signal SV_BR_BIT2_M: TYPE_STATE_BR_BIT2; --Zustandsvariable BIT_REGSITER BIT2, Ausgang Master

signal SV_BR_BIT3  : TYPE_STATE_BR_BIT3; --Zustandsvariable BIT_REGSITER BIT3
signal n_SV_BR_BIT3: TYPE_STATE_BR_BIT3; --Zustandsvariable BIT_REGSITER BIT3, neuer Wert
signal SV_BR_BIT3_M: TYPE_STATE_BR_BIT3; --Zustandsvariable BIT_REGSITER BIT3, Ausgang Master

signal SV_BR_BIT4  : TYPE_STATE_BR_BIT4; --Zustandsvariable BIT_REGSITER BIT4
signal n_SV_BR_BIT4: TYPE_STATE_BR_BIT4; --Zustandsvariable BIT_REGSITER BIT4, neuer Wert
signal SV_BR_BIT4_M: TYPE_STATE_BR_BIT4; --Zustandsvariable BIT_REGSITER BIT4, Ausgang Master

signal SV_BR_BIT5  : TYPE_STATE_BR_BIT5; --Zustandsvariable BIT_REGSITER BIT5
signal n_SV_BR_BIT5: TYPE_STATE_BR_BIT5; --Zustandsvariable BIT_REGSITER BIT5, neuer Wert
signal SV_BR_BIT5_M: TYPE_STATE_BR_BIT5; --Zustandsvariable BIT_REGSITER BIT5, Ausgang Master

signal SV_BR_BIT6  : TYPE_STATE_BR_BIT6; --Zustandsvariable BIT_REGSITER BIT6
signal n_SV_BR_BIT6: TYPE_STATE_BR_BIT6; --Zustandsvariable BIT_REGSITER BIT6, neuer Wert
signal SV_BR_BIT6_M: TYPE_STATE_BR_BIT6; --Zustandsvariable BIT_REGSITER BIT6, Ausgang Master

signal SV_BR_BIT7  : TYPE_STATE_BR_BIT7; --Zustandsvariable BIT_REGSITER BIT7
signal n_SV_BR_BIT7: TYPE_STATE_BR_BIT7; --Zustandsvariable BIT_REGSITER BIT7, neuer Wert
signal SV_BR_BIT7_M: TYPE_STATE_BR_BIT7; --Zustandsvariable BIT_REGSITER BIT7, Ausgang Master

signal SV_BR_BIT8  : TYPE_STATE_BR_BIT8; --Zustandsvariable BIT_REGSITER BIT8
signal n_SV_BR_BIT8: TYPE_STATE_BR_BIT8; --Zustandsvariable BIT_REGSITER BIT8, neuer Wert
signal SV_BR_BIT8_M: TYPE_STATE_BR_BIT8; --Zustandsvariable BIT_REGSITER BIT8, Ausgang Master

signal SV_BYTE_CHECK : TYPE_STATE_BYTE_CHECK;   --Zustandsvariable BYTE_CHECK
signal n_SV_BYTE_CHECK : TYPE_STATE_BYTE_CHECK; --Zustandsvariable BYTE_CHECK, neuer Wert
signal SV_BYTE_CHECK_M : TYPE_STATE_BYTE_CHECK; --Zustandsvariable BYTE_CHECK, Ausgang Master

signal PARITY_OK  : std_logic; --Signal, Parität in Ordnung
signal BYTE_CMPLT : std_logic; -- Signal, Byte vollständig
signal BYTE_COUNT   : std_logic_vector (7 downto 0); -- Vektor, Bytenummer, 8bit
signal n_BYTE_COUNT : std_logic_vector (7 downto 0); -- Vektor, Bytenummer, 8bit, neuer Wert
signal BYTE_COUNT_M : std_logic_vector (7 downto 0); -- Vektor, Bytenummer, 8bit, Ausgang Master

signal BYTE_VEC  : std_logic_vector (8 downto 0); -- Vektor, BIT_REGSITER, vor Auswertung der Checksume
signal BIT_VALUE : std_logic; -- Wert aktuelles Bit

signal COUNT_L   : std_logic_vector (19 downto 0); --großer Zaehler, Vektor, 20 Bit
signal n_COUNT_L : std_logic_vector (19 downto 0); --großer Zaehler, neuer Wert, Vektor, 20 Bit
signal COUNT_L_M : std_logic_vector (19 downto 0); --großer Zaehler, Ausgang Master, Vektor, 20 Bit

signal COUNT_S   : std_logic_vector (15 downto 0); --kleiner Zaehler, Vektor, 16 Bit
signal n_COUNT_S : std_logic_vector (15 downto 0); --kleiner Zaehler, neuer Wert, Vektor, 16 Bit
signal COUNT_S_M : std_logic_vector (15 downto 0); --kleiner Zaehler, Ausgang Master, Vektor, 16 Bit

signal LONG_STATE_SV   : std_logic_vector (7 downto 0); -- aktueller Zustand in 8 Bit, binär
signal LONG_STATE_n_SV : std_logic_vector (7 downto 0); -- Folgezustand in 8 Bit, binär
 
signal InAB_S    : std_logic; --Eingangsvariable
					     --Zwischengespeichert im Eingangsregister

--signal not_CLK   : std_logic; --negierte Taktvariable
--signal not_CLK_IO: std_logic; --negierte Taktvariable
						--Ein- und Ausgangsregister

signal EN_BIT_0	 : std_logic; --BIT0
signal EN_BIT_1	 : std_logic; --BIT1
signal EN_BIT_2	 : std_logic; --BIT2
signal EN_BIT_3	 : std_logic; --BIT3
signal EN_BIT_4	 : std_logic; --BIT4
signal EN_BIT_5	 : std_logic; --BIT5
signal EN_BIT_6	 : std_logic; --BIT6
signal EN_BIT_7	 : std_logic; --BIT7
signal EN_BIT_8	 : std_logic; --Paritätsbit

signal CNTS30 : std_logic_vector (19 downto 0); --Zählerwerte
signal CNTT01 : std_logic_vector (15 downto 0);
signal CNTT02 : std_logic_vector (15 downto 0);
signal CNTT03 : std_logic_vector (15 downto 0);
signal CNTT04 : std_logic_vector (15 downto 0);
signal CNTT05 : std_logic_vector (15 downto 0);
signal CNTT06 : std_logic_vector (15 downto 0);
signal CNTT07 : std_logic_vector (15 downto 0);
signal CNTT08 : std_logic_vector (15 downto 0);
signal CNTT09 : std_logic_vector (15 downto 0);
signal CNTT10 : std_logic_vector (15 downto 0);
signal CNTT11 : std_logic_vector (15 downto 0);
signal CNTT12 : std_logic_vector (15 downto 0);
signal CNTT13 : std_logic_vector (15 downto 0);

signal TMP00 : std_logic; --temporärer Zwischenwert, Paritätsprüfung
signal TMP01 : std_logic;
signal TMP02 : std_logic;
signal TMP03 : std_logic;
signal TMP10 : std_logic;
signal TMP11 : std_logic;
signal TMP20 : std_logic;

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
constant long_CNTT12 : std_logic_vector := x"EE09";
constant long_CNTT13 : std_logic_vector := x"FA3E";

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
--NOT_CLK_IO_PROC: process (CLK_IO) --negieren Taktvaraible
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

SREG_M_PROC: process (RESET, n_SV, n_SV_BR_BIT0, n_SV_BR_BIT1, n_SV_BR_BIT2, n_SV_BR_BIT3, n_SV_BR_BIT4, n_SV_BR_BIT5, n_SV_BR_BIT6, n_SV_BR_BIT7, n_SV_BR_BIT8, n_COUNT_L,n_COUNT_S, CLK) --Master
begin
  if (RESET ='1')
   then SV_M    <= ST_CTRL_00;
   	  SV_BR_BIT0_M <= ST_BR_EN_BIT0_0;
        SV_BR_BIT1_M <= ST_BR_EN_BIT1_0;
        SV_BR_BIT2_M <= ST_BR_EN_BIT2_0;
        SV_BR_BIT3_M <= ST_BR_EN_BIT3_0;
        SV_BR_BIT4_M <= ST_BR_EN_BIT4_0;
        SV_BR_BIT5_M <= ST_BR_EN_BIT5_0;
        SV_BR_BIT6_M <= ST_BR_EN_BIT6_0;
        SV_BR_BIT7_M <= ST_BR_EN_BIT7_0;
        SV_BR_BIT8_M <= ST_BR_EN_BIT8_0;
        SV_BYTE_CHECK_M <= ST_BC_00;	
   else
     if rising_edge(CLK)
	 then
	   if (IN_NEXT_STATE = '1')
	    then SV_M    <= n_SV;
	    	   SV_BR_BIT0_M <= n_SV_BR_BIT0;
            SV_BR_BIT1_M <= n_SV_BR_BIT1;
            SV_BR_BIT2_M <= n_SV_BR_BIT2;
            SV_BR_BIT3_M <= n_SV_BR_BIT3;
            SV_BR_BIT4_M <= n_SV_BR_BIT4;
            SV_BR_BIT5_M <= n_SV_BR_BIT5;
            SV_BR_BIT6_M <= n_SV_BR_BIT6;
            SV_BR_BIT7_M <= n_SV_BR_BIT7;
            SV_BR_BIT8_M <= n_SV_BR_BIT8;
		      COUNT_L_M <= n_COUNT_L;
		      COUNT_S_M <= n_COUNT_S;
            SV_BYTE_CHECK_M <= n_SV_BYTE_CHECK;
            BYTE_COUNT_M <= n_BYTE_COUNT;
	    else SV_M    <= SV_M;
	    	   SV_BR_BIT0_M <= SV_BR_BIT0_M;
            SV_BR_BIT1_M <= SV_BR_BIT1_M;
            SV_BR_BIT2_M <= SV_BR_BIT2_M;
            SV_BR_BIT3_M <= SV_BR_BIT3_M;
            SV_BR_BIT4_M <= SV_BR_BIT4_M;
            SV_BR_BIT5_M <= SV_BR_BIT5_M;
            SV_BR_BIT6_M <= SV_BR_BIT6_M;
            SV_BR_BIT7_M <= SV_BR_BIT7_M;
            SV_BR_BIT8_M <= SV_BR_BIT8_M;
	         COUNT_L_M <= COUNT_L_M;
		      COUNT_S_M <= COUNT_S_M;
            SV_BYTE_CHECK_M <= SV_BYTE_CHECK_M;
            BYTE_COUNT_M <= BYTE_COUNT_M;
        end if;
	end if;
  end if;
end process;

SREG_S_PROC: process (RESET, SV_M, SV_BR_BIT0_M, SV_BR_BIT1_M, SV_BR_BIT2_M, SV_BR_BIT3_M, SV_BR_BIT4_M, SV_BR_BIT5_M, SV_BR_BIT6_M, SV_BR_BIT7_M, SV_BR_BIT8_M, COUNT_L_M, COUNT_S_M, CLK) --Slave
begin
  if (RESET = '1')
   then SV    <= ST_CTRL_00;
        SV_BR_BIT0 <= ST_BR_EN_BIT0_0;
        SV_BR_BIT1 <= ST_BR_EN_BIT1_0;
        SV_BR_BIT2 <= ST_BR_EN_BIT2_0;
        SV_BR_BIT3 <= ST_BR_EN_BIT3_0;
        SV_BR_BIT4 <= ST_BR_EN_BIT4_0;
        SV_BR_BIT5 <= ST_BR_EN_BIT5_0;
        SV_BR_BIT6 <= ST_BR_EN_BIT6_0;
        SV_BR_BIT7 <= ST_BR_EN_BIT7_0;
        SV_BR_BIT8 <= ST_BR_EN_BIT8_0;
        SV_BYTE_CHECK <= ST_BC_00;
   else
     if falling_edge(CLK)
	 then SV    <= SV_M;
	 	   SV_BR_BIT0 <= SV_BR_BIT0_M;
         SV_BR_BIT1 <= SV_BR_BIT1_M;
         SV_BR_BIT2 <= SV_BR_BIT2_M;
         SV_BR_BIT3 <= SV_BR_BIT3_M;
         SV_BR_BIT4 <= SV_BR_BIT4_M;
         SV_BR_BIT5 <= SV_BR_BIT5_M;
         SV_BR_BIT6 <= SV_BR_BIT6_M;
         SV_BR_BIT7 <= SV_BR_BIT7_M;
         SV_BR_BIT8 <= SV_BR_BIT8_M;
	 	   COUNT_L <= COUNT_L_M;
		   COUNT_S <= COUNT_S_M;
         SV_BYTE_CHECK <= SV_BYTE_CHECK_M;
         BYTE_COUNT <= BYTE_COUNT_M;
     end if;
   end if;
end process;

BYTE_CHECK_PROC:process (NEXT_BYTE, BYTE_CMPLT, PARITY_OK, SV_BYTE_CHECK, BYTE_COUNT) --Bytes zählen und prüfen
begin
 case SV_BYTE_CHECK is
  when ST_BC_00 =>
   if (NEXT_BYTE = '1')
    then
     -- BC01
     BYTE_OK <= '0';
     n_BYTE_COUNT <= BYTE_COUNT; --bleibt gleich
     n_SV_BYTE_CHECK <= ST_BC_01; --Zustandsübergang
    else
     -- BC00
     BYTE_OK <= '0';
     n_BYTE_COUNT <= x"00"; --wird Null (hex)
     n_SV_BYTE_CHECK <= ST_BC_00; --kein Zustandsübergang
   end if;
  
  when ST_BC_01 =>
   if (BYTE_CMPLT = '1')
    then
     --BC02
     BYTE_OK <= '0';
     n_BYTE_COUNT <= BYTE_COUNT; --bleibt gleich
     n_SV_BYTE_CHECK <= ST_BC_02; --Zustandsübergang
    else
     -- BC01
     BYTE_OK <= '0';
     n_BYTE_COUNT <= BYTE_COUNT; --bleibt gleich 
     n_SV_BYTE_CHECK <= ST_BC_01; --kein Zustandsübergang
   end if;

  when ST_BC_02 =>
   if (PARITY_OK = '1')
    then
     --BC03
     BYTE_OK <= '1';
     n_BYTE_COUNT <= BYTE_COUNT+1; --wird erhoeht
     n_SV_BYTE_CHECK <= ST_BC_00; --Zustandsübergang
    else
     -- BC00
     BYTE_OK <= '0';
     n_BYTE_COUNT <= x"00"; --wird Null (hex) 
     n_SV_BYTE_CHECK <= ST_BC_00; --Zustandsübergang
   end if;
  
  when others =>
   -- BC00
   BYTE_OK <= '0';
   n_BYTE_COUNT <= x"00"; --wird Null (hex) 
   n_SV_BYTE_CHECK <= ST_BC_00; --Zustandsübergang
 end case;
end process;

BYTE_NUM_PROC:process (BYTE_COUNT) --Ausgabe BYTE_NUM aus BYTE_COUNT
begin
 BYTE_NUM <= BYTE_COUNT;
end process;

BIT_REGISTER_EN_BIT_0_PROC:process (SV_BR_BIT0, n_SV_BR_BIT0, EN_BIT_0, BIT_VALUE) --BIT_REGISTER Bit0
begin
 case SV_BR_BIT0 is
  when ST_BR_EN_BIT0_0 =>
   BYTE_VEC(0)<='0';
   if (EN_BIT_0 = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_EN_BIT0_1
      then n_SV_BR_BIT0 <= ST_BR_EN_BIT0_1;
	   else n_SV_BR_BIT0 <= ST_BR_EN_BIT0_0;
     end if;
    else n_SV_BR_BIT0 <= ST_BR_EN_BIT0_0;
   end if;

  when ST_BR_EN_BIT0_1 =>
  -- EN_BIT_0 = 1 und BIT_VALUE = 1 dann setze BYTE_VEC(0) = 1
   BYTE_VEC(0)<='1';
   if (EN_BIT_0 = '1')
    then 
     if (BIT_VALUE = '1')
      then n_SV_BR_BIT0 <= ST_BR_EN_BIT0_1;
      else n_SV_BR_BIT0 <= ST_BR_EN_BIT0_0;
     end if;
    else n_SV_BR_BIT0 <= ST_BR_EN_BIT0_1; -- BIT_VALUE = 0
   end if;

  when others =>
   n_SV_BR_BIT0 <= ST_BR_EN_BIT0_0;
 end case;
end process;

BIT_REGISTER_EN_BIT_1_PROC:process (SV_BR_BIT1, n_SV_BR_BIT1, EN_BIT_1, BIT_VALUE) --BIT_REGISTER Bit1
begin
 case SV_BR_BIT1 is
  when ST_BR_EN_BIT1_0 =>
   BYTE_VEC(1)<='0';
   if (EN_BIT_1 = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT1_1
      then n_SV_BR_BIT1 <= ST_BR_EN_BIT1_1;
	   else n_SV_BR_BIT1 <= ST_BR_EN_BIT1_0;
     end if;
    else n_SV_BR_BIT1 <= ST_BR_EN_BIT1_0;
   end if;

  when ST_BR_EN_BIT1_1 =>
  -- EN_BIT_1 = 1 und BIT_VALUE = 1 dann setze BYTE_VEC(1) = 1
   BYTE_VEC(1)<='1';
   if (EN_BIT_1 = '1')
    then 
     if (BIT_VALUE = '1')
      then n_SV_BR_BIT1 <= ST_BR_EN_BIT1_1;
      else n_SV_BR_BIT1 <= ST_BR_EN_BIT1_0;
     end if;
    else n_SV_BR_BIT1 <= ST_BR_EN_BIT1_1; -- BIT_VALUE = 0
   end if;

  when others =>
   n_SV_BR_BIT1 <= ST_BR_EN_BIT1_0;
 end case;
end process;

BIT_REGISTER_EN_BIT_2_PROC:process (SV_BR_BIT2, n_SV_BR_BIT2, EN_BIT_2, BIT_VALUE) --BIT_REGISTER Bit1
begin
 case SV_BR_BIT2 is
  when ST_BR_EN_BIT2_0 =>
   BYTE_VEC(2)<='0';
   if (EN_BIT_2 = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT2_1
      then n_SV_BR_BIT2 <= ST_BR_EN_BIT2_1;
	   else n_SV_BR_BIT2 <= ST_BR_EN_BIT2_0;
     end if;
    else n_SV_BR_BIT2 <= ST_BR_EN_BIT2_0;
   end if;

  when ST_BR_EN_BIT2_1 =>
  -- EN_BIT_2 = 1 und BIT_VALUE = 1 dann setze BYTE_VEC(2) = 1
   BYTE_VEC(2)<='1';
   if (EN_BIT_2 = '1')
    then 
     if (BIT_VALUE = '1')
      then n_SV_BR_BIT2 <= ST_BR_EN_BIT2_1;
      else n_SV_BR_BIT2 <= ST_BR_EN_BIT2_0;
     end if;
    else n_SV_BR_BIT2 <= ST_BR_EN_BIT2_1; -- BIT_VALUE = 0
   end if;

  when others =>
   n_SV_BR_BIT2 <= ST_BR_EN_BIT2_0;
 end case;
end process;

BIT_REGISTER_EN_BIT_3_PROC:process (SV_BR_BIT3, n_SV_BR_BIT3, EN_BIT_3, BIT_VALUE) --BIT_REGISTER Bit1
begin
 case SV_BR_BIT3 is
  when ST_BR_EN_BIT3_0 =>
   BYTE_VEC(3)<='0';
   if (EN_BIT_3 = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT3_1
      then n_SV_BR_BIT3 <= ST_BR_EN_BIT3_1;
	   else n_SV_BR_BIT3 <= ST_BR_EN_BIT3_0;
     end if;
    else n_SV_BR_BIT3 <= ST_BR_EN_BIT3_0;
   end if;

  when ST_BR_EN_BIT3_1 =>
  -- EN_BIT_3 = 1 und BIT_VALUE = 1 dann setze BYTE_VEC(3) = 1
   BYTE_VEC(3)<='1';
   if (EN_BIT_3 = '1')
    then 
     if (BIT_VALUE = '1')
      then n_SV_BR_BIT3 <= ST_BR_EN_BIT3_1;
      else n_SV_BR_BIT3 <= ST_BR_EN_BIT3_0;
     end if;
    else n_SV_BR_BIT3 <= ST_BR_EN_BIT3_1; -- BIT_VALUE = 0
   end if;

  when others =>
   n_SV_BR_BIT3 <= ST_BR_EN_BIT3_0;
 end case;
end process;

BIT_REGISTER_EN_BIT_4_PROC:process (SV_BR_BIT4, n_SV_BR_BIT4, EN_BIT_4, BIT_VALUE) --BIT_REGISTER Bit1
begin
 case SV_BR_BIT4 is
  when ST_BR_EN_BIT4_0 =>
   BYTE_VEC(4)<='0';
   if (EN_BIT_4 = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT4_1
      then n_SV_BR_BIT4 <= ST_BR_EN_BIT4_1;
	   else n_SV_BR_BIT4 <= ST_BR_EN_BIT4_0;
     end if;
    else n_SV_BR_BIT4 <= ST_BR_EN_BIT4_0;
   end if;

  when ST_BR_EN_BIT4_1 =>
  -- EN_BIT_4 = 1 und BIT_VALUE = 1 dann setze BYTE_VEC(4) = 1
   BYTE_VEC(4)<='1';
   if (EN_BIT_4 = '1')
    then 
     if (BIT_VALUE = '1')
      then n_SV_BR_BIT4 <= ST_BR_EN_BIT4_1;
      else n_SV_BR_BIT4 <= ST_BR_EN_BIT4_0;
     end if;
    else n_SV_BR_BIT4 <= ST_BR_EN_BIT4_1; -- BIT_VALUE = 0
   end if;

  when others =>
   n_SV_BR_BIT4 <= ST_BR_EN_BIT4_0;
 end case;
end process;

BIT_REGISTER_EN_BIT_5_PROC:process (SV_BR_BIT5, n_SV_BR_BIT5, EN_BIT_5, BIT_VALUE) --BIT_REGISTER Bit1
begin
 case SV_BR_BIT5 is
  when ST_BR_EN_BIT5_0 =>
   BYTE_VEC(5)<='0';
   if (EN_BIT_5 = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT5_1
      then n_SV_BR_BIT5 <= ST_BR_EN_BIT5_1;
	   else n_SV_BR_BIT5 <= ST_BR_EN_BIT5_0;
     end if;
    else n_SV_BR_BIT5 <= ST_BR_EN_BIT5_0;
   end if;

  when ST_BR_EN_BIT5_1 =>
  -- EN_BIT_5 = 1 und BIT_VALUE = 1 dann setze BYTE_VEC(5) = 1
   BYTE_VEC(5)<='1';
   if (EN_BIT_5 = '1')
    then 
     if (BIT_VALUE = '1')
      then n_SV_BR_BIT5 <= ST_BR_EN_BIT5_1;
      else n_SV_BR_BIT5 <= ST_BR_EN_BIT5_0;
     end if;
    else n_SV_BR_BIT5 <= ST_BR_EN_BIT5_1; -- BIT_VALUE = 0
   end if;

  when others =>
   n_SV_BR_BIT5 <= ST_BR_EN_BIT5_0;
 end case;
end process;

BIT_REGISTER_EN_BIT_6_PROC:process (SV_BR_BIT6, n_SV_BR_BIT6, EN_BIT_6, BIT_VALUE) --BIT_REGISTER Bit6
begin
 case SV_BR_BIT6 is
  when ST_BR_EN_BIT6_0 =>
   BYTE_VEC(6)<='0';
   if (EN_BIT_6 = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT6_1
      then n_SV_BR_BIT6 <= ST_BR_EN_BIT6_1;
	   else n_SV_BR_BIT6 <= ST_BR_EN_BIT6_0;
     end if;
    else n_SV_BR_BIT6 <= ST_BR_EN_BIT6_0;
   end if;

  when ST_BR_EN_BIT6_1 =>
  -- EN_BIT_6 = 1 und BIT_VALUE = 1 dann setze BYTE_VEC(6) = 1
   BYTE_VEC(6)<='1';
   if (EN_BIT_6 = '1')
    then 
     if (BIT_VALUE = '1')
      then n_SV_BR_BIT6 <= ST_BR_EN_BIT6_1;
      else n_SV_BR_BIT6 <= ST_BR_EN_BIT6_0;
     end if;
    else n_SV_BR_BIT6 <= ST_BR_EN_BIT6_1; -- BIT_VALUE = 0
   end if;

  when others =>
   n_SV_BR_BIT6 <= ST_BR_EN_BIT6_0;
 end case;
end process;

BIT_REGISTER_EN_BIT_7_PROC:process (SV_BR_BIT7, n_SV_BR_BIT7, EN_BIT_7, BIT_VALUE) --BIT_REGISTER Bit7
begin
 case SV_BR_BIT7 is
  when ST_BR_EN_BIT7_0 =>
   BYTE_VEC(7)<='0';
   if (EN_BIT_7 = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT7_1
      then n_SV_BR_BIT7 <= ST_BR_EN_BIT7_1;
	   else n_SV_BR_BIT7 <= ST_BR_EN_BIT7_0;
     end if;
    else n_SV_BR_BIT7 <= ST_BR_EN_BIT7_0;
   end if;

  when ST_BR_EN_BIT7_1 =>
  -- EN_BIT_7 = 1 und BIT_VALUE = 1 dann setze BYTE_VEC(7) = 1
   BYTE_VEC(7)<='1';
   if (EN_BIT_7 = '1')
    then 
     if (BIT_VALUE = '1')
      then n_SV_BR_BIT7 <= ST_BR_EN_BIT7_1;
      else n_SV_BR_BIT7 <= ST_BR_EN_BIT7_0;
     end if;
    else n_SV_BR_BIT7 <= ST_BR_EN_BIT7_1; -- BIT_VALUE = 0
   end if;

  when others =>
   n_SV_BR_BIT7 <= ST_BR_EN_BIT7_0;
 end case;
end process;

BIT_REGISTER_EN_BIT_8_PROC:process (SV_BR_BIT8, n_SV_BR_BIT8, EN_BIT_8, BIT_VALUE) --BIT_REGISTER Bit8
begin
 case SV_BR_BIT8 is
  when ST_BR_EN_BIT8_0 =>
   BYTE_VEC(8)<='0';
   if (EN_BIT_8 = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT8_1
      then n_SV_BR_BIT8 <= ST_BR_EN_BIT8_1;
	   else n_SV_BR_BIT8 <= ST_BR_EN_BIT8_0;
     end if;
    else n_SV_BR_BIT8 <= ST_BR_EN_BIT8_0;
   end if;

  when ST_BR_EN_BIT8_1 =>
  -- EN_BIT_8 = 1 und BIT_VALUE = 1 dann setze BYTE_VEC(8) = 1
   BYTE_VEC(8)<='1';
   if (EN_BIT_8 = '1')
    then 
     if (BIT_VALUE = '1')
      then n_SV_BR_BIT8 <= ST_BR_EN_BIT8_1;
      else n_SV_BR_BIT8 <= ST_BR_EN_BIT8_0;
     end if;
    else n_SV_BR_BIT8 <= ST_BR_EN_BIT8_1; -- BIT_VALUE = 0
   end if;

  when others =>
   n_SV_BR_BIT8 <= ST_BR_EN_BIT8_0;
 end case;
end process;

IL_OL_PROC: process (InAB_S, SV, COUNT_L,COUNT_S, CNTS30, CNTT01, CNTT02, CNTT03, CNTT04, CNTT05, CNTT06, CNTT07, CNTT08, CNTT09, CNTT10, CNTT11, CNTT12, CNTT13)
begin
  case SV is
    when ST_CTRL_00 =>	 
      if (InAB_S = '1')
	  then
	  -- VAS00
	   n_COUNT_L <= x"00000"; -- großer Zaehler Neustart
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
	   n_COUNT_L <= x"00000"; -- großer Zaehler nullen
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
     if (COUNT_L = CNTS30) --156250
     -- if (COUNT >=3)
	 then
	 -- VAS01
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
	  n_SV <= ST_CTRL_02; -- Zustandsuebgergang

	 else                 --n_COUNT < CNTS30
    --VAS01
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

    when ST_CTRL_02 =>
 	 if (InAB_S = '0')
	 then
	 -- VAS00
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
	 else 			  -- InAB_S = '1'
    --VAS01
	  n_COUNT_L <= COUNT_L+1; -- dieser Zähler wird nicht abgefragt! (Sinnlos?)
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
	  n_SV <= ST_CTRL_02; --warte tsyn30 ab
	 end if;

    when ST_CTRL_03 =>
     if (COUNT_S = CNTT01) --2604
	 then
	 -- VAS02
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
	 else                 --n_COUNT < CNTT01
    -- VAS02
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
	  n_SV <= ST_CTRL_03; --Zaehlschleife
	 end if;

    when ST_CTRL_04 =>
 	 if (InAB_S = '0') -- Startbit erkannt
	 then
	 -- VAS02
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
	  n_SV <= ST_CTRL_06; -- Zustandsuebgergang
	 else                 --InAB_S = '1'
    -- VAS03
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
	  n_SV <= ST_CTRL_05; --Error
	 end if;

    when ST_CTRL_05 =>
    -- VAS00
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
	  n_SV <= ST_CTRL_00; --Zurueck zum Initialzustand

    when ST_CTRL_06 =>
     if (COUNT_S = CNTT02) --7812
	 then
	 -- VAS04
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
	  n_SV <= ST_CTRL_07; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT02
    -- VAS02
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
     if (COUNT_S = CNTT03) --13020
	 then
	 -- VAS05
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
	  n_SV <= ST_CTRL_08; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT03
    -- VAS02
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
     if (COUNT_S = CNTT04) --18229
	 then
	 -- VAS06
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
	  n_SV <= ST_CTRL_09; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT04
    -- VAS02
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
     if (COUNT_S = CNTT05) --23435
	 then
	 -- VAS07
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
	  n_SV <= ST_CTRL_0A; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT05
    -- VAS02
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
     if (COUNT_S = CNTT06) --28644
	 then
	 -- VAS08
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
	  n_SV <= ST_CTRL_0B; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT06
    -- VAS02
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
     if (COUNT_S = CNTT07) --33854
	 then
	 -- VAS09
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
	  n_SV <= ST_CTRL_0C; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT07
    -- VAS02
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
     if (COUNT_S = CNTT08) --39062
	 then
	 -- VAS10
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
	  n_SV <= ST_CTRL_0D; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT08
    -- VAS02
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
     if (COUNT_S = CNTT09) --44270
	 then
	 -- VAS11
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
	  n_SV <= ST_CTRL_0E; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT09
    -- VAS02
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
	 end if;

    when ST_CTRL_0E =>
     if (COUNT_S = CNTT10) --49479
	 then
	 -- VAS12
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
	  n_SV <= ST_CTRL_0F; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT10
    -- VAS02
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
     if (COUNT_S = CNTT11) --54687
	 then
	 -- VAS02
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
	  n_SV <= ST_CTRL_10; -- Zustandsuebgergang
	 else                 --n_COUNT < CNTT11
    -- VAS02
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
	 end if;

    when ST_CTRL_10 =>
 	 if (InAB_S = '0')
	 then
	 -- VAS03
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
	  n_SV <= ST_CTRL_05; -- Error: Kein Stoppbit
	 else                 --InAB_S = '1'
    -- VAS13
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
	  n_SV <= ST_CTRL_12; --Stoppbit erkannt
	 end if;

    when ST_CTRL_12 =>
     if (COUNT_S = CNTT12) --60937
	 then
	 -- VAS02
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
	  n_SV <= ST_CTRL_13; -- Zustandsuebgergang
	 else                 -- n_COUNT < CNTT12
    -- VAS02
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
	  n_SV <= ST_CTRL_12; --Zaehlschleife
	 end if;

    when ST_CTRL_13 =>
     if (InAB_S = '0') -- Startbit gefunden
	 then
	 -- VAS00
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
	 else                 -- InAB_S = '1'
    -- VAS02
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
	  n_SV <= ST_CTRL_14; --Zaehlschleife Teil 1
	 end if;

    when ST_CTRL_14 =>
     if (COUNT_S = CNTT13) --64062
	 then
	 -- VAS00
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
	 else                 -- n_COUNT < CNTT13
    -- VAS02
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
	  n_SV <= ST_CTRL_13; --Zaehlschleife Teil 2
	 end if;

    when others => 
    	-- VAS00
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

PARITY_CHECK_PROC: process (BYTE_VEC) --Paritätsprüfung
 begin
  TMP00 <= BYTE_VEC(0) xor BYTE_VEC(1);
  TMP01 <= BYTE_VEC(2) xor BYTE_VEC(3);
  TMP02 <= BYTE_VEC(4) xor BYTE_VEC(5);
  TMP03 <= BYTE_VEC(6) xor BYTE_VEC(7);

  TMP10 <= TMP00 xor TMP01;
  TMP11 <= TMP02 xor TMP03;

  TMP20 <= TMP10 xor TMP11;

  if (TMP20 = BYTE_VEC(8)) 
   then PARITY_OK <= '1'; -- Parität korrekt
   else PARITY_OK <= '0'; -- Parität fehlerhaft
  end if;
end process;

BYTE_OUT_PORC: process (BYTE_VEC) --BYTEausgabe
 begin
  BYTE_OUT(0) <= BYTE_VEC(0);
  BYTE_OUT(1) <= BYTE_VEC(1);
  BYTE_OUT(2) <= BYTE_VEC(2);
  BYTE_OUT(3) <= BYTE_VEC(3);
  BYTE_OUT(4) <= BYTE_VEC(4);
  BYTE_OUT(5) <= BYTE_VEC(5);
  BYTE_OUT(6) <= BYTE_VEC(6);
  BYTE_OUT(7) <= BYTE_VEC(7);
end process;
  


STATE_DISPL_PROC: process (SV, n_SV, DISPL_COUNT, DISPL_COUNT_SWITCH, LONG_STATE_SV, LONG_STATE_n_SV, COUNT_L ,COUNT_S) -- Zustandsanzeige
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

  if (DISPL_COUNT ='0')
   then --Folgezustand anzeigen
    DISPL1_n_SV(0)  <= LONG_STATE_n_SV(0);
    DISPL1_n_SV(1)  <= LONG_STATE_n_SV(1);
    DISPL1_n_SV(2)  <= LONG_STATE_n_SV(2);
    DISPL1_n_SV(3)  <= LONG_STATE_n_SV(3);
   
    DISPL2_n_SV(0)  <= LONG_STATE_n_SV(4);
    DISPL2_n_SV(1)  <= LONG_STATE_n_SV(5);
    DISPL2_n_SV(2)  <= LONG_STATE_n_SV(6);
    DISPL2_n_SV(3)  <= LONG_STATE_n_SV(7);

   else  --Zähler anzeigen
    if (DISPL_COUNT_SWITCH ='0')
     then --kleinen Zaehler anzeigen
      DISPL1_n_SV(0) <= COUNT_S(0);
      DISPL1_n_SV(1) <= COUNT_S(1);
      DISPL1_n_SV(2) <= COUNT_S(2);
      DISPL1_n_SV(3) <= COUNT_S(3);
    
      DISPL2_n_SV(0) <= COUNT_S(4);
      DISPL2_n_SV(1) <= COUNT_S(5);
      DISPL2_n_SV(2) <= COUNT_S(6);
      DISPL2_n_SV(3) <= COUNT_S(7);
	else -- langen Zaehler anzeigen
	 DISPL1_n_SV(0) <= COUNT_L(0);
      DISPL1_n_SV(1) <= COUNT_L(1);
      DISPL1_n_SV(2) <= COUNT_L(2);
      DISPL1_n_SV(3) <= COUNT_L(3);
    
      DISPL2_n_SV(0) <= COUNT_L(4);
      DISPL2_n_SV(1) <= COUNT_L(5);
      DISPL2_n_SV(2) <= COUNT_L(6);
      DISPL2_n_SV(3) <= COUNT_L(7);
    end if; 
  end if;
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
