`timescale 1ns / 1ps

module idmem(
    input logic clk, we,
    input logic [31:0] a, wd,
    output logic [31:0] rd
    );

    logic [31:0] RAM[1023:0];
    

    initial
        // $readmemh("memfile.dat", RAM);
    //    $readmemh("memfile_src.dat", RAM);
//        $readmemh("memfile_ori.dat", RAM);
       $readmemh("memfile_andi.dat", RAM);
//        $readmemh("memfile_bne.dat", RAM);
    // assign rd = RAM[a[9:2]]; // TODO: fix imem
    assign rd = RAM[a[31:2]];
    
    always_ff @(posedge clk)
        if (we) RAM[a[31:2]] <= wd;
endmodule
