VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_2
        SIGNAL F_50MHZ_T9
        SIGNAL GO_SW7_K13
        SIGNAL STEP_BTN1_M14
        SIGNAL XLXN_33
        SIGNAL XLXN_34
        SIGNAL XLXN_35
        SIGNAL RST_BTN3_L14
        SIGNAL RUN_BTN2_L13
        SIGNAL WE_G3
        SIGNAL OE_K4
        SIGNAL CE1_P7
        SIGNAL STOP_LD0_K12
        SIGNAL COUNT_ADR(18:0)
        SIGNAL XLXN_65
        SIGNAL XLXN_66(3:0)
        SIGNAL XLXN_67(3:0)
        SIGNAL XLXN_68(3:0)
        SIGNAL XLXN_69(3:0)
        SIGNAL XLXN_70
        SIGNAL XLXN_71
        SIGNAL XLXN_72
        SIGNAL XLXN_73
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
        SIGNAL UB1_T4
        SIGNAL LB1_P6
        SIGNAL COUNT_DAT(15:0)
        PORT Input F_50MHZ_T9
        PORT Input GO_SW7_K13
        PORT Input STEP_BTN1_M14
        PORT Input RST_BTN3_L14
        PORT Input RUN_BTN2_L13
        PORT Output WE_G3
        PORT Output OE_K4
        PORT Output CE1_P7
        PORT Output STOP_LD0_K12
        PORT Output COUNT_ADR(18:0)
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
        PORT Output UB1_T4
        PORT Output LB1_P6
        PORT Output COUNT_DAT(15:0)
        BEGIN BLOCKDEF sram_25mhz_255_byte
            TIMESTAMP 2012 12 7 16 15 34
            LINE N 400 32 464 32 
            LINE N 400 96 464 96 
            LINE N 64 -608 0 -608 
            LINE N 64 -464 0 -464 
            LINE N 64 -320 0 -320 
            LINE N 64 -176 0 -176 
            LINE N 64 -32 0 -32 
            LINE N 400 -608 464 -608 
            LINE N 400 -544 464 -544 
            LINE N 400 -480 464 -480 
            LINE N 400 -416 464 -416 
            LINE N 400 -352 464 -352 
            RECTANGLE N 400 -364 464 -340 
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
            RECTANGLE N 64 -640 400 128 
        END BLOCKDEF
        BEGIN BLOCKDEF fd
            TIMESTAMP 2001 2 2 12 37 14
            RECTANGLE N 64 -320 320 -64 
            LINE N 0 -128 64 -128 
            LINE N 0 -256 64 -256 
            LINE N 384 -256 320 -256 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
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
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2012 12 7 13 43 35
            RECTANGLE N 64 -128 320 0 
            LINE N 320 -96 384 -96 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF clock_single_run_src
            TIMESTAMP 2012 12 7 13 32 56
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2012 12 7 13 34 15
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
            TIMESTAMP 2012 12 7 13 34 11
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCK XLXI_3 inv
            PIN I XLXN_34
            PIN O XLXN_2
        END BLOCK
        BEGIN BLOCK XLXI_2 fd
            PIN C F_50MHZ_T9
            PIN D XLXN_2
            PIN Q XLXN_34
        END BLOCK
        BEGIN BLOCK XLXI_21 deb_50mz_100ms_src
            PIN OUT_DEB XLXN_33
            PIN F_50MHZ XLXN_34
            PIN IN_DEB STEP_BTN1_M14
        END BLOCK
        BEGIN BLOCK XLXI_22 clock_single_run_src
            PIN CLK XLXN_34
            PIN SINGLE XLXN_33
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN3_L14
            PIN OUT_NEXT_STATE XLXN_35
        END BLOCK
        BEGIN BLOCK XLXI_1 sram_25mhz_255_byte
            PIN GO GO_SW7_K13
            PIN CLK XLXN_34
            PIN CLK_IO XLXN_34
            PIN IN_NEXT_STATE XLXN_35
            PIN RESET RST_BTN3_L14
            PIN WE WE_G3
            PIN OE OE_K4
            PIN CE1 CE1_P7
            PIN UB1 UB1_T4
            PIN LB1 LB1_P6
            PIN STOP STOP_LD0_K12
            PIN COUNT_ADR_OUT(18:0) COUNT_ADR(18:0)
            PIN COUNT_DAT_OUT(15:0) COUNT_DAT(15:0)
            PIN DISPL1_SV(3:0) XLXN_66(3:0)
            PIN DISPL2_SV(3:0) XLXN_67(3:0)
            PIN DISPL1_n_SV(3:0) XLXN_68(3:0)
            PIN DISPL2_n_SV(3:0) XLXN_69(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_30 f_div50000
            PIN F_IN XLXN_34
            PIN F_OUT XLXN_65
        END BLOCK
        BEGIN BLOCK XLXI_23 nib4_7seg_src
            PIN CLK_DISPL XLXN_65
            PIN NIB0(3:0) XLXN_66(3:0)
            PIN NIB1(3:0) XLXN_67(3:0)
            PIN NIB2(3:0) XLXN_68(3:0)
            PIN NIB3(3:0) XLXN_69(3:0)
            PIN ZI0 XLXN_70
            PIN ZI1 XLXN_71
            PIN ZI2 XLXN_72
            PIN ZI3 XLXN_73
            PIN BA BA_E14
            PIN BB BB_G13
            PIN BC BC_N15
            PIN BD BD_P15
            PIN BE BE_R16
            PIN BF BF_F13
            PIN BG BG_N16
        END BLOCK
        BEGIN BLOCK XLXI_31 inv
            PIN I XLXN_70
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_32 inv
            PIN I XLXN_71
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_33 inv
            PIN I XLXN_72
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_34 inv
            PIN I XLXN_73
            PIN O AN3_E13
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN BRANCH XLXN_2
            WIRE 208 384 208 576
            WIRE 208 576 224 576
            WIRE 208 384 288 384
        END BRANCH
        INSTANCE XLXI_3 512 352 R180
        INSTANCE XLXI_2 224 832 R0
        BEGIN BRANCH F_50MHZ_T9
            WIRE 192 704 224 704
        END BRANCH
        BEGIN BRANCH GO_SW7_K13
            WIRE 1792 432 1840 432
        END BRANCH
        BEGIN INSTANCE XLXI_21 736 1088 R0
        END INSTANCE
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 704 1056 736 1056
        END BRANCH
        BEGIN INSTANCE XLXI_22 1232 1152 R0
        END INSTANCE
        BEGIN BRANCH XLXN_33
            WIRE 1120 992 1232 992
        END BRANCH
        BEGIN BRANCH XLXN_34
            WIRE 512 384 656 384
            WIRE 656 384 656 576
            WIRE 656 576 656 992
            WIRE 656 992 736 992
            WIRE 656 576 1184 576
            WIRE 1184 576 1184 928
            WIRE 1184 928 1232 928
            WIRE 1184 576 1520 576
            WIRE 1520 576 1808 576
            WIRE 1808 576 1840 576
            WIRE 1808 576 1808 720
            WIRE 1808 720 1840 720
            WIRE 608 576 656 576
            WIRE 1520 176 1520 576
            WIRE 1520 176 1872 176
        END BRANCH
        BEGIN BRANCH XLXN_35
            WIRE 1616 928 1680 928
            WIRE 1680 864 1680 928
            WIRE 1680 864 1840 864
        END BRANCH
        BEGIN BRANCH RST_BTN3_L14
            WIRE 992 1312 1168 1312
            WIRE 1168 1312 1680 1312
            WIRE 1168 1120 1232 1120
            WIRE 1168 1120 1168 1312
            WIRE 1680 1008 1840 1008
            WIRE 1680 1008 1680 1312
        END BRANCH
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 992 1216 1136 1216
            WIRE 1136 1056 1136 1216
            WIRE 1136 1056 1232 1056
        END BRANCH
        BEGIN BRANCH WE_G3
            WIRE 2304 432 2336 432
        END BRANCH
        BEGIN BRANCH OE_K4
            WIRE 2304 496 2336 496
        END BRANCH
        BEGIN BRANCH CE1_P7
            WIRE 2304 560 2336 560
        END BRANCH
        BEGIN BRANCH STOP_LD0_K12
            WIRE 2304 624 2336 624
        END BRANCH
        BEGIN BRANCH COUNT_ADR(18:0)
            WIRE 2304 688 2336 688
        END BRANCH
        BEGIN INSTANCE XLXI_1 1840 1040 R0
        END INSTANCE
        IOMARKER 192 704 F_50MHZ_T9 R180 28
        IOMARKER 704 1056 STEP_BTN1_M14 R180 28
        IOMARKER 1792 432 GO_SW7_K13 R180 28
        IOMARKER 992 1216 RUN_BTN2_L13 R180 28
        IOMARKER 992 1312 RST_BTN3_L14 R180 28
        IOMARKER 2336 432 WE_G3 R0 28
        IOMARKER 2336 496 OE_K4 R0 28
        IOMARKER 2336 560 CE1_P7 R0 28
        IOMARKER 2336 624 STOP_LD0_K12 R0 28
        IOMARKER 2336 688 COUNT_ADR(18:0) R0 28
        BEGIN INSTANCE XLXI_30 1872 208 R0
        END INSTANCE
        BEGIN BRANCH XLXN_65
            WIRE 2256 176 2560 176
            WIRE 2560 176 2560 656
            WIRE 2560 656 2704 656
        END BRANCH
        BEGIN BRANCH XLXN_66(3:0)
            WIRE 2304 816 2704 816
        END BRANCH
        BEGIN BRANCH XLXN_67(3:0)
            WIRE 2304 880 2688 880
            WIRE 2688 880 2688 976
            WIRE 2688 976 2704 976
        END BRANCH
        BEGIN BRANCH XLXN_68(3:0)
            WIRE 2304 944 2672 944
            WIRE 2672 944 2672 1136
            WIRE 2672 1136 2704 1136
        END BRANCH
        BEGIN BRANCH XLXN_69(3:0)
            WIRE 2304 1008 2656 1008
            WIRE 2656 1008 2656 1296
            WIRE 2656 1296 2704 1296
        END BRANCH
        BEGIN INSTANCE XLXI_23 2704 1328 R0
        END INSTANCE
        INSTANCE XLXI_31 3120 688 R0
        INSTANCE XLXI_32 3120 752 R0
        INSTANCE XLXI_33 3120 816 R0
        INSTANCE XLXI_34 3120 880 R0
        BEGIN BRANCH XLXN_70
            WIRE 3088 656 3120 656
        END BRANCH
        BEGIN BRANCH XLXN_71
            WIRE 3088 720 3120 720
        END BRANCH
        BEGIN BRANCH XLXN_72
            WIRE 3088 784 3120 784
        END BRANCH
        BEGIN BRANCH XLXN_73
            WIRE 3088 848 3120 848
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3344 656 3376 656
        END BRANCH
        BEGIN BRANCH AN1_G14
            WIRE 3344 720 3376 720
        END BRANCH
        BEGIN BRANCH AN2_F14
            WIRE 3344 784 3376 784
        END BRANCH
        BEGIN BRANCH AN3_E13
            WIRE 3344 848 3376 848
        END BRANCH
        BEGIN BRANCH BA_E14
            WIRE 3088 912 3120 912
        END BRANCH
        BEGIN BRANCH BB_G13
            WIRE 3088 976 3120 976
        END BRANCH
        BEGIN BRANCH BC_N15
            WIRE 3088 1040 3120 1040
        END BRANCH
        BEGIN BRANCH BD_P15
            WIRE 3088 1104 3120 1104
        END BRANCH
        BEGIN BRANCH BE_R16
            WIRE 3088 1168 3120 1168
        END BRANCH
        BEGIN BRANCH BF_F13
            WIRE 3088 1232 3120 1232
        END BRANCH
        BEGIN BRANCH BG_N16
            WIRE 3088 1296 3120 1296
        END BRANCH
        IOMARKER 3376 656 AN0_D14 R0 28
        IOMARKER 3376 720 AN1_G14 R0 28
        IOMARKER 3376 784 AN2_F14 R0 28
        IOMARKER 3376 848 AN3_E13 R0 28
        IOMARKER 3120 912 BA_E14 R0 28
        IOMARKER 3120 976 BB_G13 R0 28
        IOMARKER 3120 1040 BC_N15 R0 28
        IOMARKER 3120 1104 BD_P15 R0 28
        IOMARKER 3120 1168 BE_R16 R0 28
        IOMARKER 3120 1232 BF_F13 R0 28
        IOMARKER 3120 1296 BG_N16 R0 28
        BEGIN BRANCH UB1_T4
            WIRE 2304 1072 2336 1072
        END BRANCH
        IOMARKER 2336 1072 UB1_T4 R0 28
        BEGIN BRANCH LB1_P6
            WIRE 2304 1136 2336 1136
        END BRANCH
        IOMARKER 2336 1136 LB1_P6 R0 28
        BEGIN BRANCH COUNT_DAT(15:0)
            WIRE 2304 752 2336 752
        END BRANCH
        IOMARKER 2336 752 COUNT_DAT(15:0) R0 28
    END SHEET
END SCHEMATIC
