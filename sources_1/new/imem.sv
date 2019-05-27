`timescale 1ns / 1ps

module imem(
    input logic [7:0] a,
    output logic [31:0] rd
    );
    
    logic [31:0] RAM[255:0];
    
    initial
        // $readmemh("memfile.dat", RAM);
    //    $readmemh("memfile_src.dat", RAM);
//        $readmemh("memfile_ori.dat", RAM);
       $readmemh("memfile_andi.dat", RAM);
//        $readmemh("memfile_bne.dat", RAM);
    assign rd = RAM[a];
endmodule
