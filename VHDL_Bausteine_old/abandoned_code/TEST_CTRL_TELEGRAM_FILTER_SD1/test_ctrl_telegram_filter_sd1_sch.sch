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
        SIGNAL RST_BTN0_L14
        SIGNAL RUN_BTN2_L13
        SIGNAL STEP_BTN1_M14
        SIGNAL FILTER_ON
        SIGNAL PARITY_OK
        SIGNAL DISPL_COUNT
        SIGNAL BYTE_IN(7:0)
        SIGNAL SEND_OUT
        SIGNAL T_CMPLT
        SIGNAL F_BYTE_OUT(7:0)
        SIGNAL BF_F13
        SIGNAL BG_N16
        SIGNAL BE_R16
        SIGNAL BD_P15
        SIGNAL BC_N15
        SIGNAL BB_G13
        SIGNAL BA_E14
        SIGNAL XLXN_28
        SIGNAL XLXN_29
        SIGNAL XLXN_30
        SIGNAL XLXN_31
        SIGNAL AN0_D14
        SIGNAL AN1_G14
        SIGNAL AN2_F14
        SIGNAL AN3_E13
        SIGNAL XLXN_36
        SIGNAL XLXN_37
        PORT Input F_50MHZ_T9
        PORT Input RST_BTN0_L14
        PORT Input RUN_BTN2_L13
        PORT Input STEP_BTN1_M14
        PORT Input FILTER_ON
        PORT Input PARITY_OK
        PORT Input DISPL_COUNT
        PORT Input BYTE_IN(7:0)
        PORT Output SEND_OUT
        PORT Output T_CMPLT
        PORT Output F_BYTE_OUT(7:0)
        PORT Output BF_F13
        PORT Output BG_N16
        PORT Output BE_R16
        PORT Output BD_P15
        PORT Output BC_N15
        PORT Output BB_G13
        PORT Output BA_E14
        PORT Output AN0_D14
        PORT Output AN1_G14
        PORT Output AN2_F14
        PORT Output AN3_E13
        BEGIN BLOCKDEF ctrl_telegram_filter_sd1_vhdl
            TIMESTAMP 2013 1 23 17 13 58
            RECTANGLE N 64 -448 464 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 464 -416 528 -416 
            LINE N 464 -352 528 -352 
            LINE N 464 -288 528 -288 
            RECTANGLE N 464 -300 528 -276 
            LINE N 464 -224 528 -224 
            RECTANGLE N 464 -236 528 -212 
            LINE N 464 -160 528 -160 
            RECTANGLE N 464 -172 528 -148 
            LINE N 464 -96 528 -96 
            RECTANGLE N 464 -108 528 -84 
            LINE N 464 -32 528 -32 
            RECTANGLE N 464 -44 528 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2013 1 23 17 14 11
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
            TIMESTAMP 2013 1 23 17 14 6
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2013 1 23 17 14 2
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF clock_single_run_src
            TIMESTAMP 2013 1 23 17 13 54
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
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
        BEGIN BLOCK XLXI_1 ctrl_telegram_filter_sd1_vhdl
            PIN FILTER_ON FILTER_ON
            PIN PARITY_OK PARITY_OK
            PIN DISPL_COUNT DISPL_COUNT
            PIN CLK F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_6
            PIN RESET RST_BTN0_L14
            PIN BYTE_IN(7:0) BYTE_IN(7:0)
            PIN SEND_OUT SEND_OUT
            PIN T_CMPLT T_CMPLT
            PIN FILTER_BYTE_OUT(7:0) F_BYTE_OUT(7:0)
            PIN DISPL1_SV(3:0) XLXN_2(3:0)
            PIN DISPL2_SV(3:0) XLXN_3(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_4(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_5(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_2 nib4_7seg_src
            PIN CLK_DISPL XLXN_1
            PIN NIB0(3:0) XLXN_2(3:0)
            PIN NIB1(3:0) XLXN_3(3:0)
            PIN NIB2(3:0) XLXN_4(3:0)
            PIN NIB3(3:0) XLXN_5(3:0)
            PIN ZI0 XLXN_28
            PIN ZI1 XLXN_29
            PIN ZI2 XLXN_30
            PIN ZI3 XLXN_31
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
            PIN F_OUT XLXN_1
        END BLOCK
        BEGIN BLOCK XLXI_4 deb_50mz_100ms_src
            PIN IN_DEB STEP_BTN1_M14
            PIN F_50MHZ F_50MHZ_T9
            PIN OUT_DEB XLXN_7
        END BLOCK
        BEGIN BLOCK XLXI_5 clock_single_run_src
            PIN CLK F_50MHZ_T9
            PIN SINGLE XLXN_7
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN0_L14
            PIN OUT_NEXT_STATE XLXN_6
        END BLOCK
        BEGIN BLOCK XLXI_6 inv
            PIN I XLXN_28
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I XLXN_29
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_8 inv
            PIN I XLXN_30
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_9 inv
            PIN I XLXN_31
            PIN O AN3_E13
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_1 1840 1136 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_2 2704 1136 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_3 1872 496 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_5 960 848 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1
            WIRE 2256 464 2704 464
        END BRANCH
        BEGIN BRANCH XLXN_2(3:0)
            WIRE 2368 912 2656 912
            WIRE 2656 624 2704 624
            WIRE 2656 624 2656 912
        END BRANCH
        BEGIN BRANCH XLXN_3(3:0)
            WIRE 2368 976 2672 976
            WIRE 2672 784 2704 784
            WIRE 2672 784 2672 976
        END BRANCH
        BEGIN BRANCH XLXN_4(3:0)
            WIRE 2368 1040 2688 1040
            WIRE 2688 944 2704 944
            WIRE 2688 944 2688 1040
        END BRANCH
        BEGIN BRANCH XLXN_5(3:0)
            WIRE 2368 1104 2704 1104
        END BRANCH
        BEGIN BRANCH XLXN_6
            WIRE 1344 624 1392 624
            WIRE 1392 624 1392 976
            WIRE 1392 976 1840 976
        END BRANCH
        BEGIN BRANCH XLXN_7
            WIRE 832 688 960 688
        END BRANCH
        BEGIN BRANCH F_50MHZ_T9
            WIRE 176 320 352 320
            WIRE 352 320 896 320
            WIRE 896 320 896 624
            WIRE 896 624 960 624
            WIRE 896 320 1456 320
            WIRE 1456 320 1456 464
            WIRE 1456 464 1456 912
            WIRE 1456 912 1840 912
            WIRE 1456 464 1872 464
            WIRE 352 320 352 752
            WIRE 352 752 448 752
        END BRANCH
        BEGIN BRANCH RST_BTN0_L14
            WIRE 496 1040 912 1040
            WIRE 912 1040 1840 1040
            WIRE 912 816 960 816
            WIRE 912 816 912 1040
        END BRANCH
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 496 976 848 976
            WIRE 848 752 848 976
            WIRE 848 752 960 752
        END BRANCH
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 240 688 432 688
            WIRE 432 688 448 688
        END BRANCH
        IOMARKER 496 1040 RST_BTN0_L14 R180 28
        BEGIN BRANCH FILTER_ON
            WIRE 1808 720 1840 720
        END BRANCH
        IOMARKER 1808 720 FILTER_ON R180 28
        BEGIN BRANCH PARITY_OK
            WIRE 1808 784 1840 784
        END BRANCH
        IOMARKER 1808 784 PARITY_OK R180 28
        BEGIN BRANCH DISPL_COUNT
            WIRE 1808 848 1840 848
        END BRANCH
        IOMARKER 1808 848 DISPL_COUNT R180 28
        BEGIN BRANCH BYTE_IN(7:0)
            WIRE 1808 1104 1840 1104
        END BRANCH
        IOMARKER 1808 1104 BYTE_IN(7:0) R180 28
        BEGIN BRANCH SEND_OUT
            WIRE 2368 720 2400 720
        END BRANCH
        IOMARKER 2400 720 SEND_OUT R0 28
        BEGIN BRANCH T_CMPLT
            WIRE 2368 784 2400 784
        END BRANCH
        IOMARKER 2400 784 T_CMPLT R0 28
        BEGIN BRANCH F_BYTE_OUT(7:0)
            WIRE 2368 848 2400 848
        END BRANCH
        IOMARKER 2400 848 F_BYTE_OUT(7:0) R0 28
        BEGIN BRANCH BF_F13
            WIRE 3088 1040 3120 1040
        END BRANCH
        IOMARKER 3120 1040 BF_F13 R0 28
        BEGIN BRANCH BG_N16
            WIRE 3088 1104 3120 1104
        END BRANCH
        IOMARKER 3120 1104 BG_N16 R0 28
        BEGIN BRANCH BE_R16
            WIRE 3088 976 3120 976
        END BRANCH
        IOMARKER 3120 976 BE_R16 R0 28
        BEGIN BRANCH BD_P15
            WIRE 3088 912 3120 912
        END BRANCH
        IOMARKER 3120 912 BD_P15 R0 28
        BEGIN BRANCH BC_N15
            WIRE 3088 848 3120 848
        END BRANCH
        IOMARKER 3120 848 BC_N15 R0 28
        BEGIN BRANCH BB_G13
            WIRE 3088 784 3120 784
        END BRANCH
        IOMARKER 3120 784 BB_G13 R0 28
        BEGIN BRANCH BA_E14
            WIRE 3088 720 3120 720
        END BRANCH
        IOMARKER 3120 720 BA_E14 R0 28
        INSTANCE XLXI_6 3104 496 R0
        INSTANCE XLXI_7 3104 560 R0
        INSTANCE XLXI_8 3104 624 R0
        INSTANCE XLXI_9 3104 688 R0
        BEGIN BRANCH XLXN_28
            WIRE 3088 464 3104 464
        END BRANCH
        BEGIN BRANCH XLXN_29
            WIRE 3088 528 3104 528
        END BRANCH
        BEGIN BRANCH XLXN_30
            WIRE 3088 592 3104 592
        END BRANCH
        BEGIN BRANCH XLXN_31
            WIRE 3088 656 3104 656
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3328 464 3360 464
        END BRANCH
        IOMARKER 3360 464 AN0_D14 R0 28
        BEGIN BRANCH AN1_G14
            WIRE 3328 528 3360 528
        END BRANCH
        IOMARKER 3360 528 AN1_G14 R0 28
        BEGIN BRANCH AN2_F14
            WIRE 3328 592 3360 592
        END BRANCH
        IOMARKER 3360 592 AN2_F14 R0 28
        BEGIN BRANCH AN3_E13
            WIRE 3328 656 3360 656
        END BRANCH
        IOMARKER 3360 656 AN3_E13 R0 28
        BEGIN INSTANCE XLXI_4 448 784 R0
        END INSTANCE
        IOMARKER 176 320 F_50MHZ_T9 R180 28
        IOMARKER 240 688 STEP_BTN1_M14 R180 28
        IOMARKER 496 976 RUN_BTN2_L13 R180 28
    END SHEET
END SCHEMATIC
