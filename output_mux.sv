module output_mux(
   input logic [31:0] PacketInPort0,
   input logic [31:0] PacketInPort1,   
   input logic [31:0] PacketInPort2,
   input logic [31:0] PacketInPort3,
   input logic [31:0] PacketInPort4,
   input logic [31:0] PacketInPort5,   
   input logic [31:0] PacketInPort6,
   input logic [31:0] PacketInPort7,
   input logic [31:0] PacketInPort8,
   input logic [31:0] PacketInPort9, 
   input logic [3:0] sel, 
   output logic [31:0] PacketOut  
);


  always_comb 
    begin
	  case(sel)
	    4'b0000: PacketOut = PacketInPort0;
		4'b0001: PacketOut = PacketInPort1;
        4'b0010: PacketOut = PacketInPort2;
		4'b0011: PacketOut = PacketInPort3;
        4'b0100: PacketOut = PacketInPort4;
		4'b0101: PacketOut = PacketInPort5;
        4'b0110: PacketOut = PacketInPort6;
		4'b0111: PacketOut = PacketInPort7;
        4'b1000: PacketOut = PacketInPort8;
		default: PacketOut = PacketInPort9;
	  endcase
	end
endmodule	
	
  
  
  
  