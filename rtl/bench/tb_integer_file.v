//////////////////////////////////////////////////////////////////////////////////
// Engineer: Rafael de Oliveira Calçada
// 
// Create Date: 03.04.2020 18:35:35
// Module Name: tb_register_file
// Project Name: Steel Core
// Description: RISC-V Steel Core 32-bit Integer Register File testbench
// 
// Dependencies: register_file.v
// 
// Version 0.01
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "../globals.vh"

module tb_integer_file();

    reg CLK;
    reg RESET;
    
    reg [4:0] RS_1_ADDR;
    reg [4:0] RS_2_ADDR;
    wire [31:0] RS_1;
    wire [31:0] RS_2;
        
    reg [4:0] RD_ADDR;
    reg WR_EN;
    reg [31:0] RD;    
    
    integer_file dut(
    
        .CLK(               CLK),
        .RESET(             RESET),
        
        .RS_1_ADDR(         RS_1_ADDR),
        .RS_2_ADDR(         RS_2_ADDR),
        .RD_ADDR(           RD_ADDR),
        .RS_1(              RS_1),
        .RS_2(              RS_2),
        
        .WR_EN(             WR_EN),
        .RD(                RD)
        
    );
    
    integer i;
    
    always
    begin
        #10 CLK = !CLK;
    end
    
    initial
    begin
    
        $display("Testing Integer Register File...");
    
        CLK = 1'b0;
        RESET = 1'b0;
        
        RS_1_ADDR = 5'b00000;
        RS_2_ADDR = 5'b00000;
        RD_ADDR = 5'b00000;
        WR_EN = 1'b0;
        RD = 32'b0;        
        
        #5;
        
        RESET = 1'b1;
        
        #15;
        
        RESET = 1'b0;
        
        $display("Testing values after reset...");
        
        for(i = 0; i < 32; i=i+1)
        begin
        
            RS_1_ADDR = i[4:0];
            
            #20;
            
            if(RS_1 != 32'h00000000)
            begin
                $display("FAIL. Check the results.");
                $finish;
            end
        
        end
        
        $display("Reset values OK.");        
        
        $display("Testing write operation...");
            
        for(i = 0; i < 32; i=i+1)
        begin        
            
            RD_ADDR = i[4:0];
            WR_EN = 1'b1;
            RD = $random;            
            
            #20;
            
            WR_EN = 1'b0;
            RS_1_ADDR = RD_ADDR;
            RS_2_ADDR = RD_ADDR;            
            
            #20;
            
            if(RD_ADDR == 5'b00000)
            begin
                if(RS_1 != 32'h00000000)
                begin
                    $display("FAIL. Check the results.");
                    $finish;
                end
                if(RS_2 != 32'h00000000)
                begin
                    $display("FAIL. Check the results.");
                    $finish;
                end
            end
            if(RD_ADDR != 5'b00000)
            begin
                if(RS_1 != RD)
                begin
                    $display("FAIL. Check the results.");
                    $finish;
                end
                if(RS_2 != RD)
                begin
                    $display("FAIL. Check the results.");
                    $finish;
                end
            end        
        
        end
        
        $display("Write operation seems to work.");
        
        $display("Integer Register File successfully tested.");
        
    end

endmodule