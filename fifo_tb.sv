`include "fifo.sv"
module fifo_tb;
  logic clk;
  logic rst;
  logic gntInCtr;
  logic full;
  logic reqInCtr;
//  logic gntUpStr;
//  logic reqUpStr;
  logic [31:0] PacketIn;
  logic [31:0] PacketOut;
  logic empty;
  logic inout_select;
  always #1 clk = ~clk;


  fifo f1(clk, 
          rst,
         PacketIn,		  
		 // reqUpStr , 
		//gntUpStr ,
          inout_select,		
			reqInCtr ,
			full, 
			 
              
			 gntInCtr , 
			 empty, 
			 PacketOut 
            );

  initial  
    begin
      clk = 0;
	  rst =1;
	  
//	  reqUpStr = 1'b0;
	  #2
	  rst =0;
	  inout_select = 1'b1;
	  PacketIn = 32'h1;
      #2
	  PacketIn = 32'h2;
	  #2
	  PacketIn = 32'h3;
	//  reqInCtr = 1'b1;
      #2
	  PacketIn = 32'h4;
     #2
	  PacketIn = 32'h5;
	  #2
	  inout_select = 1'b0;
	  PacketIn = 32'hz;
	  #2
	  reqInCtr = 1'b1;
	  
  
  
    end
	initial 
      begin
        $fsdbDumpfile("fifo.fsdb");
        $fsdbDumpvars(0, fifo_tb);
        #(10000)
		for(int i=0 ; i <16 ;i++)
		  begin
		    $display("[%d]",f1.ram[i]);
		  
		  
		  end
		  
        $finish;
      end

   

endmodule