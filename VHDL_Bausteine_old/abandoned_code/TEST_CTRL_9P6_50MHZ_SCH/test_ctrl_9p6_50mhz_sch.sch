VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL RUN_BTN2_L13
        SIGNAL XLXN_3
        SIGNAL RST_BTN3_L14
        SIGNAL InAB_R12
        SIGNAL XLXN_5
        SIGNAL CV_SW0_F12
        SIGNAL DC_SW1_G12
        SIGNAL XLXN_47(3:0)
        SIGNAL XLXN_48(3:0)
        SIGNAL XLXN_49(3:0)
        SIGNAL XLXN_21
        SIGNAL XLXN_22
        SIGNAL AN0_D14
        SIGNAL AN1_G14
        SIGNAL AN2_F14
        SIGNAL AN3_E13
        SIGNAL XLXN_25
        SIGNAL XLXN_26
        SIGNAL BA_E14
        SIGNAL BB_G13
        SIGNAL BC_N15
        SIGNAL BD_P15
        SIGNAL BE_R16
        SIGNAL BF_F13
        SIGNAL BG_N16
        SIGNAL XLXN_122
        SIGNAL XLXN_46(3:0)
        SIGNAL DC_SW2_H14
        SIGNAL FIRST_BYTE_SW6_K14
        SIGNAL F_50MHZ_T9
        SIGNAL STEP_BTN1_M14
        SIGNAL PO_LD7_P11
        SIGNAL CTRL_ERROR
        SIGNAL XLXN_199(7:0)
        SIGNAL TXD_R13
        SIGNAL READY_LD6_P12
        SIGNAL BYTE_OK
        PORT Input RUN_BTN2_L13
        PORT Input RST_BTN3_L14
        PORT Input InAB_R12
        PORT Input CV_SW0_F12
        PORT Input DC_SW1_G12
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
        PORT Input DC_SW2_H14
        PORT Input FIRST_BYTE_SW6_K14
        PORT Input F_50MHZ_T9
        PORT Input STEP_BTN1_M14
        PORT Output CTRL_ERROR
        PORT Output TXD_R13
        PORT Output READY_LD6_P12
        PORT Output BYTE_OK
        BEGIN BLOCKDEF ctrl_9p6_50mhz_vhdl
            TIMESTAMP 2013 1 17 10 44 36
            LINE N 64 992 0 992 
            LINE N 352 672 416 672 
            LINE N 352 736 416 736 
            RECTANGLE N 352 724 416 748 
            LINE N 64 544 0 544 
            LINE N 64 416 0 416 
            LINE N 64 480 0 480 
            LINE N 64 -736 0 -736 
            LINE N 64 -480 0 -480 
            LINE N 64 -352 0 -352 
            LINE N 64 -224 0 -224 
            LINE N 64 -96 0 -96 
            LINE N 352 -736 416 -736 
            LINE N 352 -32 416 -32 
            LINE N 352 288 416 288 
            RECTANGLE N 352 276 416 300 
            RECTANGLE N 352 148 416 172 
            LINE N 352 160 416 160 
            LINE N 352 224 416 224 
            RECTANGLE N 352 212 416 236 
            LINE N 352 352 416 352 
            RECTANGLE N 352 340 416 364 
            RECTANGLE N 64 -768 352 1024 
        END BLOCKDEF
        BEGIN BLOCKDEF clock_single_run_src
            TIMESTAMP 2012 10 26 19 2 41
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2012 11 1 13 39 6
            RECTANGLE N 64 -128 320 0 
            LINE N 320 -96 384 -96 
            LINE N 64 -32 0 -32 
            LINE N 64 -96 0 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF f_div50000
            TIMESTAMP 2012 10 26 19 2 52
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
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
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2012 10 26 19 2 57
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
        BEGIN BLOCKDEF ctrl_rs232_tx_vhdl
            TIMESTAMP 2013 1 17 10 7 11
            RECTANGLE N 64 -384 320 0 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -352 384 -352 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCK XLXI_3 deb_50mz_100ms_src
            PIN OUT_DEB XLXN_3
            PIN IN_DEB STEP_BTN1_M14
            PIN F_50MHZ F_50MHZ_T9
        END BLOCK
        BEGIN BLOCK XLXI_2 clock_single_run_src
            PIN CLK F_50MHZ_T9
            PIN SINGLE XLXN_3
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN3_L14
            PIN OUT_NEXT_STATE XLXN_5
        END BLOCK
        BEGIN BLOCK XLXI_4 f_div50000
            PIN F_IN F_50MHZ_T9
            PIN F_OUT XLXN_122
        END BLOCK
        BEGIN BLOCK XLXI_6 inv
            PIN I XLXN_21
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I XLXN_22
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_10 nib4_7seg_src
            PIN CLK_DISPL XLXN_122
            PIN NIB0(3:0) XLXN_46(3:0)
            PIN NIB1(3:0) XLXN_47(3:0)
            PIN NIB2(3:0) XLXN_48(3:0)
            PIN NIB3(3:0) XLXN_49(3:0)
            PIN ZI0 XLXN_21
            PIN ZI1 XLXN_22
            PIN ZI2 XLXN_25
            PIN ZI3 XLXN_26
            PIN BA BA_E14
            PIN BB BB_G13
            PIN BC BC_N15
            PIN BD BD_P15
            PIN BE BE_R16
            PIN BF BF_F13
            PIN BG BG_N16
        END BLOCK
        BEGIN BLOCK XLXI_8 inv
            PIN I XLXN_25
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_9 inv
            PIN I XLXN_26
            PIN O AN3_E13
        END BLOCK
        BEGIN BLOCK XLXI_29 ctrl_rs232_tx_vhdl
            PIN SEND PO_LD7_P11
            PIN CLK F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_5
            PIN RESET RST_BTN3_L14
            PIN SEND_BYTE(7:0) XLXN_199(7:0)
            PIN TX TXD_R13
            PIN READY READY_LD6_P12
        END BLOCK
        BEGIN BLOCK XLXI_1 ctrl_9p6_50mhz_vhdl
            PIN InAB InAB_R12
            PIN CHOSE_VALUE CV_SW0_F12
            PIN DISPL_COUNT DC_SW1_G12
            PIN DISPL_COUNT_SWITCH DC_SW2_H14
            PIN CLK F_50MHZ_T9
            PIN CLK_IO F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_5
            PIN RESET RST_BTN3_L14
            PIN CTRL_ERROR CTRL_ERROR
            PIN BYTE_OK BYTE_OK
            PIN PARITY_OK PO_LD7_P11
            PIN BYTE_OUT(7:0) XLXN_199(7:0)
            PIN DISPL1_SV(3:0) XLXN_48(3:0)
            PIN DISPL2_SV(3:0) XLXN_49(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_46(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_47(3:0)
            PIN FIRST_BYTE FIRST_BYTE_SW6_K14
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_3 384 496 R0
        END INSTANCE
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 736 624 816 624
            WIRE 816 464 816 624
            WIRE 816 464 896 464
        END BRANCH
        BEGIN BRANCH XLXN_3
            WIRE 768 400 896 400
        END BRANCH
        BEGIN INSTANCE XLXI_2 896 560 R0
        END INSTANCE
        BEGIN BRANCH RST_BTN3_L14
            WIRE 784 976 880 976
            WIRE 880 976 1904 976
            WIRE 880 976 880 2496
            WIRE 880 2496 2560 2496
            WIRE 880 528 896 528
            WIRE 880 528 880 976
        END BRANCH
        BEGIN BRANCH InAB_R12
            WIRE 1840 336 1904 336
        END BRANCH
        BEGIN BRANCH XLXN_5
            WIRE 1280 336 1296 336
            WIRE 1296 336 1296 848
            WIRE 1296 848 1904 848
            WIRE 1296 848 1296 2432
            WIRE 1296 2432 2560 2432
        END BRANCH
        BEGIN INSTANCE XLXI_4 1904 160 R0
        END INSTANCE
        BEGIN BRANCH CV_SW0_F12
            WIRE 1872 1488 1904 1488
        END BRANCH
        BEGIN BRANCH DC_SW1_G12
            WIRE 1872 1552 1904 1552
        END BRANCH
        BEGIN BRANCH XLXN_47(3:0)
            WIRE 2320 1296 2736 1296
        END BRANCH
        BEGIN BRANCH XLXN_48(3:0)
            WIRE 2320 1360 2672 1360
            WIRE 2672 1360 2672 1456
            WIRE 2672 1456 2736 1456
        END BRANCH
        BEGIN BRANCH XLXN_49(3:0)
            WIRE 2320 1424 2640 1424
            WIRE 2640 1424 2640 1616
            WIRE 2640 1616 2736 1616
        END BRANCH
        INSTANCE XLXI_6 3168 1008 R0
        INSTANCE XLXI_7 3168 1072 R0
        BEGIN BRANCH XLXN_21
            WIRE 3120 976 3168 976
        END BRANCH
        BEGIN BRANCH XLXN_22
            WIRE 3120 1040 3168 1040
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3392 976 3424 976
        END BRANCH
        BEGIN BRANCH AN1_G14
            WIRE 3392 1040 3424 1040
        END BRANCH
        BEGIN INSTANCE XLXI_10 2736 1648 R0
        END INSTANCE
        INSTANCE XLXI_8 3168 1136 R0
        INSTANCE XLXI_9 3168 1200 R0
        BEGIN BRANCH AN2_F14
            WIRE 3392 1104 3424 1104
        END BRANCH
        BEGIN BRANCH AN3_E13
            WIRE 3392 1168 3424 1168
        END BRANCH
        BEGIN BRANCH XLXN_25
            WIRE 3120 1104 3168 1104
        END BRANCH
        BEGIN BRANCH XLXN_26
            WIRE 3120 1168 3168 1168
        END BRANCH
        BEGIN BRANCH BA_E14
            WIRE 3120 1232 3152 1232
        END BRANCH
        BEGIN BRANCH BB_G13
            WIRE 3120 1296 3152 1296
        END BRANCH
        BEGIN BRANCH BC_N15
            WIRE 3120 1360 3152 1360
        END BRANCH
        BEGIN BRANCH BD_P15
            WIRE 3120 1424 3152 1424
        END BRANCH
        BEGIN BRANCH BE_R16
            WIRE 3120 1488 3152 1488
        END BRANCH
        BEGIN BRANCH BF_F13
            WIRE 3120 1552 3152 1552
        END BRANCH
        BEGIN BRANCH BG_N16
            WIRE 3120 1616 3152 1616
        END BRANCH
        BEGIN BRANCH XLXN_122
            WIRE 2288 128 2672 128
            WIRE 2672 128 2672 976
            WIRE 2672 976 2736 976
        END BRANCH
        BEGIN BRANCH XLXN_46(3:0)
            WIRE 2320 1232 2672 1232
            WIRE 2672 1136 2672 1232
            WIRE 2672 1136 2736 1136
        END BRANCH
        BEGIN BRANCH DC_SW2_H14
            WIRE 1872 1616 1904 1616
        END BRANCH
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 240 464 384 464
        END BRANCH
        BEGIN BRANCH PO_LD7_P11
            WIRE 2320 1744 2480 1744
            WIRE 2480 1744 2480 2240
            WIRE 2480 2240 2560 2240
        END BRANCH
        BEGIN BRANCH CTRL_ERROR
            WIRE 2320 336 2352 336
        END BRANCH
        IOMARKER 736 624 RUN_BTN2_L13 R180 28
        IOMARKER 784 976 RST_BTN3_L14 R180 28
        IOMARKER 1840 336 InAB_R12 R180 28
        IOMARKER 1872 1488 CV_SW0_F12 R180 28
        IOMARKER 1872 1552 DC_SW1_G12 R180 28
        IOMARKER 3424 976 AN0_D14 R0 28
        IOMARKER 3424 1040 AN1_G14 R0 28
        IOMARKER 3424 1104 AN2_F14 R0 28
        IOMARKER 3424 1168 AN3_E13 R0 28
        IOMARKER 3152 1232 BA_E14 R0 28
        IOMARKER 3152 1296 BB_G13 R0 28
        IOMARKER 3152 1360 BC_N15 R0 28
        IOMARKER 3152 1424 BD_P15 R0 28
        IOMARKER 3152 1488 BE_R16 R0 28
        IOMARKER 3152 1552 BF_F13 R0 28
        IOMARKER 3152 1616 BG_N16 R0 28
        IOMARKER 1872 1616 DC_SW2_H14 R180 28
        IOMARKER 192 128 F_50MHZ_T9 R180 28
        IOMARKER 240 464 STEP_BTN1_M14 R180 28
        IOMARKER 2352 336 CTRL_ERROR R0 28
        BEGIN INSTANCE XLXI_29 2560 2592 R0
        END INSTANCE
        BEGIN BRANCH XLXN_199(7:0)
            WIRE 2320 1808 2432 1808
            WIRE 2432 1808 2432 2560
            WIRE 2432 2560 2560 2560
        END BRANCH
        BEGIN BRANCH TXD_R13
            WIRE 2944 2240 2976 2240
        END BRANCH
        IOMARKER 2976 2240 TXD_R13 R0 28
        BEGIN BRANCH READY_LD6_P12
            WIRE 2944 2560 2976 2560
        END BRANCH
        IOMARKER 2976 2560 READY_LD6_P12 R0 28
        BEGIN BRANCH BYTE_OK
            WIRE 2320 1040 2352 1040
        END BRANCH
        IOMARKER 2352 1040 BYTE_OK R0 28
        BEGIN BRANCH F_50MHZ_T9
            WIRE 192 128 288 128
            WIRE 288 128 288 400
            WIRE 288 400 384 400
            WIRE 288 128 848 128
            WIRE 848 128 848 336
            WIRE 848 336 896 336
            WIRE 848 128 1552 128
            WIRE 1552 128 1904 128
            WIRE 1552 128 1552 592
            WIRE 1552 592 1904 592
            WIRE 1552 592 1552 720
            WIRE 1552 720 1904 720
            WIRE 1552 720 1552 2304
            WIRE 1552 2304 2560 2304
        END BRANCH
        BEGIN INSTANCE XLXI_1 1904 1072 R0
        END INSTANCE
        BEGIN BRANCH FIRST_BYTE_SW6_K14
            WIRE 1856 2064 1888 2064
            WIRE 1888 2064 1904 2064
        END BRANCH
        IOMARKER 1856 2064 FIRST_BYTE_SW6_K14 R180 28
    END SHEET
END SCHEMATIC
