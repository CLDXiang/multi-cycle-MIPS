`timescale 1ns / 1ps

module ze(
    input logic [15:0] a,
    output logic [31:0] y
    );
    assign y = {{16{1'b0}}, a};
endmodule