`timescale 1ns / 1ps

module datapath(
    input logic clk, reset,
    input logic memtoreg, regdst, iord, 
    input logic [1:0] pcsrc,
    input logic [1:0] alusrcb,
    input logic alusrca, irwrite, pcen,
    input logic regwrite,
    input logic [2:0] alucontrol,
    // output logic [5:0] opcode, funct,
    output logic zero,
    output logic [31:0] pc,
    // input logic [31:0] instr,
    output logic [31:0] adr, b,
    input logic [31:0] readData
    );

    logic [31:0] pcnext;
    logic [31:0] aluout;
    logic [31:0] a;
    logic [31:0] data;
    logic [4:0] a3;
    logic [31:0] wd3, rd1, rd2;
    logic [31:0] signimm, immsh;
    logic [31:0] srca, srcb;
    logic [31:0] aluresult, pcjump;
    logic [31:0] instr;

    flopenr #(32) pcreg(clk, reset, pcen, pcnext, pc);
    mux2 #(32) pcmux(pc, aluout, iord, adr);

    // idmem idmem(clk, memwrite, adr, b, readData);

    flopenr #(32) instrreg(clk, reset, irwrite, readData, instr);
    flopr #(32) datareg(clk, reset, readData, data);

    mux2 #(5) a3mux(instr[20:16], instr[15:11], regdst, a3);
    mux2 #(32) wd3mux(aluout, data, memtoreg, wd3);

    regfile rf(clk, regwrite, instr[25:21], instr[20:16], a3, wd3, rd1, rd2);
    signext se(instr[15:0], signimm);
    sl2 sl(signimm, immsh);

    flopr #(32) rd1reg(clk, reset, rd1, a);
    flopr #(32) rd2reg(clk, reset, rd2, b);

    mux2 #(32) srcamux(pc, a, alusrca, srca);
    mux4 #(32) srcbmux(b, 32'b100, signimm, immsh, alusrcb, srcb);

    assign pcjump = {pc[31:28], instr[25:0], 2'b00};
    alu alu(srca, srcb, alucontrol, aluresult, zero);
    flopr #(32) alureg(clk, reset, aluresult, aluout);
    mux3 #(32) pcnextreg(aluresult, aluout, pcjump, pcsrc, pcnext);


endmodule
