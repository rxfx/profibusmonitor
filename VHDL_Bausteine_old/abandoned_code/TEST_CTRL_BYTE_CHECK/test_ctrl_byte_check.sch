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
        SIGNAL BYTE_NUM(7:0)
        SIGNAL BO_LD0_K12
        SIGNAL XLXN_16
        SIGNAL XLXN_17
        SIGNAL XLXN_18
        SIGNAL XLXN_19
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
        SIGNAL RUN_BTN2_L13
        SIGNAL F_59MHZ_T9
        SIGNAL XLXN_38
        SIGNAL NB_SW7_K13
        SIGNAL PO_SW6_K14
        SIGNAL BC_SW5_J13
        SIGNAL DC_SW0_F12
        SIGNAL STEP_BTN1_M14
        PORT Output BYTE_NUM(7:0)
        PORT Output BO_LD0_K12
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
        PORT Input RUN_BTN2_L13
        PORT Input F_59MHZ_T9
        PORT Input NB_SW7_K13
        PORT Input PO_SW6_K14
        PORT Input BC_SW5_J13
        PORT Input DC_SW0_F12
        PORT Input STEP_BTN1_M14
        BEGIN BLOCKDEF ctrl_byte_check
            TIMESTAMP 2012 12 19 16 16 32
            RECTANGLE N 64 -512 384 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 384 -480 448 -480 
            LINE N 384 -400 448 -400 
            RECTANGLE N 384 -412 448 -388 
            LINE N 384 -320 448 -320 
            RECTANGLE N 384 -332 448 -308 
            LINE N 384 -240 448 -240 
            RECTANGLE N 384 -252 448 -228 
            LINE N 384 -160 448 -160 
            RECTANGLE N 384 -172 448 -148 
            LINE N 384 -80 448 -80 
            RECTANGLE N 384 -92 448 -68 
        END BLOCKDEF
        BEGIN BLOCKDEF nib4_7seg_src
            TIMESTAMP 2012 12 19 16 25 19
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
            TIMESTAMP 2012 12 19 16 25 33
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF deb_50mz_100ms_src
            TIMESTAMP 2012 12 19 16 30 43
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
        BEGIN BLOCKDEF f_div50000
            TIMESTAMP 2012 12 19 16 46 59
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 ctrl_byte_check
            PIN NEXT_BYTE NB_SW7_K13
            PIN PARITY_OK PO_SW6_K14
            PIN BYTE_CMPLT BC_SW5_J13
            PIN DISPL_COUNT DC_SW0_F12
            PIN CLK F_59MHZ_T9
            PIN CLK_IO F_59MHZ_T9
            PIN IN_NEXT_STATE XLXN_31
            PIN RESET RST_BTN3_L14
            PIN BYTE_OK BO_LD0_K12
            PIN BYTE_NUM(7:0) BYTE_NUM(7:0)
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
            PIN ZI0 XLXN_16
            PIN ZI1 XLXN_17
            PIN ZI2 XLXN_18
            PIN ZI3 XLXN_19
            PIN BA BA_E14
            PIN BB BB_G13
            PIN BC BC_N15
            PIN BD BD_P15
            PIN BE BE_R16
            PIN BF BF_F13
            PIN BG BG_N16
        END BLOCK
        BEGIN BLOCK XLXI_4 clock_single_run_src
            PIN CLK F_59MHZ_T9
            PIN SINGLE XLXN_38
            PIN RUN_R RUN_BTN2_L13
            PIN RESET RST_BTN3_L14
            PIN OUT_NEXT_STATE XLXN_31
        END BLOCK
        BEGIN BLOCK XLXI_5 deb_50mz_100ms_src
            PIN OUT_DEB XLXN_38
            PIN F_50MHZ F_59MHZ_T9
            PIN IN_DEB STEP_BTN1_M14
        END BLOCK
        BEGIN BLOCK XLXI_6 inv
            PIN I XLXN_16
            PIN O AN0_D14
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I XLXN_17
            PIN O AN1_G14
        END BLOCK
        BEGIN BLOCK XLXI_8 inv
            PIN I XLXN_18
            PIN O AN2_F14
        END BLOCK
        BEGIN BLOCK XLXI_9 inv
            PIN I XLXN_19
            PIN O AN3_E13
        END BLOCK
        BEGIN BLOCK XLXI_10 f_div50000
            PIN F_IN F_59MHZ_T9
            PIN F_OUT XLXN_1
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_1 1840 1792 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_4 928 1536 R0
        END INSTANCE
        BEGIN BRANCH XLXN_2(3:0)
            WIRE 2288 1472 2544 1472
            WIRE 2544 1312 2544 1472
            WIRE 2544 1312 2640 1312
        END BRANCH
        BEGIN BRANCH XLXN_3(3:0)
            WIRE 2288 1552 2592 1552
            WIRE 2592 1472 2640 1472
            WIRE 2592 1472 2592 1552
        END BRANCH
        BEGIN BRANCH XLXN_4(3:0)
            WIRE 2288 1632 2640 1632
        END BRANCH
        BEGIN BRANCH XLXN_5(3:0)
            WIRE 2288 1712 2592 1712
            WIRE 2592 1712 2592 1792
            WIRE 2592 1792 2640 1792
        END BRANCH
        BEGIN BRANCH BYTE_NUM(7:0)
            WIRE 2288 1392 2320 1392
        END BRANCH
        IOMARKER 2320 1392 BYTE_NUM(7:0) R0 28
        BEGIN BRANCH BO_LD0_K12
            WIRE 2288 1312 2320 1312
        END BRANCH
        IOMARKER 2320 1312 BO_LD0_K12 R0 28
        BEGIN BRANCH XLXN_1
            WIRE 2256 1152 2640 1152
        END BRANCH
        BEGIN INSTANCE XLXI_2 2640 1824 R0
        END INSTANCE
        INSTANCE XLXI_6 3040 1184 R0
        INSTANCE XLXI_7 3040 1248 R0
        INSTANCE XLXI_8 3040 1312 R0
        INSTANCE XLXI_9 3040 1376 R0
        BEGIN BRANCH XLXN_16
            WIRE 3024 1152 3040 1152
        END BRANCH
        BEGIN BRANCH XLXN_17
            WIRE 3024 1216 3040 1216
        END BRANCH
        BEGIN BRANCH XLXN_18
            WIRE 3024 1280 3040 1280
        END BRANCH
        BEGIN BRANCH XLXN_19
            WIRE 3024 1344 3040 1344
        END BRANCH
        BEGIN BRANCH AN0_D14
            WIRE 3264 1152 3296 1152
        END BRANCH
        IOMARKER 3296 1152 AN0_D14 R0 28
        BEGIN BRANCH AN1_G14
            WIRE 3264 1216 3296 1216
        END BRANCH
        IOMARKER 3296 1216 AN1_G14 R0 28
        BEGIN BRANCH AN2_F14
            WIRE 3264 1280 3296 1280
        END BRANCH
        IOMARKER 3296 1280 AN2_F14 R0 28
        BEGIN BRANCH AN3_E13
            WIRE 3264 1344 3296 1344
        END BRANCH
        IOMARKER 3296 1344 AN3_E13 R0 28
        BEGIN BRANCH BA_E14
            WIRE 3024 1408 3056 1408
        END BRANCH
        IOMARKER 3056 1408 BA_E14 R0 28
        BEGIN BRANCH BB_G13
            WIRE 3024 1472 3056 1472
        END BRANCH
        IOMARKER 3056 1472 BB_G13 R0 28
        BEGIN BRANCH BC_N15
            WIRE 3024 1536 3056 1536
        END BRANCH
        IOMARKER 3056 1536 BC_N15 R0 28
        BEGIN BRANCH BD_P15
            WIRE 3024 1600 3056 1600
        END BRANCH
        IOMARKER 3056 1600 BD_P15 R0 28
        BEGIN BRANCH BE_R16
            WIRE 3024 1664 3056 1664
        END BRANCH
        IOMARKER 3056 1664 BE_R16 R0 28
        BEGIN BRANCH BF_F13
            WIRE 3024 1728 3056 1728
        END BRANCH
        IOMARKER 3056 1728 BF_F13 R0 28
        BEGIN BRANCH BG_N16
            WIRE 3024 1792 3056 1792
        END BRANCH
        IOMARKER 3056 1792 BG_N16 R0 28
        BEGIN BRANCH XLXN_31
            WIRE 1312 1312 1312 1696
            WIRE 1312 1696 1840 1696
        END BRANCH
        BEGIN BRANCH RST_BTN3_L14
            WIRE 224 1760 912 1760
            WIRE 912 1760 1840 1760
            WIRE 912 1504 928 1504
            WIRE 912 1504 912 1760
        END BRANCH
        BEGIN BRANCH F_59MHZ_T9
            WIRE 224 1152 320 1152
            WIRE 320 1152 864 1152
            WIRE 864 1152 864 1312
            WIRE 864 1312 928 1312
            WIRE 864 1152 1360 1152
            WIRE 1360 1152 1360 1568
            WIRE 1360 1568 1360 1632
            WIRE 1360 1632 1840 1632
            WIRE 1360 1568 1840 1568
            WIRE 1360 1152 1872 1152
            WIRE 320 1152 320 1376
            WIRE 320 1376 400 1376
        END BRANCH
        BEGIN INSTANCE XLXI_5 400 1472 R0
        END INSTANCE
        BEGIN BRANCH XLXN_38
            WIRE 784 1376 928 1376
        END BRANCH
        BEGIN BRANCH NB_SW7_K13
            WIRE 1808 1312 1840 1312
        END BRANCH
        IOMARKER 1808 1312 NB_SW7_K13 R180 28
        BEGIN BRANCH PO_SW6_K14
            WIRE 1808 1376 1840 1376
        END BRANCH
        IOMARKER 1808 1376 PO_SW6_K14 R180 28
        BEGIN BRANCH BC_SW5_J13
            WIRE 1808 1440 1840 1440
        END BRANCH
        IOMARKER 1808 1440 BC_SW5_J13 R180 28
        BEGIN BRANCH DC_SW0_F12
            WIRE 1808 1504 1840 1504
        END BRANCH
        IOMARKER 1808 1504 DC_SW0_F12 R180 28
        BEGIN BRANCH STEP_BTN1_M14
            WIRE 224 1440 384 1440
            WIRE 384 1440 400 1440
        END BRANCH
        IOMARKER 224 1584 RUN_BTN2_L13 R180 28
        BEGIN BRANCH RUN_BTN2_L13
            WIRE 224 1584 800 1584
            WIRE 800 1440 800 1584
            WIRE 800 1440 912 1440
            WIRE 912 1440 928 1440
        END BRANCH
        IOMARKER 224 1760 RST_BTN3_L14 R180 28
        IOMARKER 224 1440 STEP_BTN1_M14 R180 28
        IOMARKER 224 1152 F_59MHZ_T9 R180 28
        BEGIN INSTANCE XLXI_10 1872 1184 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
