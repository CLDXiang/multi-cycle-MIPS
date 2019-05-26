`timescale 1ns / 1ps

module mips(
    input logic clk, reset,
    output logic memwrite,
    output logic [31:0] adr, b,
    input logic [31:0] readData
    );
    // TODO: separate mips and idmem
    logic zero;
    logic memtoreg, regdst, iord, pcsrc;
    logic [1:0] alusrcb;
    logic alusrca, irwrite, pcen;
    logic regwrite;
    logic [1:0] aluop;
    logic [2:0] alucontrol;
    logic [31:0] instr;

    controller c(clk, reset, instr[31:26], instr[5:0], zero, memtoreg, regdst, iord, pcsrc,
        alusrcb, alusrca, irwrite, memwrite, pcen, regwrite, aluop, alucontrol);
    datapath dp(clk, reset, memtoreg, regdst, iord, pcsrc, alusrcb, alusrca, irwrite,
        pcen, regwrite, aluop, alucontrol, zero, instr, adr, b, readData);
endmodule
