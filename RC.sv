`define dataWidth 32
module RC(
  input clk,
  input rst, 
  input gnt , 
  input empty , 
  input [`dataWidth-1:0] PacketIn,
  input logic [9:0] channel_gnt, 
  output logic [9:0] channel_req, 
  output logic req , //request to FIFO
  output logic [`dataWidth-1:0] PacketOut 
);
  parameter dim = 4;
  parameter Idle = 2'b00,
            Read = 2'b01,
            Route = 2'b10,
            Grant = 2'b11; 

  logic [`dataWidth-1:0] dataBuf;
  logic [1:0] state;
  parameter x = 3;
  parameter y = 3;
  
  always_comb 
    begin
	  if(rst) 
	    begin
		  PacketOut = 32'hzzzz_zzzz;
		end
      PacketOut = dataBuf;
    end
  
  always_ff@(posedge clk) 
    begin
      if(rst) 
	    begin
		  req  <= 0;
          dataBuf  <= 32'hzzzz_zzzz;
	      state    <= Idle;
           channel_req  <= 10'b0;
	    end
	  else 
	    begin
	      case(state)
	        Idle: 
			  begin
		        if(!empty) 
				  begin
		            state <= Read;
		            req <= 1;
		          end
		        else 
				  begin
		            req <= 0;
			        state <= Idle;
		          end
	          end	
		    Read : 
		      begin
                req <= 1'b0;		  
		        if ( gnt ) 
		          state <= Route;
		        else 
		          state <= Read;
	 	      end
		    Route: 
		      begin 
		        state <= Grant;
				if(x > PacketIn[31:30])
				  begin
				     channel_req[0] <= 1;
					 channel_req[1] <= 1;
					dataBuf <= PacketIn;
				  end
				
				  
				else if(x < PacketIn[31:30])
				  begin
				    channel_req[4] <= 1;
					channel_req[5] <= 1;
			
					dataBuf <= PacketIn;
				  end
				 
				
				else if(y > PacketIn[29:28])
				  begin
				    channel_req[7] <= 1;
					channel_req[6] <= 1;
				    dataBuf <= PacketIn;
				  end
			  
				
				else if(y < PacketIn[29:28])
				  begin
				    channel_req[2] <= 1'b1;
				    channel_req[3] <= 1'b1;
					dataBuf <= PacketIn;
				  end
				else
                  begin
				    channel_req[2] <= 1;
					channel_req[3] <= 1;
				    dataBuf <= PacketIn;
				  end
    			end
		    Grant: 
		      begin
		        if (channel_gnt)
			      begin
		            state <= Idle;
			        channel_req <= 10'b0;//already get req
		          end
		        else
		          state <= state;
		      end
	      endcase
        end
    end
endmodule