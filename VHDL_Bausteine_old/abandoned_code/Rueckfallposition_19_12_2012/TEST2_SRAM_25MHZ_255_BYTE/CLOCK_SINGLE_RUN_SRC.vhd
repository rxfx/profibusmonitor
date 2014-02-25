library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLOCK_SINGLE_RUN_SRC is
    Port ( CLK:            in std_logic;   -- (System) Takt
           SINGLE:         in std_logic;   -- 1: Einzeltakt
           RUN_R:          in std_logic;   -- 1: Dauerbetrieb
                                       --        mit Eingangsregister
           RESET:          in std_logic;   -- 1: Initialzustand soll angenommen werden
           OUT_NEXT_STATE: out std_logic); -- 1: nächster Zustand

end CLOCK_SINGLE_RUN_SRC;

architecture Behavioral of CLOCK_SINGLE_RUN_SRC is
 type TYPE_STATE is (CSR_0, CSR_1, CSR_2); -- Zustände
 
 signal SV:   TYPE_STATE; --Zustangsvariable
 signal n_SV: TYPE_STATE; --Zustangsvariable, neuer Wert
 signal SV_M: TYPE_STATE; --Zustangsvariable, Ausgang Master
 
 signal RUN_S: std_logic;
 signal not_CLK : std_logic;
 
begin
 
 NOT_CLK_PROC: process (CLK)
 begin
  not_CLK <= not CLK;
 end process;

 IREG_PROC: process (RUN_R, not_CLK)
 begin
  if (not_CLK'event and not_CLK = '1')
   then RUN_S <= RUN_R;
  end if;
 end process;

 IL_OL_PROC: process (SINGLE, RUN_S, SV)
 begin
  case SV is
   when CSR_0  =>
        if  (SINGLE = '1')
	    then OUT_NEXT_STATE <= '1'; n_SV <= CSR_2;
	    else
	         if (RUN_S = '1') 
		     then OUT_NEXT_STATE <= '1'; n_SV <= CSR_1; 
        		else OUT_NEXT_STATE <= '0'; n_SV <= CSR_0;
		    end if;
	   end if;
   when CSR_1  => OUT_NEXT_STATE <= '0';
        if  (SINGLE = '1')
	    then OUT_NEXT_STATE <= '0'; n_SV <= CSR_2;
	    else OUT_NEXT_STATE <= '1'; n_SV <= CSR_1; 
	   end if;
   when CSR_2  => OUT_NEXT_STATE <= '1';
        if  (SINGLE = '1')
	    then OUT_NEXT_STATE <= '0'; n_SV <= CSR_2;
	    else OUT_NEXT_STATE <= '0'; n_SV <= CSR_0; 
	   end if;
   when others => OUT_NEXT_STATE <= '0';
  end case;
 end process;

 SREG_M_PROC: process (RESET, n_SV, CLK) -- Master
 begin
  if(RESET = '1')
   then SV_M <= CSR_0;
   else
        if (CLK'event and CLK = '1')
	    then SV_M <= n_SV;
	   end if;
  end if;
 end process;

 SREG_S_PROC: process (RESET, SV_M, not_CLK) -- Slave
 begin
  if(RESET = '1')
   then SV <= CSR_0;
   else
        if (not_CLK'event and not_CLK = '1')
	    then SV <= SV_M;
	   end if;
  end if;
 end process;

end Behavioral;
