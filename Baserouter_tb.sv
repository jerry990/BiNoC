`include "Baserouter.sv"
module Baserouter_tb;
  logic clk;
  logic rst;
  logic eastReqUpStr;
  logic northReqUpStr;
  logic westReqUpStr;
  logic southReqUpStr;
  logic localReqUpStr;
					
  logic eastDnStrFull; 
  logic				northDnStrFull;
  logic			westDnStrFull; 
  logic		southDnStrFull;
  logic	localDnStrFull;
					
				logic	eastGntDnStr;
				logic	northGntDnStr;
				logic	westGntDnStr;
				logic	southGntDnStr;
				logic	localGntDnStr;
					
				logic[31:0]	eastPacketIn;
				logic[31:0]	northPacketIn;
				logic[31:0]	westPacketIn;
				logic[31:0]	southPacketIn;
				logic[31:0]	localPacketIn;
				//======out============	
				logic	eastReqDnStr;
				logic	northReqDnStr;
				logic	westReqDnStr;
				logic	southReqDnStr;
				logic	localReqDnStr;
					
				logic	 eastUpStrFull;
				logic	 northUpStrFull;
				logic	 westUpStrFull; 
				logic	 southUpStrFull;
				logic	 localUpStrFull;
					
   				logic	 eastGntUpStr;  
				logic	 northGntUpStr;   
				logic	 westGntUpStr ;
				logic	 southGntUpStr;
				logic	 localGntUpStr; 
					
				logic[31:0]	 eastPacketOut;
							  
				logic[31:0]	 northPacketOut;
							    
				logic[31:0]	 westPacketOut;
							   
				logic[31:0]     southPacketOut;
							  
				logic[31:0]	 localPacketOut;     
  
 
  always #1 clk = ~clk;


  Baserouter #(.x(1),.y(1))
             b00(   clk, 
                    rst,
					eastReqUpStr,
                    northReqUpStr,
					westReqUpStr,
					southReqUpStr,
					localReqUpStr,
					
					eastDnStrFull, 
					northDnStrFull,
					westDnStrFull, 
					southDnStrFull,
					localDnStrFull,
					
					eastGntDnStr,
					northGntDnStr,
					westGntDnStr,
					southGntDnStr,
					localGntDnStr,
					
					eastPacketIn,
					northPacketIn,
					westPacketIn,
					southPacketIn,
					localPacketIn,
				//======out============	
					eastReqDnStr,
					northReqDnStr,
					westReqDnStr,
					southReqDnStr,
					localReqDnStr,
					
					 eastUpStrFull,
					 northUpStrFull,
					 westUpStrFull, 
					 southUpStrFull,
					 localUpStrFull,
					
   					 eastGntUpStr,  
					 northGntUpStr,   
					 westGntUpStr ,
					 southGntUpStr,
					 localGntUpStr, 
					
					 eastPacketOut,
							  
					 northPacketOut,
							    
					 westPacketOut,
							   
				     southPacketOut,
							  
					 localPacketOut      
                  );

  initial  
    begin
      clk = 0;
	  rst =1;
	  #2
	  rst=0;
	  westPacketIn = 32'h2223332;
	  westReqUpStr = 1'b1;
      westDnStrFull = 1'b0;
	  southDnStrFull = 1'b0;
	  northDnStrFull = 1'b0;
	  eastDnStrFull = 1'b0;
	  localDnStrFull = 1'b0;
	  localGntDnStr = 1'b1;
	  southGntDnStr = 1'b1;
      westGntDnStr = 1'b1;
	  eastGntDnStr = 1'b1;
	  northGntDnStr = 1'b1;
	  
	
	//  #1
	//  westReqUpStr = 1'b0;
    //  #3
	//  westReqUpStr = 1'b1;
      
	//  #1
	//  westPacketIn = 32'h51dddddddd;
	  #1
	  localReqUpStr = 1'b0;
      #3
	  localReqUpStr = 1'b1;
      
	  #1
	  localPacketIn = 32'h51bbbbbb;
	  #1
	  westReqUpStr = 1'b0;
      #3
	  westReqUpStr = 1'b1;
      
	  #1
	  westPacketIn = 32'h6ccccccc;
	  #1
	  westReqUpStr = 1'b0;
      #3
	  westReqUpStr = 1'b1;
      
	  #1
	  westPacketIn = 32'h7ddddddd;
	  
	  
	  
	  
	  
/*	   #1
	  westReqUpStr = 1'b0;
      #1
	  westReqUpStr = 1'b1;
      
	  #1
	  westPacketIn = 32'h2223340;
	   #1
	  westReqUpStr = 1'b0;
      #1
	  westReqUpStr = 1'b1;
      
	  #1
	  westPacketIn = 32'h2223341;
	   #1
	  westReqUpStr = 1'b0;
      #1
	  westReqUpStr = 1'b1;
      
	  #1
	  westPacketIn = 32'h2223342;
	   #1
	  westReqUpStr = 1'b0;
      #1
	  westReqUpStr = 1'b1;
      
	  #1
	  westPacketIn = 32'h8223338;
	 */ 
    end
	initial 
      begin
        $fsdbDumpfile("Baserouter.fsdb");
        $fsdbDumpvars(0, Baserouter_tb);
        #(10000)
		
        $finish;
      end

   

endmodule