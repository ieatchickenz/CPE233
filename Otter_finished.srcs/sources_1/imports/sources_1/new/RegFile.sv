`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:    
// Engineer: Marisa Pummer
// 
// Create Date: 04/18/2019 06:45:46 PM
// Design Name: 
// Module Name: Otter_RAM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Otter_RAM(
    input [4:0] adr1,
    input [4:0] adr2,
    input en,  // enables the writing of data to the address
    input CLK,
    input [31:0] wd, // data you are writing to address
    input [4:0] wa, // address to write data to
    output [31:0] rs1,
    output [31:0] rs2
    );
    
    logic [31:0] r_memory [0:31];
    
    initial begin
        int i;
        for (i=0; i<32; i++) begin
            r_memory[i] = 0;
        end
    end
    
    assign rs1 = r_memory[adr1];
    assign rs2 = r_memory[adr2]; 
    
    always_ff @(posedge CLK)
    begin
        if (en == 1 & wa != 0)
            r_memory[wa] <= wd;
    end
    
endmodule

