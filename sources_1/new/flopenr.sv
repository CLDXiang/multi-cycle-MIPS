`timescale 1ns / 1ps

module flopenr #(parameter WIDTH = 8)
    (
    input logic clk, reset,
    input logic en,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
    );

    always_ff @(posedge clk, posedge reset)
        if (reset) q <= 32'b0;
        else if (en) q <= d;
endmodule
