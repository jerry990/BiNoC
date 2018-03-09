`include "fifo.sv"
`include "RC.sv"
`include "in_out_port.sv"
`include "output_mux.sv"
module port ( input clk, 
              input rst, 
			  inout [31:0] Packet,
		     // input [31:0] PacketOut,
			  input inout_select,
			  input [9:0] channel_gnt,
			  output logic full, 
		      output logic [9:0] channel_req,
			  //for out
              input [31:0] PacketInPort0,
			  input [31:0] PacketInPort1,
			  input [31:0] PacketInPort2,
			  input [31:0] PacketInPort3,
			  input [31:0] PacketInPort4,
			  input [31:0] PacketInPort5,
			  input [31:0] PacketInPort6,
			  input [31:0] PacketInPort7,
			  input [31:0] PacketInPort8,
			  input [31:0] PacketInPort9,
			  input [3:0] sel,
			  output [31:0] Packetout
			);		
  parameter port_num = 0;			
  parameter dataWidth = 32; 
  //parameter addressWidth = 2;
  parameter x = 3;
  parameter y = 3;
  
  logic emptyFifoInCntr, reqFifoInCntr, gntFifoInCntr;
  logic [dataWidth-1:0] PacketFifoInCntr;
  logic [31:0] PacketIn,PacketOut_in;

  in_out_port iop
  (
  .IN(PacketOut_in),//output
  .inout_select(inout_select),
  .OUT(PacketIn),//input
  .bio(Packet)
  );
  
  fifo f
  (
  .clk(clk),
  .rst(rst),
  .PacketIn(PacketIn),
  .inout_select(inout_select),
  .reqInCtr(reqFifoInCntr),
  .full(full), 
  .gntInCtr(gntFifoInCntr),
  .empty(emptyFifoInCntr),
  .PacketOut(PacketFifoInCntr)
  );

RC #(.x(x),.y(y)) rc_compute
(
.clk(clk),
.rst(rst),
.gnt(gntFifoInCntr),
.empty(emptyFifoInCntr),
.PacketIn(PacketFifoInCntr),
.channel_gnt(channel_gnt),
.channel_req(channel_req),
.req(reqFifoInCntr),
.PacketOut(PacketOut)
);
//------------output------------
output_mux mux ( 
  .PacketInPort0(PacketInPort0),
  .PacketInPort1(PacketInPort1),   
  .PacketInPort2(PacketInPort2),
  .PacketInPort3(PacketInPort3),
  .PacketInPort4(PacketInPort4),
  .PacketInPort5(PacketInPort5),   
  .PacketInPort6(PacketInPort6),
  .PacketInPort7(PacketInPort7),
  .PacketInPort8(PacketInPort8),
  .PacketInPort9(PacketInPort9), 
  .sel(sel),
  .PacketOut(PacketOut_in)
  );

endmodule

