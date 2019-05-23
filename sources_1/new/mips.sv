`timescale 1ns / 1ps

module mips(
        input logic clk, reset
    );
    // TODO: separate mips and idmem
    logic [5:0] opcode, funct;
    logic zero;
    logic memtoreg, regdst, iord, pcsrc;
    logic [1:0] alusrcb;
    logic alusrca, irwrite, memwrite, pcen;
    logic regwrite;
    logic [1:0] aluop;
    logic [2:0] alucontrol;

    controller c(clk, reset, opcode, funct, zero, memtoreg, regdst, iord, pcsrc,
        alusrcb, alusrca, irwrite, memwrite, pcen, regwrite, aluop, alucontrol);
    datapath dp(clk, reset, memtoreg, regdst, iord, pcsrc, alusrcb, alusrca,
        irwrite, memwrite, pcen, regwrite, aluop, alucontrol, opcode, funct, zero);
endmodule
