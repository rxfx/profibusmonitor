VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_1
        SIGNAL XLXN_2(3:0)
        SIGNAL XLXN_3(3:0)
        SIGNAL XLXN_4(3:0)
        SIGNAL XLXN_5(3:0)
        SIGNAL XLXN_6
        SIGNAL XLXN_7
        SIGNAL XLXN_8
        SIGNAL XLXN_9
        SIGNAL F_50MHZ_T9
        SIGNAL XLXN_11
        SIGNAL RUN_BTN2_L13
        SIGNAL RST_BTN0_L14
        SIGNAL FILTER_ON_SW7_K13
        SIGNAL DISPL_COUNT_SW6_K14
        SIGNAL XLXN_16
        SIGNAL BYTE_IN(7:0)
        SIGNAL FILTER_T(2:0)
        SIGNAL SEND_OUT
        SIGNAL T_CMPLT
        SIGNAL FILTER_OUT(7:0)
        SIGNAL BA_E14
        SIGNAL BB_G13
        SIGNAL BC_N15
        SIGNAL BD_P15
        SIGNAL BE_R16
        SIGNAL BF_F13
        SIGNAL BG_N16
        SIGNAL XLXN_29
        SIGNAL XLXN_30
        SIGNAL XLXN_31
        SIGNAL XLXN_32
        SIGNAL AN0_D14
        SIGNAL AN1_G14
        SIGNAL AN2_F14
        SIGNAL AN3_E13
        SIGNAL STEP_BTN1_M14
        PORT Input F_50MHZ_T9
        PORT Input RUN_BTN2_L13
        PORT Input RST_BTN0_L14
        PORT Input FILTER_ON_SW7_K13
        PORT Input DISPL_COUNT_SW6_K14
        PORT Input BYTE_IN(7:0)
        PORT Input FILTER_T(2:0)
        PORT Output SEND_OUT
        PORT Output T_CMPLT
        PORT Output FILTER_OUT(7:0)
        PORT Output BA_E14
        PORT Output BB_G13
        PORT Output BC_N15
        PORT Output BD_P15
        PORT Output BE_R16
        PORT Output BF_F13
        PORT Output BG_N16
        PORT Output AN0_D14
        PORT Output AN1_G14
        PORT Output AN2_F14
        PORT Output AN3_E13
        PORT Input STEP_BTN1_M14
        BEGIN BLOCKDEF ctrl_telegram_filter_vhdl
            TIMESTAMP 2013 1 23 12 37 43
            RECTANGLE N 64 -448 400 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 400 -416 464 -416 
            LINE N 400 -352 464 -352 
            LINE N 400 -288 464 -288 
            RECTANGLE N 400 -300 464 -276 
            LINE N 400 -224 464 -224 
            RECTANGLE N 400 -236 464 -212 
            LINE N 400 -160 464 -160 
            RECTANGLE N 400 -172 464 -148 
            LINE N 400 -96 464 -96 
            RECTANGLE N 400 -108 464 -84 
            LINE N 400 -32 464 -32 
            RECTANGLE N 400 -44 464 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2013 1 23 12 37 56
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
        BEGIN BLOCKDEF f_div50000
            TIMESTAMP 2013 1 23 12 37 52
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF clock_single_run_src
            TIMESTAMP 2013 1 23 12 37 40
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2013 1 23 12 37 48
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
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
        BEGIN BLOCK XLXI_1 ctrl_telegram_filter_vhdl
            PIN FILTER_ON FILTER_ON_SW7_K13
            PIN DISPL_COUNT DISPL_COUNT_SW6_K14
            PIN CLK F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_1
            PIN RESET RST_BTN0_L14
            PIN BYTE_IN(7:0) BYTE_IN(7:0)
            PIN FILTER_T(2:0) FILTER_T(2:0)
            PIN SEND_OUT SEND_OUT
            PIN T_CMPLT T_CMPLT
            PIN FILTER_BYTE_OUT(7:0) FILTER_OUT(7:0)
            PIN DISPL1_SV(3:0) XLXN_5(3:0)
            PIN DISPL2_SV(3:0) XLXN_4(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_3(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_2(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_2 nib4_7seg_src
            PIN CLK_DISPL XLXN_6
            PIN NIB0(3:0) XLXN_5(3:0)
            PIN NIB1(3:0) XLXN_4(3:0)
            PIN NIB2(3:0) XLXN_3(3:0)
            PIN NIB3(3:0) XLXN_2(3:0)
            PIN ZI0 XLXN_29
            PIN ZI1 XLXN_30
            PIN ZI2 XLXN_31
            PIN ZI3 XLXN_32
            PIN BA BA_E14
            PIN BB BB_G13
            PIN BC BC_N15
            PIN BD BD_P15
            PIN BE BE_R16
            PIN BF BF_F13
            PIN BG BG_N16
        END BLOCK
        BEGIN BLOCK XLXI_3 f_div50000
            PIN F_IN F_50MHZ_T9
            PIN F_OUT XLXN_6
        END BLOCK
        BEGIN BLOCK XLXI_4 clock_single_run_src
            PIN CLK F_50MHZ_T9
            PIN SINGLE XLXN_7
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN0_L14
            PIN OUT_NEXT_STATE XLXN_1
        END BLOCK
        BEGIN BLOCK XLXI_5 deb_50mz_100ms_src
            PIN IN_DEB STEP_BTN1_M14
            PIN F_50MHZ F_50MHZ_T9
            PIN OUT_DEB XLXN_7
        END BLOCK
        BEGIN BLOCK XLXI_6 inv
            PIN I XLXN_29
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I XLXN_30
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_8 inv
            PIN I XLXN_31
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_9 inv
            PIN I XLXN_32
            PIN O AN3_E13
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_1 1872 1088 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_2 2640 1088 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_4 960 896 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_5 432 832 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1
            WIRE 1344 672 1376 672
            WIRE 1376 672 1376 864
            WIRE 1376 864 1872 864
        END BRANCH
        BEGIN BRANCH XLXN_2(3:0)
            WIRE 2336 1056 2640 1056
        END BRANCH
        BEGIN BRANCH XLXN_3(3:0)
            WIRE 2336 992 2624 992
            WIRE 2624 896 2640 896
            WIRE 2624 896 2624 992
        END BRANCH
        BEGIN BRANCH XLXN_4(3:0)
            WIRE 2336 928 2608 928
            WIRE 2608 736 2640 736
            WIRE 2608 736 2608 928
        END BRANCH
        BEGIN BRANCH XLXN_5(3:0)
            WIRE 2336 864 2592 864
            WIRE 2592 576 2640 576
            WIRE 2592 576 2592 864
        END BRANCH
        BEGIN BRANCH XLXN_6
            WIRE 2288 416 2640 416
        END BRANCH
        BEGIN INSTANCE XLXI_3 1904 448 R0
        END INSTANCE
        BEGIN BRANCH XLXN_7
            WIRE 816 736 960 736
        END BRANCH
        IOMARKER 176 416 F_50MHZ_T9 R180 28
        BEGIN BRANCH F_50MHZ_T9
            WIRE 176 416 352 416
            WIRE 352 416 896 416
            WIRE 896 416 896 672
            WIRE 896 672 960 672
            WIRE 896 416 1440 416
            WIRE 1440 416 1904 416
            WIRE 1440 416 1440 800
            WIRE 1440 800 1872 800
            WIRE 352 416 352 800
            WIRE 352 800 432 800
        END BRANCH
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 224 944 848 944
            WIRE 848 800 848 944
            WIRE 848 800 960 800
        END BRANCH
        BEGIN BRANCH RST_BTN0_L14
            WIRE 224 1056 912 1056
            WIRE 912 1056 1264 1056
            WIRE 912 864 960 864
            WIRE 912 864 912 1056
            WIRE 1264 928 1264 1056
            WIRE 1264 928 1872 928
        END BRANCH
        BEGIN BRANCH FILTER_ON_SW7_K13
            WIRE 1840 672 1872 672
        END BRANCH
        IOMARKER 1840 672 FILTER_ON_SW7_K13 R180 28
        BEGIN BRANCH DISPL_COUNT_SW6_K14
            WIRE 1840 736 1872 736
        END BRANCH
        IOMARKER 1840 736 DISPL_COUNT_SW6_K14 R180 28
        BEGIN BRANCH BYTE_IN(7:0)
            WIRE 1840 992 1872 992
        END BRANCH
        IOMARKER 1840 992 BYTE_IN(7:0) R180 28
        BEGIN BRANCH FILTER_T(2:0)
            WIRE 1840 1056 1872 1056
        END BRANCH
        IOMARKER 1840 1056 FILTER_T(2:0) R180 28
        BEGIN BRANCH SEND_OUT
            WIRE 2336 672 2368 672
        END BRANCH
        IOMARKER 2368 672 SEND_OUT R0 28
        BEGIN BRANCH T_CMPLT
            WIRE 2336 736 2368 736
        END BRANCH
        IOMARKER 2368 736 T_CMPLT R0 28
        BEGIN BRANCH FILTER_OUT(7:0)
            WIRE 2336 800 2368 800
        END BRANCH
        IOMARKER 2368 800 FILTER_OUT(7:0) R0 28
        BEGIN BRANCH BA_E14
            WIRE 3024 672 3056 672
        END BRANCH
        IOMARKER 3056 672 BA_E14 R0 28
        BEGIN BRANCH BB_G13
            WIRE 3024 736 3056 736
        END BRANCH
        IOMARKER 3056 736 BB_G13 R0 28
        BEGIN BRANCH BC_N15
            WIRE 3024 800 3056 800
        END BRANCH
        IOMARKER 3056 800 BC_N15 R0 28
        BEGIN BRANCH BD_P15
            WIRE 3024 864 3056 864
        END BRANCH
        IOMARKER 3056 864 BD_P15 R0 28
        BEGIN BRANCH BE_R16
            WIRE 3024 928 3056 928
        END BRANCH
        IOMARKER 3056 928 BE_R16 R0 28
        BEGIN BRANCH BF_F13
            WIRE 3024 992 3056 992
        END BRANCH
        IOMARKER 3056 992 BF_F13 R0 28
        BEGIN BRANCH BG_N16
            WIRE 3024 1056 3056 1056
        END BRANCH
        IOMARKER 3056 1056 BG_N16 R0 28
        INSTANCE XLXI_6 3040 448 R0
        INSTANCE XLXI_7 3040 512 R0
        INSTANCE XLXI_8 3040 576 R0
        INSTANCE XLXI_9 3040 640 R0
        BEGIN BRANCH XLXN_29
            WIRE 3024 416 3040 416
        END BRANCH
        BEGIN BRANCH XLXN_30
            WIRE 3024 480 3040 480
        END BRANCH
        BEGIN BRANCH XLXN_31
            WIRE 3024 544 3040 544
        END BRANCH
        BEGIN BRANCH XLXN_32
            WIRE 3024 608 3040 608
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3264 416 3296 416
        END BRANCH
        IOMARKER 3296 416 AN0_D14 R0 28
        BEGIN BRANCH AN1_G14
            WIRE 3264 480 3296 480
        END BRANCH
        IOMARKER 3296 480 AN1_G14 R0 28
        BEGIN BRANCH AN2_F14
            WIRE 3264 544 3296 544
        END BRANCH
        IOMARKER 3296 544 AN2_F14 R0 28
        BEGIN BRANCH AN3_E13
            WIRE 3264 608 3296 608
        END BRANCH
        IOMARKER 3296 608 AN3_E13 R0 28
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 240 736 416 736
            WIRE 416 736 432 736
        END BRANCH
        IOMARKER 240 736 STEP_BTN1_M14 R180 28
        IOMARKER 224 944 RUN_BTN2_L13 R180 28
        IOMARKER 224 1056 RST_BTN0_L14 R180 28
    END SHEET
END SCHEMATIC
