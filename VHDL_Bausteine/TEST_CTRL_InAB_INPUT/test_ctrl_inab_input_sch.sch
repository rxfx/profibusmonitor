VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_6
        SIGNAL XLXN_1
        SIGNAL XLXN_2
        SIGNAL RUN_BTN2_L13
        SIGNAL XLXN_10
        SIGNAL RST_BTN3_L14
        SIGNAL STEP_BTN1_M14
        SIGNAL XLXN_13
        SIGNAL F_50MHZ_T9
        SIGNAL InAB_BTN0_M13
        SIGNAL CV_SW7_K13
        SIGNAL XLXN_17(3:0)
        SIGNAL XLXN_18(3:0)
        SIGNAL XLXN_19(3:0)
        SIGNAL XLXN_20(3:0)
        SIGNAL XLXN_21
        SIGNAL XLXN_22
        SIGNAL BV_LD7_P11
        SIGNAL BC_LD6_P12
        SIGNAL PE_LD5_N12
        SIGNAL EN_BIT_i(8:0)
        SIGNAL XLXN_27
        SIGNAL XLXN_28
        SIGNAL XLXN_29
        SIGNAL XLXN_30
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
        PORT Input RUN_BTN2_L13
        PORT Input RST_BTN3_L14
        PORT Input STEP_BTN1_M14
        PORT Input F_50MHZ_T9
        PORT Input InAB_BTN0_M13
        PORT Input CV_SW7_K13
        PORT Output BV_LD7_P11
        PORT Output BC_LD6_P12
        PORT Output PE_LD5_N12
        PORT Output EN_BIT_i(8:0)
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
            TIMESTAMP 2013 4 25 13 16 28
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF ctrl_inab_input_vhdl
            TIMESTAMP 2013 4 25 13 16 37
            RECTANGLE N 64 -512 384 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -368 0 -368 
            LINE N 64 -256 0 -256 
            LINE N 64 -144 0 -144 
            LINE N 64 -32 0 -32 
            LINE N 384 -480 448 -480 
            LINE N 384 -416 448 -416 
            LINE N 384 -352 448 -352 
            LINE N 384 -288 448 -288 
            RECTANGLE N 384 -300 448 -276 
            LINE N 384 -224 448 -224 
            RECTANGLE N 384 -236 448 -212 
            LINE N 384 -160 448 -160 
            RECTANGLE N 384 -172 448 -148 
            LINE N 384 -96 448 -96 
            RECTANGLE N 384 -108 448 -84 
            LINE N 384 -32 448 -32 
            RECTANGLE N 384 -44 448 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2013 4 25 13 16 46
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF f_div50000
            TIMESTAMP 2013 4 25 13 16 55
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2013 4 25 13 17 7
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
        BEGIN BLOCK XLXI_2 ctrl_inab_input_vhdl
            PIN InAB InAB_BTN0_M13
            PIN CHOSE_VALUE CV_SW7_K13
            PIN CLK F_50MHZ_T9
            PIN IN_NEXT_STATE XLXN_13
            PIN RESET RST_BTN3_L14
            PIN BIT_VALUE BV_LD7_P11
            PIN BYTE_CMPLT BC_LD6_P12
            PIN PAUSE_END PE_LD5_N12
            PIN EN_BIT_i(8:0) EN_BIT_i(8:0)
            PIN DISPL1_SV(3:0) XLXN_17(3:0)
            PIN DISPL2_SV(3:0) XLXN_18(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_19(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_20(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_4 f_div50000
            PIN F_IN F_50MHZ_T9
            PIN F_OUT XLXN_22
        END BLOCK
        BEGIN BLOCK XLXI_5 nib4_7seg_src
            PIN CLK_DISPL XLXN_22
            PIN NIB0(3:0) XLXN_17(3:0)
            PIN NIB1(3:0) XLXN_18(3:0)
            PIN NIB2(3:0) XLXN_19(3:0)
            PIN NIB3(3:0) XLXN_20(3:0)
            PIN ZI0 XLXN_27
            PIN ZI1 XLXN_28
            PIN ZI2 XLXN_29
            PIN ZI3 XLXN_30
            PIN BA BA_E14
            PIN BB BB_G13
            PIN BC BC_N15
            PIN BD BD_P15
            PIN BE BE_R16
            PIN BF BF_F13
            PIN BG BG_N16
        END BLOCK
        BEGIN BLOCK XLXI_1 clock_single_run_src
            PIN CLK F_50MHZ_T9
            PIN SINGLE XLXN_1
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN3_L14
            PIN OUT_NEXT_STATE XLXN_13
        END BLOCK
        BEGIN BLOCK XLXI_3 deb_50mz_100ms_src
            PIN IN_DEB STEP_BTN1_M14
            PIN F_50MHZ F_50MHZ_T9
            PIN OUT_DEB XLXN_1
        END BLOCK
        BEGIN BLOCK XLXI_8 inv
            PIN I XLXN_27
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_9 inv
            PIN I XLXN_28
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_10 inv
            PIN I XLXN_29
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_11 inv
            PIN I XLXN_30
            PIN O AN3_E13
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_1 1104 1120 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_3 528 1056 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1
            WIRE 912 960 1104 960
        END BRANCH
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 336 1152 832 1152
            WIRE 832 1152 960 1152
            WIRE 960 1024 960 1152
            WIRE 960 1024 1104 1024
        END BRANCH
        BEGIN BRANCH RST_BTN3_L14
            WIRE 352 1216 1040 1216
            WIRE 1040 1216 1504 1216
            WIRE 1040 1088 1104 1088
            WIRE 1040 1088 1040 1184
            WIRE 1040 1184 1040 1216
            WIRE 1504 1008 1504 1216
            WIRE 1504 1008 1792 1008
        END BRANCH
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 320 960 528 960
        END BRANCH
        BEGIN INSTANCE XLXI_2 1792 1040 R0
        END INSTANCE
        BEGIN BRANCH XLXN_13
            WIRE 1488 896 1792 896
        END BRANCH
        BEGIN INSTANCE XLXI_4 1792 416 R0
        END INSTANCE
        BEGIN BRANCH F_50MHZ_T9
            WIRE 336 656 400 656
            WIRE 400 656 400 1024
            WIRE 400 1024 528 1024
            WIRE 400 656 1024 656
            WIRE 1024 656 1024 672
            WIRE 1024 672 1024 896
            WIRE 1024 896 1104 896
            WIRE 1024 656 1408 656
            WIRE 1408 656 1408 784
            WIRE 1408 784 1792 784
            WIRE 1408 384 1792 384
            WIRE 1408 384 1408 656
        END BRANCH
        BEGIN BRANCH InAB_BTN0_M13
            WIRE 1760 560 1792 560
        END BRANCH
        IOMARKER 1760 560 InAB_BTN0_M13 R180 28
        BEGIN BRANCH CV_SW7_K13
            WIRE 1760 672 1792 672
        END BRANCH
        IOMARKER 1760 672 CV_SW7_K13 R180 28
        IOMARKER 336 656 F_50MHZ_T9 R180 28
        IOMARKER 320 960 STEP_BTN1_M14 R180 28
        IOMARKER 336 1152 RUN_BTN2_L13 R180 28
        IOMARKER 352 1216 RST_BTN3_L14 R180 28
        BEGIN BRANCH XLXN_17(3:0)
            WIRE 2240 816 2672 816
        END BRANCH
        BEGIN INSTANCE XLXI_5 2672 1328 R0
        END INSTANCE
        BEGIN BRANCH XLXN_18(3:0)
            WIRE 2240 880 2448 880
            WIRE 2448 880 2448 976
            WIRE 2448 976 2672 976
        END BRANCH
        BEGIN BRANCH XLXN_19(3:0)
            WIRE 2240 944 2432 944
            WIRE 2432 944 2432 1136
            WIRE 2432 1136 2672 1136
        END BRANCH
        BEGIN BRANCH XLXN_20(3:0)
            WIRE 2240 1008 2416 1008
            WIRE 2416 1008 2416 1296
            WIRE 2416 1296 2672 1296
        END BRANCH
        BEGIN BRANCH XLXN_22
            WIRE 2176 384 2656 384
            WIRE 2656 384 2656 656
            WIRE 2656 656 2672 656
        END BRANCH
        BEGIN BRANCH BV_LD7_P11
            WIRE 2240 560 2272 560
        END BRANCH
        IOMARKER 2272 560 BV_LD7_P11 R0 28
        BEGIN BRANCH BC_LD6_P12
            WIRE 2240 624 2272 624
        END BRANCH
        IOMARKER 2272 624 BC_LD6_P12 R0 28
        BEGIN BRANCH PE_LD5_N12
            WIRE 2240 688 2272 688
        END BRANCH
        IOMARKER 2272 688 PE_LD5_N12 R0 28
        BEGIN BRANCH EN_BIT_i(8:0)
            WIRE 2240 752 2272 752
        END BRANCH
        IOMARKER 2272 752 EN_BIT_i(8:0) R0 28
        INSTANCE XLXI_8 3072 688 R0
        INSTANCE XLXI_9 3072 752 R0
        INSTANCE XLXI_10 3072 816 R0
        INSTANCE XLXI_11 3072 880 R0
        BEGIN BRANCH XLXN_27
            WIRE 3056 656 3072 656
        END BRANCH
        BEGIN BRANCH XLXN_28
            WIRE 3056 720 3072 720
        END BRANCH
        BEGIN BRANCH XLXN_29
            WIRE 3056 784 3072 784
        END BRANCH
        BEGIN BRANCH XLXN_30
            WIRE 3056 848 3072 848
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3296 656 3328 656
        END BRANCH
        IOMARKER 3328 656 AN0_D14 R0 28
        BEGIN BRANCH AN1_G14
            WIRE 3296 720 3328 720
        END BRANCH
        IOMARKER 3328 720 AN1_G14 R0 28
        BEGIN BRANCH AN2_F14
            WIRE 3296 784 3328 784
        END BRANCH
        IOMARKER 3328 784 AN2_F14 R0 28
        BEGIN BRANCH AN3_E13
            WIRE 3296 848 3328 848
        END BRANCH
        IOMARKER 3328 848 AN3_E13 R0 28
        BEGIN BRANCH BA_E14
            WIRE 3056 912 3088 912
        END BRANCH
        IOMARKER 3088 912 BA_E14 R0 28
        BEGIN BRANCH BB_G13
            WIRE 3056 976 3088 976
        END BRANCH
        IOMARKER 3088 976 BB_G13 R0 28
        BEGIN BRANCH BC_N15
            WIRE 3056 1040 3088 1040
        END BRANCH
        IOMARKER 3088 1040 BC_N15 R0 28
        BEGIN BRANCH BD_P15
            WIRE 3056 1104 3088 1104
        END BRANCH
        IOMARKER 3088 1104 BD_P15 R0 28
        BEGIN BRANCH BE_R16
            WIRE 3056 1168 3088 1168
        END BRANCH
        IOMARKER 3088 1168 BE_R16 R0 28
        BEGIN BRANCH BF_F13
            WIRE 3056 1232 3088 1232
        END BRANCH
        IOMARKER 3088 1232 BF_F13 R0 28
        BEGIN BRANCH BG_N16
            WIRE 3056 1296 3088 1296
        END BRANCH
        IOMARKER 3088 1296 BG_N16 R0 28
    END SHEET
END SCHEMATIC
