VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL STEP_BTN1_M14
        SIGNAL RUN_BTN2_L13
        SIGNAL XLXN_3
        SIGNAL XLXN_5
        SIGNAL F_50MHZ_T9
        SIGNAL RST_BTN3_L14
        SIGNAL InAB_SW7_K13
        SIGNAL EQ_BTN0_M13
        SIGNAL CV_SW0_F12
        SIGNAL DC_SW1_G12
        SIGNAL XLXN_46(3:0)
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
        SIGNAL DC_SW2_H14
        SIGNAL STOP_SW6_K14
        SIGNAL PO_LD7_P11
        SIGNAL CTRL_STOP
        SIGNAL CTRL_ERROR
        SIGNAL BO_LD6_P12
        SIGNAL BYTE_OUT(8:0)
        PORT Input STEP_BTN1_M14
        PORT Input RUN_BTN2_L13
        PORT Input F_50MHZ_T9
        PORT Input RST_BTN3_L14
        PORT Input InAB_SW7_K13
        PORT Input EQ_BTN0_M13
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
        PORT Input STOP_SW6_K14
        PORT Output PO_LD7_P11
        PORT Output CTRL_STOP
        PORT Output CTRL_ERROR
        PORT Output BO_LD6_P12
        PORT Output BYTE_OUT(8:0)
        BEGIN BLOCKDEF ctrl_9p6_50mhz_vhdl
            TIMESTAMP 2012 11 16 13 10 25
            LINE N 352 672 416 672 
            LINE N 352 736 416 736 
            RECTANGLE N 352 724 416 748 
            LINE N 64 544 0 544 
            LINE N 64 608 0 608 
            LINE N 64 416 0 416 
            LINE N 64 480 0 480 
            LINE N 64 -736 0 -736 
            LINE N 64 -608 0 -608 
            LINE N 64 -480 0 -480 
            LINE N 64 -352 0 -352 
            LINE N 64 -224 0 -224 
            LINE N 64 -96 0 -96 
            LINE N 352 -736 416 -736 
            LINE N 352 -32 416 -32 
            LINE N 352 608 416 608 
            LINE N 352 288 416 288 
            RECTANGLE N 352 276 416 300 
            RECTANGLE N 352 148 416 172 
            LINE N 352 160 416 160 
            LINE N 352 224 416 224 
            RECTANGLE N 352 212 416 236 
            LINE N 352 352 416 352 
            RECTANGLE N 352 340 416 364 
            RECTANGLE N 64 -768 352 768 
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
        BEGIN BLOCK XLXI_2 clock_single_run_src
            PIN CLK F_50MHZ_T9
            PIN SINGLE XLXN_3
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN3_L14
            PIN OUT_NEXT_STATE XLXN_5
        END BLOCK
        BEGIN BLOCK XLXI_3 deb_50mz_100ms_src
            PIN OUT_DEB XLXN_3
            PIN IN_DEB STEP_BTN1_M14
            PIN F_50MHZ F_50MHZ_T9
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
        BEGIN BLOCK XLXI_1 ctrl_9p6_50mhz_vhdl
            PIN InAB InAB_SW7_K13
            PIN ERROR_QUIT EQ_BTN0_M13
            PIN CHOSE_VALUE CV_SW0_F12
            PIN DISPL_COUNT DC_SW1_G12
            PIN DISPL_COUNT_SWITCH DC_SW2_H14
            PIN STOP STOP_SW6_K14
            PIN CLK F_50MHZ_T9
            PIN CLK_IO F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_5
            PIN RESET RST_BTN3_L14
            PIN CTRL_ERROR CTRL_ERROR
            PIN CTRL_STOP CTRL_STOP
            PIN BYTE_OK BO_LD6_P12
            PIN PARITY_OK PO_LD7_P11
            PIN BYTE_OUT(8:0) BYTE_OUT(8:0)
            PIN DISPL1_SV(3:0) XLXN_48(3:0)
            PIN DISPL2_SV(3:0) XLXN_49(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_46(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_47(3:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_3 384 960 R0
        END INSTANCE
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 736 1088 816 1088
            WIRE 816 928 816 1088
            WIRE 816 928 896 928
        END BRANCH
        IOMARKER 736 1088 RUN_BTN2_L13 R180 28
        BEGIN BRANCH XLXN_3
            WIRE 768 864 896 864
        END BRANCH
        BEGIN INSTANCE XLXI_2 896 1024 R0
        END INSTANCE
        BEGIN BRANCH RST_BTN3_L14
            WIRE 784 1440 880 1440
            WIRE 880 1440 1904 1440
            WIRE 880 992 896 992
            WIRE 880 992 880 1440
        END BRANCH
        IOMARKER 784 1440 RST_BTN3_L14 R180 28
        BEGIN BRANCH InAB_SW7_K13
            WIRE 1840 800 1856 800
            WIRE 1856 800 1904 800
        END BRANCH
        BEGIN BRANCH EQ_BTN0_M13
            WIRE 1840 928 1856 928
            WIRE 1856 928 1904 928
        END BRANCH
        BEGIN BRANCH XLXN_5
            WIRE 1280 800 1296 800
            WIRE 1296 800 1296 1312
            WIRE 1296 1312 1904 1312
        END BRANCH
        IOMARKER 1840 800 InAB_SW7_K13 R180 28
        IOMARKER 1840 928 EQ_BTN0_M13 R180 28
        BEGIN INSTANCE XLXI_4 1904 624 R0
        END INSTANCE
        BEGIN BRANCH CV_SW0_F12
            WIRE 1872 1952 1888 1952
            WIRE 1888 1952 1904 1952
        END BRANCH
        IOMARKER 1872 1952 CV_SW0_F12 R180 28
        BEGIN BRANCH DC_SW1_G12
            WIRE 1872 2016 1888 2016
            WIRE 1888 2016 1904 2016
        END BRANCH
        IOMARKER 1872 2016 DC_SW1_G12 R180 28
        BEGIN BRANCH XLXN_47(3:0)
            WIRE 2320 1760 2720 1760
            WIRE 2720 1760 2736 1760
        END BRANCH
        BEGIN BRANCH XLXN_48(3:0)
            WIRE 2320 1824 2672 1824
            WIRE 2672 1824 2672 1920
            WIRE 2672 1920 2720 1920
            WIRE 2720 1920 2736 1920
        END BRANCH
        BEGIN BRANCH XLXN_49(3:0)
            WIRE 2320 1888 2640 1888
            WIRE 2640 1888 2640 2080
            WIRE 2640 2080 2720 2080
            WIRE 2720 2080 2736 2080
        END BRANCH
        INSTANCE XLXI_6 3168 1472 R0
        INSTANCE XLXI_7 3168 1536 R0
        BEGIN BRANCH XLXN_21
            WIRE 3120 1440 3168 1440
        END BRANCH
        BEGIN BRANCH XLXN_22
            WIRE 3120 1504 3168 1504
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3392 1440 3424 1440
        END BRANCH
        BEGIN BRANCH AN1_G14
            WIRE 3392 1504 3424 1504
        END BRANCH
        BEGIN INSTANCE XLXI_10 2736 2112 R0
        END INSTANCE
        INSTANCE XLXI_8 3168 1600 R0
        INSTANCE XLXI_9 3168 1664 R0
        BEGIN BRANCH AN2_F14
            WIRE 3392 1568 3424 1568
        END BRANCH
        BEGIN BRANCH AN3_E13
            WIRE 3392 1632 3424 1632
        END BRANCH
        BEGIN BRANCH XLXN_25
            WIRE 3120 1568 3168 1568
        END BRANCH
        BEGIN BRANCH XLXN_26
            WIRE 3120 1632 3168 1632
        END BRANCH
        BEGIN BRANCH BA_E14
            WIRE 3120 1696 3152 1696
        END BRANCH
        BEGIN BRANCH BB_G13
            WIRE 3120 1760 3152 1760
        END BRANCH
        BEGIN BRANCH BC_N15
            WIRE 3120 1824 3152 1824
        END BRANCH
        BEGIN BRANCH BD_P15
            WIRE 3120 1888 3152 1888
        END BRANCH
        BEGIN BRANCH BE_R16
            WIRE 3120 1952 3152 1952
        END BRANCH
        BEGIN BRANCH BF_F13
            WIRE 3120 2016 3152 2016
        END BRANCH
        BEGIN BRANCH BG_N16
            WIRE 3120 2080 3152 2080
        END BRANCH
        IOMARKER 3424 1440 AN0_D14 R0 28
        IOMARKER 3424 1504 AN1_G14 R0 28
        IOMARKER 3424 1568 AN2_F14 R0 28
        IOMARKER 3424 1632 AN3_E13 R0 28
        IOMARKER 3152 1696 BA_E14 R0 28
        IOMARKER 3152 1760 BB_G13 R0 28
        IOMARKER 3152 1824 BC_N15 R0 28
        IOMARKER 3152 1888 BD_P15 R0 28
        IOMARKER 3152 1952 BE_R16 R0 28
        IOMARKER 3152 2016 BF_F13 R0 28
        IOMARKER 3152 2080 BG_N16 R0 28
        BEGIN BRANCH XLXN_122
            WIRE 2288 592 2672 592
            WIRE 2672 592 2672 1440
            WIRE 2672 1440 2736 1440
        END BRANCH
        BEGIN BRANCH XLXN_46(3:0)
            WIRE 2320 1696 2672 1696
            WIRE 2672 1600 2672 1696
            WIRE 2672 1600 2720 1600
            WIRE 2720 1600 2736 1600
        END BRANCH
        BEGIN BRANCH DC_SW2_H14
            WIRE 1872 2080 1888 2080
            WIRE 1888 2080 1904 2080
        END BRANCH
        IOMARKER 1872 2080 DC_SW2_H14 R180 28
        BEGIN BRANCH STOP_SW6_K14
            WIRE 1872 2144 1888 2144
            WIRE 1888 2144 1904 2144
        END BRANCH
        IOMARKER 1872 2144 STOP_SW6_K14 R180 28
        BEGIN BRANCH F_50MHZ_T9
            WIRE 192 592 288 592
            WIRE 288 592 848 592
            WIRE 848 592 848 800
            WIRE 848 800 896 800
            WIRE 848 592 1552 592
            WIRE 1552 592 1552 1056
            WIRE 1552 1056 1904 1056
            WIRE 1552 1056 1552 1184
            WIRE 1552 1184 1904 1184
            WIRE 1552 592 1904 592
            WIRE 288 592 288 864
            WIRE 288 864 384 864
        END BRANCH
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 240 928 368 928
            WIRE 368 928 384 928
        END BRANCH
        IOMARKER 192 592 F_50MHZ_T9 R180 28
        IOMARKER 240 928 STEP_BTN1_M14 R180 28
        BEGIN INSTANCE XLXI_1 1904 1536 R0
        END INSTANCE
        BEGIN BRANCH PO_LD7_P11
            WIRE 2320 2208 2352 2208
        END BRANCH
        IOMARKER 2352 2208 PO_LD7_P11 R0 28
        BEGIN BRANCH CTRL_STOP
            WIRE 2320 2144 2352 2144
        END BRANCH
        IOMARKER 2352 2144 CTRL_STOP R0 28
        BEGIN BRANCH CTRL_ERROR
            WIRE 2320 800 2352 800
        END BRANCH
        IOMARKER 2352 800 CTRL_ERROR R0 28
        BEGIN BRANCH BO_LD6_P12
            WIRE 2320 1504 2352 1504
        END BRANCH
        IOMARKER 2352 1504 BO_LD6_P12 R0 28
        BEGIN BRANCH BYTE_OUT(8:0)
            WIRE 2320 2272 2352 2272
        END BRANCH
        IOMARKER 2352 2272 BYTE_OUT(8:0) R0 28
    END SHEET
END SCHEMATIC
