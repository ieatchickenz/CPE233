`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 04:53:37 PM
// Design Name: 
// Module Name: pCounter
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

//is a register 
module pCounter(
input [31:0] D,
input reset, LD, clk,
output logic [31:0] count
);

always_ff @(posedge clk)
begin
    if (reset)
        count = 0;
    else if (LD)
        count = D;    
    end
endmodule
