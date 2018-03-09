//`timescale 1ns / 1ps
`include "inputport.sv"
`include "outputport.sv"
module Baserouter(  input clk, 
                    input rst,
					input eastReqUpStr,
                    input northReqUpStr,
					input westReqUpStr,
					input southReqUpStr,
					input localReqUpStr,
					
					input eastDnStrFull, 
					input northDnStrFull,
					input westDnStrFull, 
					input southDnStrFull,
					input localDnStrFull,
					
					input eastGntDnStr,
					input northGntDnStr,
					input westGntDnStr,
					input southGntDnStr,
					input localGntDnStr,
					
					input [31:0] eastPacketIn,
					input [31:0] northPacketIn,
					input [31:0] westPacketIn,
					input [31:0] southPacketIn,
					input [31:0] localPacketIn,
					
					output eastReqDnStr,
					output northReqDnStr,
					output westReqDnStr,
					output southReqDnStr,
					output localReqDnStr,
					
					output logic eastUpStrFull,
					output logic northUpStrFull,
					output logic westUpStrFull, 
					output logic southUpStrFull,
					output logic localUpStrFull,
					
   					output logic eastGntUpStr,  
					output logic northGntUpStr,   
					output logic westGntUpStr ,
					output logic southGntUpStr,
					output logic localGntUpStr, 
					
					output logic [31:0] eastPacketOut,
							  
					output logic [31:0] northPacketOut,
							    
					output logic [31:0]	westPacketOut,
							   
					output logic [31:0] southPacketOut,
							  
					output logic [31:0] localPacketOut      
                  );
//##################### Parameter Declarations ####################################
parameter routerID     	= 6'b000_000; // Hossam - for 5x5 mesh -- //parameter routerID=4'b0000;  // for 4x4 mesh
parameter routerNo 		= 'd0;
parameter dataWidth 	 	= 32; // number of bits for data bus
parameter addressWidth 	= 1;//4;// number of bits for address bus
parameter fifoDepth 		= ((1 << addressWidth) - 1); // number of entries in fifo buffer
parameter dim 				= 4;// dimension of x,y fields in source and destination  
parameter x = 3;
parameter y = 3;

logic [dataWidth-1:0] eastPacket, northPacket, westPacket, southPacket, localPacket ;
// controll requests and grants between different ports
//Requests
logic eastReqCntr_l, eastReqCntr_s, eastReqCntr_w, eastReqCntr_n, eastReqCntr_e;
logic  northReqCntr_l, northReqCntr_s, northReqCntr_w, northReqCntr_n, northReqCntr_e;
logic  westReqCntr_l, westReqCntr_s, westReqCntr_w, westReqCntr_n, westReqCntr_e;
logic  southReqCntr_l, southReqCntr_s, southReqCntr_w, southReqCntr_n, southReqCntr_e;
logic  localReqCntr_l, localReqCntr_s, localReqCntr_w, localReqCntr_n, localReqCntr_e;
//Grants
logic eastGntCntr_l, eastGntCntr_s, eastGntCntr_w,eastGntCntr_n, eastGntCntr_e;
logic northGntCntr_l, northGntCntr_s, northGntCntr_w, northGntCntr_n, northGntCntr_e;
logic westGntCntr_l, westGntCntr_s, westGntCntr_w, westGntCntr_n, westGntCntr_e;
logic southGntCntr_l, southGntCntr_s, southGntCntr_w, southGntCntr_n, southGntCntr_e;
logic localGntCntr_l, localGntCntr_s, localGntCntr_w, localGntCntr_n, localGntCntr_e;
inputport # (.routerNo(routerNo),.dataWidth(dataWidth),.addressWidth(addressWidth) ,
                    .fifoDepth(fifoDepth),.dim(dim),.x(x),.y(y) ) eastInputController
(
.clk(clk),
.rst(rst),
.reqUpStr(eastReqUpStr),  
.gntUpStr(eastGntUpStr), 
//Buffering Status
.full(eastUpStrFull), //Own Buffer
//Packet Depending on Requests
.PacketIn(eastPacketIn),
.reqOutCntr({ eastReqCntr_l, eastReqCntr_s, eastReqCntr_w, eastReqCntr_n, eastReqCntr_e }),//added eastReqCntr_e
.gntOutCntr({ eastGntCntr_l, eastGntCntr_s, eastGntCntr_w, eastGntCntr_n, eastGntCntr_e }), //added eastGntCntr_e
.PacketOut(eastPacket)
);

/* instantiate East Output Controller . */
outputport # (.routerNo(routerNo),.dataWidth(dataWidth)) eastOutputController
( 
.clk(clk), 
.rst(rst), 
.reqDnStr(eastReqDnStr),
.gntDnStr(eastGntDnStr),   
.full(eastDnStrFull), 
.PacketInPort_4(localPacket), 
.PacketInPort_3(southPacket), 
.PacketInPort_2(westPacket), 
.PacketInPort_1(northPacket),
.PacketInPort_0(eastPacket), 
.reqInCntr({ localReqCntr_e, southReqCntr_e, westReqCntr_e, northReqCntr_e, eastReqCntr_e }), 
.gntInCntr({ localGntCntr_e, southGntCntr_e, westGntCntr_e, northGntCntr_e, eastGntCntr_e }), 
.PacketOut(eastPacketOut) 
);     	

//#################################    North Port  ##########################################
/* instantiate North Input Controller . */
inputport  # (.routerNo(routerNo),.dataWidth(dataWidth),.addressWidth(addressWidth) ,
                    .fifoDepth(fifoDepth),.dim(dim),.x(x),.y(y) ) northInputController
(
.clk(clk),
.rst(rst),
.reqUpStr(northReqUpStr), 
.gntUpStr(northGntUpStr),
//Buffering Status 
.full(northUpStrFull),  
.PacketIn(northPacketIn), 
.reqOutCntr( {northReqCntr_l, northReqCntr_s, northReqCntr_w, northReqCntr_n, northReqCntr_e}),
.gntOutCntr( {northGntCntr_l, northGntCntr_s, northGntCntr_w, northGntCntr_n, northGntCntr_e}), 
.PacketOut(northPacket)
);

/* instantiate North Output Controller . */
outputport # (.routerNo(routerNo),.dataWidth(dataWidth)) northOutputController
( 
.clk(clk), 
.rst(rst), 
.reqDnStr(northReqDnStr), 
.gntDnStr(northGntDnStr), 
.full(northDnStrFull), 
.PacketInPort_4(localPacket), 
.PacketInPort_3(southPacket), 
.PacketInPort_2(westPacket), 
.PacketInPort_1(northPacket),
.PacketInPort_0(eastPacket), 
.reqInCntr({ localReqCntr_n, southReqCntr_n, westReqCntr_n, northReqCntr_n, eastReqCntr_n}), 
.gntInCntr({ localGntCntr_n, southGntCntr_n, westGntCntr_n, northGntCntr_n, eastGntCntr_n }),  
.PacketOut(northPacketOut) 
);

//#################################    West Port  ##########################################
/* instantiate West Input Controller . */
inputport  # (.routerNo(routerNo),.dataWidth(dataWidth),.addressWidth(addressWidth) ,
                    .fifoDepth(fifoDepth),.dim(dim),.x(x),.y(y) ) westInputController
(
.clk(clk),
.rst(rst),
.reqUpStr(westReqUpStr), 
.gntUpStr(westGntUpStr),
//Buffering Status  
.full(westUpStrFull), 
//Packet Depending on Requests
.PacketIn(westPacketIn), 
.reqOutCntr({westReqCntr_l, westReqCntr_s, westReqCntr_w, westReqCntr_n, westReqCntr_e}),
.gntOutCntr({westGntCntr_l, westGntCntr_s, westGntCntr_w, westGntCntr_n, westGntCntr_e}), 
.PacketOut(westPacket)
);

/* instantiate West Output Controller . */                       
outputport # (.routerNo(routerNo),.dataWidth(dataWidth)) westOutputController
( 
.clk(clk), 
.rst(rst), 
.reqDnStr(westReqDnStr), 
.gntDnStr(westGntDnStr), 
.full(westDnStrFull), 
.PacketInPort_4(localPacket), 
.PacketInPort_3(southPacket), 
.PacketInPort_2(westPacket), 
.PacketInPort_1(northPacket),
.PacketInPort_0(eastPacket), 
.reqInCntr({ localReqCntr_w, southReqCntr_w, westReqCntr_w, northReqCntr_w, eastReqCntr_w }), 
.gntInCntr({ localGntCntr_w, southGntCntr_w, westGntCntr_w, northGntCntr_w, eastGntCntr_w }), 
.PacketOut(westPacketOut) 
);


//#################################    South Port  ##########################################
/* instantiate South Input Controller . */
inputport  # (.routerNo(routerNo),.dataWidth(dataWidth),.addressWidth(addressWidth) ,
                    .fifoDepth(fifoDepth),.dim(dim),.x(x),.y(y) ) southInputController
(
.clk(clk),
.rst(rst),
.reqUpStr(southReqUpStr),
.gntUpStr(southGntUpStr), 
//Buffering Status  
.full(southUpStrFull), 
.PacketIn(southPacketIn),
.reqOutCntr({southReqCntr_l, southReqCntr_s, southReqCntr_w, southReqCntr_n, southReqCntr_e}),
.gntOutCntr({southGntCntr_l, southGntCntr_s, southGntCntr_w, southGntCntr_n, southGntCntr_e}), 
.PacketOut(southPacket)
);

/* instantiate South Output Controller . */
outputport # (.routerNo(routerNo),.dataWidth(dataWidth)) southOutputController
( 
.clk(clk), 
.rst(rst), 
.reqDnStr(southReqDnStr),  
.gntDnStr(southGntDnStr), 
.full(southDnStrFull), 
.PacketInPort_4(localPacket), 
.PacketInPort_3(southPacket), 
.PacketInPort_2(westPacket), 
.PacketInPort_1(northPacket),
.PacketInPort_0(eastPacket), 
.reqInCntr({ localReqCntr_s, southReqCntr_s, westReqCntr_s, northReqCntr_s, eastReqCntr_s }), 
.gntInCntr({ localGntCntr_s, southGntCntr_s, westGntCntr_s, northGntCntr_s, eastGntCntr_s }), 
.PacketOut(southPacketOut) 
);

//#################################    Local Port  ##########################################
/* instantiate Local Input Controller . */
inputport  # (.routerNo(routerNo),.dataWidth(dataWidth),.addressWidth(addressWidth) ,
                    .fifoDepth(fifoDepth),.dim(dim),.x(x),.y(y) ) localInputController
(
.clk(clk),
.rst(rst),
.reqUpStr(localReqUpStr), 
.gntUpStr(localGntUpStr),
.full(localUpStrFull), 
.PacketIn(localPacketIn),
.reqOutCntr({localReqCntr_l, localReqCntr_s, localReqCntr_w, localReqCntr_n, localReqCntr_e}), 
.gntOutCntr({localGntCntr_l, localGntCntr_s, localGntCntr_w, localGntCntr_n, localGntCntr_e}), 
.PacketOut(localPacket) 
);

/* instantiate Local Output Controller . */
outputport # (.routerNo(routerNo),.dataWidth(dataWidth)) localOutputController
( 
.clk(clk), 
.rst(rst), 
.reqDnStr(localReqDnStr),
.gntDnStr(localGntDnStr),  
.full(localDnStrFull), 
.PacketInPort_4(localPacket), 
.PacketInPort_3(southPacket), 
.PacketInPort_2(westPacket), 
.PacketInPort_1(northPacket),
.PacketInPort_0(eastPacket), 
.reqInCntr({ localReqCntr_l, southReqCntr_l, westReqCntr_l, northReqCntr_l, eastReqCntr_l }), 
.gntInCntr({ localGntCntr_l, southGntCntr_l, westGntCntr_l, northGntCntr_l, eastGntCntr_l }),  
.PacketOut(localPacketOut) 
);

endmodule
