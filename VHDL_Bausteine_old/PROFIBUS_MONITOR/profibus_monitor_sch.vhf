--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 6.3.03i
--  \   \         Application : 
--  /   /         Filename : profibus_monitor_sch.vhf
-- /___/   /\     Timestamp : 04/12/2013 17:21:50
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: profibus_monitor_sch
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
-- synopsys translate_off
library UNISIM;
use UNISIM.Vcomponents.ALL;
-- synopsys translate_on

entity profibus_monitor_sch is
   port ( CHOSE_VALUE   : in    std_logic; 
          DISPL_COUNT   : in    std_logic; 
          ERROR_CTRL    : in    std_logic; 
          F_50MHZ_T9    : in    std_logic; 
          InAB_R12      : in    std_logic; 
          RST_BTN0_L14  : in    std_logic; 
          RUN_BTN2_L13  : in    std_logic; 
          STEP_BTN1_M14 : in    std_logic; 
          TELEGRAM_RUN  : in    std_logic; 
          TELEGRAM_STOP : in    std_logic; 
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
          KNOWN_T       : out   std_logic; 
          NO_ED         : out   std_logic; 
          PARITY_FAIL   : out   std_logic; 
          READY         : out   std_logic; 
          TXD_R13       : out   std_logic; 
          T_END         : out   std_logic; 
          T_LENGTH      : out   std_logic_vector (7 downto 0); 
          T_TYPE        : out   std_logic_vector (3 downto 0); 
          UNKNOWN_B     : out   std_logic; 
          WORKING       : out   std_logic; 
          XLXN_571      : out   std_logic_vector (3 downto 0); 
          XLXN_572      : out   std_logic_vector (3 downto 0); 
          XLXN_573      : out   std_logic_vector (3 downto 0); 
          XLXN_574      : out   std_logic_vector (3 downto 0));
end profibus_monitor_sch;

architecture BEHAVIORAL of profibus_monitor_sch is
   attribute BOX_TYPE   : string ;
   signal BYTE_CMPLT    : std_logic;
   signal XLXN_8        : std_logic;
   signal XLXN_9        : std_logic;
   signal XLXN_10       : std_logic;
   signal XLXN_11       : std_logic;
   signal XLXN_47       : std_logic;
   signal XLXN_60       : std_logic_vector (8 downto 0);
   signal XLXN_61       : std_logic;
   signal XLXN_64       : std_logic;
   signal XLXN_469      : std_logic_vector (7 downto 0);
   signal XLXN_494      : std_logic;
   signal XLXN_496      : std_logic;
   signal XLXN_546      : std_logic_vector (3 downto 0);
   signal XLXN_547      : std_logic_vector (3 downto 0);
   signal XLXN_548      : std_logic_vector (3 downto 0);
   signal XLXN_549      : std_logic_vector (3 downto 0);
   signal XLXN_569      : std_logic;
   signal XLXN_570      : std_logic;
   component f_div50000
      port ( F_IN  : in    std_logic; 
             F_OUT : out   std_logic);
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
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
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
   
   component ctrl_bit_register
      port ( BIT_VALUE     : in    std_logic; 
             CLK           : in    std_logic; 
             IN_NEXT_STATE : in    std_logic; 
             RESET         : in    std_logic; 
             EN_BIT_i      : in    std_logic_vector (8 downto 0); 
             PARITY_OK     : out   std_logic; 
             BYTE_OUT      : out   std_logic_vector (7 downto 0));
   end component;
   
   component ctrl_rs232_tx_vhdl
      port ( SEND          : in    std_logic; 
             CLK           : in    std_logic; 
             IN_NEXT_STATE : in    std_logic; 
             RESET         : in    std_logic; 
             SEND_BYTE     : in    std_logic_vector (7 downto 0); 
             TX            : out   std_logic; 
             READY         : out   std_logic);
   end component;
   
   component ctrl_inab_input_vhdl
      port ( InAB          : in    std_logic; 
             CHOSE_VALUE   : in    std_logic; 
             CLK           : in    std_logic; 
             IN_NEXT_STATE : in    std_logic; 
             RESET         : in    std_logic; 
             BIT_VALUE     : out   std_logic; 
             BYTE_CMPLT    : out   std_logic; 
             PAUSE_END     : out   std_logic; 
             EN_BIT_i      : out   std_logic_vector (8 downto 0); 
             DISPL1_SV     : out   std_logic_vector (3 downto 0); 
             DISPL2_SV     : out   std_logic_vector (3 downto 0); 
             DISPL1_n_SV   : out   std_logic_vector (3 downto 0); 
             DISPL2_n_SV   : out   std_logic_vector (3 downto 0));
   end component;
   
   component ctrl_telegram_check
      port ( TELEGRAM_RUN  : in    std_logic; 
             PARITY_OK     : in    std_logic; 
             BYTE_CMPLT    : in    std_logic; 
             PAUSE_END     : in    std_logic; 
             TELEGRAM_STOP : in    std_logic; 
             ERROR_CTRL    : in    std_logic; 
             CLK           : in    std_logic; 
             IN_NEXT_STATE : in    std_logic; 
             RESET         : in    std_logic; 
             DISPL_COUNT   : in    std_logic; 
             BYTE_IN       : in    std_logic_vector (7 downto 0); 
             T_END         : out   std_logic; 
             SEND_OUT      : out   std_logic; 
             PARITY_FAIL   : out   std_logic; 
             NO_ED         : out   std_logic; 
             WORKING       : out   std_logic; 
             KNOWN_T       : out   std_logic; 
             UNKNOWN_BYTE  : out   std_logic; 
             T_LENGTH      : out   std_logic_vector (7 downto 0); 
             T_TYPE        : out   std_logic_vector (3 downto 0); 
             DISPL1_SV     : out   std_logic_vector (3 downto 0); 
             DISPL2_SV     : out   std_logic_vector (3 downto 0); 
             DISPL1_n_SV   : out   std_logic_vector (3 downto 0); 
             DISPL2_n_SV   : out   std_logic_vector (3 downto 0));
   end component;
   
begin
   XLXI_2 : f_div50000
      port map (F_IN=>F_50MHZ_T9,      
                F_OUT=>XLXN_570);
   
   XLXI_3 : nib4_7seg_src
      port map (CLK_DISPL=>XLXN_570,      
                NIB0(3 downto 0)=>XLXN_549(3 downto 0),      
                NIB1(3 downto 0)=>XLXN_548(3 downto 0),      
                NIB2(3 downto 0)=>XLXN_547(3 downto 0),      
                NIB3(3 downto 0)=>XLXN_546(3 downto 0),      
                BA=>BA_E14,      
                BB=>BB_G13,      
                BC=>BC_N15,      
                BD=>BD_P15,      
                BE=>BE_R16,      
                BF=>BF_F13,      
                BG=>BG_N16,      
                ZI0=>XLXN_8,      
                ZI1=>XLXN_9,      
                ZI2=>XLXN_10,      
                ZI3=>XLXN_11);
   
   XLXI_4 : INV
      port map (I=>XLXN_8,      
                O=>AN0_D14);
   
   XLXI_5 : INV
      port map (I=>XLXN_9,      
                O=>AN1_G14);
   
   XLXI_6 : INV
      port map (I=>XLXN_10,      
                O=>AN2_F14);
   
   XLXI_7 : INV
      port map (I=>XLXN_11,      
                O=>AN3_E13);
   
   XLXI_15 : clock_single_run_src
      port map (CLK=>F_50MHZ_T9,      
                RESET=>RST_BTN0_L14,      
                RUN_R=>RUN_BTN2_L13,      
                SINGLE=>XLXN_47,      
                OUT_NEXT_STATE=>XLXN_64);
   
   XLXI_16 : deb_50mz_100ms_src
      port map (F_50MHZ=>F_50MHZ_T9,      
                IN_DEB=>STEP_BTN1_M14,      
                OUT_DEB=>XLXN_47);
   
   XLXI_17 : ctrl_bit_register
      port map (BIT_VALUE=>XLXN_61,      
                CLK=>F_50MHZ_T9,      
                EN_BIT_i(8 downto 0)=>XLXN_60(8 downto 0),      
                IN_NEXT_STATE=>XLXN_64,      
                RESET=>RST_BTN0_L14,      
                BYTE_OUT(7 downto 0)=>XLXN_469(7 downto 0),      
                PARITY_OK=>XLXN_494);
   
   XLXI_20 : ctrl_rs232_tx_vhdl
      port map (CLK=>F_50MHZ_T9,      
                IN_NEXT_STATE=>XLXN_64,      
                RESET=>RST_BTN0_L14,      
                SEND=>XLXN_569,      
                SEND_BYTE(7 downto 0)=>XLXN_469(7 downto 0),      
                READY=>READY,      
                TX=>TXD_R13);
   
   XLXI_21 : ctrl_inab_input_vhdl
      port map (CHOSE_VALUE=>CHOSE_VALUE,      
                CLK=>F_50MHZ_T9,      
                InAB=>InAB_R12,      
                IN_NEXT_STATE=>XLXN_64,      
                RESET=>RST_BTN0_L14,      
                BIT_VALUE=>XLXN_61,      
                BYTE_CMPLT=>BYTE_CMPLT,      
                DISPL1_n_SV(3 downto 0)=>XLXN_573(3 downto 0),      
                DISPL1_SV(3 downto 0)=>XLXN_571(3 downto 0),      
                DISPL2_n_SV(3 downto 0)=>XLXN_574(3 downto 0),      
                DISPL2_SV(3 downto 0)=>XLXN_572(3 downto 0),      
                EN_BIT_i(8 downto 0)=>XLXN_60(8 downto 0),      
                PAUSE_END=>XLXN_496);
   
   XLXI_22 : ctrl_telegram_check
      port map (BYTE_CMPLT=>BYTE_CMPLT,      
                BYTE_IN(7 downto 0)=>XLXN_469(7 downto 0),      
                CLK=>F_50MHZ_T9,      
                DISPL_COUNT=>DISPL_COUNT,      
                ERROR_CTRL=>ERROR_CTRL,      
                IN_NEXT_STATE=>XLXN_64,      
                PARITY_OK=>XLXN_494,      
                PAUSE_END=>XLXN_496,      
                RESET=>RST_BTN0_L14,      
                TELEGRAM_RUN=>TELEGRAM_RUN,      
                TELEGRAM_STOP=>TELEGRAM_STOP,      
                DISPL1_n_SV(3 downto 0)=>XLXN_547(3 downto 0),      
                DISPL1_SV(3 downto 0)=>XLXN_549(3 downto 0),      
                DISPL2_n_SV(3 downto 0)=>XLXN_546(3 downto 0),      
                DISPL2_SV(3 downto 0)=>XLXN_548(3 downto 0),      
                KNOWN_T=>KNOWN_T,      
                NO_ED=>NO_ED,      
                PARITY_FAIL=>PARITY_FAIL,      
                SEND_OUT=>XLXN_569,      
                T_END=>T_END,      
                T_LENGTH(7 downto 0)=>T_LENGTH(7 downto 0),      
                T_TYPE(3 downto 0)=>T_TYPE(3 downto 0),      
                UNKNOWN_BYTE=>UNKNOWN_B,      
                WORKING=>WORKING);
   
end BEHAVIORAL;


