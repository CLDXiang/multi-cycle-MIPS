`timescale 1ns / 1ps

module memoryDecoder(
    input logic clk, writeEN,
    input logic [31:0] addr, writeData,
    output logic [31:0] readData,
    input logic reset,
    input logic btnL, btnR,
    input logic [15:0] switch,
    output logic [7:0] AN,
    output logic DP,
    output logic [6:0] A2G
    );
    
    logic pRead, pWrite, mWrite;
    logic [11:0] led;
    logic [31:0] readData1, readData2;
    logic sign;
    logic [31:0] digit;
    
    assign pRead = (addr[7] == 1'b1) ? 1:0;
    assign pWrite = (addr[7] == 1'b1) ? writeEN: 0;
    assign mWrite = writeEN & (addr[7] == 1'b0);
    assign digit = {switch, 4'b0000, (sign == 1'b1 ? {4'b1, led[7:0]} : led)};

    idmem idmem(clk, writeEN, addr, writedata, readData1);
    IO io(clk, reset, pRead, pWrite, addr[3:2], writeData, readData2, btnL, btnR, switch, led, sign);
    sevenseg sevenseg(clk, reset, digit, AN, DP, A2G, sign);
    
    assign readData = (addr[7] == 1'b1) ? readData2 : readData1;
    
endmodule
