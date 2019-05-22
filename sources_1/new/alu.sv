`timescale 1ns / 1ps

module alu(
    input logic [31:0] a, b, 
    input logic [2:0] alucont,
    output logic [31:0] result, 
    output logic zero
    );
    always_comb
        case(alucont)   
            3'b000: result <= a & b;
            3'b001: result <= a | b;
            3'b010: result <= a + b;
            3'b011: result <= 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
            3'b100: result <= a & ~b;
            3'b101: result <= a | ~b;
            3'b110: result <= a - b;
            3'b111: result <= (a < b) ? 32'b1:32'b0;
        endcase
    assign zero = (result == 0) ? 1:0; 
endmodule
