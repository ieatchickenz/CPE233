`timescale 1ns / 1ps


module ALU(
input[31:0] A, B,
input [3:0]ALU_fun,
output logic [31:0] out
    );
    always_comb
    begin
    case(ALU_fun)
    4'b0000: out = A + B;
    4'b1000: out = A - B;
    4'b0110: out = A|B;
    4'b0111: out = A&B;
    4'b0100: out = A^B;
    4'b0101: out = A >> B[4:0];
    4'b0001: out = A << B[4:0];
    4'b1101: out = $signed(A) >>> B[4:0];
    4'b0010: out = ($signed(A) < $signed(B))? 1:0;
    4'b0011: out = (A < B) ? 1:0;
    4'b1001: out = {A};
    default: out = B;
    endcase
    end
endmodule

