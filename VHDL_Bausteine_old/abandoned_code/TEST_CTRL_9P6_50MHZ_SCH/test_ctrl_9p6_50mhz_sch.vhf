--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 6.3.03i
--  \   \         Application : 
--  /   /         Filename : test_ctrl_9p6_50mhz_sch.vhf
-- /___/   /\     Timestamp : 12/19/2012 16:39:51
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: test_ctrl_9p6_50mhz_sch
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
-- synopsys translate_off
library UNISIM;
use UNISIM.Vcomponents.ALL;
-- synopsys translate_on

entity test_ctrl_9p6_50mhz_sch is
   port ( BC_SW5_J13    : in    std_logic; 
          CV_SW0_F12    : in    std_logic; 
          DC_SW1_G12    : in    std_logic; 
          DC_SW2_H14    : in    std_logic; 
          F_50MHZ_T9    : in    std_logic; 
          InAB_SW7_K13  : in    std_logic; 
          NB_SW6_14     : in    std_logic; 
          PO_SW4_J14    : in    std_logic; 
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
          BO_LD6_P12    : out   std_logic; 
          BYTE_NUM      : out   std_logic_vector (7 downto 0); 
          BYTE_OUT      : out   std_logic_vector (7 downto 0));
end test_ctrl_9p6_50mhz_sch;

architecture BEHAVIORAL of test_ctrl_9p6_50mhz_sch is
   attribute BOX_TYPE   : string ;
   signal XLXN_3        : std_logic;
   signal XLXN_5        : std_logic;
   signal XLXN_21       : std_logic;
   signal XLXN_22       : std_logic;
   signal XLXN_25       : std_logic;
   signal XLXN_26       : std_logic;
   signal XLXN_46       : std_logic_vector (3 downto 0);
   signal XLXN_47       : std_logic_vector (3 downto 0);
   signal XLXN_48       : std_logic_vector (3 downto 0);
   signal XLXN_49       : std_logic_vector (3 downto 0);
   signal XLXN_122      : std_logic;
   component ctrl_9p6_50mhz_vhdl
      port ( InAB               : in    std_logic; 
             CHOSE_VALUE        : in    std_logic; 
             DISPL_COUNT        : in    std_logic; 
             DISPL_COUNT_SWITCH : in    std_logic; 
             BYTE_CMPLT         : in    std_logic; 
             PARITY_OK          : in    std_logic; 
             NEXT_BYTE          : in    std_logic; 
             CLK                : in    std_logic; 
             CLK_IO             : in    std_logic; 
             IN_NEXT_STATE      : in    std_logic; 
             RESET              : in    std_logic; 
             BYTE_OK            : out   std_logic; 
             BYTE_OUT           : out   std_logic_vector (7 downto 0); 
             BYTE_NUM           : out   std_logic_vector (7 downto 0); 
             DISPL1_SV          : out   std_logic_vector (3 downto 0); 
             DISPL2_SV          : out   std_logic_vector (3 downto 0); 
             DISPL1_n_SV        : out   std_logic_vector (3 downto 0); 
             DISPL2_n_SV        : out   std_logic_vector (3 downto 0));
   end component;
   
   component clock_single_run_src
      port ( CLK            : in    std_logic; 
             SINGLE         : in    std_logic; 
             RUN_R          : in    std_logic; 
             RESET          : in    std_logic; 
             OUT_NEXT_STATE : out   std_logic);
   end component;
   
   component deb_50mz_100ms_src
      port ( IN_DEB  : in    std_logic; 
             F_50MHZ : in    std_logic; 
             OUT_DEB : out   std_logic);
   end component;
   
   component f_div50000
      port ( F_IN  : in    std_logic; 
             F_OUT : out   std_logic);
   end component;
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
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
   
begin
   XLXI_1 : ctrl_9p6_50mhz_vhdl
      port map (BYTE_CMPLT=>BC_SW5_J13,      
                CHOSE_VALUE=>CV_SW0_F12,      
                CLK=>F_50MHZ_T9,      
                CLK_IO=>F_50MHZ_T9,      
                DISPL_COUNT=>DC_SW1_G12,      
                DISPL_COUNT_SWITCH=>DC_SW2_H14,      
                InAB=>InAB_SW7_K13,      
                IN_NEXT_STATE=>XLXN_5,      
                NEXT_BYTE=>NB_SW6_14,      
                PARITY_OK=>PO_SW4_J14,      
                RESET=>RST_BTN3_L14,      
                BYTE_NUM(7 downto 0)=>BYTE_NUM(7 downto 0),      
                BYTE_OK=>BO_LD6_P12,      
                BYTE_OUT(7 downto 0)=>BYTE_OUT(7 downto 0),      
                DISPL1_n_SV(3 downto 0)=>XLXN_46(3 downto 0),      
                DISPL1_SV(3 downto 0)=>XLXN_48(3 downto 0),      
                DISPL2_n_SV(3 downto 0)=>XLXN_47(3 downto 0),      
                DISPL2_SV(3 downto 0)=>XLXN_49(3 downto 0));
   
   XLXI_2 : clock_single_run_src
      port map (CLK=>F_50MHZ_T9,      
                RESET=>RST_BTN3_L14,      
                RUN_R=>RUN_BTN2_L13,      
                SINGLE=>XLXN_3,      
                OUT_NEXT_STATE=>XLXN_5);
   
   XLXI_3 : deb_50mz_100ms_src
      port map (F_50MHZ=>F_50MHZ_T9,      
                IN_DEB=>STEP_BTN1_M14,      
                OUT_DEB=>XLXN_3);
   
   XLXI_4 : f_div50000
      port map (F_IN=>F_50MHZ_T9,      
                F_OUT=>XLXN_122);
   
   XLXI_6 : INV
      port map (I=>XLXN_21,      
                O=>AN0_D14);
   
   XLXI_7 : INV
      port map (I=>XLXN_22,      
                O=>AN1_G14);
   
   XLXI_8 : INV
      port map (I=>XLXN_25,      
                O=>AN2_F14);
   
   XLXI_9 : INV
      port map (I=>XLXN_26,      
                O=>AN3_E13);
   
   XLXI_10 : nib4_7seg_src
      port map (CLK_DISPL=>XLXN_122,      
                NIB0(3 downto 0)=>XLXN_46(3 downto 0),      
                NIB1(3 downto 0)=>XLXN_47(3 downto 0),      
                NIB2(3 downto 0)=>XLXN_48(3 downto 0),      
                NIB3(3 downto 0)=>XLXN_49(3 downto 0),      
                BA=>BA_E14,      
                BB=>BB_G13,      
                BC=>BC_N15,      
                BD=>BD_P15,      
                BE=>BE_R16,      
                BF=>BF_F13,      
                BG=>BG_N16,      
                ZI0=>XLXN_21,      
                ZI1=>XLXN_22,      
                ZI2=>XLXN_25,      
                ZI3=>XLXN_26);
   
end BEHAVIORAL;


