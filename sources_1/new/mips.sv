`timescale 1ns / 1ps

module mips(
    input logic clk, reset,
    output logic [31:0] pc,
    // input logic [31:0] instr,
    output logic memwrite,
    output logic [31:0] adr, b,
    input logic [31:0] readData
    );
    // TODO: separate mips and idmem
    logic zero;
    logic memtoreg, regdst, iord;
    logic [1:0] pcsrc;
    logic [1:0] alusrcb;
    logic alusrca, irwrite, pcen;
    logic regwrite;
    logic [2:0] alucontrol;
    logic [31:0] instr;
    logic immext;

    controller c(clk, reset, instr[31:26], instr[5:0], zero, memtoreg, regdst, iord, pcsrc,
        alusrcb, alusrca, irwrite, memwrite, pcen, regwrite, alucontrol, immext);
    datapath dp(clk, reset, memtoreg, regdst, iord, pcsrc, alusrcb, alusrca, irwrite,
        pcen, regwrite, alucontrol, zero, pc, instr, adr, b, readData, immext);

    flopenr #(32) instrreg(clk, reset, irwrite, readData, instr);
endmodule
