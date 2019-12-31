`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2019 04:34:28 PM
// Design Name: 
// Module Name: OTTER_MCU
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


module OTTER_MCU(
    input CLK,
    input RESET,
    input [31:0] IOBUS_IN,
    output [31:0] IOBUS_OUT,
    output [31:0] IOBUS_ADDR,
    output IOBUS_WR
    );
    
    wire [31:0] branch_pc;
    wire [31:0] jump_pc;
    wire [31:0] jumpreg_pc;
    wire [31:0] I_immed;
    wire [31:0] S_immed;
    wire [31:0] U_immed;
    
    wire [31:0] IR;
    wire [31:0] rs1;
    wire [31:0] rs2;
    
    
    wire [31:0] pc_out;
    wire [31:0] count4;
    assign count4 = pc_out + 4;
    wire [31:0] pc_in;
    wire [1:0] pc_src;
    wire [1:0] wr_sel;
    
    wire [31:0] ALU_out;
    wire [3:0] alu_fun;
    wire [31:0] a;
    wire [31:0] b;
    wire alu_src_a;
    wire [1:0] alu_src_b;
    
    wire br_eq, br_lt, br_ltu;
    
    wire pcWrite, memWrite, memRead1, memRead2;
    wire [31:0] dout2;
    
    wire [31:0] wd;
    wire en;
    
    BranchCondGen branchGen(
    .rs1(rs1),
    .rs2(rs2),
    .br_eq(br_eq),
    .br_lt(br_lt),
    .br_ltu(br_ltu)
    );
    
    ALU ALU(
    .A(a),
    .B(b),
    .ALU_fun(alu_fun),
    .out(ALU_out)
    );
    
    MUX_21 alu_mux21(
    .a(rs1),
    .b(U_immed),
    .s(alu_src_a),
    .out(a)
    );
    
    Mux4to1 alu_b_mux(
    .data(rs2),
    .d1(I_immed),
    .d2(S_immed),
    .d3(pc_out),
    .SEL(alu_src_b),
    .y(b)
    );
   
    
    Otter_RAM RegFile(
    .adr1(IR[19:15]),
    .adr2(IR[24:20]),
    .en(en),
    .CLK(CLK),
    .wd(wd),
    .wa(IR[11:7]),
    .rs1(rs1),
    .rs2(rs2)
    );
    
    
    CUFSM fsm(
    .clk(CLK), 
    .RST(RESET),
    .ir(IR[6:0]),
    .pcWrite(pcWrite), 
    .regWrite(en), 
    .memWrite(memWrite), 
    .memRead1(memRead1), 
    .memRead2(memRead2)
    );
    
    wire dummy;
    
    OTTER_mem_byte mem(
    .MEM_ADDR1(pc_out),     //Instruction Memory Port
    .MEM_ADDR2(ALU_out),     //Data Memory Port
    .MEM_CLK(CLK),
    .MEM_DIN2(rs2),
    .MEM_WRITE2(memWrite),
    .MEM_READ1(memRead1),
    .MEM_READ2(memRead2),
    .IO_IN(IOBUS_IN),
    .ERR(dummy),
    .MEM_SIZE(IR[13:12]),
    .MEM_SIGN(IR[14]),
    .MEM_DOUT1(IR),
    .MEM_DOUT2(dout2),
    .IO_WR(IOBUS_WR)
    );
    
    Mux4to1 regFile_mux(
    .data(count4),
    .d1(0),
    .d2(dout2),
    .d3(ALU_out),
    .SEL(wr_sel),
    .y(wd)
    );
    
    Mux4to1 pc_mux(
    .data(count4),
    .d1(jumpreg_pc),
    .d2(branch_pc),
    .d3(jump_pc),
    .SEL(pc_src),
    .y(pc_in)
    );
    
    
    pCounter PC(
    .D(pc_in),
    .reset(RESET),
    .LD(pcWrite),
    .clk(CLK),
    .count(pc_out)
    );
    
    CUDecoder decode(
    .br_eq(br_eq),
    .br_lt(br_lt),
    .br_ltu(br_ltu),
    .ir(IR),
    .alu_srcA(alu_src_a),
    .alu_srcB(alu_src_b),
    .pcSource(pc_src),
    .rf_wr_sel(wr_sel),
    .alu_fun(alu_fun)
    );
    
    
    
   //Branch Target Generation
   assign branch_pc = pc_out + {{20{IR[31]}}, IR[7], IR[30:25], IR[11:8], 1'b0};
    
   //Jump Target Generation
   assign jump_pc = pc_out + {{12{IR[31]}}, IR[19:12], IR[20], IR[30:21], 1'b0};
    
    //JumpReg Target Generation
    assign jumpreg_pc = rs1 + I_immed;
    
    //I-type Immediate Value 
    assign I_immed = {{21{IR[31]}}, IR[30:20]};
    
    //S-type Immediate Value
    assign S_immed = {{21{IR[31]}}, IR[30:25], IR[11:7]};
    
    //U-type Immediate Value
    assign U_immed = {IR[31:12], 12'b000000000000};
    
    assign IOBUS_ADDR = ALU_out;
    assign IOBUS_OUT = rs2;
    
    
    
endmodule
