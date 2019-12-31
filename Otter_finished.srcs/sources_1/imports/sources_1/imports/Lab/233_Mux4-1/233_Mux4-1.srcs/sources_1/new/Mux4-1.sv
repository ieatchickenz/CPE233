`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alex Petrov
// 
// Create Date: 04/02/2019 04:58:59 PM
// Design Name: 
// Module Name: Mux4-1
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


module Mux4to1(
    input [31:0] data,
    input [31:0] d1,
    input [31:0] d2,
    input [31:0] d3,
    input [1:0] SEL,
    output logic [31:0] y
    );
    
always_comb begin
    if(SEL == 0)
        y = data;
    
    else if(SEL == 1)
        y = d1;
        
    else if(SEL == 2)
        y = d2;
        
    else if(SEL == 3)
        y = d3;
        
    else
        y = 0; 
end
endmodule
