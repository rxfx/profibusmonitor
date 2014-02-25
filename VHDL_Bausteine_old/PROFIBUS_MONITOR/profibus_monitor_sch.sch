VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_47
        SIGNAL F_50MHZ_T9
        SIGNAL STEP_BTN1_M14
        SIGNAL RUN_BTN2_L13
        SIGNAL RST_BTN0_L14
        SIGNAL InAB_R12
        SIGNAL CHOSE_VALUE
        SIGNAL XLXN_60(8:0)
        SIGNAL XLXN_61
        SIGNAL XLXN_64
        SIGNAL TXD_R13
        SIGNAL READY
        SIGNAL XLXN_469(7:0)
        SIGNAL BYTE_CMPLT
        SIGNAL TELEGRAM_RUN
        SIGNAL XLXN_494
        SIGNAL XLXN_496
        SIGNAL TELEGRAM_STOP
        SIGNAL ERROR_CTRL
        SIGNAL BG_N16
        SIGNAL BF_F13
        SIGNAL BE_R16
        SIGNAL BD_P15
        SIGNAL BC_N15
        SIGNAL BB_G13
        SIGNAL BA_E14
        SIGNAL AN3_E13
        SIGNAL AN2_F14
        SIGNAL AN1_G14
        SIGNAL AN0_D14
        SIGNAL XLXN_11
        SIGNAL XLXN_10
        SIGNAL XLXN_9
        SIGNAL XLXN_8
        SIGNAL XLXN_546(3:0)
        SIGNAL XLXN_547(3:0)
        SIGNAL XLXN_548(3:0)
        SIGNAL XLXN_549(3:0)
        SIGNAL T_END
        SIGNAL PARITY_FAIL
        SIGNAL NO_ED
        SIGNAL WORKING
        SIGNAL KNOWN_T
        SIGNAL UNKNOWN_B
        SIGNAL T_LENGTH(7:0)
        SIGNAL T_TYPE(3:0)
        SIGNAL XLXN_569
        SIGNAL XLXN_570
        SIGNAL XLXN_571(3:0)
        SIGNAL XLXN_572(3:0)
        SIGNAL XLXN_573(3:0)
        SIGNAL XLXN_574(3:0)
        SIGNAL DISPL_COUNT
        PORT Input F_50MHZ_T9
        PORT Input STEP_BTN1_M14
        PORT Input RUN_BTN2_L13
        PORT Input RST_BTN0_L14
        PORT Input InAB_R12
        PORT Input CHOSE_VALUE
        PORT Output TXD_R13
        PORT Output READY
        PORT Input TELEGRAM_RUN
        PORT Input TELEGRAM_STOP
        PORT Input ERROR_CTRL
        PORT Output BG_N16
        PORT Output BF_F13
        PORT Output BE_R16
        PORT Output BD_P15
        PORT Output BC_N15
        PORT Output BB_G13
        PORT Output BA_E14
        PORT Output AN3_E13
        PORT Output AN2_F14
        PORT Output AN1_G14
        PORT Output AN0_D14
        PORT Output T_END
        PORT Output PARITY_FAIL
        PORT Output NO_ED
        PORT Output WORKING
        PORT Output KNOWN_T
        PORT Output UNKNOWN_B
        PORT Output T_LENGTH(7:0)
        PORT Output T_TYPE(3:0)
        PORT Output XLXN_571(3:0)
        PORT Output XLXN_572(3:0)
        PORT Output XLXN_573(3:0)
        PORT Output XLXN_574(3:0)
        PORT Input DISPL_COUNT
        BEGIN BLOCKDEF f_div50000
            TIMESTAMP 2013 1 29 10 41 34
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2013 1 29 10 41 30
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
        BEGIN BLOCKDEF clock_single_run_src
            TIMESTAMP 2013 1 29 10 42 2
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2013 1 29 10 41 39
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF ctrl_bit_register
            TIMESTAMP 2013 1 29 10 41 56
            RECTANGLE N 64 -320 320 0 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -288 384 -288 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF ctrl_rs232_tx_vhdl
            TIMESTAMP 2013 1 29 10 41 24
            RECTANGLE N 64 -320 320 0 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -288 384 -288 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF ctrl_inab_input_vhdl
            TIMESTAMP 2013 1 29 13 17 3
            LINE N 400 32 464 32 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
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
            RECTANGLE N 64 -448 400 64 
        END BLOCKDEF
        BEGIN BLOCKDEF ctrl_telegram_check
            TIMESTAMP 2013 1 29 11 39 34
            LINE N 64 864 0 864 
            LINE N 64 32 0 32 
            LINE N 64 96 0 96 
            LINE N 64 160 0 160 
            LINE N 64 224 0 224 
            LINE N 64 288 0 288 
            LINE N 64 352 0 352 
            LINE N 480 32 544 32 
            LINE N 480 96 544 96 
            LINE N 480 160 544 160 
            LINE N 480 224 544 224 
            LINE N 480 288 544 288 
            LINE N 480 352 544 352 
            LINE N 480 416 544 416 
            LINE N 480 480 544 480 
            RECTANGLE N 480 468 544 492 
            LINE N 480 544 544 544 
            RECTANGLE N 480 532 544 556 
            LINE N 480 608 544 608 
            RECTANGLE N 480 596 544 620 
            LINE N 480 672 544 672 
            RECTANGLE N 480 660 544 684 
            LINE N 480 736 544 736 
            RECTANGLE N 480 724 544 748 
            LINE N 480 800 544 800 
            RECTANGLE N 480 788 544 812 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            RECTANGLE N 64 -384 480 896 
        END BLOCKDEF
        BEGIN BLOCK XLXI_2 f_div50000
            PIN F_IN F_50MHZ_T9
            PIN F_OUT XLXN_570
        END BLOCK
        BEGIN BLOCK XLXI_15 clock_single_run_src
            PIN CLK F_50MHZ_T9
            PIN SINGLE XLXN_47
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN0_L14
            PIN OUT_NEXT_STATE XLXN_64
        END BLOCK
        BEGIN BLOCK XLXI_16 deb_50mz_100ms_src
            PIN IN_DEB STEP_BTN1_M14
            PIN F_50MHZ F_50MHZ_T9
            PIN OUT_DEB XLXN_47
        END BLOCK
        BEGIN BLOCK XLXI_17 ctrl_bit_register
            PIN BIT_VALUE XLXN_61
            PIN CLK F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_64
            PIN RESET RST_BTN0_L14
            PIN EN_BIT_i(8:0) XLXN_60(8:0)
            PIN PARITY_OK XLXN_494
            PIN BYTE_OUT(7:0) XLXN_469(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_20 ctrl_rs232_tx_vhdl
            PIN SEND XLXN_569
            PIN CLK F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_64
            PIN RESET RST_BTN0_L14
            PIN SEND_BYTE(7:0) XLXN_469(7:0)
            PIN TX TXD_R13
            PIN READY READY
        END BLOCK
        BEGIN BLOCK XLXI_21 ctrl_inab_input_vhdl
            PIN InAB InAB_R12
            PIN CHOSE_VALUE CHOSE_VALUE
            PIN CLK F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_64
            PIN RESET RST_BTN0_L14
            PIN BIT_VALUE XLXN_61
            PIN BYTE_CMPLT BYTE_CMPLT
            PIN PAUSE_END XLXN_496
            PIN EN_BIT_i(8:0) XLXN_60(8:0)
            PIN DISPL1_SV(3:0) XLXN_571(3:0)
            PIN DISPL2_SV(3:0) XLXN_572(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_573(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_574(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_22 ctrl_telegram_check
            PIN TELEGRAM_RUN TELEGRAM_RUN
            PIN PARITY_OK XLXN_494
            PIN BYTE_CMPLT BYTE_CMPLT
            PIN PAUSE_END XLXN_496
            PIN TELEGRAM_STOP TELEGRAM_STOP
            PIN ERROR_CTRL ERROR_CTRL
            PIN CLK F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_64
            PIN RESET RST_BTN0_L14
            PIN DISPL_COUNT DISPL_COUNT
            PIN BYTE_IN(7:0) XLXN_469(7:0)
            PIN T_END T_END
            PIN SEND_OUT XLXN_569
            PIN PARITY_FAIL PARITY_FAIL
            PIN NO_ED NO_ED
            PIN WORKING WORKING
            PIN KNOWN_T KNOWN_T
            PIN UNKNOWN_BYTE UNKNOWN_B
            PIN T_LENGTH(7:0) T_LENGTH(7:0)
            PIN T_TYPE(3:0) T_TYPE(3:0)
            PIN DISPL1_SV(3:0) XLXN_549(3:0)
            PIN DISPL2_SV(3:0) XLXN_548(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_547(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_546(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_4 inv
            PIN I XLXN_8
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I XLXN_11
            PIN O AN3_E13
        END BLOCK
        BEGIN BLOCK XLXI_6 inv
            PIN I XLXN_10
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_5 inv
            PIN I XLXN_9
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_3 nib4_7seg_src
            PIN CLK_DISPL XLXN_570
            PIN NIB0(3:0) XLXN_549(3:0)
            PIN NIB1(3:0) XLXN_548(3:0)
            PIN NIB2(3:0) XLXN_547(3:0)
            PIN NIB3(3:0) XLXN_546(3:0)
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
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_2 2064 176 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_15 960 496 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_16 304 432 R0
        END INSTANCE
        BEGIN BRANCH XLXN_47
            WIRE 688 336 960 336
        END BRANCH
        IOMARKER 176 144 F_50MHZ_T9 R180 28
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 224 336 304 336
        END BRANCH
        IOMARKER 224 336 STEP_BTN1_M14 R180 28
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 208 512 768 512
            WIRE 768 400 768 512
            WIRE 768 400 960 400
        END BRANCH
        IOMARKER 208 512 RUN_BTN2_L13 R180 28
        IOMARKER 208 576 RST_BTN0_L14 R180 28
        IOMARKER 144 32 InAB_R12 R180 28
        BEGIN INSTANCE XLXI_17 416 1280 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_20 2576 2624 R0
        END INSTANCE
        BEGIN BRANCH TXD_R13
            WIRE 2960 2336 2992 2336
        END BRANCH
        IOMARKER 2992 2336 TXD_R13 R0 28
        BEGIN BRANCH READY
            WIRE 2960 2592 2992 2592
        END BRANCH
        IOMARKER 2992 2592 READY R0 28
        BEGIN BRANCH XLXN_469(7:0)
            WIRE 800 1248 928 1248
            WIRE 928 1248 928 1264
            WIRE 928 1264 928 2592
            WIRE 928 2592 2576 2592
            WIRE 928 1264 1776 1264
        END BRANCH
        BEGIN BRANCH InAB_R12
            WIRE 144 32 1776 32
            WIRE 1776 32 1776 320
            WIRE 1776 320 1984 320
        END BRANCH
        BEGIN BRANCH CHOSE_VALUE
            WIRE 240 96 1664 96
            WIRE 1664 96 1664 384
            WIRE 1664 384 1984 384
        END BRANCH
        BEGIN BRANCH F_50MHZ_T9
            WIRE 176 144 240 144
            WIRE 240 144 240 400
            WIRE 240 400 304 400
            WIRE 240 400 240 800
            WIRE 240 800 240 1056
            WIRE 240 1056 416 1056
            WIRE 240 800 1008 800
            WIRE 1008 800 1008 1072
            WIRE 1008 1072 1008 2400
            WIRE 1008 2400 2576 2400
            WIRE 1008 1072 1776 1072
            WIRE 240 144 880 144
            WIRE 880 144 880 272
            WIRE 880 272 960 272
            WIRE 880 144 1408 144
            WIRE 1408 144 2064 144
            WIRE 1408 144 1408 448
            WIRE 1408 448 1984 448
        END BRANCH
        BEGIN BRANCH RST_BTN0_L14
            WIRE 208 576 800 576
            WIRE 800 576 800 640
            WIRE 800 640 800 720
            WIRE 800 720 1168 720
            WIRE 1168 720 1168 1200
            WIRE 1168 1200 1168 2528
            WIRE 1168 2528 2576 2528
            WIRE 1168 1200 1776 1200
            WIRE 800 640 1984 640
            WIRE 304 720 304 1184
            WIRE 304 1184 416 1184
            WIRE 304 720 800 720
            WIRE 800 464 960 464
            WIRE 800 464 800 576
        END BRANCH
        BEGIN BRANCH XLXN_61
            WIRE 400 896 400 992
            WIRE 400 992 416 992
            WIRE 400 896 2560 896
            WIRE 2448 320 2560 320
            WIRE 2560 320 2560 896
        END BRANCH
        BEGIN BRANCH XLXN_60(8:0)
            WIRE 16 848 2496 848
            WIRE 16 848 16 1248
            WIRE 16 1248 416 1248
            WIRE 2448 448 2496 448
            WIRE 2496 448 2496 848
        END BRANCH
        BEGIN INSTANCE XLXI_21 1984 736 R0
        END INSTANCE
        BEGIN BRANCH XLXN_64
            WIRE 352 752 352 1120
            WIRE 352 1120 416 1120
            WIRE 352 752 1088 752
            WIRE 1088 752 1360 752
            WIRE 1088 752 1088 1136
            WIRE 1088 1136 1088 2464
            WIRE 1088 2464 2576 2464
            WIRE 1088 1136 1776 1136
            WIRE 1344 272 1360 272
            WIRE 1360 272 1360 576
            WIRE 1360 576 1984 576
            WIRE 1360 576 1360 752
        END BRANCH
        BEGIN BRANCH BYTE_CMPLT
            WIRE 1264 864 2528 864
            WIRE 1264 864 1264 1520
            WIRE 1264 1520 1776 1520
            WIRE 2448 384 2528 384
            WIRE 2528 384 2528 864
        END BRANCH
        INSTANCE XLXI_4 3136 1552 R0
        BEGIN BRANCH BG_N16
            WIRE 3120 2160 3152 2160
        END BRANCH
        BEGIN BRANCH BF_F13
            WIRE 3120 2096 3152 2096
        END BRANCH
        BEGIN BRANCH BE_R16
            WIRE 3120 2032 3152 2032
        END BRANCH
        BEGIN BRANCH BD_P15
            WIRE 3120 1968 3152 1968
        END BRANCH
        BEGIN BRANCH BC_N15
            WIRE 3120 1904 3152 1904
        END BRANCH
        BEGIN BRANCH BB_G13
            WIRE 3120 1840 3152 1840
        END BRANCH
        BEGIN BRANCH BA_E14
            WIRE 3120 1776 3152 1776
        END BRANCH
        BEGIN BRANCH AN3_E13
            WIRE 3360 1712 3392 1712
        END BRANCH
        BEGIN BRANCH AN2_F14
            WIRE 3360 1648 3392 1648
        END BRANCH
        BEGIN BRANCH AN1_G14
            WIRE 3360 1584 3392 1584
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3360 1520 3392 1520
        END BRANCH
        BEGIN BRANCH XLXN_11
            WIRE 3120 1712 3136 1712
        END BRANCH
        BEGIN BRANCH XLXN_10
            WIRE 3120 1648 3136 1648
        END BRANCH
        BEGIN BRANCH XLXN_9
            WIRE 3120 1584 3136 1584
        END BRANCH
        BEGIN BRANCH XLXN_8
            WIRE 3120 1520 3136 1520
        END BRANCH
        INSTANCE XLXI_7 3136 1744 R0
        INSTANCE XLXI_6 3136 1680 R0
        INSTANCE XLXI_5 3136 1616 R0
        BEGIN INSTANCE XLXI_3 2736 2192 R0
        END INSTANCE
        IOMARKER 3152 2160 BG_N16 R0 28
        IOMARKER 3152 2096 BF_F13 R0 28
        IOMARKER 3152 2032 BE_R16 R0 28
        IOMARKER 3152 1968 BD_P15 R0 28
        IOMARKER 3152 1904 BC_N15 R0 28
        IOMARKER 3152 1840 BB_G13 R0 28
        IOMARKER 3152 1776 BA_E14 R0 28
        IOMARKER 3392 1712 AN3_E13 R0 28
        IOMARKER 3392 1648 AN2_F14 R0 28
        IOMARKER 3392 1584 AN1_G14 R0 28
        IOMARKER 3392 1520 AN0_D14 R0 28
        BEGIN BRANCH XLXN_546(3:0)
            WIRE 2320 2160 2736 2160
        END BRANCH
        BEGIN BRANCH XLXN_547(3:0)
            WIRE 2320 2096 2720 2096
            WIRE 2720 2000 2736 2000
            WIRE 2720 2000 2720 2096
        END BRANCH
        BEGIN BRANCH XLXN_548(3:0)
            WIRE 2320 2032 2704 2032
            WIRE 2704 1840 2736 1840
            WIRE 2704 1840 2704 2032
        END BRANCH
        BEGIN BRANCH XLXN_549(3:0)
            WIRE 2320 1968 2688 1968
            WIRE 2688 1760 2720 1760
            WIRE 2688 1760 2688 1968
            WIRE 2720 1680 2736 1680
            WIRE 2720 1680 2720 1760
        END BRANCH
        BEGIN INSTANCE XLXI_22 1776 1360 R0
        END INSTANCE
        BEGIN BRANCH TELEGRAM_RUN
            WIRE 736 1392 1776 1392
        END BRANCH
        BEGIN BRANCH XLXN_494
            WIRE 800 992 816 992
            WIRE 816 992 816 1456
            WIRE 816 1456 1776 1456
        END BRANCH
        BEGIN BRANCH XLXN_496
            WIRE 1360 832 2464 832
            WIRE 1360 832 1360 1584
            WIRE 1360 1584 1776 1584
            WIRE 2448 768 2464 768
            WIRE 2464 768 2464 832
        END BRANCH
        BEGIN BRANCH TELEGRAM_STOP
            WIRE 736 1648 1776 1648
        END BRANCH
        BEGIN BRANCH ERROR_CTRL
            WIRE 736 1712 1776 1712
        END BRANCH
        IOMARKER 736 1392 TELEGRAM_RUN R180 28
        IOMARKER 736 1648 TELEGRAM_STOP R180 28
        IOMARKER 736 1712 ERROR_CTRL R180 28
        BEGIN BRANCH T_END
            WIRE 2320 1392 2352 1392
        END BRANCH
        IOMARKER 2352 1392 T_END R0 28
        BEGIN BRANCH PARITY_FAIL
            WIRE 2320 1520 2352 1520
        END BRANCH
        IOMARKER 2352 1520 PARITY_FAIL R0 28
        BEGIN BRANCH NO_ED
            WIRE 2320 1584 2352 1584
        END BRANCH
        IOMARKER 2352 1584 NO_ED R0 28
        BEGIN BRANCH WORKING
            WIRE 2320 1648 2352 1648
        END BRANCH
        IOMARKER 2352 1648 WORKING R0 28
        BEGIN BRANCH KNOWN_T
            WIRE 2320 1712 2352 1712
        END BRANCH
        IOMARKER 2352 1712 KNOWN_T R0 28
        BEGIN BRANCH UNKNOWN_B
            WIRE 2320 1776 2352 1776
        END BRANCH
        IOMARKER 2352 1776 UNKNOWN_B R0 28
        BEGIN BRANCH T_LENGTH(7:0)
            WIRE 2320 1840 2352 1840
        END BRANCH
        IOMARKER 2352 1840 T_LENGTH(7:0) R0 28
        BEGIN BRANCH T_TYPE(3:0)
            WIRE 2320 1904 2352 1904
        END BRANCH
        IOMARKER 2352 1904 T_TYPE(3:0) R0 28
        BEGIN BRANCH XLXN_569
            WIRE 2320 1456 2560 1456
            WIRE 2560 1456 2560 2336
            WIRE 2560 2336 2576 2336
        END BRANCH
        BEGIN BRANCH XLXN_570
            WIRE 2448 144 2592 144
            WIRE 2592 144 2592 1520
            WIRE 2592 1520 2736 1520
        END BRANCH
        BEGIN BRANCH XLXN_571(3:0)
            WIRE 2448 512 2464 512
            WIRE 2464 512 2720 512
        END BRANCH
        BEGIN BRANCH XLXN_572(3:0)
            WIRE 2448 576 2464 576
            WIRE 2464 576 2720 576
        END BRANCH
        BEGIN BRANCH XLXN_573(3:0)
            WIRE 2448 640 2464 640
            WIRE 2464 640 2720 640
        END BRANCH
        BEGIN BRANCH XLXN_574(3:0)
            WIRE 2448 704 2464 704
            WIRE 2464 704 2720 704
        END BRANCH
        IOMARKER 2720 512 XLXN_571(3:0) R0 28
        IOMARKER 2720 576 XLXN_572(3:0) R0 28
        IOMARKER 2720 640 XLXN_573(3:0) R0 28
        IOMARKER 2720 704 XLXN_574(3:0) R0 28
        BEGIN BRANCH DISPL_COUNT
            WIRE 1744 2224 1776 2224
        END BRANCH
        IOMARKER 1744 2224 DISPL_COUNT R180 28
        IOMARKER 240 96 CHOSE_VALUE R180 28
    END SHEET
END SCHEMATIC
