`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2019 05:49:18 PM
// Design Name: 
// Module Name: MUX_21
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


module MUX_21(
    input logic [31:0] a,
    input logic [31:0] b,
    input s,
    output logic [31:0] out
    );
    
    always_comb begin
    if(s == 0)begin
        out = a;
        end
    else begin
        out = b;
        end
    end
endmodule
