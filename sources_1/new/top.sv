`timescale 1ns / 1ps

module top(
    input logic clk, reset,
    output logic[31:0] writedata, adr,
    output logic memwrite
    );
    logic [31:0] pc, readdata;
    mips mips(clk, reset, pc, memwrite, adr, writedata, readdata);
    idmem idmem(clk, memwrite, adr, writedata, readdata);
endmodule
