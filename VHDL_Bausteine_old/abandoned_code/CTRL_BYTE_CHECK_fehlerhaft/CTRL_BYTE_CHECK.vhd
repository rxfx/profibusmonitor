-- CTRL_BYTE_CHECK
-- Bytes zählen und prüfen
-- Projekt: PROFIBUS MONITOR
-- Ersteller: Martin Harndt
-- Erstellt: 19.12.2012
-- Bearbeiter: mharndt
-- Geaendert: 18.01.2013 

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

 		   CLK	      : in  std_logic; --Taktvariable
		   IN_NEXT_STATE: in std_logic;  --1:Zustandsuebergang möglich
		   RESET		 : in std_logic);   --1: Initialzustand annehmen


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

signal not_CLK   : std_logic; --negierte Taktvariable

begin

NOT_CLK_PROC: process (CLK) --negieren Taktvariable
begin
  not_CLK <= not CLK;
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

BYTE_CHECK_PROC:process (NEXT_BYTE, BYTE_CMPLT, PARITY_OK, SV, BYTE_COUNT) --Bytes zählen und prüfen
begin
 case SV is
  when ST_BC_00 =>
   if (NEXT_BYTE = '1')
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
   if (BYTE_CMPLT = '1')
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
   if (PARITY_OK = '1')
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
	   
end Behavioral;
