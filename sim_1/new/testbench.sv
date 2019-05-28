`timescale 1ns / 1ps

module testbench();
    logic clk;
    logic reset;
    
    logic [31:0] writedata, dataadr;
    logic memwrite;
    
    top dut(clk, reset, writedata, dataadr, memwrite);
    
    initial
        begin
            reset <= 1; #25; reset <= 0;
        end
        
    always
        begin
            clk <= 1; 
            #20; 
            clk <= 0; 
            #20;
        end
    
    always @(negedge clk)
        begin
            if (memwrite) begin
//                 if (dataadr === 84 & writedata === 7) begin // test src
               if (dataadr === 84 & writedata === 16'b0000001100010000) begin // test andi
                    $display("Simulation succeeded");
                    $stop;
                end
            end
        end
        
endmodule
