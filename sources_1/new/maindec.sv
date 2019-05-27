`timescale 1ns / 1ps

module maindec(
    input logic clk, reset,
    input logic [5:0] op, // TODO: fix here, always: op = ob00x000???
    output logic pcwrite, memwrite, irwrite, regwrite,
    output logic alusrca, branch, iord, memtoreg, regdst,
    output logic [1:0] alusrcb, pcsrc,
    output logic [1:0] aluop,
    output logic immext
    );
    /* State */
    parameter FETCH = 4'b0000; // 0
    parameter DECODE = 4'b0001; // 1
    parameter MEMADR = 4'b0010; // 2
    parameter MEMRD = 4'b0011; // 3
    parameter MEMWB = 4'b0100; // 4
    parameter MEMWR = 4'b0101; // 5
    parameter RTYPEEX = 4'b0110; // 6
    parameter RTYPEWB = 4'b0111; // 7
    parameter BEQEX = 4'b1000; // 8
    parameter ADDIEX = 4'b1001; // 9
    parameter ADDIANDIWB = 4'b1010; // 10
    parameter JEX = 4'b1011; // 11
    parameter ANDIEX = 4'b1100; // 12

    /* Opcode */
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;
    parameter RTYPE = 6'b000000;
    parameter BEQ = 6'b000100;
    parameter ADDI = 6'b001000;
    parameter J = 6'b000010;
    parameter ANDI = 6'b001100;

    logic [3:0] state, nextstate;
    logic [15:0] controls;

    /* State register */
    always_ff @(posedge clk or posedge reset)
        begin
          $display(">> Opcode: 0b%b", op);
          $display(">> pcwrite: %b, memwrite: %b, irwrite: %b, regwrite: %b, alusrca: %b, branch: %b, iord: %b, memtoreg: %b, regdst: %b, alusrcb: %b, pcsrc: %b, aluop: %b, immext: %b", pcwrite, memwrite, irwrite, regwrite, alusrca, branch, iord, memtoreg, regdst, alusrcb, pcsrc, aluop, immext);
          $display(">> State: %d => %d", state, nextstate);
        //   $stop;
            if (reset) state <= FETCH;
            else state <= nextstate;
        end
    
    /* Next state logic */
    always_comb case(state)
        FETCH: nextstate = DECODE;
        DECODE: case(op)
                    LW: nextstate = MEMADR;
                    SW: nextstate = MEMADR;
                    RTYPE: nextstate = RTYPEEX;
                    BEQ: nextstate = BEQEX;
                    ADDI: nextstate = ADDIEX;
                    J: nextstate = JEX;
                    ANDI: nextstate = ANDIEX;
                    default: nextstate = 4'bx;
                endcase
        MEMADR: case(op)
                    LW: nextstate = MEMRD;
                    SW: nextstate = MEMWR;
                    default: nextstate = 4'bx;
                endcase
        MEMRD: nextstate = MEMWB;
        MEMWB: nextstate = FETCH;
        MEMWR: nextstate = FETCH;
        RTYPEEX: nextstate = RTYPEWB;
        RTYPEWB: nextstate = FETCH;
        BEQEX: nextstate = FETCH;
        ADDIEX: nextstate = ADDIANDIWB;
        ADDIANDIWB: nextstate = FETCH;
        JEX: nextstate = FETCH;
        ANDIEX: nextstate= ADDIANDIWB;
        default: nextstate = 4'bx;
    endcase

    /* Output logic */
    assign {pcwrite, memwrite, irwrite, regwrite,
            alusrca, branch, iord, memtoreg, regdst,
            alusrcb, pcsrc, aluop, immext} = controls;

    always_comb case(state)
         FETCH: controls = {15'h5010, 1'b0};
         DECODE: controls = {15'h0030, 1'b0};
         MEMADR: controls = {15'h0420, 1'b0};
         MEMRD: controls = {15'h0100, 1'b0};
         MEMWB: controls = {15'h0880, 1'b0};
         MEMWR: controls = {15'h2100, 1'b0};
         RTYPEEX: controls = {15'h0402, 1'b0};
         RTYPEWB: controls = {15'h0840, 1'b0};
         BEQEX: controls = {15'h0605, 1'b0};
         ADDIEX: controls = {15'h0420, 1'b0};
         ADDIANDIWB: controls = {15'h0800, 1'b0};
         JEX: controls = {15'h4008, 1'b0};
         ANDIEX: controls = {15'h0423, 1'b1};
         default: controls = 16'hxxxx;
    endcase
endmodule
