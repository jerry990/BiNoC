`define dataWidth 32
module fifo( input logic clk, 
             input logic rst, 
		     input logic [`dataWidth-1:0] PacketIn,
			 input logic inout_select,
             input logic reqInCtr , 
			 output logic full, 
			 output logic gntInCtr , 
			 output logic empty, 
			 output logic [`dataWidth-1:0] PacketOut 
            );
	
  parameter addressWidth = 4;// number of bits for address bus
 // parameter fifoDepth =  ( ( 1 << addressWidth ) - 1 ); // number of entries in fifo buffer
  parameter dim = 2;// dimension of x,y fields in source and destination
  
  logic [addressWidth-1:0] readAddr,writeAddr;
  logic [addressWidth:0] read_ptr,write_ptr;
  logic [`dataWidth-1:0] ram [15:0];	
  logic read_buf,write_buf;
  
  
  assign readAddr = read_ptr [addressWidth-1:0];
  assign writeAddr = write_ptr [addressWidth-1:0];
  assign read_buf = reqInCtr && !empty && !rst;// read signal ... 
  assign write_buf = !full && inout_select && !rst;// write signal ... 
  assign full = ( (writeAddr == readAddr) &&(write_ptr[addressWidth] ^ read_ptr[addressWidth]) );	
  assign empty = ( read_ptr == write_ptr ) && !rst; 
  
  
  
  always_ff@(posedge clk) begin
    if(rst)//reset all registers
      begin 
        gntInCtr  <= 0;
		write_ptr <= {(addressWidth+1){1'b0}}; //readEnable	 <= 0; writeEnable <= 0; 
		read_ptr <= {(addressWidth+1){1'b0}};  
		PacketOut <= 32'hzzzz_zzzz;
      end
    else 
      begin
// handle request from up stream router 
			//else
              //  EnableGnt <= 1'b0;			
//  ---------------------------- write process ------------------------- // 			
			if (write_buf)// Buffer not Full
			  begin
					//gntUpStr 	<= 1;	
			    write_ptr <= write_ptr + 1'b1;
				$display("write_QQ");
				ram[writeAddr] <= PacketIn;
			  end
			else	
			  begin	
		 	    write_ptr <= write_ptr;				
			  end								
// ----------------------------- read process -------------------------- //
			if (read_buf )
				begin						
					 gntInCtr <= 1; //readEnable  <= 1;
					 read_ptr <= read_ptr + 1'b1;
			         PacketOut <= ram[readAddr];
					 $display("read_QQ");
				end
			else 
			begin	
			  gntInCtr	<= 0;  //readEnable  <= 0;	
			end		
      end 
  end   
endmodule