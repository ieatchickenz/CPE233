`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2019 03:35:29 PM
// Design Name: 
// Module Name: clkDiv1
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


//-----------------------------------------------------------------------
//-- Module to divide the clock 
//-----------------------------------------------------------------------
module clk_div (  input clk,
                  output logic sclk=0);

  integer MAX_COUNT = 100000; //1000000; //2
  integer div_cnt =0;
   always @ (posedge clk)              
   begin
         if (div_cnt == MAX_COUNT) 
         begin 
            sclk = ~sclk;
            div_cnt = 0;
         end else
            div_cnt = div_cnt + 1;  
   end 
endmodule
