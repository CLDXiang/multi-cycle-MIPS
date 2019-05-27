`timescale 1ns / 1ps

module sevenseg(
    input logic clk, reset,
    input logic [31:0] digit,
    output logic [7:0] AN,
    output logic DP,
    output logic [6:0] A2G
    );
    
    logic [19:0] clkdiv;
    logic [2:0] s;
    logic [3:0] x;
    
    assign DP = 1;
    assign s = clkdiv[19:17];
    
    always_comb
    case(s)
        0: x = digit[3:0];
        1: x = digit[7:4];
        2: x = digit[11:8];
        3: x = digit[15:12];
        4: x = digit[19:16];
        5: x = digit[23:20];
        6: x = digit[27:24];
        7: x = digit[31:28];
        default: x = digit[3:0];
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
        4'h0: A2G = 7'b1000000; 
        4'h1: A2G = 7'b1111001; 
        4'h2: A2G = 7'b0100100; 
        4'h3: A2G = 7'b0110000; 
        4'h4: A2G = 7'b0011001; 
        4'h5: A2G = 7'b0010010; 
        4'h6: A2G = 7'b0000010; 
        4'h7: A2G = 7'b1111000; 
        4'h8: A2G = 7'b0000000; 
        4'h9: A2G = 7'b0010000; 
        4'hA: A2G = 7'b0001000; 
        4'hB: A2G = 7'b0000011; 
        4'hC: A2G = 7'b1000110; 
        4'hD: A2G = 7'b0100001; 
        4'hE: A2G = 7'b0000110; 
        4'hF: A2G = 7'b0001110; 
        default: A2G = 7'b1000000;
    endcase
    
endmodule
