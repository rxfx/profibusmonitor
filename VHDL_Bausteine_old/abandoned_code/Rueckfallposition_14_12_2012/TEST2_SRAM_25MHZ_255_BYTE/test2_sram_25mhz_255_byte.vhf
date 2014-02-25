--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 6.3.03i
--  \   \         Application : 
--  /   /         Filename : test2_sram_25mhz_255_byte.vhf
-- /___/   /\     Timestamp : 12/07/2012 17:15:50
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: test2_sram_25mhz_255_byte
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
-- synopsys translate_off
library UNISIM;
use UNISIM.Vcomponents.ALL;
-- synopsys translate_on

entity test2_sram_25mhz_255_byte is
   port ( F_50MHZ_T9    : in    std_logic; 
          GO_SW7_K13    : in    std_logic; 
          RST_BTN3_L14  : in    std_logic; 
          RUN_BTN2_L13  : in    std_logic; 
          STEP_BTN1_M14 : in    std_logic; 
          AN0_D14       : out   std_logic; 
          AN1_G14       : out   std_logic; 
          AN2_F14       : out   std_logic; 
          AN3_E13       : out   std_logic; 
          BA_E14        : out   std_logic; 
          BB_G13        : out   std_logic; 
          BC_N15        : out   std_logic; 
          BD_P15        : out   std_logic; 
          BE_R16        : out   std_logic; 
          BF_F13        : out   std_logic; 
          BG_N16        : out   std_logic; 
          CE1_P7        : out   std_logic; 
          COUNT_ADR     : out   std_logic_vector (18 downto 0); 
          COUNT_DAT     : out   std_logic_vector (15 downto 0); 
          LB1_P6        : out   std_logic; 
          OE_K4         : out   std_logic; 
          STOP_LD0_K12  : out   std_logic; 
          UB1_T4        : out   std_logic; 
          WE_G3         : out   std_logic);
end test2_sram_25mhz_255_byte;

architecture BEHAVIORAL of test2_sram_25mhz_255_byte is
   attribute INIT       : string ;
   attribute BOX_TYPE   : string ;
   signal XLXN_2        : std_logic;
   signal XLXN_33       : std_logic;
   signal XLXN_34       : std_logic;
   signal XLXN_35       : std_logic;
   signal XLXN_65       : std_logic;
   signal XLXN_66       : std_logic_vector (3 downto 0);
   signal XLXN_67       : std_logic_vector (3 downto 0);
   signal XLXN_68       : std_logic_vector (3 downto 0);
   signal XLXN_69       : std_logic_vector (3 downto 0);
   signal XLXN_70       : std_logic;
   signal XLXN_71       : std_logic;
   signal XLXN_72       : std_logic;
   signal XLXN_73       : std_logic;
   component sram_25mhz_255_byte
      port ( GO            : in    std_logic; 
             CLK           : in    std_logic; 
             CLK_IO        : in    std_logic; 
             IN_NEXT_STATE : in    std_logic; 
             RESET         : in    std_logic; 
             WE            : out   std_logic; 
             OE            : out   std_logic; 
             CE1           : out   std_logic; 
             UB1           : out   std_logic; 
             LB1           : out   std_logic; 
             STOP          : out   std_logic; 
             COUNT_ADR_OUT : out   std_logic_vector (18 downto 0); 
             COUNT_DAT_OUT : out   std_logic_vector (15 downto 0); 
             DISPL1_SV     : out   std_logic_vector (3 downto 0); 
             DISPL2_SV     : out   std_logic_vector (3 downto 0); 
             DISPL1_n_SV   : out   std_logic_vector (3 downto 0); 
             DISPL2_n_SV   : out   std_logic_vector (3 downto 0));
   end component;
   
   component FD
      -- synopsys translate_off
      generic( INIT : bit :=  '0');
      -- synopsys translate_on
      port ( C : in    std_logic; 
             D : in    std_logic; 
             Q : out   std_logic);
   end component;
   attribute INIT of FD : component is "0";
   attribute BOX_TYPE of FD : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component deb_50mz_100ms_src
      port ( OUT_DEB : out   std_logic; 
             F_50MHZ : in    std_logic; 
             IN_DEB  : in    std_logic);
   end component;
   
   component clock_single_run_src
      port ( CLK            : in    std_logic; 
             SINGLE         : in    std_logic; 
             RUN_R          : in    std_logic; 
             RESET          : in    std_logic; 
             OUT_NEXT_STATE : out   std_logic);
   end component;
   
   component nib4_7seg_src
      port ( CLK_DISPL : in    std_logic; 
             NIB0      : in    std_logic_vector (3 downto 0); 
             NIB1      : in    std_logic_vector (3 downto 0); 
             NIB2      : in    std_logic_vector (3 downto 0); 
             NIB3      : in    std_logic_vector (3 downto 0); 
             ZI0       : out   std_logic; 
             ZI1       : out   std_logic; 
             ZI2       : out   std_logic; 
             ZI3       : out   std_logic; 
             BA        : out   std_logic; 
             BB        : out   std_logic; 
             BC        : out   std_logic; 
             BD        : out   std_logic; 
             BE        : out   std_logic; 
             BF        : out   std_logic; 
             BG        : out   std_logic);
   end component;
   
   component f_div50000
      port ( F_IN  : in    std_logic; 
             F_OUT : out   std_logic);
   end component;
   
begin
   XLXI_1 : sram_25mhz_255_byte
      port map (CLK=>XLXN_34,      
                CLK_IO=>XLXN_34,      
                GO=>GO_SW7_K13,      
                IN_NEXT_STATE=>XLXN_35,      
                RESET=>RST_BTN3_L14,      
                CE1=>CE1_P7,      
                COUNT_ADR_OUT(18 downto 0)=>COUNT_ADR(18 downto 0),      
                COUNT_DAT_OUT(15 downto 0)=>COUNT_DAT(15 downto 0),      
                DISPL1_n_SV(3 downto 0)=>XLXN_68(3 downto 0),      
                DISPL1_SV(3 downto 0)=>XLXN_66(3 downto 0),      
                DISPL2_n_SV(3 downto 0)=>XLXN_69(3 downto 0),      
                DISPL2_SV(3 downto 0)=>XLXN_67(3 downto 0),      
                LB1=>LB1_P6,      
                OE=>OE_K4,      
                STOP=>STOP_LD0_K12,      
                UB1=>UB1_T4,      
                WE=>WE_G3);
   
   XLXI_2 : FD
      port map (C=>F_50MHZ_T9,      
                D=>XLXN_2,      
                Q=>XLXN_34);
   
   XLXI_3 : INV
      port map (I=>XLXN_34,      
                O=>XLXN_2);
   
   XLXI_21 : deb_50mz_100ms_src
      port map (F_50MHZ=>XLXN_34,      
                IN_DEB=>STEP_BTN1_M14,      
                OUT_DEB=>XLXN_33);
   
   XLXI_22 : clock_single_run_src
      port map (CLK=>XLXN_34,      
                RESET=>RST_BTN3_L14,      
                RUN_R=>RUN_BTN2_L13,      
                SINGLE=>XLXN_33,      
                OUT_NEXT_STATE=>XLXN_35);
   
   XLXI_23 : nib4_7seg_src
      port map (CLK_DISPL=>XLXN_65,      
                NIB0(3 downto 0)=>XLXN_66(3 downto 0),      
                NIB1(3 downto 0)=>XLXN_67(3 downto 0),      
                NIB2(3 downto 0)=>XLXN_68(3 downto 0),      
                NIB3(3 downto 0)=>XLXN_69(3 downto 0),      
                BA=>BA_E14,      
                BB=>BB_G13,      
                BC=>BC_N15,      
                BD=>BD_P15,      
                BE=>BE_R16,      
                BF=>BF_F13,      
                BG=>BG_N16,      
                ZI0=>XLXN_70,      
                ZI1=>XLXN_71,      
                ZI2=>XLXN_72,      
                ZI3=>XLXN_73);
   
   XLXI_30 : f_div50000
      port map (F_IN=>XLXN_34,      
                F_OUT=>XLXN_65);
   
   XLXI_31 : INV
      port map (I=>XLXN_70,      
                O=>AN0_D14);
   
   XLXI_32 : INV
      port map (I=>XLXN_71,      
                O=>AN1_G14);
   
   XLXI_33 : INV
      port map (I=>XLXN_72,      
                O=>AN2_F14);
   
   XLXI_34 : INV
      port map (I=>XLXN_73,      
                O=>AN3_E13);
   
end BEHAVIORAL;


