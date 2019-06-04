`timescale 1ns / 1ps

module sevenseg(
    input logic clk, reset,
    input logic [31:0] digit,
    output logic [7:0] AN,
    output logic DP,
    output logic [6:0] A2G,
    input logic sign
    );
    
    logic [19:0] clkdiv;
    logic [2:0] s;
    logic [4:0] x;
    
    assign DP = 1;
    assign s = clkdiv[19:17];
    
    always_comb
    case(s)
        0: x = {1'b0, digit[3:0]};
        1: x = {1'b0, digit[7:4]};
        2: x = {sign, digit[11:8]};
        // 2: x = {1'b0, digit[11:8]};
        3: x = 5'h10; // =
        4: x = {1'b0, digit[19:16]};
        5: x = {1'b0, digit[23:20]};
        6: x = {1'b0, digit[27:24]};
        7: x = {1'b0, digit[31:28]};
        default: x = {1'b0, digit[3:0]};
    endcase
    
    always_comb
        case(s)
            0: AN = 8'b1111_1110;
            1: AN = 8'b1111_1101;
            2: AN = 8'b1111_1011;
            3: AN = 8'b1111_0111;
            4: AN = 8'b1110_1111;
            5: AN = 8'b1101_1111;
            6: AN = 8'b1011_1111;
            7: AN = 8'b0111_1111;
            default: AN = 8'b1111_1110;
        endcase
    
    always @(posedge clk or posedge reset)
    begin
        if(reset == 1)
            clkdiv <= 0;
        else
            clkdiv <= clkdiv + 1;
    end
    
    always_comb
    case (x)
        5'h0: A2G = 7'b1000000; 
        5'h1: A2G = 7'b1111001; 
        5'h2: A2G = 7'b0100100; 
        5'h3: A2G = 7'b0110000; 
        5'h4: A2G = 7'b0011001; 
        5'h5: A2G = 7'b0010010; 
        5'h6: A2G = 7'b0000010; 
        5'h7: A2G = 7'b1111000; 
        5'h8: A2G = 7'b0000000; 
        5'h9: A2G = 7'b0010000; 
        5'hA: A2G = 7'b0001000; 
        5'hB: A2G = 7'b0000011; 
        5'hC: A2G = 7'b1000110; 
        5'hD: A2G = 7'b0100001; 
        5'hE: A2G = 7'b0000110; 
        5'hF: A2G = 7'b0001110; 
        5'h10: A2G = 7'b0110111; // =
        5'h11: A2G = 7'b0111111; // -
        default: A2G = 7'b1000000;
    endcase
    
endmodule
