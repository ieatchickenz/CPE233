`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2019 05:14:17 PM
// Design Name: 
// Module Name: CUFSM
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


module CUFSM( 
input clk, RST,
input [6:0] ir,
output logic pcWrite, regWrite, memWrite, memRead1, memRead2
);

typedef enum {FETCH, EXECUTE, WRITEBACK} STATES;
STATES NS, PS;

always_ff @(posedge clk)
   begin
      if (RST)
         PS <= FETCH;
      else
         PS <= NS;
   end

always_comb
begin

pcWrite = 0;
regWrite = 0;
memWrite = 0;
memRead1 = 0;
memRead2 = 0;

case (PS)

default NS = FETCH;

FETCH:
begin
pcWrite = 0;
memRead1 = 1;
NS = EXECUTE;
end

EXECUTE:
begin
   if (ir == 7'b0000011) 
      begin
      pcWrite = 0;
      memRead2 = 1;
      NS = WRITEBACK;
      end
   else if (ir == 7'b0100011)
      begin
      pcWrite = 1;
      memWrite = 1;
      NS = FETCH;
      end
   else if (ir == 7'b1100011)
      begin
      pcWrite = 1;
      NS = FETCH;
      end
   else
      begin
      pcWrite = 1;
      regWrite = 1;
      memRead1 = 0;
      NS = FETCH;
      end
end
   
WRITEBACK:
begin
pcWrite = 1;
memRead2 = 1;
regWrite = 1;
NS = FETCH;
end
   
endcase
end

endmodule
