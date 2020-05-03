//////////////////////////////////////////////////////////////////////////////////
// Engineer: Rafael de Oliveira Calçada (rafaelcalcada@gmail.com)
// 
// Create Date: 02.05.2020 15:45:27
// Module Name: tb_csr_file
// Project Name: Steel Core
// Description: RISC-V Steel Core CSR File testbench
// 
// Dependencies: csr_file.v
// 
// Version 0.01
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "../globals.vh"

module tb_machine_mode();

    reg CLK;
    reg RESET;
    
    reg ILLEGAL_INSTR;
    reg MISALIGNED_INSTR;
    
    reg [6:2] OPCODE_6_TO_2;
    reg [2:0] FUNCT3;
    reg [6:0] FUNCT7;
    reg [4:0] RS1_ADDR;
    reg [4:0] RS2_ADDR;
    reg [4:0] RD_ADDR;
    
    reg E_IRQ;
    reg T_IRQ;
    reg S_IRQ;

    reg MIE;
    reg MEIE;
    reg MTIE;
    reg MSIE;
    reg MEIP;
    reg MTIP;
    reg MSIP;         
    
    wire I_OR_E;
    wire SET_EPC;
    wire SET_CAUSE;
    wire [3:0] CAUSE;
    wire INSTRET_INC;
    wire MIE_CLEAR;
    wire MIE_SET;
    
    wire [1:0] PC_SRC;
    
    wire STALL;
    
    machine_control dut(

        .CLK(CLK),
        .RESET(RESET),
        
        .ILLEGAL_INSTR(ILLEGAL_INSTR),
        .MISALIGNED_INSTR(MISALIGNED_INSTR),
        
        .OPCODE_6_TO_2(OPCODE_6_TO_2),
        .FUNCT3(FUNCT3),
        .FUNCT7(FUNCT7),
        .RS1_ADDR(RS1_ADDR),
        .RS2_ADDR(RS2_ADDR),
        .RD_ADDR(RD_ADDR),
        
        .E_IRQ(E_IRQ),
        .T_IRQ(T_IRQ),
        .S_IRQ(S_IRQ),
        
        .I_OR_E(I_OR_E),
        .SET_CAUSE(SET_CAUSE),
        .CAUSE(CAUSE),
        .SET_EPC(SET_EPC),
        .INSTRET_INC(INSTRET_INC),
        .MIE_CLEAR(MIE_CLEAR),
        .MIE_SET(MIE_SET),
        .MIE(MIE),
        .MEIE(MEIE),
        .MTIE(MTIE),
        .MSIE(MSIE),
        .MEIP(MEIP),
        .MTIP(MTIP),
        .MSIP(MSIP),
        
        .PC_SRC(PC_SRC),
        
        .STALL(STALL)

    );
    
    always
    begin
        #10 CLK = !CLK;
    end
    
    initial
    begin
    
        $display("Testing Machine Mode Control module...");
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        ILLEGAL_INSTR = 1'b0;
        MISALIGNED_INSTR = 1'b0;
                
        OPCODE_6_TO_2 = `OPCODE_OP;
        FUNCT3 = `FUNCT3_ADD;
        FUNCT7 = `FUNCT7_ADD;
        RS1_ADDR = 5'b00000;
        RS2_ADDR = 5'b00000;
        RD_ADDR = 5'b00000;
        
        E_IRQ = 1'b0;
        T_IRQ = 1'b0;
        S_IRQ = 1'b0;
    
        MIE = 1'b0;
        MEIE = 1'b0;
        MTIE = 1'b0;
        MSIE = 1'b0;
        MEIP = 1'b0;
        MTIP = 1'b0;
        MSIP = 1'b0;
        
        $display("Testing RESET state...");
        
        #5;
        RESET = 1'b1;
        #15;
        RESET = 1'b0;
        
        if(PC_SRC != `BOOT)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_SET != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        $display("RESET state values OK.");
        
        #20;
        
        /************************************************************
        *************************************************************
        ************************************************************/
        
        $display("Testing OPERATING state...");
        
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_SET != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        $display("OPERATING state values OK.");
        
        /************************************************************
        *************************************************************
        ************************************************************/
        
        $display("Testing if the machine keeps in operating state when MIE=0 for all kinds of interrupt...");
        
        E_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        E_IRQ = 1'b0;
        
        T_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        T_IRQ = 1'b0;
        
        S_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        S_IRQ = 1'b0;
        
        $display("Test OK.");
        
        /************************************************************
        *************************************************************
        ************************************************************/
        
        $display("Testing if the machine changes it state when MIE=0 for all kinds of exceptions.");
        
        MIE = 1'b0;
        ILLEGAL_INSTR = 1'b1;
        #20;
        if(PC_SRC != `TRAP)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(CAUSE != 4'b0010)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        ILLEGAL_INSTR = 1'b0;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        
        MISALIGNED_INSTR = 1'b1;
        #20;
        if(PC_SRC != `TRAP)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(CAUSE != 4'b0000)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        MISALIGNED_INSTR = 1'b0;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
               
        OPCODE_6_TO_2 = `OPCODE_SYSTEM;
        FUNCT3 = `FUNCT3_ECALL;
        FUNCT7 = `FUNCT7_ECALL;
        RS1_ADDR = `RS1_ECALL;
        RS2_ADDR = `RS2_ECALL;
        RD_ADDR = `RD_ECALL;
        #20;
        if(PC_SRC != `TRAP)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(CAUSE != 4'b1011)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        OPCODE_6_TO_2 = `OPCODE_OP;
        FUNCT3 = `FUNCT3_ADD;
        FUNCT7 = `FUNCT7_ADD;
        RS1_ADDR = 5'b00000;
        RS2_ADDR = 5'b00000;
        RD_ADDR = 5'b00000;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        
        OPCODE_6_TO_2 = `OPCODE_SYSTEM;
        FUNCT3 = `FUNCT3_EBREAK;
        FUNCT7 = `FUNCT7_EBREAK;
        RS1_ADDR = `RS1_EBREAK;
        RS2_ADDR = `RS2_EBREAK;
        RD_ADDR = `RD_EBREAK;
        #20;
        if(PC_SRC != `TRAP)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(CAUSE != 4'b0011)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        OPCODE_6_TO_2 = `OPCODE_OP;
        FUNCT3 = `FUNCT3_ADD;
        FUNCT7 = `FUNCT7_ADD;
        RS1_ADDR = 5'b00000;
        RS2_ADDR = 5'b00000;
        RD_ADDR = 5'b00000;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end        
        
        $display("Test OK.");  
        
        /************************************************************
        *************************************************************
        ************************************************************/      
        
        $display("Testing if the machine keeps in operating state when MIE=1 for all types of interrupt when MTIE=0, MSIE=0 and MEIE=0...");
        
        MIE = 1'b1;
        E_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        E_IRQ = 1'b0;
        
        T_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        T_IRQ = 1'b0;
        
        S_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        S_IRQ = 1'b0;        
        
        $display("Test OK.");
        
        /************************************************************
        *************************************************************
        ************************************************************/
        
        $display("Testing if the machine change its state only for external interrupts in operating state when MIE=1 and MTIE=0, MSIE=0 and MEIE=1...");
        
        MIE = 1'b1;
        MEIE = 1'b1;
        E_IRQ = 1'b1;
        #20;
        if(PC_SRC != `TRAP)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(CAUSE != 4'b1011)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        E_IRQ = 1'b0;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        
        T_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        T_IRQ = 1'b0;
        
        S_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        S_IRQ = 1'b0;        
        
        MEIE = 1'b0;
        
        $display("Test OK.");
        
        /************************************************************
        *************************************************************
        ************************************************************/
        
        $display("Testing if the machine change its state only for timer interrupts in operating state when MIE=1 and MTIE=1, MSIE=0 and MEIE=0...");
        
        MIE = 1'b1;
        MTIE = 1'b1;
        T_IRQ = 1'b1;
        #20;
        if(PC_SRC != `TRAP)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(CAUSE != 4'b0111)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        T_IRQ = 1'b0;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        
        E_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        E_IRQ = 1'b0;
        
        S_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        S_IRQ = 1'b0;        
        
        MTIE = 1'b0;
        
        $display("Test OK.");        
        
        /************************************************************
        *************************************************************
        ************************************************************/
        
        $display("Testing if the machine change its state only for software interrupts in operating state when MIE=1 and MTIE=0, MSIE=1 and MEIE=0...");
        
        MIE = 1'b1;
        MSIE = 1'b1;
        S_IRQ = 1'b1;
        #20;
        if(PC_SRC != `TRAP)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(CAUSE != 4'b0011)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        S_IRQ = 1'b0;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        
        T_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        T_IRQ = 1'b0;
        
        E_IRQ = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        E_IRQ = 1'b0;        
        
        MSIE = 1'b0;
        
        $display("Test OK.");

        /************************************************************
        *************************************************************
        ************************************************************/        
        
        $display("Testing if the machine change its state only for MEIP in operating state when MIE=1 and MTIE=0, MSIE=0 and MEIE=1...");
        
        MIE = 1'b1;
        MEIE = 1'b1;
        MEIP = 1'b1;
        #20;
        if(PC_SRC != `TRAP)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(CAUSE != 4'b1011)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        MEIP = 1'b0;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        
        MTIP = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        MTIP = 1'b0;
        
        MSIP = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        MSIP = 1'b0;        
        
        MEIE = 1'b0;
        
        $display("Test OK.");
        
        /************************************************************
        *************************************************************
        ************************************************************/
        
        $display("Testing if the machine change its state only for MTIP in operating state when MIE=1 and MTIE=1, MSIE=0 and MEIE=0...");
        
        MIE = 1'b1;
        MTIE = 1'b1;
        MTIP = 1'b1;
        #20;
        if(PC_SRC != `TRAP)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(CAUSE != 4'b0111)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        MTIP = 1'b0;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        
        MEIP = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        MEIP = 1'b0;
        
        MSIP = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        MSIP = 1'b0;        
        
        MTIE = 1'b0;
        
        $display("Test OK.");        
        
        /************************************************************
        *************************************************************
        ************************************************************/
        
        $display("Testing if the machine change its state only for MSIP in operating state when MIE=1 and MTIE=0, MSIE=1 and MEIE=0...");
        
        MIE = 1'b1;
        MSIE = 1'b1;
        MSIP = 1'b1;
        #20;
        if(PC_SRC != `TRAP)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(CAUSE != 4'b0011)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(I_OR_E != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        MSIP = 1'b0;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        
        MTIP = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        MTIP = 1'b0;
        
        MEIP = 1'b1;
        #20;
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        MEIP = 1'b0;        
        
        MSIE = 1'b0;
        
        $display("Test OK.");

        /************************************************************
        *************************************************************
        ************************************************************/
        
        $display("Testing transition from OPERATING to TRAP RETURN...");
        
        OPCODE_6_TO_2 = `OPCODE_SYSTEM;
        FUNCT7 = `FUNCT7_MRET;       
        FUNCT3 = `FUNCT3_MRET;
        RS1_ADDR = `RS1_MRET;
        RS2_ADDR = `RS2_MRET;
        RD_ADDR = `RD_MRET;
        #20;
        
        if(PC_SRC != `EPC)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_SET != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end        
        
        $display("Test OK.");
        
        OPCODE_6_TO_2 = `OPCODE_OP;
        FUNCT3 = `FUNCT3_ADD;
        FUNCT7 = `FUNCT7_ADD;
        RS1_ADDR = 5'b00000;
        RS2_ADDR = 5'b00000;
        RD_ADDR = 5'b00000;
        #20;
        
        /************************************************************
        *************************************************************
        ************************************************************/
        
        $display("Testing transition from TRAP RETURN to OPERATING...");
        
        if(PC_SRC != `OPERATING)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_CAUSE != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(SET_EPC != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_CLEAR != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(MIE_SET != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(STALL != 1'b0)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        if(INSTRET_INC != 1'b1)
        begin
            $display("FAIL. Check the results.");
            $finish;
        end
        
        $display("Test OK.");
        
        $display("Machine Mode Control module successfully tested.");
    
    end    

endmodule
