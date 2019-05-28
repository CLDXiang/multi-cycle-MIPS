`timescale 1ns / 1ps

module top_IO(
    input logic clk, BTNC,
    input logic [15:0] SW,
    output logic [7:0] AN,
    output logic DP,
    input logic BTNL,
    input logic BTNR,
    output logic [6:0] A2G
    );
    
    logic [31:0] pc, readdata;
    logic [31:0] writedata, adr;
    logic memwrite;
    
    mips mips(clk, BTNC, pc, memwrite, adr, writedata, readdata);
    memoryDecoder mdec(clk, memwrite, adr, writedata, readdata, BTNC, BTNL, BTNR, SW, AN, DP, A2G);
    
endmodule
