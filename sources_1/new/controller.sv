`timescale 1ns / 1ps

module controller(
    input logic clk, reset,
    input logic [5:0] opcode, funct,
    input logic zero,
    output logic memtoreg, regdst, iord, 
    output logic [1:0] pcsrc,
    output logic [1:0] alusrcb,
    output logic alusrca, irwrite, memwrite, pcen,
    output logic regwrite,
    output logic [2:0] alucontrol,
    output logic immext
    );

    logic branch, pcwrite;
    logic [1:0] aluop;

    maindec md(clk, reset, opcode, pcwrite, memwrite, irwrite, regwrite,
        alusrca, branch, iord, memtoreg, regdst, alusrcb, pcsrc, aluop, immext);
    aludec ad(funct, aluop, alucontrol);

    assign pcen = (zero & branch) | pcwrite;

endmodule
