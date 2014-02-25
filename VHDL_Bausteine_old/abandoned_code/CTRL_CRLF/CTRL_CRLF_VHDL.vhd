-- CTRL_CRLF
-- Carriage Return Line Fed bei Telegrammende in den zu sendenen Datenstrom einfügen
-- Projekt: PROFIBUS MONITOR
-- Ersteller: Martin Harndt
-- Erstellt: 10.01.2013
-- Bearbeiter: mharndt
-- Geaendert: 24.01.2013 
-- Umstellung auf: rising_edge(CLK) und falling_edge(CLK) http://www.sigasi.com/content/clock-edge-detection

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
		   IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
		   RESET		 : in std_logic);   --1: Initialzustand annehmen
         
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

--signal not_CLK   : std_logic; --negierte Taktvariable

begin

--NOT_CLK_PROC: process (CLK) --negieren Taktvariable
--begin
--  not_CLK <= not CLK;
--end process;


SREG_M_PROC: process (RESET, n_SV, CLK) --Master
begin
  if (RESET ='1')
   then SV_M    <= ST_CRLF_00;	
   else
    if rising_edge(CLK)
	  then
	   if (IN_NEXT_STATE = '1')
	    then SV_M    <= n_SV;
	    else SV_M    <= SV_M;
      end if;
	 end if;
  end if;
end process;

SREG_S_PROC: process (RESET, SV_M, CLK) --Slave
begin
  if (RESET = '1')
   then SV    <= ST_CRLF_00;
   else
     if falling_edge(CLK)
	   then SV    <= SV_M;
     end if;
  end if;
end process;

CTRL_CRLF_PROC:process (BYTE_IN, BYTE_OK, T_CMPLT, SV) --Wenn Byte ok dann Output=Input, wenn Byte ok und Telegramm komplett dann OUTPUT=CRLF
begin
 case SV is
  when ST_CRLF_00 =>
   if (BYTE_OK = '1')
    then
     --CR01
     BYTE_SEND <= BYTE_IN; --Output=Input
     n_sv <= ST_CRLF_01; --Zustandsübergang
    else
     --CR00
     BYTE_SEND <= BYTE_IN; --Output=Input
     n_sv <= ST_CRLF_00; --bleibt im Zustand
   end if;
  
  when ST_CRLF_01 =>
   if (T_CMPLT = '1')
    then
     --CR02
     BYTE_SEND <= x"0D"; --Carriage Return
     n_SV <= ST_CRLF_02; --Zustandsübergang
    else
     --CR01
     BYTE_SEND <= BYTE_IN; --Output=Input
     n_sv <= ST_CRLF_01; --Zustandsübergang
   end if;

  when ST_CRLF_02 =>
     --CR03
     BYTE_SEND <= x"0A"; --Line Feed
     n_SV <= ST_CRLF_00; --Zustandsübergang

    when others =>
   -- CR00
   BYTE_SEND <= BYTE_IN; --Output=Input
   n_SV <= ST_CRLF_00; --Zustandsübergang
 end case;
end process;

end Behavioral;
