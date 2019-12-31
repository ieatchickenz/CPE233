`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2019 11:17:41 AM
// Design Name: 
// Module Name: otter_sim
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


module otter_sim();

logic [15:0] switches,leds;
logic clk=0;
logic btnl,btnc;

OTTER_Wrapper DUT(
   .CLK(clk),
   .BTNL(btnl),
   .BTNC(btnc),
   .SWITCHES(switches),
   .LEDS(leds),
   .CATHODES(),
   .ANODES(),
   .VGA_RGB(),
   .VGA_HS(),
   .VGA_VS());
   
   always
        #10 clk =!clk;
   initial begin
        btnc=1;
        switches=16'h0000;
        #100
        btnc=0;
        
   
   end
   
   
endmodule