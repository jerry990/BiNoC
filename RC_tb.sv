`include "RC.sv"
module RC_tb;
  logic clk;
  logic rst;
  logic gnt;
  logic req;
  
  logic [31:0] PacketIn;
  logic [31:0] PacketOut;
  logic empty;
  logic inout_select;
  logic [9:0] gntOutCntr;
  logic [9:0] channel_req;
  always #1 clk = ~clk;


  RC r(
  clk,
  rst, 
  gnt , 
  empty , 
  PacketIn,
  gntOutCntr, 
  channel_req, 
  req , //request to FIFO
  PacketOut 
    );

  initial  
    begin
      clk = 0;
	  rst =1;
	  #2
	  rst =0;
	  empty = 1'b0;
	  PacketIn = 32'h1;
	  gnt = 1'b1;
      #2
	  PacketIn = 32'h2;
	  #2
	  PacketIn = 32'h3;
	
      #2
	  PacketIn = 32'h4;
      #2
	  PacketIn = 32'h5;
	  #2
	  PacketIn = 32'hz;
	  
  
  
    end
	initial 
      begin
        $fsdbDumpfile("RC.fsdb");
        $fsdbDumpvars(0, RC_tb);
        #(10000)
		
		  
        $finish;
      end

   

endmodule