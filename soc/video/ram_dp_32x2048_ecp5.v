/* Verilog netlist generated by SCUBA Diamond (64-bit) 3.10.2.115.2 */
/* Module Version: 7.5 */
/* /home/jeroen/diamond/ispfpga/bin/lin64/scuba -w -n ram_dp_32x2048 -lang verilog -synth lse -bus_exp 7 -bb -arch sa5p00 -type bram -wp 11 -rp 1010 -data_width 32 -rdata_width 32 -num_rows 11 -cascade -1 -mem_init0 -writemodeA NORMAL -writemodeB NORMAL -fdc /tmp/test/ram_dp_32x2048/ram_dp_32x2048.fdc  */
/* Tue Nov  5 08:28:10 2019 */


`timescale 1 ns / 1 ps
module ram_dp_32x2048 (DataInA, DataInB, AddressA, AddressB, ClockA, 
    ClockB, ClockEnA, ClockEnB, WrA, WrB, ResetA, ResetB, QA, QB)/* synthesis NGD_DRC_MASK=1 */;
    input wire [31:0] DataInA;
    input wire [31:0] DataInB;
    input wire [3:0] AddressA;
    input wire [3:0] AddressB;
    input wire ClockA;
    input wire ClockB;
    input wire ClockEnA;
    input wire ClockEnB;
    input wire WrA;
    input wire WrB;
    input wire ResetA;
    input wire ResetB;
    output wire [31:0] QA;
    output wire [31:0] QB;

    wire scuba_vhi;
    wire scuba_vlo;
	assign scuba_vhi = 1;
	assign scuba_vlo = 0;

    defparam ram_dp_32x2048_0_0_1.ASYNC_RESET_RELEASE = "SYNC" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_3F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_3E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_3D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_3C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_3B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_3A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_39 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_38 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_37 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_36 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_35 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_34 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_33 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_32 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_31 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_30 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_2F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_2E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_2D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_2C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_2B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_2A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_29 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_28 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_27 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_26 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_25 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_24 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_23 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_22 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_21 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_20 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_1F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_1E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_1D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_1C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_1B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_1A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_19 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_18 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_17 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_16 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_15 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_14 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_13 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_12 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_11 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_10 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_0F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_0E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_0D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_0C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_0B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_0A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_09 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_08 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_07 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_06 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_05 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_04 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_03 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_02 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_01 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.INITVAL_00 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_0_1.CSDECODE_B = "0b000" ;
    defparam ram_dp_32x2048_0_0_1.CSDECODE_A = "0b000" ;
    defparam ram_dp_32x2048_0_0_1.WRITEMODE_B = "NORMAL" ;
    defparam ram_dp_32x2048_0_0_1.WRITEMODE_A = "NORMAL" ;
    defparam ram_dp_32x2048_0_0_1.GSR = "ENABLED" ;
    defparam ram_dp_32x2048_0_0_1.RESETMODE = "ASYNC" ;
    defparam ram_dp_32x2048_0_0_1.REGMODE_B = "NOREG" ;
    defparam ram_dp_32x2048_0_0_1.REGMODE_A = "NOREG" ;
    defparam ram_dp_32x2048_0_0_1.DATA_WIDTH_B = 18 ;
    defparam ram_dp_32x2048_0_0_1.DATA_WIDTH_A = 18 ;
    DP16KD ram_dp_32x2048_0_0_1 (.DIA17(DataInA[17]), .DIA16(DataInA[16]), 
        .DIA15(DataInA[15]), .DIA14(DataInA[14]), .DIA13(DataInA[13]), .DIA12(DataInA[12]), 
        .DIA11(DataInA[11]), .DIA10(DataInA[10]), .DIA9(DataInA[9]), .DIA8(DataInA[8]), 
        .DIA7(DataInA[7]), .DIA6(DataInA[6]), .DIA5(DataInA[5]), .DIA4(DataInA[4]), 
        .DIA3(DataInA[3]), .DIA2(DataInA[2]), .DIA1(DataInA[1]), .DIA0(DataInA[0]), 
        .ADA13(scuba_vlo), .ADA12(scuba_vlo), .ADA11(scuba_vlo), .ADA10(scuba_vlo), 
        .ADA9(scuba_vlo), .ADA8(scuba_vlo), .ADA7(AddressA[3]), .ADA6(AddressA[2]), 
        .ADA5(AddressA[1]), .ADA4(AddressA[0]), .ADA3(scuba_vlo), .ADA2(scuba_vlo), 
        .ADA1(scuba_vhi), .ADA0(scuba_vhi), .CEA(ClockEnA), .OCEA(ClockEnA), 
        .CLKA(ClockA), .WEA(WrA), .CSA2(scuba_vlo), .CSA1(scuba_vlo), .CSA0(scuba_vlo), 
        .RSTA(ResetA), .DIB17(DataInB[17]), .DIB16(DataInB[16]), .DIB15(DataInB[15]), 
        .DIB14(DataInB[14]), .DIB13(DataInB[13]), .DIB12(DataInB[12]), .DIB11(DataInB[11]), 
        .DIB10(DataInB[10]), .DIB9(DataInB[9]), .DIB8(DataInB[8]), .DIB7(DataInB[7]), 
        .DIB6(DataInB[6]), .DIB5(DataInB[5]), .DIB4(DataInB[4]), .DIB3(DataInB[3]), 
        .DIB2(DataInB[2]), .DIB1(DataInB[1]), .DIB0(DataInB[0]), .ADB13(scuba_vlo), 
        .ADB12(scuba_vlo), .ADB11(scuba_vlo), .ADB10(scuba_vlo), .ADB9(scuba_vlo), 
        .ADB8(scuba_vlo), .ADB7(AddressB[3]), .ADB6(AddressB[2]), .ADB5(AddressB[1]), 
        .ADB4(AddressB[0]), .ADB3(scuba_vlo), .ADB2(scuba_vlo), .ADB1(scuba_vhi), 
        .ADB0(scuba_vhi), .CEB(ClockEnB), .OCEB(ClockEnB), .CLKB(ClockB), 
        .WEB(WrB), .CSB2(scuba_vlo), .CSB1(scuba_vlo), .CSB0(scuba_vlo), 
        .RSTB(ResetB), .DOA17(QA[17]), .DOA16(QA[16]), .DOA15(QA[15]), .DOA14(QA[14]), 
        .DOA13(QA[13]), .DOA12(QA[12]), .DOA11(QA[11]), .DOA10(QA[10]), 
        .DOA9(QA[9]), .DOA8(QA[8]), .DOA7(QA[7]), .DOA6(QA[6]), .DOA5(QA[5]), 
        .DOA4(QA[4]), .DOA3(QA[3]), .DOA2(QA[2]), .DOA1(QA[1]), .DOA0(QA[0]), 
        .DOB17(QB[17]), .DOB16(QB[16]), .DOB15(QB[15]), .DOB14(QB[14]), 
        .DOB13(QB[13]), .DOB12(QB[12]), .DOB11(QB[11]), .DOB10(QB[10]), 
        .DOB9(QB[9]), .DOB8(QB[8]), .DOB7(QB[7]), .DOB6(QB[6]), .DOB5(QB[5]), 
        .DOB4(QB[4]), .DOB3(QB[3]), .DOB2(QB[2]), .DOB1(QB[1]), .DOB0(QB[0]))
             /* synthesis MEM_LPC_FILE="ram_dp_32x2048.lpc" */
             /* synthesis MEM_INIT_FILE="INIT_ALL_0s" */;



    defparam ram_dp_32x2048_0_1_0.ASYNC_RESET_RELEASE = "SYNC" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_3F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_3E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_3D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_3C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_3B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_3A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_39 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_38 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_37 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_36 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_35 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_34 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_33 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_32 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_31 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_30 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_2F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_2E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_2D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_2C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_2B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_2A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_29 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_28 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_27 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_26 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_25 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_24 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_23 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_22 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_21 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_20 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_1F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_1E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_1D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_1C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_1B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_1A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_19 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_18 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_17 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_16 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_15 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_14 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_13 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_12 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_11 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_10 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_0F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_0E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_0D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_0C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_0B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_0A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_09 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_08 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_07 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_06 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_05 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_04 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_03 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_02 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_01 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.INITVAL_00 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam ram_dp_32x2048_0_1_0.CSDECODE_B = "0b000" ;
    defparam ram_dp_32x2048_0_1_0.CSDECODE_A = "0b000" ;
    defparam ram_dp_32x2048_0_1_0.WRITEMODE_B = "NORMAL" ;
    defparam ram_dp_32x2048_0_1_0.WRITEMODE_A = "NORMAL" ;
    defparam ram_dp_32x2048_0_1_0.GSR = "ENABLED" ;
    defparam ram_dp_32x2048_0_1_0.RESETMODE = "ASYNC" ;
    defparam ram_dp_32x2048_0_1_0.REGMODE_B = "NOREG" ;
    defparam ram_dp_32x2048_0_1_0.REGMODE_A = "NOREG" ;
    defparam ram_dp_32x2048_0_1_0.DATA_WIDTH_B = 18 ;
    defparam ram_dp_32x2048_0_1_0.DATA_WIDTH_A = 18 ;
    DP16KD ram_dp_32x2048_0_1_0 (.DIA17(scuba_vlo), .DIA16(scuba_vlo), .DIA15(scuba_vlo), 
        .DIA14(scuba_vlo), .DIA13(DataInA[31]), .DIA12(DataInA[30]), .DIA11(DataInA[29]), 
        .DIA10(DataInA[28]), .DIA9(DataInA[27]), .DIA8(DataInA[26]), .DIA7(DataInA[25]), 
        .DIA6(DataInA[24]), .DIA5(DataInA[23]), .DIA4(DataInA[22]), .DIA3(DataInA[21]), 
        .DIA2(DataInA[20]), .DIA1(DataInA[19]), .DIA0(DataInA[18]), .ADA13(scuba_vlo), 
        .ADA12(scuba_vlo), .ADA11(scuba_vlo), .ADA10(scuba_vlo), .ADA9(scuba_vlo), 
        .ADA8(scuba_vlo), .ADA7(AddressA[3]), .ADA6(AddressA[2]), .ADA5(AddressA[1]), 
        .ADA4(AddressA[0]), .ADA3(scuba_vlo), .ADA2(scuba_vlo), .ADA1(scuba_vhi), 
        .ADA0(scuba_vhi), .CEA(ClockEnA), .OCEA(ClockEnA), .CLKA(ClockA), 
        .WEA(WrA), .CSA2(scuba_vlo), .CSA1(scuba_vlo), .CSA0(scuba_vlo), 
        .RSTA(ResetA), .DIB17(scuba_vlo), .DIB16(scuba_vlo), .DIB15(scuba_vlo), 
        .DIB14(scuba_vlo), .DIB13(DataInB[31]), .DIB12(DataInB[30]), .DIB11(DataInB[29]), 
        .DIB10(DataInB[28]), .DIB9(DataInB[27]), .DIB8(DataInB[26]), .DIB7(DataInB[25]), 
        .DIB6(DataInB[24]), .DIB5(DataInB[23]), .DIB4(DataInB[22]), .DIB3(DataInB[21]), 
        .DIB2(DataInB[20]), .DIB1(DataInB[19]), .DIB0(DataInB[18]), .ADB13(scuba_vlo), 
        .ADB12(scuba_vlo), .ADB11(scuba_vlo), .ADB10(scuba_vlo), .ADB9(scuba_vlo), 
        .ADB8(scuba_vlo), .ADB7(AddressB[3]), .ADB6(AddressB[2]), .ADB5(AddressB[1]), 
        .ADB4(AddressB[0]), .ADB3(scuba_vlo), .ADB2(scuba_vlo), .ADB1(scuba_vhi), 
        .ADB0(scuba_vhi), .CEB(ClockEnB), .OCEB(ClockEnB), .CLKB(ClockB), 
        .WEB(WrB), .CSB2(scuba_vlo), .CSB1(scuba_vlo), .CSB0(scuba_vlo), 
        .RSTB(ResetB), .DOA17(), .DOA16(), .DOA15(), .DOA14(), .DOA13(QA[31]), 
        .DOA12(QA[30]), .DOA11(QA[29]), .DOA10(QA[28]), .DOA9(QA[27]), .DOA8(QA[26]), 
        .DOA7(QA[25]), .DOA6(QA[24]), .DOA5(QA[23]), .DOA4(QA[22]), .DOA3(QA[21]), 
        .DOA2(QA[20]), .DOA1(QA[19]), .DOA0(QA[18]), .DOB17(), .DOB16(), 
        .DOB15(), .DOB14(), .DOB13(QB[31]), .DOB12(QB[30]), .DOB11(QB[29]), 
        .DOB10(QB[28]), .DOB9(QB[27]), .DOB8(QB[26]), .DOB7(QB[25]), .DOB6(QB[24]), 
        .DOB5(QB[23]), .DOB4(QB[22]), .DOB3(QB[21]), .DOB2(QB[20]), .DOB1(QB[19]), 
        .DOB0(QB[18]))
             /* synthesis MEM_LPC_FILE="ram_dp_32x2048.lpc" */
             /* synthesis MEM_INIT_FILE="INIT_ALL_0s" */;



    // exemplar begin
    // exemplar attribute ram_dp_32x2048_0_0_1 MEM_LPC_FILE ram_dp_32x2048.lpc
    // exemplar attribute ram_dp_32x2048_0_0_1 MEM_INIT_FILE INIT_ALL_0s
    // exemplar attribute ram_dp_32x2048_0_1_0 MEM_LPC_FILE ram_dp_32x2048.lpc
    // exemplar attribute ram_dp_32x2048_0_1_0 MEM_INIT_FILE INIT_ALL_0s
    // exemplar end

endmodule
