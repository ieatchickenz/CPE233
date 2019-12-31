`timescale 1ns / 1ps

module BranchCondGen(
input [31:0] rs1, rs2,
output logic br_eq, br_lt, br_ltu);


always_comb
    if(rs1 == rs2)begin
       br_eq = 1;
       br_lt = 0;
       br_ltu = 0;
       end
    else if($signed(rs1) < $signed(rs2)) begin
       br_eq = 0;
       br_ltu =0;
       br_lt =1;
       end
    else if(rs1 < rs2) begin              
       br_eq = 0;
       br_ltu = 1;
       br_lt = 0;
       end
    else begin
       br_eq =0;
       br_lt =0;
       br_ltu =0;
       end
endmodule
