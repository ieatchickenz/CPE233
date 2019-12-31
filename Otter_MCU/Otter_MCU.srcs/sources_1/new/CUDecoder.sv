`timescale 1ns / 1ps

module CUDecoder(
input br_eq, br_lt, br_ltu,
input [31:0] ir,
output logic alu_srcA, 
output logic [1:0] alu_srcB, pcSource, rf_wr_sel,
output logic [3:0] alu_fun  
    );
    
    // Create enumeration datatype for the opcode. Symbols tied to bit values
     typedef enum logic [6:0] {
     LUI = 7'b0110111,
     AUIPC = 7'b0010111,
     JAL = 7'b1101111,
     JALR = 7'b1100111,
     BRANCH = 7'b1100011,
     LOAD = 7'b0000011,
     STORE = 7'b0100011,
     OP_IMM = 7'b0010011,
     OP = 7'b0110011
     } opcode_t;
    
     opcode_t OPCODE; //Define variable of newly defined type
     //Cast input bits as enum, for showing opcode names during simulation
     assign OPCODE = opcode_t'(ir);
    
    always_comb
    begin
        alu_srcA = 0;
        alu_srcB = 0;
        pcSource = 0;
        rf_wr_sel = 0;
        alu_fun = 0;
        
    case(ir[6:0])
    OP: begin
       alu_srcA = 0;
       alu_srcB = 0;
       pcSource = 0;
       rf_wr_sel = 3;
       
       case(ir[14:12])
       
       3'b000:
          case(ir[31:25])
          
          7'b0000000://add
             alu_fun = 4'b0000;
             
          7'b0100000: //sub
             alu_fun = 4'b1000;
          endcase   
             
       3'b001: //sll
          alu_fun = 4'b0001;
          
       3'b010: //slt
          alu_fun = 4'b0010;
          
       3'b011: //sltu   
          alu_fun = 4'b0011;
          
       3'b100: //xor
          alu_fun = 4'b0100;
          
       3'b101: 
          case(ir[31:25])
          7'b0000000: //srl 
             alu_fun = 4'b0101;
             
          7'b0100000: //sra 
             alu_fun = 4'b1101;
          endcase
   
       3'b110://or 
          alu_fun = 4'b0110;
          
       3'b111: //and
          alu_fun = 4'b0111;
          endcase
        end
       
    OP_IMM:begin//immediate
       alu_srcA = 0;  
       alu_srcB = 1;
       pcSource = 0;
       rf_wr_sel = 3;
       
       case(ir[14:12])
       
       3'b000: //addi 
          alu_fun = 4'b0000;
          
       3'b010: //slti
          alu_fun = 4'b0011;
          
       3'b011://sltiu
          alu_fun = 4'b0011;
          
       3'b100: //xori
          alu_fun = 4'b0100;
       
       3'b110: //ori
          alu_fun = 4'b0110;
          
       3'b111: //andi
          alu_fun = 4'b0111;
          
       3'b001: //slli
          alu_fun = 4'b0001;
       
       3'b101: //sr
          case(ir[31:25])
          
          7'b0000000: //srli
             alu_fun = 4'b0101;
             
          7'b0100000: //srai
             alu_fun = 4'b0001;
          endcase   
       endcase
      end
       
    
    STORE: begin //stype
       alu_fun = 4'b0000;
       alu_srcA = 0;  
       alu_srcB = 2;
       pcSource = 0;
       rf_wr_sel = 2;
       end
    
     
    LOAD: begin //ltype
       alu_fun = 4'b0000;
       alu_srcA = 0;  
       alu_srcB = 1;
       pcSource = 0;
       rf_wr_sel = 2;
       end   
       
    BRANCH: begin //btype
       alu_fun = 4'b0000;
       alu_srcA = 0;  
       alu_srcB = 0;
       //pcSource = 2;
       rf_wr_sel = 0;
       
       case(ir[14:12])
       3'b000:
         begin
         if (br_eq) pcSource = 2; //beq
         else pcSource = 0;
         end
       3'b001:
         begin
         if(~br_eq) pcSource =2; //bne
         else pcSource = 0;
         end
        
       3'b100:
         begin
         if(br_lt) pcSource = 2; //blt
         else pcSource =0;
         end
       
       3'b101:
         begin
         if(br_eq|~br_lt) pcSource = 2; //bge  
         else pcSource = 0;
         end
          
       3'b110: 
         begin
         if(br_ltu) pcSource = 2; //bltu
         else pcSource = 0;
         end
       
       3'b111:
         begin 
         if (br_eq|~br_ltu) pcSource = 2;//bgeu     
         else pcSource = 0;
         end
         endcase
      end
      
    JALR: begin //jalr
       alu_fun = 4'b0000;
       alu_srcA = 0;  
       alu_srcB = 1;
       pcSource = 1;
       rf_wr_sel = 2;
       end
    
       
    JAL: begin //jal
       alu_fun = 4'b0000;
       alu_srcA = 0;  
       alu_srcB = 0;
       pcSource = 3;
       rf_wr_sel = 2;      
       end
    
       
    AUIPC: begin //auipc 
       alu_fun = 4'b0000;
       alu_srcA = 1;  
       alu_srcB = 3;
       pcSource = 0;
       rf_wr_sel = 3;
       end
       
    LUI: begin//LUI
       alu_fun = 4'b1001;
       alu_srcA = 1;  
       alu_srcB = 0;
       pcSource = 0;
       rf_wr_sel = 3;      
       end
     endcase
    end
    
    endmodule


