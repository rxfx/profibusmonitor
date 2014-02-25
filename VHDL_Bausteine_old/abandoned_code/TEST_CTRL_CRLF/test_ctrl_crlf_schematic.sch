VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_1(3:0)
        SIGNAL XLXN_2(3:0)
        SIGNAL XLXN_3(3:0)
        SIGNAL XLXN_4(3:0)
        SIGNAL XLXN_5
        SIGNAL XLXN_6
        SIGNAL XLXN_7
        SIGNAL XLXN_8
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
        SIGNAL BYTE_SEND(7:0)
        SIGNAL XLXN_21
        SIGNAL XLXN_22
        SIGNAL XLXN_23
        SIGNAL XLXN_24
        SIGNAL XLXN_25
        SIGNAL XLXN_26
        SIGNAL RST_BTN3_L14
        SIGNAL RUN_BTN2_L13
        SIGNAL F_50MHZ_T9
        SIGNAL BYTE_OK_SW7_K13
        SIGNAL T_CMPLT_SW6_K14
        SIGNAL BYTE_IN(7:0)
        SIGNAL XLXN_34
        SIGNAL STEP_BTN1_M14
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
        PORT Output BYTE_SEND(7:0)
        PORT Input RST_BTN3_L14
        PORT Input RUN_BTN2_L13
        PORT Input F_50MHZ_T9
        PORT Input BYTE_OK_SW7_K13
        PORT Input T_CMPLT_SW6_K14
        PORT Input BYTE_IN(7:0)
        PORT Input STEP_BTN1_M14
        BEGIN BLOCKDEF ctrl_crlf_vhdl
            TIMESTAMP 2013 1 11 15 7 11
            RECTANGLE N 64 -448 432 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 432 -416 496 -416 
            RECTANGLE N 432 -428 496 -404 
            LINE N 432 -320 496 -320 
            RECTANGLE N 432 -332 496 -308 
            LINE N 432 -224 496 -224 
            RECTANGLE N 432 -236 496 -212 
            LINE N 432 -128 496 -128 
            RECTANGLE N 432 -140 496 -116 
            LINE N 432 -32 496 -32 
            RECTANGLE N 432 -44 496 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2013 1 11 15 7 26
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
        BEGIN BLOCKDEF clock_single_run_src
            TIMESTAMP 2013 1 11 15 7 4
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2013 1 11 15 7 17
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF f_div50000
            TIMESTAMP 2013 1 11 15 7 22
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
        BEGIN BLOCK XLXI_1 ctrl_crlf_vhdl
            PIN BYTE_OK BYTE_OK_SW7_K13
            PIN T_CMPLT T_CMPLT_SW6_K14
            PIN CLK F_50MHZ_T9
            PIN CLK_IO F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_23
            PIN RESET RST_BTN3_L14
            PIN BYTE_IN(7:0) BYTE_IN(7:0)
            PIN BYTE_SEND(7:0) BYTE_SEND(7:0)
            PIN DISPL1_SV(3:0) XLXN_4(3:0)
            PIN DISPL2_SV(3:0) XLXN_3(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_2(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_1(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_2 nib4_7seg_src
            PIN CLK_DISPL XLXN_21
            PIN NIB0(3:0) XLXN_4(3:0)
            PIN NIB1(3:0) XLXN_3(3:0)
            PIN NIB2(3:0) XLXN_2(3:0)
            PIN NIB3(3:0) XLXN_1(3:0)
            PIN ZI0 XLXN_5
            PIN ZI1 XLXN_6
            PIN ZI2 XLXN_7
            PIN ZI3 XLXN_8
            PIN BA BA_E14
            PIN BB BB_G13
            PIN BC BC_N15
            PIN BD BD_P15
            PIN BE BE_R16
            PIN BF BF_F13
            PIN BG BG_N16
        END BLOCK
        BEGIN BLOCK XLXI_3 clock_single_run_src
            PIN CLK F_50MHZ_T9
            PIN SINGLE XLXN_26
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN3_L14
            PIN OUT_NEXT_STATE XLXN_23
        END BLOCK
        BEGIN BLOCK XLXI_4 deb_50mz_100ms_src
            PIN IN_DEB STEP_BTN1_M14
            PIN F_50MHZ F_50MHZ_T9
            PIN OUT_DEB XLXN_26
        END BLOCK
        BEGIN BLOCK XLXI_5 f_div50000
            PIN F_IN F_50MHZ_T9
            PIN F_OUT XLXN_21
        END BLOCK
        BEGIN BLOCK XLXI_6 inv
            PIN I XLXN_5
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I XLXN_6
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_8 inv
            PIN I XLXN_7
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_9 inv
            PIN I XLXN_8
            PIN O AN3_E13
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_1 1712 1696 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_2 2544 1696 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_5 1792 1056 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1(3:0)
            WIRE 2208 1664 2544 1664
        END BRANCH
        BEGIN BRANCH XLXN_2(3:0)
            WIRE 2208 1568 2528 1568
            WIRE 2528 1504 2544 1504
            WIRE 2528 1504 2528 1568
        END BRANCH
        BEGIN BRANCH XLXN_3(3:0)
            WIRE 2208 1472 2512 1472
            WIRE 2512 1344 2544 1344
            WIRE 2512 1344 2512 1472
        END BRANCH
        BEGIN BRANCH XLXN_4(3:0)
            WIRE 2208 1376 2496 1376
            WIRE 2496 1184 2544 1184
            WIRE 2496 1184 2496 1376
        END BRANCH
        INSTANCE XLXI_6 2944 1056 R0
        INSTANCE XLXI_7 2944 1120 R0
        INSTANCE XLXI_8 2944 1184 R0
        INSTANCE XLXI_9 2944 1248 R0
        BEGIN BRANCH XLXN_5
            WIRE 2928 1024 2944 1024
        END BRANCH
        BEGIN BRANCH XLXN_6
            WIRE 2928 1088 2944 1088
        END BRANCH
        BEGIN BRANCH XLXN_7
            WIRE 2928 1152 2944 1152
        END BRANCH
        BEGIN BRANCH XLXN_8
            WIRE 2928 1216 2944 1216
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3168 1024 3200 1024
        END BRANCH
        IOMARKER 3200 1024 AN0_D14 R0 28
        BEGIN BRANCH AN1_G14
            WIRE 3168 1088 3200 1088
        END BRANCH
        IOMARKER 3200 1088 AN1_G14 R0 28
        BEGIN BRANCH AN2_F14
            WIRE 3168 1152 3200 1152
        END BRANCH
        IOMARKER 3200 1152 AN2_F14 R0 28
        BEGIN BRANCH AN3_E13
            WIRE 3168 1216 3200 1216
        END BRANCH
        IOMARKER 3200 1216 AN3_E13 R0 28
        BEGIN BRANCH BA_E14
            WIRE 2928 1280 2960 1280
        END BRANCH
        IOMARKER 2960 1280 BA_E14 R0 28
        BEGIN BRANCH BB_G13
            WIRE 2928 1344 2960 1344
        END BRANCH
        IOMARKER 2960 1344 BB_G13 R0 28
        BEGIN BRANCH BC_N15
            WIRE 2928 1408 2960 1408
        END BRANCH
        IOMARKER 2960 1408 BC_N15 R0 28
        BEGIN BRANCH BD_P15
            WIRE 2928 1472 2960 1472
        END BRANCH
        IOMARKER 2960 1472 BD_P15 R0 28
        BEGIN BRANCH BE_R16
            WIRE 2928 1536 2960 1536
        END BRANCH
        IOMARKER 2960 1536 BE_R16 R0 28
        BEGIN BRANCH BF_F13
            WIRE 2928 1600 2960 1600
        END BRANCH
        IOMARKER 2960 1600 BF_F13 R0 28
        BEGIN BRANCH BG_N16
            WIRE 2928 1664 2960 1664
        END BRANCH
        IOMARKER 2960 1664 BG_N16 R0 28
        BEGIN BRANCH BYTE_SEND(7:0)
            WIRE 2208 1280 2240 1280
        END BRANCH
        IOMARKER 2240 1280 BYTE_SEND(7:0) R0 28
        BEGIN BRANCH XLXN_21
            WIRE 2176 1024 2544 1024
        END BRANCH
        BEGIN INSTANCE XLXI_3 960 1760 R0
        END INSTANCE
        BEGIN BRANCH XLXN_23
            WIRE 1344 1536 1712 1536
        END BRANCH
        BEGIN INSTANCE XLXI_4 400 1696 R0
        END INSTANCE
        BEGIN BRANCH XLXN_26
            WIRE 784 1600 960 1600
        END BRANCH
        BEGIN BRANCH RST_BTN3_L14
            WIRE 848 1872 896 1872
            WIRE 896 1872 1408 1872
            WIRE 896 1728 960 1728
            WIRE 896 1728 896 1872
            WIRE 1408 1600 1712 1600
            WIRE 1408 1600 1408 1872
        END BRANCH
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 528 1776 800 1776
            WIRE 800 1664 960 1664
            WIRE 800 1664 800 1776
        END BRANCH
        IOMARKER 528 1776 RUN_BTN2_L13 R180 28
        IOMARKER 848 1872 RST_BTN3_L14 R180 28
        BEGIN BRANCH BYTE_OK_SW7_K13
            WIRE 1680 1280 1712 1280
        END BRANCH
        IOMARKER 1680 1280 BYTE_OK_SW7_K13 R180 28
        BEGIN BRANCH T_CMPLT_SW6_K14
            WIRE 1680 1344 1712 1344
        END BRANCH
        IOMARKER 1680 1344 T_CMPLT_SW6_K14 R180 28
        BEGIN BRANCH BYTE_IN(7:0)
            WIRE 1680 1664 1712 1664
        END BRANCH
        IOMARKER 1680 1664 BYTE_IN(7:0) R180 28
        IOMARKER 272 1024 F_50MHZ_T9 R180 28
        BEGIN BRANCH F_50MHZ_T9
            WIRE 272 1024 320 1024
            WIRE 320 1024 880 1024
            WIRE 880 1024 880 1536
            WIRE 880 1536 960 1536
            WIRE 880 1024 1408 1024
            WIRE 1408 1024 1792 1024
            WIRE 1408 1024 1408 1408
            WIRE 1408 1408 1408 1472
            WIRE 1408 1472 1712 1472
            WIRE 1408 1408 1712 1408
            WIRE 320 1024 320 1664
            WIRE 320 1664 400 1664
        END BRANCH
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 256 1600 400 1600
        END BRANCH
        IOMARKER 256 1600 STEP_BTN1_M14 R180 28
    END SHEET
END SCHEMATIC
