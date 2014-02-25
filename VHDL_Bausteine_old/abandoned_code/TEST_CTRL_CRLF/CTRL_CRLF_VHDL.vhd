-- CTRL_CRLF
-- Carriage Return Line Fed bei Telegrammende in den zu sendenen Datenstrom einfügen
-- Projekt: PROFIBUS MONITOR
-- Ersteller: Martin Harndt
-- Erstellt: 10.01.2013
-- Bearbeiter: mharndt
-- Geaendert: 10.01.2013 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CTRL_CRLF_VHDL is
    Port(BYTE_IN : in std_logic_vector (7 downto 0); --Eingangsvariable, zu Daten Input, 8 bit
         BYTE_OK : in std_logic; --Eingangsvariable, Byte OK
         T_CMPLT : in std_logic; --Eingangsvariabel, Telegramm vollständig
         BYTE_SEND : out std_logic_vector (7 downto 0); --Ausgangsvariable, zu sendene Daten, 8 bit

         CLK	      : in  std_logic; --Taktvariable
		   CLK_IO       : in  std_logic; --Tanktvariable,
		   						   --Ein- und Ausgangsregister
		   IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
		   RESET		 : in std_logic;   --1: Initialzustand annehmen

         DISPL1_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl1, binärzahl
		   DISPL2_SV    : out std_logic_vector (3 downto 0); --aktueller Zustand Zahl2, binärzahl
		   DISPL1_n_SV  : out std_logic_vector (3 downto 0); --Folgezustand Zahl1, binärzahl
		   DISPL2_n_SV	 : out std_logic_vector (3 downto 0));  --Folgezustand Zahl2, binärzahl 
         
end CTRL_CRLF_VHDL;

architecture Behavioral of CTRL_CRLF_VHDL is

type TYPE_STATE is 
              (ST_CRLF_00, --Zustaende CTRL_CRLF
               ST_CRLF_01,
               ST_CRLF_02,
               ST_CRLF_03);

signal SV  : TYPE_STATE; --Zustandsvariable
signal n_SV: TYPE_STATE; --Zustandsvariable, neuer Wert
signal SV_M: TYPE_STATE; --Zustandsvariable, Ausgang Master

signal not_CLK   : std_logic; --negierte Taktvariable
signal not_CLK_IO: std_logic; --negierte Taktvariable
						--Ein- und Ausgangsregister

signal STATE_SV   : std_logic_vector (7 downto 0); -- aktueller Zustand in 8 Bit, binär
signal STATE_n_SV : std_logic_vector (7 downto 0); -- Folgezustand in 8 Bit, binär

signal BYTE_IN_S : std_logic_vector (7 downto 0); --Eingangsvariable, Zwischengespeichern im Eingangsregister
signal BYTE_OK_S :   std_logic; --Eingangsvariable, Zwischengespeichern im Eingangsregister
signal T_CMPLT_S :   std_logic; --Eingangsvariabel, Zwischengespeichern im Eingangsregister


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
        BYTE_OK_S <= BYTE_OK;
        T_CMPLT_S <= T_CMPLT;
end if;
end process;

SREG_M_PROC: process (RESET, n_SV, CLK) --Master
begin
  if (RESET ='1')
   then SV_M    <= ST_CRLF_00;	
   else
    if (CLK'event and CLK = '1')
	  then
	   if (IN_NEXT_STATE = '1')
	    then SV_M    <= n_SV;
	    else SV_M    <= SV_M;
      end if;
	 end if;
  end if;
end process;

SREG_S_PROC: process (RESET, SV_M, not_CLK) --Slave
begin
  if (RESET = '1')
   then SV    <= ST_CRLF_00;
   else
     if (not_CLK'event and not_CLK = '1')
	   then SV    <= SV_M;
     end if;
  end if;
end process;

CTRL_CRLF_PROC:process (BYTE_IN_S, BYTE_OK_S, T_CMPLT_S, SV) --Wenn Byte ok dann Output=Input, wenn Byte ok und Telegramm komplett dann OUTPUT=CRLF
begin
 case SV is
  when ST_CRLF_00 =>
   if (BYTE_OK_S = '1')
    then
     --CR01
     BYTE_SEND <= BYTE_IN_S; --Output=Input
     n_sv <= ST_CRLF_01; --Zustandsübergang
    else
     --CR00
     BYTE_SEND <= BYTE_IN_S; --Output=Input
     n_sv <= ST_CRLF_00; --bleibt im Zustand
   end if;
  
  when ST_CRLF_01 =>
   if (T_CMPLT_S = '1')
    then
     --CR02
     BYTE_SEND <= x"0D"; --Carriage Return
     n_SV <= ST_CRLF_02; --Zustandsübergang
    else
     --CR01
     BYTE_SEND <= BYTE_IN_S; --Output=Input
     n_sv <= ST_CRLF_01; --Zustandsübergang
   end if;

  when ST_CRLF_02 =>
     --CR03
     BYTE_SEND <= x"0A"; --Line Feed
     n_SV <= ST_CRLF_00; --Zustandsübergang

    when others =>
   -- CR00
   BYTE_SEND <= BYTE_IN_S; --Output=Input
   n_SV <= ST_CRLF_00; --Zustandsübergang
 end case;
end process;

STATE_DISPL_PROC: process (SV, n_SV, STATE_SV, STATE_n_SV) -- Zustandsanzeige
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

end Behavioral;
