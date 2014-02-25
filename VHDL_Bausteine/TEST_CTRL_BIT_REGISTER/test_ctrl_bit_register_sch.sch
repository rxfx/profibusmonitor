VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_1
        SIGNAL F_50MHZ_T9
        SIGNAL STEP_BTN1_M14
        SIGNAL RUN_BTN2_L13
        SIGNAL RST_BTN3_L14
        SIGNAL XLXN_8
        SIGNAL XLXN_11
        SIGNAL XLXN_12(3:0)
        SIGNAL XLXN_13(3:0)
        SIGNAL XLXN_14(3:0)
        SIGNAL XLXN_17(3:0)
        SIGNAL BV_BTN0_M13
        SIGNAL EN_BIT_i(7:0)
        SIGNAL PO_LD7_P11
        SIGNAL BYTE_OUT(7:0)
        SIGNAL XLXN_24
        SIGNAL XLXN_34
        SIGNAL XLXN_35(3:0)
        SIGNAL XLXN_36(3:0)
        SIGNAL XLXN_37(3:0)
        SIGNAL XLXN_20
        SIGNAL XLXN_21
        SIGNAL XLXN_22
        SIGNAL XLXN_23
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
        SIGNAL XLXN_53(3:0)
        PORT Input F_50MHZ_T9
        PORT Input STEP_BTN1_M14
        PORT Input RUN_BTN2_L13
        PORT Input RST_BTN3_L14
        PORT Input BV_BTN0_M13
        PORT Input EN_BIT_i(7:0)
        PORT Output PO_LD7_P11
        PORT Output BYTE_OUT(7:0)
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
            TIMESTAMP 2013 4 24 17 20 48
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2013 4 24 17 20 14
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF f_div50000
            TIMESTAMP 2013 4 24 17 20 23
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2013 4 24 17 20 34
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
        BEGIN BLOCKDEF ctrl_bit_register
            TIMESTAMP 2013 4 25 12 49 29
            LINE N 64 288 0 288 
            LINE N 320 32 384 32 
            RECTANGLE N 320 20 384 44 
            LINE N 320 96 384 96 
            RECTANGLE N 320 84 384 108 
            LINE N 320 160 384 160 
            RECTANGLE N 320 148 384 172 
            LINE N 320 224 384 224 
            RECTANGLE N 320 212 384 236 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -288 384 -288 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
            RECTANGLE N 64 -320 320 320 
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
        BEGIN BLOCKDEF vcc
            TIMESTAMP 2001 2 2 12 37 29
            LINE N 64 -32 64 -64 
            LINE N 64 0 64 -32 
            LINE N 96 -64 32 -64 
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 clock_single_run_src
            PIN CLK F_50MHZ_T9
            PIN SINGLE XLXN_1
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN3_L14
            PIN OUT_NEXT_STATE XLXN_8
        END BLOCK
        BEGIN BLOCK XLXI_2 deb_50mz_100ms_src
            PIN IN_DEB STEP_BTN1_M14
            PIN F_50MHZ F_50MHZ_T9
            PIN OUT_DEB XLXN_1
        END BLOCK
        BEGIN BLOCK XLXI_3 f_div50000
            PIN F_IN F_50MHZ_T9
            PIN F_OUT XLXN_11
        END BLOCK
        BEGIN BLOCK XLXI_5 ctrl_bit_register
            PIN BIT_VALUE BV_BTN0_M13
            PIN CLK F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_8
            PIN RESET RST_BTN3_L14
            PIN EN_BIT_i(7:0) EN_BIT_i(7:0)
            PIN PARITY_OK PO_LD7_P11
            PIN BYTE_OUT(7:0) BYTE_OUT(7:0)
            PIN DISPL1_SV(3:0) XLXN_12(3:0)
            PIN DISPL2_SV(3:0) XLXN_13(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_14(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_17(3:0)
            PIN EN_BIT_8 XLXN_24
        END BLOCK
        BEGIN BLOCK XLXI_10 vcc
            PIN P XLXN_24
        END BLOCK
        BEGIN BLOCK XLXI_4 nib4_7seg_src
            PIN CLK_DISPL XLXN_11
            PIN NIB0(3:0) XLXN_12(3:0)
            PIN NIB1(3:0) XLXN_13(3:0)
            PIN NIB2(3:0) XLXN_14(3:0)
            PIN NIB3(3:0) XLXN_17(3:0)
            PIN ZI0 XLXN_20
            PIN ZI1 XLXN_21
            PIN ZI2 XLXN_22
            PIN ZI3 XLXN_23
            PIN BA BA_E14
            PIN BB BB_G13
            PIN BC BC_N15
            PIN BD BD_P15
            PIN BE BE_R16
            PIN BF BF_F13
            PIN BG BG_N16
        END BLOCK
        BEGIN BLOCK XLXI_6 inv
            PIN I XLXN_20
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I XLXN_21
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_8 inv
            PIN I XLXN_22
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_9 inv
            PIN I XLXN_23
            PIN O AN3_E13
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_1 976 832 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_2 400 768 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1
            WIRE 784 672 976 672
        END BRANCH
        BEGIN BRANCH F_50MHZ_T9
            WIRE 288 480 336 480
            WIRE 336 480 912 480
            WIRE 912 480 912 608
            WIRE 912 608 976 608
            WIRE 912 480 1408 480
            WIRE 1408 480 1408 544
            WIRE 1408 544 1664 544
            WIRE 336 480 336 736
            WIRE 336 736 400 736
            WIRE 1408 288 1792 288
            WIRE 1408 288 1408 480
        END BRANCH
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 288 672 400 672
        END BRANCH
        BEGIN BRANCH RST_BTN3_L14
            WIRE 288 928 928 928
            WIRE 928 928 1376 928
            WIRE 928 800 976 800
            WIRE 928 800 928 928
            WIRE 1376 672 1376 928
            WIRE 1376 672 1664 672
        END BRANCH
        BEGIN INSTANCE XLXI_3 1792 320 R0
        END INSTANCE
        BEGIN BRANCH XLXN_8
            WIRE 1360 608 1664 608
        END BRANCH
        BEGIN BRANCH XLXN_11
            WIRE 2176 288 2400 288
        END BRANCH
        BEGIN BRANCH XLXN_12(3:0)
            WIRE 2048 800 2336 800
            WIRE 2336 448 2400 448
            WIRE 2336 448 2336 800
        END BRANCH
        BEGIN BRANCH XLXN_13(3:0)
            WIRE 2048 864 2352 864
            WIRE 2352 608 2400 608
            WIRE 2352 608 2352 864
        END BRANCH
        BEGIN BRANCH XLXN_14(3:0)
            WIRE 2048 928 2368 928
            WIRE 2368 768 2400 768
            WIRE 2368 768 2368 928
        END BRANCH
        BEGIN BRANCH XLXN_17(3:0)
            WIRE 2048 992 2384 992
            WIRE 2384 928 2400 928
            WIRE 2384 928 2384 992
        END BRANCH
        IOMARKER 288 672 STEP_BTN1_M14 R180 28
        IOMARKER 288 480 F_50MHZ_T9 R180 28
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 288 848 800 848
            WIRE 800 736 800 848
            WIRE 800 736 976 736
        END BRANCH
        IOMARKER 288 848 RUN_BTN2_L13 R180 28
        IOMARKER 288 928 RST_BTN3_L14 R180 28
        BEGIN BRANCH BV_BTN0_M13
            WIRE 1632 480 1664 480
        END BRANCH
        BEGIN BRANCH EN_BIT_i(7:0)
            WIRE 1632 736 1664 736
        END BRANCH
        BEGIN BRANCH PO_LD7_P11
            WIRE 2048 480 2080 480
        END BRANCH
        BEGIN BRANCH BYTE_OUT(7:0)
            WIRE 2048 736 2080 736
        END BRANCH
        BEGIN BRANCH XLXN_24
            WIRE 1600 1040 1600 1056
            WIRE 1600 1056 1664 1056
        END BRANCH
        BEGIN INSTANCE XLXI_5 1664 768 R0
        END INSTANCE
        INSTANCE XLXI_10 1536 1040 R0
        IOMARKER 1632 480 BV_BTN0_M13 R180 28
        IOMARKER 1632 736 EN_BIT_i(7:0) R180 28
        IOMARKER 2080 480 PO_LD7_P11 R0 28
        IOMARKER 2080 736 BYTE_OUT(7:0) R0 28
        BEGIN BRANCH XLXN_20
            WIRE 2784 288 2800 288
        END BRANCH
        BEGIN BRANCH XLXN_21
            WIRE 2784 352 2800 352
        END BRANCH
        BEGIN BRANCH XLXN_22
            WIRE 2784 416 2800 416
        END BRANCH
        BEGIN BRANCH XLXN_23
            WIRE 2784 480 2800 480
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3024 288 3056 288
        END BRANCH
        BEGIN BRANCH AN1_G14
            WIRE 3024 352 3056 352
        END BRANCH
        BEGIN BRANCH AN2_F14
            WIRE 3024 416 3056 416
        END BRANCH
        BEGIN BRANCH AN3_E13
            WIRE 3024 480 3056 480
        END BRANCH
        BEGIN BRANCH BA_E14
            WIRE 2784 544 2816 544
        END BRANCH
        BEGIN BRANCH BB_G13
            WIRE 2784 608 2816 608
        END BRANCH
        BEGIN BRANCH BC_N15
            WIRE 2784 672 2816 672
        END BRANCH
        BEGIN BRANCH BD_P15
            WIRE 2784 736 2816 736
        END BRANCH
        BEGIN BRANCH BE_R16
            WIRE 2784 800 2816 800
        END BRANCH
        BEGIN BRANCH BF_F13
            WIRE 2784 864 2816 864
        END BRANCH
        BEGIN BRANCH BG_N16
            WIRE 2784 928 2816 928
        END BRANCH
        BEGIN INSTANCE XLXI_4 2400 960 R0
        END INSTANCE
        INSTANCE XLXI_6 2800 320 R0
        INSTANCE XLXI_7 2800 384 R0
        INSTANCE XLXI_8 2800 448 R0
        INSTANCE XLXI_9 2800 512 R0
        IOMARKER 3056 288 AN0_D14 R0 28
        IOMARKER 3056 352 AN1_G14 R0 28
        IOMARKER 3056 416 AN2_F14 R0 28
        IOMARKER 3056 480 AN3_E13 R0 28
        IOMARKER 2816 544 BA_E14 R0 28
        IOMARKER 2816 608 BB_G13 R0 28
        IOMARKER 2816 672 BC_N15 R0 28
        IOMARKER 2816 736 BD_P15 R0 28
        IOMARKER 2816 800 BE_R16 R0 28
        IOMARKER 2816 864 BF_F13 R0 28
        IOMARKER 2816 928 BG_N16 R0 28
    END SHEET
END SCHEMATIC
