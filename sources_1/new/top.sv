`timescale 1ns / 1ps

module top(
    input logic clk, reset,
    output logic[31:0] writedata, adr,
    output logic memwrite
    );
    logic [31:0] pc, readdata;
    mips mips(clk, reset, pc, memwrite, adr, writedata, readdata);
    // imem imem(pc[9:2], readdata);
    // dmem dmem(clk, memwrite, adr, writedata, readdata);
    // idmem idmem(clk, memwrite, dataadr, writedata, readdata, pc[9:2], instr);
    idmem idmem(clk, memwrite, adr, writedata, readdata);
endmodule
