
module PE(
          input rst,
          input clk, 
          output logic ReqDnStr,
          input  GntDnStr,
          input  DnStrFull,
          output logic [31:0]PacketOut
          );              
  //parameter routerID = 6'b000_000; // change depends on mesh size 
  //parameter ModuleID = 6'b000_000;
  //parameter CLOCK_MULT = 3'b001; //// packet injection rate (percentage of cycles)
  parameter dataWidth = 32;// number of bits for data bus
  parameter dim = 4;// dimension of x,y fields in source and destination  
  parameter //WAIT_REQ=3'b000, 
			//RECEIVE_DATA=3'b001,
			IDLE = 3'b010,
            PKT_PREP = 3'b011, 
            SEND_REQ = 3'b100, 
            WAIT_GRANT = 3'b101;  
            
			
  logic [dataWidth-1:0] dataBuf;// data buffer register 

  logic [2:0] STATE;
  logic [3:0] Delay,Count;
  logic [7:0] num; //0 : 255
  
  logic [1:0] random_x,random_y;  
  logic [23:0] random_data;
  always @(posedge clk )  
    begin
      if(rst) 
	    begin
          STATE <= IDLE;
		  dataBuf <= 32'h0;      
		  Count <=4'b0;
		  Delay <= 4'b0;
		end
	  else 
	    begin
          case(STATE)
		    
		  
            IDLE:
              begin 
                Delay   <= {$random}% 16;//{$random}%3;// 0,1,2,3 are selected randomly
                random_x <= {$random} % 3;
                random_y <= {$random} % 3;
                random_data <= {$random} % 9000;
                STATE  <= PKT_PREP;
              end
            PKT_PREP:
              begin
                dataBuf <= {2'b01,2'b01,random_x,random_y,random_data};     
                STATE  <= SEND_REQ;
              end
            SEND_REQ:
              begin  
                if (Count == Delay)
                  begin
                    if (!DnStrFull) // Buffer not Full !=1
                      begin
                        ReqDnStr <= 1; //send request to Local Port
                        PacketOut  <= dataBuf;
                        STATE  <= WAIT_GRANT;
                        Count <= 0;
                      end //if
                    else 
                      begin
                        STATE <= SEND_REQ;
                      end 
                  end//if delay
                else 
                  begin
                    Count <= Count+1'b1;          
                  end
              end  //if (PacketID != 1023)    
            WAIT_GRANT: 
              begin
                if (GntDnStr) // Buffer not Full
                  begin
                    ReqDnStr <=0; //send request to Local Port
                    STATE    <= IDLE;
                  end
                else
                  begin
                    STATE    <= WAIT_GRANT;
                  end
              end
          endcase
      end
    end //else
	
	
endmodule
          
          