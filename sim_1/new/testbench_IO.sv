`timescale 1ns / 1ps

module testbench_IO();
    logic clk, BTNC;
    logic [15:0] SW;
    logic [7:0] AN;
    logic DP;
    logic BTNL;
    logic BTNR;
    logic [6:0] A2G;

    logic [31:0] pc, readdata;
    logic [31:0] writedata, adr;
    logic memwrite;
    
    mips mips(clk, BTNC, pc, memwrite, adr, writedata, readdata);
    memoryDecoder mdec(clk, memwrite, adr, writedata, readdata, BTNC, BTNL, BTNR, SW, AN, DP, A2G);
    
    initial
        begin
            
            SW = 16'b0001_0010_0011_0100;
            BTNC = 1; // reset
            #20 BTNC = 0;
            #30 BTNR = 1; BTNL = 0;
            #200 BTNR = 0; BTNL = 1;
        end
        
    always
        begin
            clk <= 1; 
            #20; 
            clk <= 0; 
            #20;
        end

endmodule
