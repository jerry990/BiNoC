`include "outputport.sv"
module outputport_tb;

logic clk;
logic rst;
logic [31:0] PacketInPort0,PacketInPort1,PacketInPort2,PacketInPort3,PacketInPort4,PacketInPort5,PacketInPort6,
             PacketInPort7,PacketInPort8,PacketInPort9,PacketOut;
logic full1,full2;
logic reqDnStr,gntDnStr;


outputport o(clk, 
             rst, 
		     reqDnStr, 
			 gntDnStr, 
			 full1,
             full2,				   
			 PacketInPort0,
             PacketInPort1,   
             PacketInPort2,
             PacketInPort3,
             PacketInPort4,
             PacketInPort5,   
             PacketInPort6,
             PacketInPort7,
             PacketInPort8,
             PacketInPort9, 
             reqInCntr, 
             gntInCntr, 
		     PacketOut
			 );

initial begin
  clk = 1'b0;
  rst = 1'b1;
  #3
  rst= 1'b0;
  PacketInPort0 = 32'h2112_2222;
  
 
end

initial
  begin
    $fsdbDumpfile("outputport.fsdb");
    $fsdbDumpvars(0, outputport_tb);
    #10000 $finish;
  end

endmodule