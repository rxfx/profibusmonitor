-- SRAM_25MHZ_255_BYTE
-- beschreibt/liest den SRAM des Spartan 3
-- Ersteller: Martin Harndt
-- Erstellt: 30.11.2012
-- Bearbeiter: mharndt
-- Geaendert: 07.12.2012 


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRAM_25MHZ_255_BYTE is
    Port ( GO : in std_logic;
           COUNT_ADR_OUT : out std_logic_vector(18 downto 0); --Ausgabe Adresse, 19 Byte
           COUNT_DAT_OUT : out std_logic_vector(15 downto 0); --Ausgabe gespeicherte Daten, 16 Byte
           WE : out std_logic; -- Write Enable
           OE : out std_logic; -- Output Enable
           CE1 : out std_logic; --Chip Enable
           UB1 : out std_logic; --Upper Byte Enable
           LB1 : out std_logic; --Lower Byte Enable
           STOP : out std_logic; -- zum Anzeigen von STOP
		     CLK	: in  std_logic; --Taktvariable
		     CLK_IO : in  std_logic; --Tanktvariable,
		                             --Ein- und Ausgangsregister
		     IN_NEXT_STATE : in std_logic;  --1:Zustandsuebergang möglich
		     RESET : in std_logic;  --1: Initialzustand annehmen
		     DISPL1_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl1, binärzahl
		     DISPL2_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl2, binärzahl
		     DISPL1_n_SV  : out std_logic_vector (3 downto 0); --Folgezustand Zahl1, binärzahl
		     DISPL2_n_SV	 : out std_logic_vector (3 downto 0));  --Folgezustand Zahl2, binärzahl 
end SRAM_25MHZ_255_BYTE;

architecture Behavioral of SRAM_25MHZ_255_BYTE is

type TYPE_STATE is 
       (ST_RAM_00, --Zustaende
		  ST_RAM_01,
		  ST_RAM_02,
		  ST_RAM_03,
		  ST_RAM_04,
		  ST_RAM_05);

signal SV  : TYPE_STATE; --Zustandsvariable
signal n_SV: TYPE_STATE; --Zustandsvariable, neuer Wert
signal SV_M: TYPE_STATE; --Zustandsvariable, Ausgang Master

signal not_CLK   : std_logic; --negierte Taktvariable
signal not_CLK_IO: std_logic; --negierte Taktvariable
						            --Ein- und Ausgangsregister
signal GO_S    : std_logic; --Eingangsvariable
					             --Zwischengespeichert im Eingangsregister

signal COUNT_ADR : std_logic_vector(18 downto 0); --Adresszaehler, Vektor, 19 bit
signal n_COUNT_ADR : std_logic_vector(18 downto 0); --Adresszaehler, neuer Wert, Vektor, 19 bit
signal COUNT_ADR_M : std_logic_vector(18 downto 0); --Adresszaehler, Ausgang Master, Vektor, 19 bit

signal COUNT_DAT : std_logic_vector(15 downto 0); --Datenzaehler, Vektor, 15 bit
signal n_COUNT_DAT : std_logic_vector(15 downto 0); --Datenzaehler, neuer Wert, Vektor, 15 bit
signal COUNT_DAT_M : std_logic_vector(15 downto 0); --Datenzaehler, Ausgang Master, Vektor, 15 bit

signal DISPL_STATE_SV   : std_logic_vector (7 downto 0); -- aktueller Zustand in 8 Bit, binär
signal DISPL_STATE_n_SV : std_logic_vector (7 downto 0); -- Folgezustand in 8 Bit, binär

begin

NOT_CLK_PROC: process (CLK) --negieren Taktvariable
begin
 not_CLK <= not CLK;
end process;

NOT_CLK_IO_PROC: process (CLK_IO) --negieren Taktvaraiable, Ein- und Ausgangsregister
begin
 not_CLK_IO <= not CLK_IO;
end process;

IREG_PROC: process (GO, GO_S, not_CLK_IO) --Eingangsregister
begin
 if (not_CLK_IO'event and not_CLK_IO = '1') --Eingangsregister
  then GO_S <= GO;
end if;
end process;

SREG_M_PROC: process (RESET, n_SV, CLK) --Master
begin
 if (RESET ='1')
  then SV_M    <= ST_RAM_00;	
  else
   if (CLK'event and CLK = '1')
    then
     if (IN_NEXT_STATE = '1')
      then SV_M    <= n_SV;
	 	 COUNT_ADR_M <= n_COUNT_ADR;
		 COUNT_DAT_M <= n_COUNT_DAT;
      else SV_M    <= SV_M;
	 	 COUNT_ADR_M <= COUNT_ADR_M;
		 COUNT_DAT_M <= COUNT_DAT_M;
     end if;
   end if;
 end if;
end process;

SREG_S_PROC: process (RESET, SV_M, not_CLK) --Slave
begin
 if (RESET = '1')
  then SV    <= ST_RAM_00;
  else
   if (not_CLK'event and not_CLK = '1')
    then SV    <= SV_M;
    	    COUNT_ADR <= COUNT_ADR_M;
	    COUNT_DAT <= COUNT_DAT_M;
   end if;
 end if;
end process;

IL_OL_PROC: process (GO_S, SV, COUNT_ADR, COUNT_DAT)
begin
 UB1 <= '0'; --Upper Byte Ein (0=Ein 1=Aus)
 LB1 <= '0'; --Lower Byte Ein (0=Ein 1=Aus)
 case SV is
  when ST_RAM_00 =>	 
   if (GO_S = '1')
    then
     -- RAM01
     n_COUNT_ADR <= b"0000000000000000000"; -- Adress Zaehler Neustart
     n_COUNT_DAT <= b"1111111111111111"; -- Daten Zaehler Neustart
     WE <= '1'; --Aus (0=Ein 1=Aus)
     OE <= '1'; --Aus (0=Ein 1=Aus)
     CE1 <= '1'; --Aus (0=Ein 1=Aus)
     STOP <= '0'; -- Aus(0=Aus 1=Ein)
     n_SV <= ST_RAM_01; -- Zustandsuebgergang
    else
     --RAM00
     n_COUNT_ADR <= b"0000000000000000000"; -- Adress Zaehler Neustart
     n_COUNT_DAT <= b"1111111111111111"; -- Daten Zaehler Neustart
     WE <= '1'; --Aus
     OE <= '1'; --Aus
     CE1 <= '0'; --Ein
     STOP <= '0'; --Aus
     n_SV <= ST_RAM_00; -- GO = '0'
   end if;

  when ST_RAM_01 =>	 
   -- RAM02
   n_COUNT_ADR <= COUNT_ADR; -- Wert bleibt gleich
   n_COUNT_DAT <= COUNT_DAT; -- Wert bleibt gleich
   WE <= '0'; --Ein
   OE <= '1'; --Aus
   CE1 <= '0'; --Ein
   STOP <= '0'; --Aus
   n_SV <= ST_RAM_02; -- Zustandsuebgergang

  when ST_RAM_02 =>	 
   if (COUNT_ADR = b"1111111111111111")
    then
     -- RAM05
     n_COUNT_ADR <= COUNT_ADR; -- Wert bleibt gleich 
     n_COUNT_DAT <= COUNT_DAT; -- Wert bleibt gleich
     WE <= '1'; --Aus (0=Ein 1=Aus)
     OE <= '1'; --Aus (0=Ein 1=Aus)
     CE1 <= '0'; --Ein (0=Ein 1=Aus)
     STOP <= '0'; -- Aus(0=Aus 1=Ein)
     n_SV <= ST_RAM_03; -- COUNT_ADR < FF
    else
     --RAM03
     n_COUNT_ADR <= COUNT_ADR+1; -- Adress Zaehler inkrementieren
     n_COUNT_DAT <= COUNT_DAT-1; -- Daten Zaehler dekrementieren
     WE <= '1'; --Aus
     OE <= '1'; --Aus
     CE1 <= '0'; --Ein
     STOP <= '0'; --Aus
     n_SV <= ST_RAM_04; -- COUNT_ADR = FF
   end if;

  when ST_RAM_03 =>	 
   if (GO_S = '0')
    then
     -- RAM06
     n_COUNT_ADR <= COUNT_ADR; -- Wert bleibt gleich 
     n_COUNT_DAT <= COUNT_DAT; -- Wert bleibt gleich
     WE <= '1'; --Aus (0=Ein 1=Aus)
     OE <= '1'; --Aus (0=Ein 1=Aus)
     CE1 <= '0'; --Ein (0=Ein 1=Aus)
     STOP <= '1'; -- Ein(0=Aus 1=Ein)
     n_SV <= ST_RAM_05; -- GO_S ='0'
    else
     --RAM05
     n_COUNT_ADR <= COUNT_ADR; -- Wert bleibt gleich 
     n_COUNT_DAT <= COUNT_DAT; -- Wert bleibt gleich 
     WE <= '1'; --Aus
     OE <= '1'; --Aus
     CE1 <= '0'; --Ein
     STOP <= '0'; --Aus
     n_SV <= ST_RAM_03; -- GO_S ='1'
   end if;

  when ST_RAM_04 =>	 
   -- RAM04
   n_COUNT_ADR <= COUNT_ADR; -- Wert bleibt gleich 
   n_COUNT_DAT <= COUNT_DAT; -- Wert bleibt gleich
   WE <= '1'; --Aus (0=Ein 1=Aus)
   OE <= '1'; --Aus (0=Ein 1=Aus)
   CE1 <= '0'; --Ein (0=Ein 1=Aus)
   STOP <= '0'; -- Aus(0=Aus 1=Ein)
   n_SV <= ST_RAM_01; -- Zustandsübergang

  when ST_RAM_05 =>	 
   if (GO_S = '0')
    then
     -- RAM08
     n_COUNT_ADR <= COUNT_ADR; -- Wert bleibt gleich 
     n_COUNT_DAT <= COUNT_DAT; -- Wert bleibt gleich
     WE <= '1'; --Aus (0=Ein 1=Aus)
     OE <= '0'; --Ein (0=Ein 1=Aus)
     CE1 <= '0'; --Ein (0=Ein 1=Aus)
     STOP <= '1'; -- Ein(0=Aus 1=Ein)
     n_SV <= ST_RAM_05; -- GO_S ='0'
    else
     --RAM07
     n_COUNT_ADR <= COUNT_ADR; -- Wert bleibt gleich 
     n_COUNT_DAT <= COUNT_DAT; -- Wert bleibt gleich 
     WE <= '1'; --Aus
     OE <= '0'; --Ein
     CE1 <= '0'; --Ein
     STOP <= '1'; --Ein
     n_SV <= ST_RAM_00; -- GO_S ='1'
   end if;

  when others => 
   -- RAM00
   n_COUNT_ADR <= b"0000000000000000000"; -- Adress Zaehler Neustart
   n_COUNT_DAT <= b"1111111111111111"; -- Daten Zaehler Neustart
   WE <= '1'; --Aus
   OE <= '1'; --Aus
   CE1 <= '1';	--Aus
   STOP <= '0'; --Aus
   n_SV <= ST_RAM_00;
 end case;
end process;

ADR_DAT_OUT_PROC: process (n_COUNT_ADR, n_COUNT_DAT) --Ausgabe Adresse und Daten
 begin
  --Adressen
  COUNT_ADR_OUT(0) <= n_COUNT_ADR(0);
  COUNT_ADR_OUT(1) <= n_COUNT_ADR(1);
  COUNT_ADR_OUT(2) <= n_COUNT_ADR(2);
  COUNT_ADR_OUT(3) <= n_COUNT_ADR(3);
  COUNT_ADR_OUT(4) <= n_COUNT_ADR(4);
  COUNT_ADR_OUT(5) <= n_COUNT_ADR(5);
  COUNT_ADR_OUT(6) <= n_COUNT_ADR(6);
  COUNT_ADR_OUT(7) <= n_COUNT_ADR(7);
  COUNT_ADR_OUT(8) <= n_COUNT_ADR(8);
  COUNT_ADR_OUT(9) <= n_COUNT_ADR(9);
  COUNT_ADR_OUT(10) <= n_COUNT_ADR(10);
  COUNT_ADR_OUT(11) <= n_COUNT_ADR(11);
  COUNT_ADR_OUT(12) <= n_COUNT_ADR(12);
  COUNT_ADR_OUT(13) <= n_COUNT_ADR(13);
  COUNT_ADR_OUT(14) <= n_COUNT_ADR(14);
  COUNT_ADR_OUT(15) <= n_COUNT_ADR(15);
  COUNT_ADR_OUT(16) <= n_COUNT_ADR(16);
  COUNT_ADR_OUT(17) <= n_COUNT_ADR(17);
  COUNT_ADR_OUT(18) <= n_COUNT_ADR(18);
  --Daten
  COUNT_DAT_OUT(0) <= n_COUNT_DAT(0);
  COUNT_DAT_OUT(1) <= n_COUNT_DAT(1);
  COUNT_DAT_OUT(2) <= n_COUNT_DAT(2);
  COUNT_DAT_OUT(3) <= n_COUNT_DAT(3);
  COUNT_DAT_OUT(4) <= n_COUNT_DAT(4);
  COUNT_DAT_OUT(5) <= n_COUNT_DAT(5);
  COUNT_DAT_OUT(6) <= n_COUNT_DAT(6);
  COUNT_DAT_OUT(7) <= n_COUNT_DAT(7);
  COUNT_DAT_OUT(8) <= n_COUNT_DAT(8);
  COUNT_DAT_OUT(9) <= n_COUNT_DAT(9);
  COUNT_DAT_OUT(10) <= n_COUNT_DAT(10);
  COUNT_DAT_OUT(11) <= n_COUNT_DAT(11);
  COUNT_DAT_OUT(12) <= n_COUNT_DAT(12);
  COUNT_DAT_OUT(13) <= n_COUNT_DAT(13);
  COUNT_DAT_OUT(14) <= n_COUNT_DAT(14);
  COUNT_DAT_OUT(15) <= n_COUNT_DAT(15);
end process;

STATE_DISPL_PROC: process (SV, n_SV, DISPL_STATE_SV, DISPL_STATE_n_SV) -- Zustandsanzeige
 begin
  DISPL_STATE_SV   <= conv_std_logic_vector(TYPE_STATE'pos(  SV),8); --Zustandsumwandlung in 8 Bit
  DISPL_STATE_n_SV <= conv_std_logic_vector(TYPE_STATE'pos(n_SV),8);
     
  DISPL1_SV(0) <= DISPL_STATE_SV(0); --Bit0
  DISPL1_SV(1) <= DISPL_STATE_SV(1); --Bit1
  DISPL1_SV(2) <= DISPL_STATE_SV(2); --Bit2
  DISPL1_SV(3) <= DISPL_STATE_SV(3); --Bit3

  DISPL2_SV(0) <= DISPL_STATE_SV(4); --usw.
  DISPL2_SV(1) <= DISPL_STATE_SV(5);
  DISPL2_SV(2) <= DISPL_STATE_SV(6);
  DISPL2_SV(3) <= DISPL_STATE_SV(7);

  --Folgezustand anzeigen
  DISPL1_n_SV(0)  <= DISPL_STATE_n_SV(0);
  DISPL1_n_SV(1)  <= DISPL_STATE_n_SV(1);
  DISPL1_n_SV(2)  <= DISPL_STATE_n_SV(2);
  DISPL1_n_SV(3)  <= DISPL_STATE_n_SV(3);
  
  DISPL2_n_SV(0)  <= DISPL_STATE_n_SV(4);
  DISPL2_n_SV(1)  <= DISPL_STATE_n_SV(5);
  DISPL2_n_SV(2)  <= DISPL_STATE_n_SV(6);
  DISPL2_n_SV(3)  <= DISPL_STATE_n_SV(7);
 end process;

end Behavioral;
