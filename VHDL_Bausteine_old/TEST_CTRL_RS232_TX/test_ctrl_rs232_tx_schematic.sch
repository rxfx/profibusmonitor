VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_1
        SIGNAL XLXN_3
        SIGNAL XLXN_4(3:0)
        SIGNAL XLXN_5(3:0)
        SIGNAL XLXN_6(3:0)
        SIGNAL XLXN_7(3:0)
        SIGNAL XLXN_8
        SIGNAL XLXN_9
        SIGNAL XLXN_10
        SIGNAL XLXN_11
        SIGNAL XLXN_12
        SIGNAL XLXN_13
        SIGNAL XLXN_14
        SIGNAL F_50MHZ_T9
        SIGNAL XLXN_16
        SIGNAL RST_BTN3_L14
        SIGNAL RUN_BTN2_L13
        SIGNAL STEP_BTN1_M14
        SIGNAL CV_SW6_K14
        SIGNAL DC_SW7_K13
        SIGNAL SEND_BYTE(7:0)
        SIGNAL SEND_SW5_J13
        SIGNAL TX_LD0_K12
        SIGNAL READY_LD7_P11
        SIGNAL AN0_D14
        SIGNAL AN1_G14
        SIGNAL AN2_F14
        SIGNAL AN3_E13
        SIGNAL BA_E14
        SIGNAL BB_G13
        SIGNAL BC_N15
        SIGNAL BD_P15
        SIGNAL BE_R16
        SIGNAL BF_F13
        SIGNAL BG_N16
        SIGNAL XLXN_52
        SIGNAL XLXN_55
        SIGNAL XLXN_57
        SIGNAL XLXN_58
        SIGNAL XLXN_61
        SIGNAL XLXN_60
        SIGNAL XLXN_2
        PORT Input F_50MHZ_T9
        PORT Input RST_BTN3_L14
        PORT Input RUN_BTN2_L13
        PORT Input STEP_BTN1_M14
        PORT Input CV_SW6_K14
        PORT Input DC_SW7_K13
        PORT Input SEND_BYTE(7:0)
        PORT Input SEND_SW5_J13
        PORT Output TX_LD0_K12
        PORT Output READY_LD7_P11
        PORT Output AN0_D14
        PORT Output AN1_G14
        PORT Output AN2_F14
        PORT Output AN3_E13
        PORT Output BA_E14
        PORT Output BB_G13
        PORT Output BC_N15
        PORT Output BD_P15
        PORT Output BE_R16
        PORT Output BF_F13
        PORT Output BG_N16
        BEGIN BLOCKDEF clock_single_run_src
            TIMESTAMP 2013 1 11 16 27 9
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF ctrl_rs232_tx_vhdl
            TIMESTAMP 2013 1 11 16 27 13
            RECTANGLE N 64 -512 416 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 416 -480 480 -480 
            LINE N 416 -400 480 -400 
            LINE N 416 -320 480 -320 
            RECTANGLE N 416 -332 480 -308 
            LINE N 416 -240 480 -240 
            RECTANGLE N 416 -252 480 -228 
            LINE N 416 -160 480 -160 
            RECTANGLE N 416 -172 480 -148 
            LINE N 416 -80 480 -80 
            RECTANGLE N 416 -92 480 -68 
        END BLOCKDEF
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2013 1 11 16 27 18
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF f_div50000
            TIMESTAMP 2013 1 11 16 27 21
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2013 1 11 16 27 26
            RECTANGLE N 64 -704 320 0 
            LINE N 64 -672 0 -672 
            LINE N 64 -512 0 -512 
            RECTANGLE N 0 -524 64 -500 
            LINE N 64 -352 0 -352 
            RECTANGLE N 0 -364 64 -340 
            LINE N 64 -192 0 -192 
            RECTANGLE N 0 -204 64 -180 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -672 384 -672 
            LINE N 320 -608 384 -608 
            LINE N 320 -544 384 -544 
            LINE N 320 -480 384 -480 
            LINE N 320 -416 384 -416 
            LINE N 320 -352 384 -352 
            LINE N 320 -288 384 -288 
            LINE N 320 -224 384 -224 
            LINE N 320 -160 384 -160 
            LINE N 320 -96 384 -96 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF inv
            TIMESTAMP 2001 2 2 12 38 38
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 clock_single_run_src
            PIN CLK F_50MHZ_T9
            PIN SINGLE XLXN_1
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN3_L14
            PIN OUT_NEXT_STATE XLXN_2
        END BLOCK
        BEGIN BLOCK XLXI_2 ctrl_rs232_tx_vhdl
            PIN SEND SEND_SW5_J13
            PIN CLK F_50MHZ_T9
            PIN CLK_IO F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_2
            PIN RESET RST_BTN3_L14
            PIN CHOSE_VALUE CV_SW6_K14
            PIN DISPL_COUNT DC_SW7_K13
            PIN SEND_BYTE(7:0) SEND_BYTE(7:0)
            PIN TX TX_LD0_K12
            PIN READY READY_LD7_P11
            PIN DISPL1_SV(3:0) XLXN_7(3:0)
            PIN DISPL2_SV(3:0) XLXN_6(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_5(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_4(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_3 deb_50mz_100ms_src
            PIN IN_DEB STEP_BTN1_M14
            PIN F_50MHZ F_50MHZ_T9
            PIN OUT_DEB XLXN_1
        END BLOCK
        BEGIN BLOCK XLXI_4 f_div50000
            PIN F_IN F_50MHZ_T9
            PIN F_OUT XLXN_3
        END BLOCK
        BEGIN BLOCK XLXI_5 nib4_7seg_src
            PIN CLK_DISPL XLXN_3
            PIN NIB0(3:0) XLXN_7(3:0)
            PIN NIB1(3:0) XLXN_6(3:0)
            PIN NIB2(3:0) XLXN_5(3:0)
            PIN NIB3(3:0) XLXN_4(3:0)
            PIN ZI0 XLXN_8
            PIN ZI1 XLXN_9
            PIN ZI2 XLXN_10
            PIN ZI3 XLXN_11
            PIN BA BA_E14
            PIN BB BB_G13
            PIN BC BC_N15
            PIN BD BD_P15
            PIN BE BE_R16
            PIN BF BF_F13
            PIN BG BG_N16
        END BLOCK
        BEGIN BLOCK XLXI_6 inv
            PIN I XLXN_8
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I XLXN_9
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_8 inv
            PIN I XLXN_10
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_9 inv
            PIN I XLXN_11
            PIN O AN3_E13
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_2 1664 1344 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_5 2544 1296 R0
        END INSTANCE
        BEGIN BRANCH XLXN_3
            WIRE 2144 624 2544 624
        END BRANCH
        BEGIN BRANCH XLXN_4(3:0)
            WIRE 2144 1264 2544 1264
        END BRANCH
        BEGIN BRANCH XLXN_5(3:0)
            WIRE 2144 1184 2528 1184
            WIRE 2528 1104 2544 1104
            WIRE 2528 1104 2528 1184
        END BRANCH
        BEGIN BRANCH XLXN_6(3:0)
            WIRE 2144 1104 2512 1104
            WIRE 2512 944 2544 944
            WIRE 2512 944 2512 1104
        END BRANCH
        BEGIN BRANCH XLXN_7(3:0)
            WIRE 2144 1024 2496 1024
            WIRE 2496 784 2544 784
            WIRE 2496 784 2496 1024
        END BRANCH
        INSTANCE XLXI_6 2944 656 R0
        INSTANCE XLXI_7 2944 720 R0
        INSTANCE XLXI_8 2944 784 R0
        INSTANCE XLXI_9 2944 848 R0
        BEGIN BRANCH XLXN_8
            WIRE 2928 624 2944 624
        END BRANCH
        BEGIN BRANCH XLXN_9
            WIRE 2928 688 2944 688
        END BRANCH
        BEGIN BRANCH XLXN_10
            WIRE 2928 752 2944 752
        END BRANCH
        BEGIN BRANCH XLXN_11
            WIRE 2928 816 2944 816
        END BRANCH
        BEGIN INSTANCE XLXI_4 1760 656 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1
            WIRE 736 944 864 944
        END BRANCH
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 560 1072 752 1072
            WIRE 752 1008 752 1072
            WIRE 752 1008 864 1008
        END BRANCH
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 256 944 352 944
        END BRANCH
        BEGIN BRANCH F_50MHZ_T9
            WIRE 208 624 288 624
            WIRE 288 624 288 1008
            WIRE 288 1008 352 1008
            WIRE 288 624 800 624
            WIRE 800 624 1312 624
            WIRE 1312 624 1312 928
            WIRE 1312 928 1312 992
            WIRE 1312 992 1664 992
            WIRE 1312 928 1664 928
            WIRE 1312 624 1760 624
            WIRE 800 624 800 880
            WIRE 800 880 864 880
        END BRANCH
        BEGIN BRANCH CV_SW6_K14
            WIRE 1632 1184 1664 1184
        END BRANCH
        IOMARKER 1632 1184 CV_SW6_K14 R180 28
        BEGIN BRANCH DC_SW7_K13
            WIRE 1632 1248 1664 1248
        END BRANCH
        IOMARKER 1632 1248 DC_SW7_K13 R180 28
        BEGIN BRANCH SEND_BYTE(7:0)
            WIRE 1632 1312 1664 1312
        END BRANCH
        IOMARKER 1632 1312 SEND_BYTE(7:0) R180 28
        IOMARKER 560 1072 RUN_BTN2_L13 R180 28
        BEGIN BRANCH SEND_SW5_J13
            WIRE 1632 864 1664 864
        END BRANCH
        IOMARKER 1632 864 SEND_SW5_J13 R180 28
        BEGIN BRANCH TX_LD0_K12
            WIRE 2144 864 2176 864
        END BRANCH
        IOMARKER 2176 864 TX_LD0_K12 R0 28
        BEGIN BRANCH READY_LD7_P11
            WIRE 2144 944 2176 944
        END BRANCH
        IOMARKER 2176 944 READY_LD7_P11 R0 28
        BEGIN BRANCH AN0_D14
            WIRE 3168 624 3200 624
        END BRANCH
        IOMARKER 3200 624 AN0_D14 R0 28
        BEGIN BRANCH AN1_G14
            WIRE 3168 688 3200 688
        END BRANCH
        IOMARKER 3200 688 AN1_G14 R0 28
        BEGIN BRANCH AN2_F14
            WIRE 3168 752 3200 752
        END BRANCH
        IOMARKER 3200 752 AN2_F14 R0 28
        BEGIN BRANCH AN3_E13
            WIRE 3168 816 3200 816
        END BRANCH
        IOMARKER 3200 816 AN3_E13 R0 28
        BEGIN BRANCH BA_E14
            WIRE 2928 880 2960 880
        END BRANCH
        IOMARKER 2960 880 BA_E14 R0 28
        BEGIN BRANCH BB_G13
            WIRE 2928 944 2960 944
        END BRANCH
        IOMARKER 2960 944 BB_G13 R0 28
        BEGIN BRANCH BC_N15
            WIRE 2928 1008 2960 1008
        END BRANCH
        IOMARKER 2960 1008 BC_N15 R0 28
        BEGIN BRANCH BD_P15
            WIRE 2928 1072 2960 1072
        END BRANCH
        IOMARKER 2960 1072 BD_P15 R0 28
        BEGIN BRANCH BE_R16
            WIRE 2928 1136 2960 1136
        END BRANCH
        IOMARKER 2960 1136 BE_R16 R0 28
        BEGIN BRANCH BF_F13
            WIRE 2928 1200 2960 1200
        END BRANCH
        IOMARKER 2960 1200 BF_F13 R0 28
        BEGIN BRANCH BG_N16
            WIRE 2928 1264 2960 1264
        END BRANCH
        IOMARKER 2960 1264 BG_N16 R0 28
        IOMARKER 208 624 F_50MHZ_T9 R180 28
        IOMARKER 256 944 STEP_BTN1_M14 R180 28
        BEGIN INSTANCE XLXI_3 352 1040 R0
        END INSTANCE
        IOMARKER 560 1120 RST_BTN3_L14 R180 28
        BEGIN BRANCH XLXN_2
            WIRE 1248 880 1264 880
            WIRE 1264 880 1264 1056
            WIRE 1264 1056 1664 1056
        END BRANCH
        BEGIN BRANCH RST_BTN3_L14
            WIRE 560 1120 768 1120
            WIRE 768 1120 1664 1120
            WIRE 768 1072 768 1120
            WIRE 768 1072 864 1072
        END BRANCH
        BEGIN INSTANCE XLXI_1 864 1104 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
