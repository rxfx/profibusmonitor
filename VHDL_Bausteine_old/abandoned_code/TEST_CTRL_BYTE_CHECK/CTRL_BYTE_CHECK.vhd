-- CTRL_BYTE_CHECK
-- Bytes zählen und prüfen
-- Ersteller: Martin Harndt
-- Erstellt: 19.12.2012
-- Bearbeiter: mharndt
-- Geaendert: 19.12.2012 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CTRL_BYTE_CHECK is
    Port (BYTE_OK	 : out std_logic; --Ausgangsvariable, Byte vollständig
         BYTE_NUM  : out std_logic_vector (7 downto 0); --Ausgangswariable, Bytenummer
         NEXT_BYTE : in std_logic; --Eingangsvariable, naechstes Byte
         PARITY_OK  : in std_logic; --Eingangsvariable, Parität in Ordnung
         BYTE_CMPLT : in std_logic; --Eingangsvariable, Byte vollständig

		   DISPL_COUNT  : in  std_logic; --Eingangsvariable, Folgeszustand oder Bytezaehler anzeigen

 		   CLK	      : in  std_logic; --Taktvariable
		   CLK_IO       : in  std_logic; --Tanktvariable,
		   						   --Ein- und Ausgangsregister
		   IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
		   RESET		 : in std_logic;   --1: Initialzustand annehmen
		   
		   DISPL1_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl1, binärzahl
		   DISPL2_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl2, binärzahl
		   DISPL1_n_SV  : out std_logic_vector (3 downto 0); --Folgezustand Zahl1, binärzahl
		   DISPL2_n_SV	 : out std_logic_vector (3 downto 0));  --Folgezustand Zahl2, binärzahl 


end CTRL_BYTE_CHECK;

architecture Behavioral of CTRL_BYTE_CHECK is

type TYPE_STATE is 
              (ST_BC_00, --Zustaende BYTE_CHECK
               ST_BC_01,
               ST_BC_02);

signal SV  : TYPE_STATE; --Zustandsvariable
signal n_SV: TYPE_STATE; --Zustandsvariable, neuer Wert
signal SV_M: TYPE_STATE; --Zustandsvariable, Ausgang Master


signal BYTE_COUNT   : std_logic_vector (7 downto 0); -- Vektor, Bytenummer, 8bit
signal n_BYTE_COUNT : std_logic_vector (7 downto 0); -- Vektor, Bytenummer, 8bit, neuer Wert
signal BYTE_COUNT_M : std_logic_vector (7 downto 0); -- Vektor, Bytenummer, 8bit, Ausgang Master

signal NEXT_BYTE_S : std_logic; --Eingangsvariable, zwischengespeichert im Eingangsregister
signal BYTE_CMPLT_S : std_logic; --Eingangsvariable, zwischengespeichert im Eingangsregister
signal PARITY_OK_S : std_logic; --Eingangsvariable, zwischengespeichert im Eingangsregister

signal LONG_STATE_SV   : std_logic_vector (7 downto 0); -- aktueller Zustand in 8 Bit, binär
signal LONG_STATE_n_SV : std_logic_vector (7 downto 0); -- Folgezustand in 8 Bit, binär

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

IREG_PROC: process (BYTE_CMPLT, not_CLK_IO) --Eingangsregister
begin
 if (not_CLK_IO'event and not_CLK_IO = '1') --Eingangsregister
   then NEXT_BYTE_S <= NEXT_BYTE;
        BYTE_CMPLT_S <= BYTE_CMPLT;
        PARITY_OK_S <= PARITY_OK;
end if;
end process;

SREG_M_PROC: process (RESET, n_SV, CLK) --Master
begin
  if (RESET ='1')
   then SV_M    <= ST_BC_00;	
   else
     if (CLK'event and CLK = '1')
	 then
	   if (IN_NEXT_STATE = '1')
	    then SV_M    <= n_SV;
            BYTE_COUNT_M <= n_BYTE_COUNT;
	    else SV_M    <= SV_M;
            BYTE_COUNT_M <= BYTE_COUNT_M;
        end if;
	end if;
  end if;
end process;

SREG_S_PROC: process (RESET, SV_M, not_CLK) --Slave
begin
  if (RESET = '1')
   then SV    <= ST_BC_00;
   else
     if (not_CLK'event and not_CLK = '1')
	 then SV    <= SV_M;
         BYTE_COUNT <= BYTE_COUNT_M;
     end if;
   end if;
end process;

BYTE_CHECK_PROC:process (NEXT_BYTE_S, BYTE_CMPLT_S, PARITY_OK_S, SV, BYTE_COUNT) --Bytes zählen und prüfen
begin
 case SV is
  when ST_BC_00 =>
   if (NEXT_BYTE_S = '1')
    then
     -- BC01
     BYTE_OK <= '0';
     n_BYTE_COUNT <= BYTE_COUNT; --bleibt gleich
     n_SV <= ST_BC_01; --Zustandsübergang
    else
     -- BC00
     BYTE_OK <= '0';
     n_BYTE_COUNT <= x"00"; --wird Null (hex)
     n_SV <= ST_BC_00; --kein Zustandsübergang
   end if;
  
  when ST_BC_01 =>
   if (BYTE_CMPLT_S = '1')
    then
     --BC02
     BYTE_OK <= '0';
     n_BYTE_COUNT <= BYTE_COUNT; --bleibt gleich
     n_SV <= ST_BC_02; --Zustandsübergang
    else
     -- BC01
     BYTE_OK <= '0';
     n_BYTE_COUNT <= BYTE_COUNT; --bleibt gleich 
     n_SV <= ST_BC_01; --kein Zustandsübergang
   end if;

  when ST_BC_02 =>
   if (PARITY_OK_S = '1')
    then
     --BC03
     BYTE_OK <= '1';
     n_BYTE_COUNT <= BYTE_COUNT+1; --wird erhoeht
     n_SV <= ST_BC_00; --Zustandsübergang
    else
     -- BC00
     BYTE_OK <= '0';
     n_BYTE_COUNT <= x"00"; --wird Null (hex) 
     n_SV <= ST_BC_00; --Zustandsübergang
   end if;
  
  when others =>
   -- BC00
   BYTE_OK <= '0';
   n_BYTE_COUNT <= x"00"; --wird Null (hex) 
   n_SV <= ST_BC_00; --Zustandsübergang
 end case;
end process;

BYTE_NUM_PROC:process (BYTE_COUNT) --Ausgabe BYTE_NUM aus BYTE_COUNT
begin
 BYTE_NUM <= BYTE_COUNT;
end process;

STATE_DISPL_PROC: process (SV, n_SV, DISPL_COUNT, LONG_STATE_SV, LONG_STATE_n_SV, BYTE_COUNT) -- Zustandsanzeige
 begin
  LONG_STATE_SV   <= conv_std_logic_vector(TYPE_STATE'pos(  SV),8); --Zustandsumwandlung in 8 Bit
  LONG_STATE_n_SV <= conv_std_logic_vector(TYPE_STATE'pos(n_SV),8);
  --anktuellen Zustand anzeigen   
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

   else  --BYTEzaehler anzeigen 
    DISPL1_n_SV(0) <= BYTE_COUNT(0);
    DISPL1_n_SV(1) <= BYTE_COUNT(1);
    DISPL1_n_SV(2) <= BYTE_COUNT(2);
    DISPL1_n_SV(3) <= BYTE_COUNT(3);
    
    DISPL2_n_SV(0) <= BYTE_COUNT(4);
    DISPL2_n_SV(1) <= BYTE_COUNT(5);
    DISPL2_n_SV(2) <= BYTE_COUNT(6);
    DISPL2_n_SV(3) <= BYTE_COUNT(7);
  end if;
 end process;

	   
end Behavioral;
