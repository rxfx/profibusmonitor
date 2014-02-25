VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        BEGIN BLOCKDEF ctrl_9p6_50mhz_vhdl
            TIMESTAMP 2012 12 14 15 33 41
            RECTANGLE N 64 -640 480 0 
            LINE N 64 -608 0 -608 
            LINE N 64 -544 0 -544 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 480 -608 544 -608 
            LINE N 480 -544 544 -544 
            LINE N 480 -480 544 -480 
            LINE N 480 -416 544 -416 
            LINE N 480 -352 544 -352 
            RECTANGLE N 480 -364 544 -340 
            LINE N 480 -288 544 -288 
            RECTANGLE N 480 -300 544 -276 
            LINE N 480 -224 544 -224 
            RECTANGLE N 480 -236 544 -212 
            LINE N 480 -160 544 -160 
            RECTANGLE N 480 -172 544 -148 
            LINE N 480 -96 544 -96 
            RECTANGLE N 480 -108 544 -84 
        END BLOCKDEF
        BEGIN BLOCKDEF sram_25mhz_255_byte
            TIMESTAMP 2012 12 14 15 33 46
            RECTANGLE N 64 -768 400 0 
            LINE N 64 -736 0 -736 
            LINE N 64 -656 0 -656 
            LINE N 64 -576 0 -576 
            LINE N 64 -496 0 -496 
            LINE N 64 -416 0 -416 
            LINE N 64 -336 0 -336 
            LINE N 64 -256 0 -256 
            LINE N 64 -176 0 -176 
            LINE N 64 -96 0 -96 
            LINE N 400 -736 464 -736 
            LINE N 400 -672 464 -672 
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
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 ctrl_9p6_50mhz_vhdl
            PIN InAB
            PIN ERROR_QUIT
            PIN CHOSE_VALUE
            PIN DISPL_COUNT
            PIN DISPL_COUNT_SWITCH
            PIN STOP
            PIN CLK
            PIN CLK_IO
            PIN IN_NEXT_STATE
            PIN RESET
            PIN CTRL_ERROR
            PIN CTRL_STOP
            PIN BYTE_OK
            PIN PARITY_OK
            PIN BYTE_OUT(7:0)
            PIN DISPL1_SV(3:0)
            PIN DISPL2_SV(3:0)
            PIN DISPL1_n_SV(3:0)
            PIN DISPL2_n_SV(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_2 sram_25mhz_255_byte
            PIN GO
            PIN DISPL_ADR
            PIN DISPL_DAT
            PIN PLUS
            PIN MINUS
            PIN CLK
            PIN CLK_IO
            PIN IN_NEXT_STATE
            PIN RESET
            PIN COUNT_DAT_INOUT(15:0)
            PIN WE
            PIN OE
            PIN CE1
            PIN UB1
            PIN LB1
            PIN STOP
            PIN COUNT_ADR_OUT(18:0)
            PIN DISPL1_SV(3:0)
            PIN DISPL2_SV(3:0)
            PIN DISPL1_n_SV(3:0)
            PIN DISPL2_n_SV(3:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3801 2688
        ATTR LengthUnitName "CM"
        ATTR GridsPerUnit "4"
        BEGIN INSTANCE XLXI_1 503 1216 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_2 1207 1328 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
