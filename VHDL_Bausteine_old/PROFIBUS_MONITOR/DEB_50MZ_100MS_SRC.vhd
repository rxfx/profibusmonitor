library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--Enprelleinheit
--entprellt bei 50 MHZ etw mit 100 ms

entity DEB_50MZ_100MS_SRC is
    Port ( IN_DEB : in std_logic;
           F_50MHZ : in std_logic;
           OUT_DEB : out std_logic);
end DEB_50MZ_100MS_SRC;

architecture Behavioral of DEB_50MZ_100MS_SRC is

type    SV_TYPE is (DEB0, DEB1);
 signal SV, n_SV, SV_M : SV_TYPE;
 signal COUNT_DEB, n_COUNT_DEB, COUNT_DEB_M:  std_logic_vector (23 downto 0);
 signal NOT_F_50MHZ    : std_logic;
 signal IN_DEB_S       : std_logic;
 
 constant CONST_DEB_max:  std_logic_vector := x"4C4B40"; 

begin
 
 IREG_PROC: process (IN_DEB, NOT_F_50MHZ)
 begin
  if (NOT_F_50MHZ'event and NOT_F_50MHZ = '1')
   then IN_DEB_S <= IN_DEB;
  end if;
 end process;

 SREG_M_PROC: process (F_50MHZ, n_SV, n_COUNT_DEB, SV_M)
 begin
  if (F_50MHZ'event and F_50MHZ = '1')
   then
    SV_M        <= n_SV;
    COUNT_DEB_M <= n_COUNT_DEB;
   else
    COUNT_DEB_M <= COUNT_DEB_M;
  end if;
 end process;

 NOT_F_50MHZ_PROC: process (F_50MHZ)
 begin
   NOT_F_50MHZ <= not F_50MHZ;
 end process;

 SREG_S_PROC: process (NOT_F_50MHZ, SV_M, COUNT_DEB_M)
 begin
  if (NOT_F_50MHZ'event and NOT_F_50MHZ = '1')
  then
   SV        <= SV_M;
   COUNT_DEB <= COUNT_DEB_M;
  end if;
 end process;

 IL_OL_PROC: process (IN_DEB_S, SV, COUNT_DEB)
 begin
  case SV is
   when DEB0 =>
    if (IN_DEB_S = '1')
    then
     if COUNT_DEB >= CONST_DEB_max
     then
      OUT_DEB <= '0';
      n_COUNT_DEB <= x"000000";
      n_SV <= DEB1;
     else
      OUT_DEB <= '0';
      n_COUNT_DEB <= COUNT_DEB+1;
      n_SV <= DEB0;
     end if;
    else
     if COUNT_DEB = x"000000"
     then
      OUT_DEB <= '0';
      n_COUNT_DEB <= COUNT_DEB;
      n_SV <= DEB0;
     else
      OUT_DEB <= '0';
      n_COUNT_DEB <= COUNT_DEB-1;
      n_SV <= DEB0;
     end if;
    end if;
   
   when DEB1 =>
    if (IN_DEB_S = '1')
    then
     if COUNT_DEB >= CONST_DEB_max
     then
      OUT_DEB <= '1';
      n_COUNT_DEB <= COUNT_DEB;
      n_SV <= DEB1;
     else
      OUT_DEB <= '1';
      n_COUNT_DEB <= COUNT_DEB+1;
      n_SV <= DEB1;
     end if;
    else
     if COUNT_DEB = x"000000"
     then
      OUT_DEB <= '1';
      n_COUNT_DEB <= COUNT_DEB;
      n_SV <= DEB0;
     else
      OUT_DEB <= '1';
      n_COUNT_DEB <= COUNT_DEB-1;
      n_SV <= DEB1;
     end if;
    end if;
   when Others =>
    OUT_DEB <= '0';
    n_COUNT_DEB <= x"000000";
    n_SV <= DEB0;
  end case;
 end process;
end Behavioral;
