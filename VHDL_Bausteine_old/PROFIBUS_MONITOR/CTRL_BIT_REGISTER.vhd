-- CTRL_BIT_REGISTER
-- Einlesen der einzelnen Werte für bestimmte Bits, berechung der Parität und Ausgabe als Byte
-- Projekt: PROFIBUS MONITOR
-- Ersteller: Martin Harndt
-- Erstellt: 08.01.2013
-- Bearbeiter: mharndt
-- Geaendert: 25.01.2013
-- Umstellung auf: rising_edge(CLK) und falling_edge(CLK) und http://www.sigasi.com/content/clock-edge-detection 
-- Optimierungen aus: http://www.lothar-miller.de/s9y/categories/37-FSM

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CTRL_BIT_REGISTER is
   Port (EN_BIT_i  : in std_logic_vector (8 downto 0); --Eingangsvariable, Einschalten des Bitregisters i

         BIT_VALUE : in std_logic; -- Eingangsvariable, Wert des aktuellen Bits		   
		   BYTE_OUT	 : out std_logic_vector (7 downto 0); --Ausgangsvariable, Byte, 8bit, Vektor
		   PARITY_OK     : out std_logic; --Ausgangsvariable, Parität i.O.

 		   CLK	      : in  std_logic; --Taktvariable
		   IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
		   RESET		 : in std_logic);   --1: Initialzustand annehmen

end CTRL_BIT_REGISTER;

architecture Behavioral of CTRL_BIT_REGISTER is

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


signal SV_BR_BIT0  : TYPE_STATE_BR_BIT0 := ST_BR_EN_BIT0_0; --Zustandsvariable BIT_REGSITER BIT0
signal n_SV_BR_BIT0: TYPE_STATE_BR_BIT0 := ST_BR_EN_BIT0_0; --Zustandsvariable BIT_REGSITER BIT0, neuer Wert
signal SV_BR_BIT0_M: TYPE_STATE_BR_BIT0 := ST_BR_EN_BIT0_0; --Zustandsvariable BIT_REGSITER BIT0, Ausgang Master

signal SV_BR_BIT1  : TYPE_STATE_BR_BIT1 := ST_BR_EN_BIT1_0; --Zustandsvariable BIT_REGSITER BIT1
signal n_SV_BR_BIT1: TYPE_STATE_BR_BIT1 := ST_BR_EN_BIT1_0; --Zustandsvariable BIT_REGSITER BIT1, neuer Wert
signal SV_BR_BIT1_M: TYPE_STATE_BR_BIT1 := ST_BR_EN_BIT1_0; --Zustandsvariable BIT_REGSITER BIT1, Ausgang Master

signal SV_BR_BIT2  : TYPE_STATE_BR_BIT2 := ST_BR_EN_BIT2_0; --Zustandsvariable BIT_REGSITER BIT2
signal n_SV_BR_BIT2: TYPE_STATE_BR_BIT2 := ST_BR_EN_BIT2_0; --Zustandsvariable BIT_REGSITER BIT2, neuer Wert
signal SV_BR_BIT2_M: TYPE_STATE_BR_BIT2 := ST_BR_EN_BIT2_0; --Zustandsvariable BIT_REGSITER BIT2, Ausgang Master

signal SV_BR_BIT3  : TYPE_STATE_BR_BIT3 := ST_BR_EN_BIT3_0; --Zustandsvariable BIT_REGSITER BIT3
signal n_SV_BR_BIT3: TYPE_STATE_BR_BIT3 := ST_BR_EN_BIT3_0; --Zustandsvariable BIT_REGSITER BIT3, neuer Wert
signal SV_BR_BIT3_M: TYPE_STATE_BR_BIT3 := ST_BR_EN_BIT3_0; --Zustandsvariable BIT_REGSITER BIT3, Ausgang Master

signal SV_BR_BIT4  : TYPE_STATE_BR_BIT4 := ST_BR_EN_BIT4_0; --Zustandsvariable BIT_REGSITER BIT4
signal n_SV_BR_BIT4: TYPE_STATE_BR_BIT4 := ST_BR_EN_BIT4_0; --Zustandsvariable BIT_REGSITER BIT4, neuer Wert
signal SV_BR_BIT4_M: TYPE_STATE_BR_BIT4 := ST_BR_EN_BIT4_0; --Zustandsvariable BIT_REGSITER BIT4, Ausgang Master

signal SV_BR_BIT5  : TYPE_STATE_BR_BIT5 := ST_BR_EN_BIT5_0; --Zustandsvariable BIT_REGSITER BIT5
signal n_SV_BR_BIT5: TYPE_STATE_BR_BIT5 := ST_BR_EN_BIT5_0; --Zustandsvariable BIT_REGSITER BIT5, neuer Wert
signal SV_BR_BIT5_M: TYPE_STATE_BR_BIT5 := ST_BR_EN_BIT5_0; --Zustandsvariable BIT_REGSITER BIT5, Ausgang Master

signal SV_BR_BIT6  : TYPE_STATE_BR_BIT6 := ST_BR_EN_BIT6_0; --Zustandsvariable BIT_REGSITER BIT6
signal n_SV_BR_BIT6: TYPE_STATE_BR_BIT6 := ST_BR_EN_BIT6_0; --Zustandsvariable BIT_REGSITER BIT6, neuer Wert
signal SV_BR_BIT6_M: TYPE_STATE_BR_BIT6 := ST_BR_EN_BIT6_0; --Zustandsvariable BIT_REGSITER BIT6, Ausgang Master

signal SV_BR_BIT7  : TYPE_STATE_BR_BIT7 := ST_BR_EN_BIT7_0; --Zustandsvariable BIT_REGSITER BIT7
signal n_SV_BR_BIT7: TYPE_STATE_BR_BIT7 := ST_BR_EN_BIT7_0; --Zustandsvariable BIT_REGSITER BIT7, neuer Wert
signal SV_BR_BIT7_M: TYPE_STATE_BR_BIT7 := ST_BR_EN_BIT7_0; --Zustandsvariable BIT_REGSITER BIT7, Ausgang Master

signal SV_BR_BIT8  : TYPE_STATE_BR_BIT8 := ST_BR_EN_BIT8_0; --Zustandsvariable BIT_REGSITER BIT8
signal n_SV_BR_BIT8: TYPE_STATE_BR_BIT8 := ST_BR_EN_BIT8_0; --Zustandsvariable BIT_REGSITER BIT8, neuer Wert
signal SV_BR_BIT8_M: TYPE_STATE_BR_BIT8 := ST_BR_EN_BIT8_0; --Zustandsvariable BIT_REGSITER BIT8, Ausgang Master

signal BYTE_VEC  : std_logic_vector (8 downto 0) := b"000000000"; -- Vektor, BIT_REGSITER, vor Auswertung der Checksume

--signal not_CLK   : std_logic; --negierte Taktvariable


--signal TMP00 : std_logic; --temporärer Zwischenwert, Paritätsprüfung
--signal TMP01 : std_logic;
--signal TMP02 : std_logic;
--signal TMP03 : std_logic;
--signal TMP10 : std_logic;
--signal TMP11 : std_logic;
--signal TMP20 : std_logic;

begin

--NOT_CLK_PROC: process (CLK) --negieren Taktvariable
--begin
--  not_CLK <= not CLK;
--end process;


SREG_M_PROC: process (RESET, n_SV_BR_BIT0, n_SV_BR_BIT1, n_SV_BR_BIT2, n_SV_BR_BIT3, n_SV_BR_BIT4, n_SV_BR_BIT5, n_SV_BR_BIT6, n_SV_BR_BIT7, n_SV_BR_BIT8, CLK) --Master
begin
  if (RESET ='1')
   then SV_BR_BIT0_M <= ST_BR_EN_BIT0_0;
        SV_BR_BIT1_M <= ST_BR_EN_BIT1_0;
        SV_BR_BIT2_M <= ST_BR_EN_BIT2_0;
        SV_BR_BIT3_M <= ST_BR_EN_BIT3_0;
        SV_BR_BIT4_M <= ST_BR_EN_BIT4_0;
        SV_BR_BIT5_M <= ST_BR_EN_BIT5_0;
        SV_BR_BIT6_M <= ST_BR_EN_BIT6_0;
        SV_BR_BIT7_M <= ST_BR_EN_BIT7_0;
        SV_BR_BIT8_M <= ST_BR_EN_BIT8_0;
   else
     if rising_edge(CLK)
	 then
	   if (IN_NEXT_STATE = '1')
	    then SV_BR_BIT0_M <= n_SV_BR_BIT0;
            SV_BR_BIT1_M <= n_SV_BR_BIT1;
            SV_BR_BIT2_M <= n_SV_BR_BIT2;
            SV_BR_BIT3_M <= n_SV_BR_BIT3;
            SV_BR_BIT4_M <= n_SV_BR_BIT4;
            SV_BR_BIT5_M <= n_SV_BR_BIT5;
            SV_BR_BIT6_M <= n_SV_BR_BIT6;
            SV_BR_BIT7_M <= n_SV_BR_BIT7;
            SV_BR_BIT8_M <= n_SV_BR_BIT8;
	    else 
            SV_BR_BIT0_M <= SV_BR_BIT0_M;
            SV_BR_BIT1_M <= SV_BR_BIT1_M;
            SV_BR_BIT2_M <= SV_BR_BIT2_M;
            SV_BR_BIT3_M <= SV_BR_BIT3_M;
            SV_BR_BIT4_M <= SV_BR_BIT4_M;
            SV_BR_BIT5_M <= SV_BR_BIT5_M;
            SV_BR_BIT6_M <= SV_BR_BIT6_M;
            SV_BR_BIT7_M <= SV_BR_BIT7_M;
            SV_BR_BIT8_M <= SV_BR_BIT8_M;
        end if;
	end if;
  end if;
end process;

SREG_S_PROC: process (RESET, SV_BR_BIT0_M, SV_BR_BIT1_M, SV_BR_BIT2_M, SV_BR_BIT3_M, SV_BR_BIT4_M, SV_BR_BIT5_M, SV_BR_BIT6_M, SV_BR_BIT7_M, SV_BR_BIT8_M, CLK) --Slave
begin
  if (RESET = '1')
   then SV_BR_BIT0 <= ST_BR_EN_BIT0_0;
        SV_BR_BIT1 <= ST_BR_EN_BIT1_0;
        SV_BR_BIT2 <= ST_BR_EN_BIT2_0;
        SV_BR_BIT3 <= ST_BR_EN_BIT3_0;
        SV_BR_BIT4 <= ST_BR_EN_BIT4_0;
        SV_BR_BIT5 <= ST_BR_EN_BIT5_0;
        SV_BR_BIT6 <= ST_BR_EN_BIT6_0;
        SV_BR_BIT7 <= ST_BR_EN_BIT7_0;
        SV_BR_BIT8 <= ST_BR_EN_BIT8_0;
   else
     if falling_edge(CLK)
	 then 
         SV_BR_BIT0 <= SV_BR_BIT0_M;
         SV_BR_BIT1 <= SV_BR_BIT1_M;
         SV_BR_BIT2 <= SV_BR_BIT2_M;
         SV_BR_BIT3 <= SV_BR_BIT3_M;
         SV_BR_BIT4 <= SV_BR_BIT4_M;
         SV_BR_BIT5 <= SV_BR_BIT5_M;
         SV_BR_BIT6 <= SV_BR_BIT6_M;
         SV_BR_BIT7 <= SV_BR_BIT7_M;
         SV_BR_BIT8 <= SV_BR_BIT8_M;
     end if;
   end if;
end process;

BIT_REGISTER_EN_BIT_0_PROC:process (SV_BR_BIT0, n_SV_BR_BIT0, BIT_VALUE, EN_BIT_i) --BIT_REGISTER Bit0
begin
 case SV_BR_BIT0 is
  when ST_BR_EN_BIT0_0 =>
   BYTE_OUT(0)<='0';
   BYTE_VEC(0)<='0';
   if (EN_BIT_i(0) = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_EN_BIT0_1
      then n_SV_BR_BIT0 <= ST_BR_EN_BIT0_1;
	   else n_SV_BR_BIT0 <= ST_BR_EN_BIT0_0;
     end if;
    else n_SV_BR_BIT0 <= ST_BR_EN_BIT0_0;
   end if;

  when ST_BR_EN_BIT0_1 =>
  -- EN_BIT_0_S = 1 und BIT_VALUE = 1 dann setze BYTE_OUT(0) = 1
   BYTE_OUT(0)<='1';
   BYTE_VEC(0)<='1';
   if (EN_BIT_i(0) = '1')
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

BIT_REGISTER_EN_BIT_1_PROC:process (SV_BR_BIT1, n_SV_BR_BIT1, BIT_VALUE, EN_BIT_i) --BIT_REGISTER Bit1
begin
 case SV_BR_BIT1 is
  when ST_BR_EN_BIT1_0 =>
   BYTE_OUT(1)<='0';
   BYTE_VEC(1)<='0';
   if (EN_BIT_i(1) = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT1_1
      then n_SV_BR_BIT1 <= ST_BR_EN_BIT1_1;
	   else n_SV_BR_BIT1 <= ST_BR_EN_BIT1_0;
     end if;
    else n_SV_BR_BIT1 <= ST_BR_EN_BIT1_0;
   end if;

  when ST_BR_EN_BIT1_1 =>
  -- EN_BIT_1_S = 1 und BIT_VALUE = 1 dann setze BYTE_OUT(1) = 1
   BYTE_OUT(1)<='1';
   BYTE_VEC(1)<='1';
   if (EN_BIT_i(1) = '1')
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

BIT_REGISTER_EN_BIT_2_PROC:process (SV_BR_BIT2, n_SV_BR_BIT2, BIT_VALUE, EN_BIT_i) --BIT_REGISTER Bit1
begin
 case SV_BR_BIT2 is
  when ST_BR_EN_BIT2_0 =>
   BYTE_OUT(2)<='0';
   BYTE_VEC(2)<='0';
   if (EN_BIT_i(2) = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT2_1
      then n_SV_BR_BIT2 <= ST_BR_EN_BIT2_1;
	   else n_SV_BR_BIT2 <= ST_BR_EN_BIT2_0;
     end if;
    else n_SV_BR_BIT2 <= ST_BR_EN_BIT2_0;
   end if;

  when ST_BR_EN_BIT2_1 =>
  -- EN_BIT_2_S = 1 und BIT_VALUE = 1 dann setze BYTE_OUT(2) = 1
   BYTE_OUT(2)<='1';
   BYTE_VEC(2)<='1';
   if (EN_BIT_i(2) = '1')
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

BIT_REGISTER_EN_BIT_3_PROC:process (SV_BR_BIT3, n_SV_BR_BIT3, BIT_VALUE, EN_BIT_i) --BIT_REGISTER Bit1
begin
 case SV_BR_BIT3 is
  when ST_BR_EN_BIT3_0 =>
   BYTE_OUT(3)<='0';
   BYTE_VEC(3)<='0';
   if (EN_BIT_i(3) = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT3_1
      then n_SV_BR_BIT3 <= ST_BR_EN_BIT3_1;
	   else n_SV_BR_BIT3 <= ST_BR_EN_BIT3_0;
     end if;
    else n_SV_BR_BIT3 <= ST_BR_EN_BIT3_0;
   end if;

  when ST_BR_EN_BIT3_1 =>
  -- EN_BIT_3_S = 1 und BIT_VALUE = 1 dann setze BYTE_OUT(3) = 1
   BYTE_OUT(3)<='1';
   BYTE_VEC(3)<='1';
   if (EN_BIT_i(3) = '1')
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

BIT_REGISTER_EN_BIT_4_PROC:process (SV_BR_BIT4, n_SV_BR_BIT4, BIT_VALUE, EN_BIT_i) --BIT_REGISTER Bit1
begin
 case SV_BR_BIT4 is
  when ST_BR_EN_BIT4_0 =>
   BYTE_OUT(4)<='0';
   BYTE_VEC(4)<='0';
   if (EN_BIT_i(4) = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT4_1
      then n_SV_BR_BIT4 <= ST_BR_EN_BIT4_1;
	   else n_SV_BR_BIT4 <= ST_BR_EN_BIT4_0;
     end if;
    else n_SV_BR_BIT4 <= ST_BR_EN_BIT4_0;
   end if;

  when ST_BR_EN_BIT4_1 =>
  -- EN_BIT_4 = 1 und BIT_VALUE = 1 dann setze BYTE_OUT(4) = 1
   BYTE_OUT(4)<='1';
   BYTE_VEC(4)<='1';
   if (EN_BIT_i(4) = '1')
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

BIT_REGISTER_EN_BIT_5_PROC:process (SV_BR_BIT5, n_SV_BR_BIT5, BIT_VALUE, EN_BIT_i) --BIT_REGISTER Bit1
begin
 case SV_BR_BIT5 is
  when ST_BR_EN_BIT5_0 =>
   BYTE_OUT(5)<='0';
   BYTE_VEC(5)<='0';
   if (EN_BIT_i(5) = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT5_1
      then n_SV_BR_BIT5 <= ST_BR_EN_BIT5_1;
	   else n_SV_BR_BIT5 <= ST_BR_EN_BIT5_0;
     end if;
    else n_SV_BR_BIT5 <= ST_BR_EN_BIT5_0;
   end if;

  when ST_BR_EN_BIT5_1 =>
  -- EN_BIT_5_S = 1 und BIT_VALUE = 1 dann setze BYTE_OUT(5) = 1
   BYTE_OUT(5)<='1';
   BYTE_VEC(5)<='1';
   if (EN_BIT_i(5) = '1')
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

BIT_REGISTER_EN_BIT_6_PROC:process (SV_BR_BIT6, n_SV_BR_BIT6, BIT_VALUE, EN_BIT_i) --BIT_REGISTER Bit6
begin
 case SV_BR_BIT6 is
  when ST_BR_EN_BIT6_0 =>
   BYTE_OUT(6)<='0';
   BYTE_VEC(6)<='0';
   if (EN_BIT_i(6) = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT6_1
      then n_SV_BR_BIT6 <= ST_BR_EN_BIT6_1;
	   else n_SV_BR_BIT6 <= ST_BR_EN_BIT6_0;
     end if;
    else n_SV_BR_BIT6 <= ST_BR_EN_BIT6_0;
   end if;

  when ST_BR_EN_BIT6_1 =>
  -- EN_BIT_6 = 1 und BIT_VALUE = 1 dann setze BYTE_OUT(6) = 1
   BYTE_OUT(6)<='1';
   BYTE_VEC(6)<='1';
   if (EN_BIT_i(6) = '1')
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

BIT_REGISTER_EN_BIT_7_PROC:process (SV_BR_BIT7, n_SV_BR_BIT7, BIT_VALUE, EN_BIT_i) --BIT_REGISTER Bit7
begin
 case SV_BR_BIT7 is
  when ST_BR_EN_BIT7_0 =>
   BYTE_OUT(7)<='0';
   BYTE_VEC(7)<='0';
   if (EN_BIT_i(7) = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT7_1
      then n_SV_BR_BIT7 <= ST_BR_EN_BIT7_1;
	   else n_SV_BR_BIT7 <= ST_BR_EN_BIT7_0;
     end if;
    else n_SV_BR_BIT7 <= ST_BR_EN_BIT7_0;
   end if;

  when ST_BR_EN_BIT7_1 =>
  -- EN_BIT_7_S = 1 und BIT_VALUE = 1 dann setze BYTE_OUT(7) = 1
   BYTE_OUT(7)<='1';
   BYTE_VEC(7)<='1';
   if (EN_BIT_i(7) = '1')
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

BIT_REGISTER_EN_BIT_8_PROC:process (SV_BR_BIT8, n_SV_BR_BIT8, BIT_VALUE, EN_BIT_i) --BIT_REGISTER Bit8
begin
 case SV_BR_BIT8 is
  when ST_BR_EN_BIT8_0 =>
   BYTE_VEC(8)<='0';
   if (EN_BIT_i(8) = '1')
    then
     if (BIT_VALUE = '1')--gehe zu ST_BR_BIT8_1
      then n_SV_BR_BIT8 <= ST_BR_EN_BIT8_1;
	   else n_SV_BR_BIT8 <= ST_BR_EN_BIT8_0;
     end if;
    else n_SV_BR_BIT8 <= ST_BR_EN_BIT8_0;
   end if;

  when ST_BR_EN_BIT8_1 =>
  -- EN_BIT_8_S = 1 und BIT_VALUE = 1 dann setze BYTE_OUT(8) = 1
   BYTE_VEC(8)<='1';
   if (EN_BIT_i(8) = '1')
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

PARITY_CHECK_PROC: process (BYTE_VEC) --Paritätsprüfung (Mit VARIABLEN := , STATT SIGNALEN <=)
 variable TMP00, TMP01, TMP02, TMP03, TMP10, TMP11, TMP20 : std_logic;
 begin
  TMP00 := BYTE_VEC(0) xor BYTE_VEC(1);
  TMP01 := BYTE_VEC(2) xor BYTE_VEC(3);
  TMP02 := BYTE_VEC(4) xor BYTE_VEC(5);
  TMP03 := BYTE_VEC(6) xor BYTE_VEC(7);

  TMP10 := TMP00 xor TMP01;
  TMP11 := TMP02 xor TMP03;

  TMP20 := TMP10 xor TMP11;

  if (TMP20 = BYTE_VEC(8)) 
   then PARITY_OK <= '1'; -- Parität korrekt
   else PARITY_OK <= '0'; -- Parität fehlerhaft
  end if;
end process;


--BYTE_OUT_PORC: process (BYTE_VEC) --BYTEausgabe
-- begin
--  BYTE_OUT(0) <= BYTE_VEC(0);
--  BYTE_OUT(1) <= BYTE_VEC(1);
--  BYTE_OUT(2) <= BYTE_VEC(2);
--  BYTE_OUT(3) <= BYTE_VEC(3);
--  BYTE_OUT(4) <= BYTE_VEC(4);
--  BYTE_OUT(5) <= BYTE_VEC(5);
--  BYTE_OUT(6) <= BYTE_VEC(6);
--  BYTE_OUT(7) <= BYTE_VEC(7);
--end process;

end Behavioral;
