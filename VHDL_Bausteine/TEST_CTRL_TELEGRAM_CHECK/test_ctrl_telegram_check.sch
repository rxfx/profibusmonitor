VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_1
        SIGNAL XLXN_2
        SIGNAL XLXN_3
        SIGNAL XLXN_4
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
        SIGNAL XLXN_31
        SIGNAL RST_BTN3_L14
        SIGNAL STEP_BTN1_M14
        SIGNAL RUN_BTN2_L13
        SIGNAL XLXN_41
        SIGNAL F_50MHZ_T9
        SIGNAL NEXT_STATE
        SIGNAL XLXN_48(3:0)
        SIGNAL XLXN_49(3:0)
        SIGNAL XLXN_50(3:0)
        SIGNAL XLXN_51(3:0)
        SIGNAL TELEGRAM_RUN
        SIGNAL PARITY_OK
        SIGNAL BYTE_CMPLT
        SIGNAL PAUSE_END
        SIGNAL TELEGRAM_STOP
        SIGNAL ERROR_CTRL
        SIGNAL T_END
        SIGNAL SEND_OUT
        SIGNAL PARITY_FAIL
        SIGNAL NO_LED
        SIGNAL WORKING
        SIGNAL KNOWN_T
        SIGNAL UNKNOWN_BYTE
        SIGNAL T_LENGTH(7:0)
        SIGNAL T_TYPE(3:0)
        SIGNAL BYTE_IN(7:0)
        SIGNAL DISPL_COUNT
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
        PORT Input RST_BTN3_L14
        PORT Input STEP_BTN1_M14
        PORT Input RUN_BTN2_L13
        PORT Input F_50MHZ_T9
        PORT Output NEXT_STATE
        PORT Input TELEGRAM_RUN
        PORT Output T_END
        PORT Output SEND_OUT
        PORT Output PARITY_FAIL
        PORT Output NO_LED
        PORT Output WORKING
        PORT Output KNOWN_T
        PORT Output UNKNOWN_BYTE
        PORT Output T_LENGTH(7:0)
        PORT Output T_TYPE(3:0)
        PORT Input BYTE_IN(7:0)
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2013 1 28 18 1 39
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
            TIMESTAMP 2013 1 28 18 1 44
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF clock_single_run_src
            TIMESTAMP 2013 1 28 18 1 59
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2013 1 28 18 1 49
            RECTANGLE N 64 -128 320 0 
            LINE N 320 -96 384 -96 
            LINE N 64 -32 0 -32 
            LINE N 64 -96 0 -96 
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
        BEGIN BLOCKDEF ctrl_telegram_check
            TIMESTAMP 2013 1 28 18 42 52
            LINE N 64 864 0 864 
            LINE N 64 288 0 288 
            LINE N 64 352 0 352 
            LINE N 64 416 0 416 
            LINE N 64 480 0 480 
            LINE N 64 544 0 544 
            LINE N 64 608 0 608 
            LINE N 480 288 544 288 
            LINE N 480 352 544 352 
            LINE N 480 416 544 416 
            LINE N 480 480 544 480 
            LINE N 480 544 544 544 
            LINE N 480 608 544 608 
            LINE N 480 672 544 672 
            LINE N 480 736 544 736 
            RECTANGLE N 480 724 544 748 
            LINE N 480 800 544 800 
            RECTANGLE N 480 788 544 812 
            LINE N 64 32 0 32 
            RECTANGLE N 0 20 64 44 
            LINE N 64 -352 0 -352 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 480 -288 544 -288 
            RECTANGLE N 480 -300 544 -276 
            LINE N 480 -224 544 -224 
            RECTANGLE N 480 -236 544 -212 
            LINE N 480 -160 544 -160 
            RECTANGLE N 480 -172 544 -148 
            LINE N 480 -96 544 -96 
            RECTANGLE N 480 -108 544 -84 
            RECTANGLE N 64 -512 480 1024 
        END BLOCKDEF
        BEGIN BLOCKDEF vcc
            TIMESTAMP 2001 2 2 12 37 29
            LINE N 64 -32 64 -64 
            LINE N 64 0 64 -32 
            LINE N 96 -64 32 -64 
        END BLOCKDEF
        BEGIN BLOCK XLXI_2 nib4_7seg_src
            PIN CLK_DISPL XLXN_31
            PIN NIB0(3:0) XLXN_48(3:0)
            PIN NIB1(3:0) XLXN_49(3:0)
            PIN NIB2(3:0) XLXN_50(3:0)
            PIN NIB3(3:0) XLXN_51(3:0)
            PIN ZI0 XLXN_1
            PIN ZI1 XLXN_2
            PIN ZI2 XLXN_3
            PIN ZI3 XLXN_4
            PIN BA BA_E14
            PIN BB BB_G13
            PIN BC BC_N15
            PIN BD BD_P15
            PIN BE BE_R16
            PIN BF BF_F13
            PIN BG BG_N16
        END BLOCK
        BEGIN BLOCK XLXI_6 inv
            PIN I XLXN_1
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I XLXN_2
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_8 inv
            PIN I XLXN_3
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_9 inv
            PIN I XLXN_4
            PIN O AN3_E13
        END BLOCK
        BEGIN BLOCK XLXI_3 f_div50000
            PIN F_IN F_50MHZ_T9
            PIN F_OUT XLXN_31
        END BLOCK
        BEGIN BLOCK XLXI_4 clock_single_run_src
            PIN CLK F_50MHZ_T9
            PIN SINGLE XLXN_41
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN3_L14
            PIN OUT_NEXT_STATE NEXT_STATE
        END BLOCK
        BEGIN BLOCK XLXI_5 deb_50mz_100ms_src
            PIN IN_DEB STEP_BTN1_M14
            PIN F_50MHZ F_50MHZ_T9
            PIN OUT_DEB XLXN_41
        END BLOCK
        BEGIN BLOCK XLXI_10 ctrl_telegram_check
            PIN TELEGRAM_RUN TELEGRAM_RUN
            PIN PARITY_OK PARITY_OK
            PIN BYTE_CMPLT BYTE_CMPLT
            PIN PAUSE_END PAUSE_END
            PIN TELEGRAM_STOP TELEGRAM_STOP
            PIN ERROR_CTRL ERROR_CTRL
            PIN CLK F_50MHZ_T9
            PIN IN_NEXT_STATE NEXT_STATE
            PIN RESET RST_BTN3_L14
            PIN DISPL_COUNT DISPL_COUNT
            PIN BYTE_IN(7:0) BYTE_IN(7:0)
            PIN T_END T_END
            PIN SEND_OUT SEND_OUT
            PIN PARITY_FAIL PARITY_FAIL
            PIN NO_ED NO_LED
            PIN WORKING WORKING
            PIN KNOWN_T KNOWN_T
            PIN UNKNOWN_BYTE UNKNOWN_BYTE
            PIN T_LENGTH(7:0) T_LENGTH(7:0)
            PIN T_TYPE(3:0) T_TYPE(3:0)
            PIN DISPL1_SV(3:0) XLXN_48(3:0)
            PIN DISPL2_SV(3:0) XLXN_49(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_50(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_51(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_11 vcc
            PIN P BYTE_CMPLT
        END BLOCK
        BEGIN BLOCK XLXI_13 vcc
            PIN P PAUSE_END
        END BLOCK
        BEGIN BLOCK XLXI_14 vcc
            PIN P PARITY_OK
        END BLOCK
        BEGIN BLOCK XLXI_15 vcc
            PIN P TELEGRAM_STOP
        END BLOCK
        BEGIN BLOCK XLXI_16 vcc
            PIN P ERROR_CTRL
        END BLOCK
        BEGIN BLOCK XLXI_17 vcc
            PIN P DISPL_COUNT
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_2 2720 1616 R0
        END INSTANCE
        INSTANCE XLXI_6 3120 976 R0
        INSTANCE XLXI_7 3120 1040 R0
        INSTANCE XLXI_8 3120 1104 R0
        INSTANCE XLXI_9 3120 1168 R0
        BEGIN BRANCH XLXN_1
            WIRE 3104 944 3120 944
        END BRANCH
        BEGIN BRANCH XLXN_2
            WIRE 3104 1008 3120 1008
        END BRANCH
        BEGIN BRANCH XLXN_3
            WIRE 3104 1072 3120 1072
        END BRANCH
        BEGIN BRANCH XLXN_4
            WIRE 3104 1136 3120 1136
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3344 944 3376 944
        END BRANCH
        BEGIN BRANCH AN1_G14
            WIRE 3344 1008 3376 1008
        END BRANCH
        BEGIN BRANCH AN2_F14
            WIRE 3344 1072 3376 1072
        END BRANCH
        BEGIN BRANCH AN3_E13
            WIRE 3344 1136 3376 1136
        END BRANCH
        BEGIN BRANCH BA_E14
            WIRE 3104 1200 3136 1200
        END BRANCH
        BEGIN BRANCH BB_G13
            WIRE 3104 1264 3136 1264
        END BRANCH
        BEGIN BRANCH BC_N15
            WIRE 3104 1328 3136 1328
        END BRANCH
        BEGIN BRANCH BD_P15
            WIRE 3104 1392 3136 1392
        END BRANCH
        BEGIN BRANCH BE_R16
            WIRE 3104 1456 3136 1456
        END BRANCH
        BEGIN BRANCH BF_F13
            WIRE 3104 1520 3136 1520
        END BRANCH
        BEGIN BRANCH BG_N16
            WIRE 3104 1584 3136 1584
        END BRANCH
        BEGIN INSTANCE XLXI_3 1920 976 R0
        END INSTANCE
        BEGIN BRANCH XLXN_31
            WIRE 2304 944 2720 944
        END BRANCH
        BEGIN BRANCH RST_BTN3_L14
            WIRE 224 1776 960 1776
            WIRE 960 1776 1488 1776
            WIRE 960 1648 1008 1648
            WIRE 960 1648 960 1776
            WIRE 1488 1424 1488 1776
            WIRE 1488 1424 1904 1424
        END BRANCH
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 240 1584 464 1584
        END BRANCH
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 224 1680 912 1680
            WIRE 912 1584 912 1680
            WIRE 912 1584 1008 1584
        END BRANCH
        BEGIN BRANCH XLXN_41
            WIRE 848 1520 1008 1520
        END BRANCH
        BEGIN INSTANCE XLXI_4 1008 1680 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_5 464 1616 R0
        END INSTANCE
        IOMARKER 3376 944 AN0_D14 R0 28
        IOMARKER 3376 1008 AN1_G14 R0 28
        IOMARKER 3376 1072 AN2_F14 R0 28
        IOMARKER 3376 1136 AN3_E13 R0 28
        IOMARKER 3136 1200 BA_E14 R0 28
        IOMARKER 3136 1264 BB_G13 R0 28
        IOMARKER 3136 1328 BC_N15 R0 28
        IOMARKER 3136 1392 BD_P15 R0 28
        IOMARKER 3136 1456 BE_R16 R0 28
        IOMARKER 3136 1520 BF_F13 R0 28
        IOMARKER 3136 1584 BG_N16 R0 28
        IOMARKER 192 1280 F_50MHZ_T9 R180 28
        IOMARKER 240 1584 STEP_BTN1_M14 R180 28
        IOMARKER 224 1680 RUN_BTN2_L13 R180 28
        IOMARKER 224 1776 RST_BTN3_L14 R180 28
        BEGIN BRANCH F_50MHZ_T9
            WIRE 192 1280 400 1280
            WIRE 400 1280 400 1520
            WIRE 400 1520 464 1520
            WIRE 400 1280 912 1280
            WIRE 912 1280 912 1456
            WIRE 912 1456 1008 1456
            WIRE 912 944 912 1280
            WIRE 912 944 1440 944
            WIRE 1440 944 1920 944
            WIRE 1440 944 1440 1232
            WIRE 1440 1232 1904 1232
        END BRANCH
        BEGIN BRANCH NEXT_STATE
            WIRE 1392 1312 1456 1312
            WIRE 1456 1312 1904 1312
            WIRE 1904 1312 1904 1360
            WIRE 1456 1312 1456 1456
            WIRE 1392 1456 1456 1456
        END BRANCH
        BEGIN BRANCH XLXN_48(3:0)
            WIRE 2448 1296 2576 1296
            WIRE 2576 1104 2576 1296
            WIRE 2576 1104 2720 1104
        END BRANCH
        BEGIN BRANCH XLXN_49(3:0)
            WIRE 2448 1360 2704 1360
            WIRE 2704 1264 2720 1264
            WIRE 2704 1264 2704 1360
        END BRANCH
        BEGIN BRANCH XLXN_50(3:0)
            WIRE 2448 1424 2720 1424
        END BRANCH
        BEGIN BRANCH XLXN_51(3:0)
            WIRE 2448 1488 2704 1488
            WIRE 2704 1488 2704 1584
            WIRE 2704 1584 2720 1584
        END BRANCH
        BEGIN INSTANCE XLXI_10 1904 1584 R0
        END INSTANCE
        BEGIN BRANCH TELEGRAM_RUN
            WIRE 1872 1872 1904 1872
        END BRANCH
        IOMARKER 1872 1872 TELEGRAM_RUN R180 28
        BEGIN BRANCH PARITY_OK
            WIRE 1472 1920 1472 1936
            WIRE 1472 1936 1872 1936
            WIRE 1872 1936 1904 1936
        END BRANCH
        BEGIN BRANCH BYTE_CMPLT
            WIRE 1376 1984 1376 2000
            WIRE 1376 2000 1872 2000
            WIRE 1872 2000 1904 2000
        END BRANCH
        BEGIN BRANCH PAUSE_END
            WIRE 1264 2032 1264 2064
            WIRE 1264 2064 1872 2064
            WIRE 1872 2064 1904 2064
        END BRANCH
        BEGIN BRANCH TELEGRAM_STOP
            WIRE 1168 2096 1168 2128
            WIRE 1168 2128 1872 2128
            WIRE 1872 2128 1904 2128
        END BRANCH
        BEGIN BRANCH ERROR_CTRL
            WIRE 1072 2144 1072 2192
            WIRE 1072 2192 1872 2192
            WIRE 1872 2192 1904 2192
        END BRANCH
        BEGIN BRANCH T_END
            WIRE 2448 1872 2480 1872
        END BRANCH
        IOMARKER 2480 1872 T_END R0 28
        BEGIN BRANCH SEND_OUT
            WIRE 2448 1936 2480 1936
        END BRANCH
        IOMARKER 2480 1936 SEND_OUT R0 28
        BEGIN BRANCH PARITY_FAIL
            WIRE 2448 2000 2480 2000
        END BRANCH
        IOMARKER 2480 2000 PARITY_FAIL R0 28
        BEGIN BRANCH NO_LED
            WIRE 2448 2064 2480 2064
        END BRANCH
        IOMARKER 2480 2064 NO_LED R0 28
        BEGIN BRANCH WORKING
            WIRE 2448 2128 2480 2128
        END BRANCH
        IOMARKER 2480 2128 WORKING R0 28
        BEGIN BRANCH KNOWN_T
            WIRE 2448 2192 2480 2192
        END BRANCH
        IOMARKER 2480 2192 KNOWN_T R0 28
        BEGIN BRANCH UNKNOWN_BYTE
            WIRE 2448 2256 2480 2256
        END BRANCH
        IOMARKER 2480 2256 UNKNOWN_BYTE R0 28
        BEGIN BRANCH T_LENGTH(7:0)
            WIRE 2448 2320 2480 2320
        END BRANCH
        IOMARKER 2480 2320 T_LENGTH(7:0) R0 28
        BEGIN BRANCH T_TYPE(3:0)
            WIRE 2448 2384 2480 2384
        END BRANCH
        IOMARKER 2480 2384 T_TYPE(3:0) R0 28
        BEGIN BRANCH BYTE_IN(7:0)
            WIRE 1872 1616 1904 1616
        END BRANCH
        IOMARKER 1872 1616 BYTE_IN(7:0) R180 28
        BEGIN BRANCH DISPL_COUNT
            WIRE 1696 2432 1696 2448
            WIRE 1696 2448 1904 2448
        END BRANCH
        INSTANCE XLXI_11 1312 1984 R0
        INSTANCE XLXI_13 1200 2032 R0
        INSTANCE XLXI_14 1408 1920 R0
        IOMARKER 1392 1312 NEXT_STATE R180 28
        INSTANCE XLXI_15 1104 2096 R0
        INSTANCE XLXI_16 1008 2144 R0
        INSTANCE XLXI_17 1632 2432 R0
    END SHEET
END SCHEMATIC
