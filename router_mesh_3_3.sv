`include "Baserouter.sv"
`include "PE.sv"
module router_mesh_3_3(
  input clk,
  input rst
  );
  
  parameter dataWidth = 32;
  //===============req================
  //east to west										
  logic eastReq_0_0_w,eastReq_0_1_w,eastReq_0_2_w,eastReq_1_0_w,eastReq_1_1_w,eastReq_1_2_w; 
  //north to south
  logic northReq_0_0_s,northReq_1_0_s,northReq_2_0_s,northReq_0_1_s,northReq_1_1_s,northReq_2_1_s;
  //west to east
  logic westReq_1_0_e,westReq_1_1_e,westReq_1_2_e,westReq_2_0_e,westReq_2_1_e,westReq_2_2_e;
  //south to north
  logic southReq_0_1_n, southReq_1_1_n,southReq_2_1_n,southReq_0_2_n,southReq_1_2_n,southReq_2_2_n;
  //Local UpStr
  logic  localReqUpStr_0_0, localReqUpStr_1_0, localReqUpStr_0_1, localReqUpStr_1_1,
         localReqUpStr_2_0, localReqUpStr_0_2, localReqUpStr_1_2, localReqUpStr_2_1,
		 localReqUpStr_2_2;
  //Local DnStr
  logic  localReqDnStr_0_0, localReqDnStr_1_0,localReqDnStr_0_1,localReqDnStr_1_1,
         localReqDnStr_2_0, localReqDnStr_0_2, localReqDnStr_1_2, localReqDnStr_2_1,
		 localReqDnStr_2_2;
  //===========gnt ==============================
  //east to west
  logic eastGnt_0_0_w, eastGnt_0_1_w, eastGnt_0_2_w, eastGnt_1_0_w, eastGnt_1_1_w, eastGnt_1_2_w;
  //north to south
  logic  northGnt_0_1_s, northGnt_1_1_s, northGnt_0_0_s, northGnt_1_0_s, northGnt_2_0_s, northGnt_2_1_s;
  //west to east
  logic  westGnt_1_0_e, westGnt_1_1_e, westGnt_1_2_e, westGnt_2_0_e, westGnt_2_1_e, westGnt_2_2_e;
  //south to north
  logic  southGnt_0_1_n, southGnt_1_1_n, southGnt_2_1_n, southGnt_0_2_n, southGnt_2_2_n, southGnt_1_2_n;
  //Local UpStr
  logic  localGntUpStr_0_0, localGntUpStr_1_0,localGntUpStr_0_1,localGntUpStr_1_1,
         localGntUpStr_2_0, localGntUpStr_0_2,localGntUpStr_1_2,localGntUpStr_2_1,
		 localGntUpStr_2_2;
  //Local  DnStr
  logic  localGntDnStr_0_0, localGntDnStr_1_0,localGntDnStr_0_1,localGntDnStr_1_1,
         localGntDnStr_2_0, localGntDnStr_0_2,localGntDnStr_1_2,localGntDnStr_2_1,
		 localGntDnStr_2_2;
  //============full===========================
  //east to west
  logic eastFull_0_0_w, eastFull_0_1_w, eastFull_0_2_w, eastFull_1_0_w, eastFull_1_1_w, eastFull_1_2_w;
  //north to south
  logic northFull_0_1_s, northFull_1_1_s, northFull_0_0_s, northFull_1_0_s, northFull_2_0_s, northFull_2_1_s;
  //west to east
  logic westFull_1_0_e, westFull_1_1_e, westFull_1_2_e, westFull_2_0_e, westFull_2_1_e, westFull_2_2_e;
  //south to north
  logic  southFull_0_1_n, southFull_1_1_n, southFull_2_1_n, southFull_0_2_n, southFull_2_2_n, southFull_1_2_n; 
  //Local UpStr
  logic  localUpStrFull_0_0, localUpStrFull_1_0,localUpStrFull_0_1,localUpStrFull_1_1,
         localUpStrFull_2_0, localUpStrFull_0_2,localUpStrFull_1_2,localUpStrFull_2_1,
		 localUpStrFull_2_2;
  //Local  DnStr
  logic  localDnStrFull_0_0, localDnStrFull_1_0,localDnStrFull_0_1,localDnStrFull_1_1,
         localDnStrFull_2_0, localDnStrFull_0_2,localDnStrFull_1_2,localDnStrFull_2_1,
		 localDnStrFull_2_2;
  //======================Packet============================
  //east to west
  logic [dataWidth-1:0] eastPacket_0_0_w, eastPacket_0_1_w, eastPacket_0_2_w, eastPacket_1_0_w, eastPacket_1_1_w, eastPacket_1_2_w;
  //north to south
  logic [dataWidth-1:0] northPacket_0_1_s, northPacket_1_1_s, northPacket_0_0_s, northPacket_1_0_s, northPacket_2_0_s, northPacket_2_1_s;
  //west to east
  logic [dataWidth-1:0] westPacket_1_0_e, westPacket_1_1_e, westPacket_1_2_e, westPacket_2_0_e, westPacket_2_1_e, westPacket_2_2_e;
  //south to north
  logic [dataWidth-1:0] southPacket_0_1_n, southPacket_1_1_n, southPacket_2_1_n, southPacket_0_2_n, southPacket_2_2_n, southPacket_1_2_n;
  //Local localPacketIn
  logic [dataWidth-1:0] localPacketIn_0_0, localPacketIn_1_0,localPacketIn_0_1,localPacketIn_1_1,
                        localPacketIn_2_0, localPacketIn_0_2,localPacketIn_1_2,localPacketIn_2_1,
						localPacketIn_2_2;
  //Local  localPacketOut
  logic [dataWidth-1:0] localPacketOut_0_0, localPacketOut_1_0,localPacketOut_0_1,localPacketOut_1_1,
                        localPacketOut_2_0, localPacketOut_0_2,localPacketOut_1_2,localPacketOut_2_1,
						localPacketOut_2_2;
  //==============router x 4===============
  Baserouter #(.x(0),.y(0))
             n00(   .clk(clk), 
                    .rst(rst),
  					.eastReqUpStr(westReq_1_0_e),//input
                    .northReqUpStr(southReq_0_1_n),
  					.westReqUpStr(1'bz),
  					.southReqUpStr(1'bz),
  					.localReqUpStr(localReqUpStr_0_0),
  					
  					.eastDnStrFull(westFull_1_0_e),//input 
  					.northDnStrFull(southFull_0_1_n),
  					.westDnStrFull(1'bz), 
  					.southDnStrFull(1'bz),
  					.localDnStrFull(localDnStrFull_0_0),
  					
  					.eastGntDnStr(westGnt_1_0_e),
  					.northGntDnStr(southGnt_0_1_n),
  					.westGntDnStr(1'bz),
  					.southGntDnStr(1'bz),
  					.localGntDnStr(localDnStrFull_0_0),
  					
  					.eastPacketIn(westPacket_1_0_e),
  					.northPacketIn(southPacket_0_1_n),
  					.westPacketIn(32'hzzzz_zzzz),
  					.southPacketIn(32'hzzzz_zzzz),
  					.localPacketIn(localPacketIn_0_0),
  					//======following is output========
  					.eastReqDnStr(eastReq_0_0_w),
  					.northReqDnStr(northReq_0_0_s),
  					.westReqDnStr(),
  					.southReqDnStr(),
  					.localReqDnStr(localReqDnStr_0_0),
  					
  					.eastUpStrFull(eastFull_0_0_w),
  					.northUpStrFull(northFull_0_0_s),
  					.westUpStrFull(), 
  					.southUpStrFull(),
  					.localUpStrFull(localUpStrFull_0_0),
  					
     				.eastGntUpStr(eastGnt_0_0_w),  
  					.northGntUpStr(northGnt_0_0_s),   
  					.westGntUpStr(),
  					.southGntUpStr(),
  					.localGntUpStr(localGntUpStr_0_0), 
  					
  					.eastPacketOut(eastPacket_0_0_w),
  							  
  					.northPacketOut(northPacket_0_0_s),
  							    
  					.westPacketOut(),
  							   
  					.southPacketOut(),
  							  
  					.localPacketOut(localPacketOut_0_0)      
                    );
					
  
  Baserouter#(.x(0),.y(1)) 
             n01(    .clk(clk), 
                    .rst(rst),
  			 	    .eastReqUpStr(westReq_1_1_e),//input
                    .northReqUpStr(southReq_0_2_n),
  					.westReqUpStr(1'bz),
  					.southReqUpStr(northReq_0_0_s),
  					.localReqUpStr(localReqUpStr_0_1),
  					
  					.eastDnStrFull(westFull_1_1_e),//input 
  					.northDnStrFull(southFull_0_2_n),
  					.westDnStrFull(1'bz), 
  					.southDnStrFull(northFull_0_0_s),
  					.localDnStrFull(localDnStrFull_0_1),
  					
  					.eastGntDnStr(westGnt_1_1_e),
  					.northGntDnStr(southGnt_0_2_n),
  					.westGntDnStr(1'bz),
  					.southGntDnStr(northGnt_0_0_s),
  					.localGntDnStr(localDnStrFull_0_1),
  					
  					.eastPacketIn(westPacket_1_1_e),
  					.northPacketIn(southPacket_0_2_n),
  					.westPacketIn(32'hzzzz_zzzz),
  					.southPacketIn(northPacket_0_0_s),
  					.localPacketIn(localPacketIn_0_1),
  					//======following is output========
  					.eastReqDnStr(eastReq_0_1_w),
  					.northReqDnStr(northReq_0_1_s),
  					.westReqDnStr(),
  					.southReqDnStr(southReq_0_1_n),
  					.localReqDnStr(localReqDnStr_0_1),
  					
  					.eastUpStrFull(eastFull_0_1_w),
  					.northUpStrFull(northFull_0_1_s),
  					.westUpStrFull(), 
  					.southUpStrFull(southFull_0_1_n),
  					.localUpStrFull(localUpStrFull_0_1),
  					
     			    .eastGntUpStr(eastGnt_0_1_w),  
  					.northGntUpStr(northGnt_0_1_s),   
  					.westGntUpStr(),
  					.southGntUpStr(southGnt_0_1_n),
  					.localGntUpStr(localGntUpStr_0_1), 
  					
  					.eastPacketOut(eastPacket_0_1_w),
  							  
  					.northPacketOut(northPacket_0_1_s),
  							    
  					.westPacketOut(),
  							   
  					.southPacketOut(southPacket_0_1_n),
  							  
  					.localPacketOut(localPacketOut_0_1)      
                    );
					
  
   Baserouter#(.x(1),.y(0)) 
              n10(  .clk(clk), 
                    .rst(rst),
  					.eastReqUpStr(westReq_2_0_e),//input
                    .northReqUpStr(southReq_1_1_n),
  					.westReqUpStr(eastReq_0_0_w),
  					.southReqUpStr(1'bz),
  					.localReqUpStr(localReqUpStr_1_0),
  					
  					.eastDnStrFull(westFull_2_0_e),//input 
  					.northDnStrFull(southFull_1_1_n),
  					.westDnStrFull(eastFull_0_0_w), 
  					.southDnStrFull(1'bz),
  					.localDnStrFull(localDnStrFull_1_0),
  					
  					.eastGntDnStr(westGnt_2_0_e),
  					.northGntDnStr(southGnt_1_1_n),
  					.westGntDnStr(eastGnt_0_0_w),
  					.southGntDnStr(1'bz),
  					.localGntDnStr(localDnStrFull_1_0),
  					
  					.eastPacketIn(westPacket_2_0_e),
  					.northPacketIn(southPacket_1_1_n),
  					.westPacketIn(eastPacket_0_0_w),
  					.southPacketIn(32'hzzzz_zzzz),
  					.localPacketIn(localPacketIn_1_0),
  					//======following is output========
  					.eastReqDnStr(eastReq_1_0_w),
  					.northReqDnStr(northReq_1_0_s),
  					.westReqDnStr(westReq_1_0_e),
  					.southReqDnStr(),
  					.localReqDnStr(localReqDnStr_1_0),
  					
  					.eastUpStrFull(eastFull_1_0_w),
  					.northUpStrFull(northFull_1_0_s),
  					.westUpStrFull(westFull_1_0_e), 
  					.southUpStrFull(),
  					.localUpStrFull(localUpStrFull_1_0),
  					
     			    .eastGntUpStr(eastGnt_1_0_w),  
  					.northGntUpStr(northGnt_1_0_s),   
  					.westGntUpStr(westGnt_1_0_e),
  					.southGntUpStr(),
  					.localGntUpStr(localGntUpStr_1_0), 
  					
  					.eastPacketOut(eastPacket_1_0_w),
  							  
  					.northPacketOut(northPacket_1_0_s),
  							    
  					.westPacketOut(westPacket_1_0_e),
  							   
  					.southPacketOut(),
  							  
  					.localPacketOut(localPacketOut_1_0)      
                    );
	initial begin
	  localDnStrFull_1_1 = 1'b0;
	  localGntDnStr_1_1 = 1'b1;
	end
	Baserouter#(.x(1),.y(1)) 
	         n11(   .clk(clk), 
                    .rst(rst),
  				    .eastReqUpStr(westReq_2_1_e),//input
                    .northReqUpStr(southReq_1_2_n),
  					.westReqUpStr(eastReq_0_1_w),
  					.southReqUpStr(northReq_1_0_s),
  					.localReqUpStr(localReqUpStr_1_1),
  					
  					.eastDnStrFull(westFull_2_1_e),//input 
  					.northDnStrFull(southFull_1_2_n),
  					.westDnStrFull(eastFull_0_1_w), 
  					.southDnStrFull(northFull_1_0_s),
  					.localDnStrFull(localDnStrFull_1_1),
  					
  					.eastGntDnStr(westGnt_2_1_e),
  					.northGntDnStr(southGnt_1_2_n),
  					.westGntDnStr(eastGnt_0_1_w),
  					.southGntDnStr(northGnt_1_0_s),
  					.localGntDnStr(localGntDnStr_1_1),
  					
  					.eastPacketIn(westPacket_2_1_e),
  					.northPacketIn(southPacket_1_2_n),
  					.westPacketIn(eastPacket_0_1_w),
  					.southPacketIn(northPacket_1_0_s),
  					.localPacketIn(localPacketIn_1_1),
  					//======following is output========
  					.eastReqDnStr(eastReq_1_1_w),
  					.northReqDnStr(northReq_1_1_s),
  					.westReqDnStr(westReq_1_1_e),
  					.southReqDnStr(southReq_1_1_n),
  					.localReqDnStr(localReqDnStr_1_1),
  					
  					.eastUpStrFull(eastFull_1_1_w),
  					.northUpStrFull(northFull_1_1_s),
  					.westUpStrFull(westFull_1_1_e), 
  					.southUpStrFull(southFull_1_1_n),
  					.localUpStrFull(localUpStrFull_1_1),
  					
     				.eastGntUpStr(eastGnt_1_1_w),  
  					.northGntUpStr(northGnt_1_1_s),   
  					.westGntUpStr(westGnt_1_1_e),
  					.southGntUpStr(southGnt_1_1_n),
  					.localGntUpStr(localGntUpStr_1_1), 
  					
  					.eastPacketOut(eastPacket_1_1_w),
  							  
  					.northPacketOut(northPacket_1_1_s),
  							    
  					.westPacketOut(westPacket_1_1_e),
  							   
  					.southPacketOut(southPacket_1_1_n),
  							  
  					.localPacketOut(localPacketOut_1_1)      
                    );
	Baserouter #(.x(2),.y(0))
	         n20(   .clk(clk), 
                    .rst(rst),
  					.eastReqUpStr(1'bz),//input
                    .northReqUpStr(southReq_2_1_n),
  					.westReqUpStr(eastReq_1_0_w),
  					.southReqUpStr(1'bz),
  					.localReqUpStr(localReqUpStr_2_0),
  					
  					.eastDnStrFull(1'bz),//input 
  					.northDnStrFull(southFull_2_1_n),
  					.westDnStrFull(eastFull_1_0_w), 
  					.southDnStrFull(1'bz),
  					.localDnStrFull(localDnStrFull_2_0),
  					
  					.eastGntDnStr(1'bz),
  					.northGntDnStr(southGnt_2_1_n),
  					.westGntDnStr(eastGnt_1_0_w),
  					.southGntDnStr(1'bz),
  					.localGntDnStr(localDnStrFull_2_0),
  					
  					.eastPacketIn(32'hzzzz_zzzz),
  					.northPacketIn(southPacket_2_1_n),
  					.westPacketIn(eastPacket_1_0_w),
  					.southPacketIn(32'hzzzz_zzzz),
  					.localPacketIn(localPacketIn_2_0),
  					//======following is output========
  					.eastReqDnStr(),
  					.northReqDnStr(northReq_2_0_s),
  					.westReqDnStr(westReq_2_0_e),
  					.southReqDnStr(),
  					.localReqDnStr(localReqDnStr_2_0),
  					
  					.eastUpStrFull(),
  					.northUpStrFull(northFull_2_0_s),
  					.westUpStrFull(westFull_2_0_e), 
  					.southUpStrFull(),
  					.localUpStrFull(localUpStrFull_2_0),
  					
     				.eastGntUpStr(),  
  					.northGntUpStr(northGnt_2_0_s),   
  					.westGntUpStr(westGnt_2_0_e),
  					.southGntUpStr(),
  					.localGntUpStr(localGntUpStr_2_0), 
  					
  					.eastPacketOut(),
  							  
  					.northPacketOut(northPacket_2_0_s),
  							    
  					.westPacketOut(westPacket_2_0_e),
  							   
  					.southPacketOut(),
  							  
  					.localPacketOut(localPacketOut_2_0)      
                    );
	Baserouter #(.x(0),.y(2)) 
	         n02(   .clk(clk), 
                    .rst(rst),
  					.eastReqUpStr(westReq_1_2_e),//input
                    .northReqUpStr(1'bz),
  					.westReqUpStr(1'bz),
  					.southReqUpStr(northReq_0_1_s),
  					.localReqUpStr(localReqUpStr_0_2),
  					
  					.eastDnStrFull(westFull_1_2_e),//input 
  					.northDnStrFull(1'bz),
  					.westDnStrFull(1'bz), 
  					.southDnStrFull(northFull_0_1_s),
  					.localDnStrFull(localDnStrFull_0_2),
  					
  					.eastGntDnStr(westGnt_1_2_e),
  					.northGntDnStr(1'bz),
  					.westGntDnStr(1'bz),
  					.southGntDnStr(northGnt_0_1_s),
  					.localGntDnStr(localDnStrFull_0_2),
  					
  					.eastPacketIn(westPacket_1_2_e),
  					.northPacketIn(32'hzzzz_zzzz),
  					.westPacketIn(32'hzzzz_zzzz),
  					.southPacketIn(northPacket_0_1_s),
  					.localPacketIn(localPacketIn_0_2),
  					//======following is output========
  					.eastReqDnStr(eastReq_0_2_w),
  					.northReqDnStr(),
  					.westReqDnStr(),
  					.southReqDnStr(southReq_0_2_n),
  					.localReqDnStr(localReqDnStr_0_2),
  					
  					.eastUpStrFull(eastFull_0_2_w),
  					.northUpStrFull(),
  					.westUpStrFull(), 
  					.southUpStrFull(southFull_0_2_n),
  					.localUpStrFull(localUpStrFull_0_2),
  					
     				.eastGntUpStr(eastGnt_0_2_w),  
  					.northGntUpStr(),   
  					.westGntUpStr(),
  					.southGntUpStr(southGnt_0_2_n),
  					.localGntUpStr(localGntUpStr_0_2), 
  					
  					.eastPacketOut(eastPacket_0_2_w),
  							  
  					.northPacketOut(),
  							    
  					.westPacketOut(),
  							   
  					.southPacketOut(southPacket_0_2_n),
  							  
  					.localPacketOut(localPacketOut_0_2)      
                    );
	Baserouter#(.x(1),.y(2)) 
              n12(  .clk(clk), 
                    .rst(rst),
  					.eastReqUpStr(westReq_2_2_e),//input
                    .northReqUpStr(1'bz),
  					.westReqUpStr(eastReq_0_2_w),
  					.southReqUpStr(northReq_1_1_s),
  					.localReqUpStr(localReqUpStr_1_2),
  					
  					.eastDnStrFull(westFull_2_2_e),//input 
  					.northDnStrFull(1'bz),
  					.westDnStrFull(eastFull_0_2_w), 
  					.southDnStrFull(northFull_1_1_s),
  					.localDnStrFull(1'b0/*localDnStrFull_1_2*/),
  					
  					.eastGntDnStr(westGnt_2_2_e),
  					.northGntDnStr(1'bz),
  					.westGntDnStr(eastGnt_0_2_w),
  					.southGntDnStr(northGnt_1_1_s),
  					.localGntDnStr(1'b1/*localDnStrFull_1_2*/),
  					
  					.eastPacketIn(westPacket_2_2_e),
  					.northPacketIn(32'hzzzz_zzzz),
  					.westPacketIn(eastPacket_0_2_w),
  					.southPacketIn(northPacket_1_1_s),
  					.localPacketIn(localPacketIn_1_2),
  					//======following is output========
  					.eastReqDnStr(eastReq_1_2_w),
  					.northReqDnStr(),
  					.westReqDnStr(westReq_1_2_e),
  					.southReqDnStr(southReq_1_2_n),
  					.localReqDnStr(localReqDnStr_1_2),
  					
  					.eastUpStrFull(eastFull_1_2_w),
  					.northUpStrFull(),
  					.westUpStrFull(westFull_1_2_e), 
  					.southUpStrFull(southFull_1_2_n),
  					.localUpStrFull(localUpStrFull_1_2),
  					
     			    .eastGntUpStr(eastGnt_1_2_w),  
  					.northGntUpStr(),   
  					.westGntUpStr(westGnt_1_2_e),
  					.southGntUpStr(southGnt_1_2_n),
  					.localGntUpStr(localGntUpStr_1_2), 
  					
  					.eastPacketOut(eastPacket_1_2_w),
  							  
  					.northPacketOut(),
  							    
  					.westPacketOut(westPacket_1_2_e),
  							   
  					.southPacketOut(southPacket_1_2_n),
  							  
  					.localPacketOut(localPacketOut_1_2)      
                    );
	Baserouter#(.x(2),.y(1)) 
             n21(   .clk(clk), 
                    .rst(rst),
  			 	    .eastReqUpStr(1'bz),//input
                    .northReqUpStr(southReq_2_2_n),
  					.westReqUpStr(eastReq_1_1_w),
  					.southReqUpStr(northReq_2_0_s),
  					.localReqUpStr(localReqUpStr_2_1),
  					
  					.eastDnStrFull(1'bz),//input 
  					.northDnStrFull(southFull_2_2_n),
  					.westDnStrFull(eastFull_1_1_w), 
  					.southDnStrFull(northFull_2_0_s),
  					.localDnStrFull(localDnStrFull_2_1),
  					
  					.eastGntDnStr(1'bz),
  					.northGntDnStr(southGnt_2_2_n),
  					.westGntDnStr(eastGnt_1_1_w),
  					.southGntDnStr(northGnt_2_0_s),
  					.localGntDnStr(localDnStrFull_2_1),
  					
  					.eastPacketIn(32'hzzzz_zzzz),
  					.northPacketIn(southPacket_2_2_n),
  					.westPacketIn(eastPacket_1_1_w),
  					.southPacketIn(northPacket_2_0_s),
  					.localPacketIn(localPacketIn_2_1),
  					//======following is output========
  					.eastReqDnStr(),
  					.northReqDnStr(northReq_2_1_s),
  					.westReqDnStr(westReq_2_1_e),
  					.southReqDnStr(southReq_2_1_n),
  					.localReqDnStr(localReqDnStr_2_1),
  					
  					.eastUpStrFull(),
  					.northUpStrFull(northFull_2_1_s),
  					.westUpStrFull(westFull_2_1_e), 
  					.southUpStrFull(southFull_2_1_n),
  					.localUpStrFull(localUpStrFull_2_1),
  					
     			    .eastGntUpStr(),  
  					.northGntUpStr(northGnt_2_1_s),   
  					.westGntUpStr(westGnt_2_1_e),
  					.southGntUpStr(southGnt_2_1_n),
  					.localGntUpStr(localGntUpStr_2_1), 
  					
  					.eastPacketOut(),
  							  
  					.northPacketOut(northPacket_2_1_s),
  							    
  					.westPacketOut(westPacket_2_1_e),
  							   
  					.southPacketOut(southPacket_2_1_n),
  							  
  					.localPacketOut(localPacketOut_2_1)      
                    );		
					
	Baserouter #(.x(2),.y(2))
             n22(   .clk(clk), 
                    .rst(rst),
  					.eastReqUpStr(1'bz),//input
                    .northReqUpStr(1'bz),
  					.westReqUpStr(eastReq_1_2_w),
  					.southReqUpStr(northReq_2_1_s),
  					.localReqUpStr(localReqUpStr_2_2),
  					
  					.eastDnStrFull(1'bz),//input 
  					.northDnStrFull(1'bz),
  					.westDnStrFull(eastFull_1_2_w), 
  					.southDnStrFull(northFull_2_1_s),
  					.localDnStrFull(localDnStrFull_2_2),
  					
  					.eastGntDnStr(1'bz),
  					.northGntDnStr(1'bz),
  					.westGntDnStr(eastGnt_1_2_w),
  					.southGntDnStr(northGnt_2_1_s),
  					.localGntDnStr(localDnStrFull_2_2),
  					
  					.eastPacketIn(32'hzzzz_zzzz),
  					.northPacketIn(32'hzzzz_zzzz),
  					.westPacketIn(eastPacket_1_2_w),
  					.southPacketIn(northPacket_2_1_s),
  					.localPacketIn(localPacketIn_2_2),
  					//======following is output========
  					.eastReqDnStr(),
  					.northReqDnStr(),
  					.westReqDnStr(westReq_2_2_e),
  					.southReqDnStr(southReq_2_2_n),
  					.localReqDnStr(localReqDnStr_2_2),
  					
  					.eastUpStrFull(),
  					.northUpStrFull(),
  					.westUpStrFull(westFull_2_2_e), 
  					.southUpStrFull(southFull_2_2_n),
  					.localUpStrFull(localUpStrFull_2_2),
  					
     				.eastGntUpStr(),  
  					.northGntUpStr(),   
  					.westGntUpStr(westGnt_2_2_e),
  					.southGntUpStr(southGnt_2_2_n),
  					.localGntUpStr(localGntUpStr_2_2), 
  					
  					.eastPacketOut(),
  							  
  					.northPacketOut(),
  							    
  					.westPacketOut(westPacket_2_2_e),
  							   
  					.southPacketOut(southPacket_2_2_w),
  							  
  					.localPacketOut(localPacketOut_2_2)      
                    );
					
	PE  PEn11(
               .rst(rst),
               .clk(clk), 
               .ReqDnStr(localReqUpStr_1_1),
               .GntDnStr(localGntUpStr_1_1),
               .DnStrFull(localUpStrFull_1_1),
               .PacketOut(localPacketIn_1_1)
          );   				
endmodule