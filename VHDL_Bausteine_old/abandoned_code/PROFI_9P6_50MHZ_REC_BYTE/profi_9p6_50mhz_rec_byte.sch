VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL BYTE_OUT(7:0)
        SIGNAL BYTE_NUM(7:0)
        SIGNAL T_CMPLT
        SIGNAL T_LENGTH(7:0)
        SIGNAL T_TYPE(3:0)
        SIGNAL BYTE_OK
        SIGNAL InAB
        SIGNAL NEXT_BYTE
        SIGNAL IN_NEXT_STATE
        SIGNAL RESET
        SIGNAL NEXT_TELEGRAM
        SIGNAL CLK
        SIGNAL CLK_IO
        PORT Output BYTE_OUT(7:0)
        PORT Output BYTE_NUM(7:0)
        PORT Output T_CMPLT
        PORT Output T_LENGTH(7:0)
        PORT Output T_TYPE(3:0)
        PORT Output BYTE_OK
        PORT Input InAB
        PORT Input NEXT_BYTE
        PORT Input IN_NEXT_STATE
        PORT Input RESET
        PORT Input NEXT_TELEGRAM
        PORT Input CLK
        PORT Input CLK_IO
        BEGIN BLOCKDEF ctrl_9p6_50mhz_vhdl
            TIMESTAMP 2013 1 8 17 49 1
            RECTANGLE N 64 -576 480 0 
            LINE N 64 -544 0 -544 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 480 -544 544 -544 
            LINE N 480 -464 544 -464 
            RECTANGLE N 480 -476 544 -452 
            LINE N 480 -384 544 -384 
            RECTANGLE N 480 -396 544 -372 
        END BLOCKDEF
        BEGIN BLOCKDEF ctrl_telegram_check
            TIMESTAMP 2013 1 8 16 19 41
            RECTANGLE N 64 -512 480 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 480 -480 544 -480 
            LINE N 480 -416 544 -416 
            RECTANGLE N 480 -428 544 -404 
            LINE N 480 -352 544 -352 
            RECTANGLE N 480 -364 544 -340 
        END BLOCKDEF
        BEGIN BLOCK XLXI_3 ctrl_telegram_check
            PIN NEXT_TELEGRAM NEXT_TELEGRAM
            PIN CLK CLK
            PIN CLK_IO CLK_IO
            PIN IN_NEXT_STATE IN_NEXT_STATE
            PIN RESET RESET
            PIN BYTE_IN(7:0) BYTE_OUT(7:0)
            PIN BYTE_NUM(7:0) BYTE_NUM(7:0)
            PIN TELEGRAM_CMPLT T_CMPLT
            PIN TELEGRAM_LENGTH(7:0) T_LENGTH(7:0)
            PIN TELEGRAM_TYPE(3:0) T_TYPE(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_4 ctrl_9p6_50mhz_vhdl
            PIN InAB InAB
            PIN NEXT_BYTE NEXT_BYTE
            PIN CLK CLK
            PIN CLK_IO CLK_IO
            PIN IN_NEXT_STATE IN_NEXT_STATE
            PIN RESET RESET
            PIN BYTE_OK BYTE_OK
            PIN BYTE_OUT(7:0) BYTE_OUT(7:0)
            PIN BYTE_NUM(7:0) BYTE_NUM(7:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN BRANCH BYTE_OUT(7:0)
            WIRE 1872 656 1968 656
            WIRE 1968 656 2576 656
            WIRE 1968 144 1968 656
            WIRE 1968 144 3152 144
        END BRANCH
        BEGIN INSTANCE XLXI_3 2576 752 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_4 1328 1120 R0
        END INSTANCE
        BEGIN BRANCH T_CMPLT
            WIRE 3120 272 3152 272
        END BRANCH
        BEGIN BRANCH T_LENGTH(7:0)
            WIRE 3120 336 3152 336
        END BRANCH
        BEGIN BRANCH T_TYPE(3:0)
            WIRE 3120 400 3152 400
        END BRANCH
        IOMARKER 3152 272 T_CMPLT R0 28
        IOMARKER 3152 336 T_LENGTH(7:0) R0 28
        IOMARKER 3152 400 T_TYPE(3:0) R0 28
        BEGIN BRANCH BYTE_OK
            WIRE 1872 576 1888 576
            WIRE 1888 80 3152 80
            WIRE 1888 80 1888 576
        END BRANCH
        IOMARKER 3152 144 BYTE_OUT(7:0) R0 28
        IOMARKER 3152 80 BYTE_OK R0 28
        IOMARKER 3168 800 BYTE_NUM(7:0) R0 28
        BEGIN BRANCH BYTE_NUM(7:0)
            WIRE 1872 736 2512 736
            WIRE 2512 736 2512 800
            WIRE 2512 800 3168 800
            WIRE 2512 720 2576 720
            WIRE 2512 720 2512 736
        END BRANCH
        BEGIN BRANCH InAB
            WIRE 320 576 1328 576
        END BRANCH
        BEGIN BRANCH NEXT_BYTE
            WIRE 320 832 1328 832
        END BRANCH
        BEGIN BRANCH IN_NEXT_STATE
            WIRE 320 320 1232 320
            WIRE 1232 320 1232 1024
            WIRE 1232 1024 1328 1024
            WIRE 1232 320 2368 320
            WIRE 2368 320 2368 528
            WIRE 2368 528 2576 528
        END BRANCH
        BEGIN BRANCH RESET
            WIRE 320 1088 1248 1088
            WIRE 1248 1088 1328 1088
            WIRE 1248 1088 1248 1184
            WIRE 1248 1184 2464 1184
            WIRE 2464 592 2576 592
            WIRE 2464 592 2464 1184
        END BRANCH
        IOMARKER 320 320 IN_NEXT_STATE R180 28
        IOMARKER 320 576 InAB R180 28
        IOMARKER 320 832 NEXT_BYTE R180 28
        IOMARKER 320 1088 RESET R180 28
        BEGIN BRANCH NEXT_TELEGRAM
            WIRE 320 272 2576 272
        END BRANCH
        IOMARKER 320 272 NEXT_TELEGRAM R180 28
        BEGIN BRANCH CLK
            WIRE 320 896 1008 896
            WIRE 1008 896 1328 896
            WIRE 1008 400 1008 896
            WIRE 1008 400 2576 400
        END BRANCH
        BEGIN BRANCH CLK_IO
            WIRE 320 960 1072 960
            WIRE 1072 960 1328 960
            WIRE 1072 464 1072 960
            WIRE 1072 464 2576 464
        END BRANCH
        IOMARKER 320 896 CLK R180 28
        IOMARKER 320 960 CLK_IO R180 28
    END SHEET
END SCHEMATIC
