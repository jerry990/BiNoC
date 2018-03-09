`include "channel_control.sv"
`include "port.sv"
module router(
  input clk,
  input rst,
  input west_HP_input_req,
  input east_HP_input_req,
  input north_HP_input_req,
  input south_HP_input_req,
  input local_HP_input_req,
  
  output logic west_HP_input_gnt,
  output logic east_HP_input_gnt,
  output logic north_HP_input_gnt,
  output logic south_HP_input_gnt,
  output logic local_HP_input_gnt,
 
 
  output logic west_LP_input_gnt,
  output logic east_LP_input_gnt,
  output logic north_LP_input_gnt,
  output logic south_LP_input_gnt,
  output logic local_LP_input_gnt,
  
  output logic west_full_0,
  output logic west_full_1,
  output logic north_full_0,
  output logic north_full_1,
  output logic south_full_0,
  output logic south_full_1,
  output logic local_full_0,
  output logic local_full_1,
  output logic east_full_0,
  output logic east_full_1,
  
 
  input west_LP_input_req,
  input east_LP_input_req,
  input north_LP_input_req,
  input south_LP_input_req,
  input local_LP_input_req,
  
  inout [31:0] westPacket_0,
  inout [31:0] westPacket_1,
  inout [31:0] eastPacket_0,
  inout [31:0] eastPacket_1,
  inout [31:0] northPacket_0,
  inout [31:0] northPacket_1,
  inout [31:0] southPacket_0,
  inout [31:0] southPacket_1,
  inout [31:0] localPacket_0,
  inout [31:0] localPacket_1  
 
);
//--------HP req----------
  logic west_HP_channel_req_0,west_HP_channel_req_1,
        west_HP_channel_req_2,west_HP_channel_req_3,
		west_HP_channel_req_4,west_HP_channel_req_5,
		west_HP_channel_req_6,west_HP_channel_req_7,
		west_HP_channel_req_8,west_HP_channel_req_9;
		
  logic east_HP_channel_req_0,east_HP_channel_req_1,
        east_HP_channel_req_2,east_HP_channel_req_3,
		east_HP_channel_req_4,east_HP_channel_req_5,
		east_HP_channel_req_6,east_HP_channel_req_7,
		east_HP_channel_req_8,east_HP_channel_req_9;
		
  logic north_HP_channel_req_0,north_HP_channel_req_1,
        north_HP_channel_req_2,north_HP_channel_req_3,
		north_HP_channel_req_4,north_HP_channel_req_5,
		north_HP_channel_req_6,north_HP_channel_req_7,
		north_HP_channel_req_8,north_HP_channel_req_9;
		
  logic south_HP_channel_req_0,south_HP_channel_req_1,
        south_HP_channel_req_2,south_HP_channel_req_3,
		south_HP_channel_req_4,south_HP_channel_req_5,
		south_HP_channel_req_6,south_HP_channel_req_7,
		south_HP_channel_req_8,south_HP_channel_req_9;
		
  logic local_HP_channel_req_0,local_HP_channel_req_1,
        local_HP_channel_req_2,local_HP_channel_req_3,
		local_HP_channel_req_4,local_HP_channel_req_5,
		local_HP_channel_req_6,local_HP_channel_req_7,
		local_HP_channel_req_8,local_HP_channel_req_9;
 
  //--------LP req----------
  logic west_LP_channel_req_0,west_LP_channel_req_1,
        west_LP_channel_req_2,west_LP_channel_req_3,
		west_LP_channel_req_4,west_LP_channel_req_5,
		west_LP_channel_req_6,west_LP_channel_req_7,
		west_LP_channel_req_8,west_LP_channel_req_9;
		
  logic east_LP_channel_req_0,east_LP_channel_req_1,
        east_LP_channel_req_2,east_LP_channel_req_3,
		east_LP_channel_req_4,east_LP_channel_req_5,
		east_LP_channel_req_6,east_LP_channel_req_7,
		east_LP_channel_req_8,east_LP_channel_req_9;
		
  logic north_LP_channel_req_0,north_LP_channel_req_1,
        north_LP_channel_req_2,north_LP_channel_req_3,
		north_LP_channel_req_4,north_LP_channel_req_5,
		north_LP_channel_req_6,north_LP_channel_req_7,
		north_LP_channel_req_8,north_LP_channel_req_9;
		
  logic south_LP_channel_req_0,south_LP_channel_req_1,
        south_LP_channel_req_2,south_LP_channel_req_3,
		south_LP_channel_req_4,south_LP_channel_req_5,
		south_LP_channel_req_6,south_LP_channel_req_7,
		south_LP_channel_req_8,south_LP_channel_req_9;
		
  logic local_LP_channel_req_0,local_LP_channel_req_1,
        local_LP_channel_req_2,local_LP_channel_req_3,
		local_LP_channel_req_4,local_LP_channel_req_5,
		local_LP_channel_req_6,local_LP_channel_req_7,
		local_LP_channel_req_8,local_LP_channel_req_9;
		
//--------HP gnt----------
  logic west_HP_channel_gnt_0,west_HP_channel_gnt_1,
        west_HP_channel_gnt_2,west_HP_channel_gnt_3,
		west_HP_channel_gnt_4,west_HP_channel_gnt_5,
		west_HP_channel_gnt_6,west_HP_channel_gnt_7,
		west_HP_channel_gnt_8,west_HP_channel_gnt_9;
		
  logic east_HP_channel_gnt_0,east_HP_channel_gnt_1,
        east_HP_channel_gnt_2,east_HP_channel_gnt_3,
		east_HP_channel_gnt_4,east_HP_channel_gnt_5,
		east_HP_channel_gnt_6,east_HP_channel_gnt_7,
		east_HP_channel_gnt_8,east_HP_channel_gnt_9;
		
  logic north_HP_channel_gnt_0,north_HP_channel_gnt_1,
        north_HP_channel_gnt_2,north_HP_channel_gnt_3,
		north_HP_channel_gnt_4,north_HP_channel_gnt_5,
		north_HP_channel_gnt_6,north_HP_channel_gnt_7,
		north_HP_channel_gnt_8,north_HP_channel_gnt_9;
		
  logic south_HP_channel_gnt_0,south_HP_channel_gnt_1,
        south_HP_channel_gnt_2,south_HP_channel_gnt_3,
		south_HP_channel_gnt_4,south_HP_channel_gnt_5,
		south_HP_channel_gnt_6,south_HP_channel_gnt_7,
		south_HP_channel_gnt_8,south_HP_channel_gnt_9;
		
  logic local_HP_channel_gnt_0,local_HP_channel_gnt_1,
        local_HP_channel_gnt_2,local_HP_channel_gnt_3,
		local_HP_channel_gnt_4,local_HP_channel_gnt_5,
		local_HP_channel_gnt_6,local_HP_channel_gnt_7,
		local_HP_channel_gnt_8,local_HP_channel_gnt_9;

  //--------LP gnt----------
  logic west_LP_channel_gnt_0,west_LP_channel_gnt_1,
        west_LP_channel_gnt_2,west_LP_channel_gnt_3,
		west_LP_channel_gnt_4,west_LP_channel_gnt_5,
		west_LP_channel_gnt_6,west_LP_channel_gnt_7,
		west_LP_channel_gnt_8,west_LP_channel_gnt_9;
		
  logic east_LP_channel_gnt_0,east_LP_channel_gnt_1,
        east_LP_channel_gnt_2,east_LP_channel_gnt_3,
		east_LP_channel_gnt_4,east_LP_channel_gnt_5,
		east_LP_channel_gnt_6,east_LP_channel_gnt_7,
		east_LP_channel_gnt_8,east_LP_channel_gnt_9;
		
  logic north_LP_channel_gnt_0,north_LP_channel_gnt_1,
        north_LP_channel_gnt_2,north_LP_channel_gnt_3,
		north_LP_channel_gnt_4,north_LP_channel_gnt_5,
		north_LP_channel_gnt_6,north_LP_channel_gnt_7,
		north_LP_channel_gnt_8,north_LP_channel_gnt_9;
		
  logic south_LP_channel_gnt_0,south_LP_channel_gnt_1,
        south_LP_channel_gnt_2,south_LP_channel_gnt_3,
		south_LP_channel_gnt_4,south_LP_channel_gnt_5,
		south_LP_channel_gnt_6,south_LP_channel_gnt_7,
		south_LP_channel_gnt_8,south_LP_channel_gnt_9;
		
  logic local_LP_channel_gnt_0,local_LP_channel_gnt_1,
        local_LP_channel_gnt_2,local_LP_channel_gnt_3,
		local_LP_channel_gnt_4,local_LP_channel_gnt_5,
		local_LP_channel_gnt_6,local_LP_channel_gnt_7,
		local_LP_channel_gnt_8,local_LP_channel_gnt_9;
		
  
  //--------------------input req-------------------
 // logic west_HP_input_req,east_HP_input_req,north_HP_input_req,south_HP_input_req,local_HP_input_req;
 // logic west_LP_input_req,east_LP_input_req,north_LP_input_req,south_LP_input_req,local_LP_input_req;
  //--------------------output req------------------
  logic west_HP_output_req,east_HP_output_req,north_HP_output_req,south_HP_output_req,local_HP_output_req;
  logic west_LP_output_req,east_LP_output_req,north_LP_output_req,south_LP_output_req,local_LP_output_req;
  //--------------------inout_select----------------
  logic west_HP_inout_select,east_HP_inout_select,north_HP_inout_select,south_HP_inout_select,local_HP_inout_select;
  logic west_LP_inout_select,east_LP_inout_select,north_LP_inout_select,south_LP_inout_select,local_LP_inout_select;
  //--------------------sel-------------------------
  logic [3:0] west_HP_sel,east_HP_sel,north_HP_sel,south_HP_sel,local_HP_sel;
  logic [3:0] west_LP_sel,east_LP_sel,north_LP_sel,south_LP_sel,local_LP_sel;
  
  channel_control w_controller(
    .clk(clk),
    .rst(rst),
    .HP_input_req(west_HP_input_req),
    .LP_input_req(west_LP_input_req),
    .HP_channel_req({west_HP_channel_req_9,west_HP_channel_req_8,
	                west_HP_channel_req_7,west_HP_channel_req_6,
					west_HP_channel_req_5,west_HP_channel_req_4,
					west_HP_channel_req_3,west_HP_channel_req_2,
					west_HP_channel_req_1,west_HP_channel_req_0}),
    .LP_channel_req({west_LP_channel_req_9,west_LP_channel_req_8,
	                west_LP_channel_req_7,west_LP_channel_req_6,
					west_LP_channel_req_5,west_LP_channel_req_4,
					west_LP_channel_req_3,west_LP_channel_req_2,
					west_LP_channel_req_1,west_LP_channel_req_0}),
    .HP_channel_gnt({west_HP_channel_gnt_9,west_HP_channel_gnt_8,
	                west_HP_channel_gnt_7,west_HP_channel_gnt_6,
					west_HP_channel_gnt_5,west_HP_channel_gnt_4,
					west_HP_channel_gnt_3,west_HP_channel_gnt_2,
					west_HP_channel_gnt_1,west_HP_channel_gnt_0}),
    .LP_channel_gnt({west_LP_channel_gnt_9,west_LP_channel_gnt_8,
	                west_LP_channel_gnt_7,west_LP_channel_gnt_6,
					west_LP_channel_gnt_5,west_LP_channel_gnt_4,
					west_LP_channel_gnt_3,west_LP_channel_gnt_2,
					west_LP_channel_gnt_1,west_LP_channel_gnt_0}),  
    .HP_inout_select(west_HP_inout_select),
    .LP_inout_select(west_LP_inout_select),
    .HP_output_req(west_HP_output_req),
    .LP_output_req(west_LP_output_req),
    .HP_sel(west_HP_sel),
    .LP_sel(west_LP_sel)
);
  
  channel_control e_controller(
    .clk(clk),
    .rst(rst),
    .HP_input_req(east_HP_input_req),
    .LP_input_req(east_LP_input_req),
    .HP_channel_req({east_HP_channel_req_9,east_HP_channel_req_8,
	                east_HP_channel_req_7,east_HP_channel_req_6,
					east_HP_channel_req_5,east_HP_channel_req_4,
					east_HP_channel_req_3,east_HP_channel_req_2,
					east_HP_channel_req_1,east_HP_channel_req_0}),
    .LP_channel_req({east_LP_channel_req_9,east_LP_channel_req_8,
	                east_LP_channel_req_7,east_LP_channel_req_6,
					east_LP_channel_req_5,east_LP_channel_req_4,
					east_LP_channel_req_3,east_LP_channel_req_2,
					east_LP_channel_req_1,east_LP_channel_req_0}),
    .HP_channel_gnt({east_HP_channel_gnt_9,east_HP_channel_gnt_8,
	                east_HP_channel_gnt_7,east_HP_channel_gnt_6,
					east_HP_channel_gnt_5,east_HP_channel_gnt_4,
					east_HP_channel_gnt_3,east_HP_channel_gnt_2,
					east_HP_channel_gnt_1,east_HP_channel_gnt_0}),
    .LP_channel_gnt({east_LP_channel_gnt_9,east_LP_channel_gnt_8,
	                east_LP_channel_gnt_7,east_LP_channel_gnt_6,
					east_LP_channel_gnt_5,east_LP_channel_gnt_4,
					east_LP_channel_gnt_3,east_LP_channel_gnt_2,
					east_LP_channel_gnt_1,east_LP_channel_gnt_0}),  
    .HP_inout_select(east_HP_inout_select),
    .LP_inout_select(east_LP_inout_select),
    .HP_output_req(east_HP_output_req),
    .LP_output_req(east_LP_output_req),
    .HP_sel(east_HP_sel),
    .LP_sel(east_LP_sel)
);

  channel_control n_controller(
    .clk(clk),
    .rst(rst),
    .HP_input_req(north_HP_input_req),
    .LP_input_req(north_LP_input_req),
    .HP_channel_req({north_HP_channel_req_9,north_HP_channel_req_8,
	                north_HP_channel_req_7,north_HP_channel_req_6,
					north_HP_channel_req_5,north_HP_channel_req_4,
					north_HP_channel_req_3,north_HP_channel_req_2,
					north_HP_channel_req_1,north_HP_channel_req_0}),
    .LP_channel_req({north_LP_channel_req_9,north_LP_channel_req_8,
	                north_LP_channel_req_7,north_LP_channel_req_6,
					north_LP_channel_req_5,north_LP_channel_req_4,
					north_LP_channel_req_3,north_LP_channel_req_2,
					north_LP_channel_req_1,north_LP_channel_req_0}),
    .HP_channel_gnt({north_HP_channel_gnt_9,north_HP_channel_gnt_8,
	                north_HP_channel_gnt_7,north_HP_channel_gnt_6,
					north_HP_channel_gnt_5,north_HP_channel_gnt_4,
					north_HP_channel_gnt_3,north_HP_channel_gnt_2,
					north_HP_channel_gnt_1,north_HP_channel_gnt_0}),
    .LP_channel_gnt({north_LP_channel_gnt_9,north_LP_channel_gnt_8,
	                north_LP_channel_gnt_7,north_LP_channel_gnt_6,
					north_LP_channel_gnt_5,north_LP_channel_gnt_4,
					north_LP_channel_gnt_3,north_LP_channel_gnt_2,
					north_LP_channel_gnt_1,north_LP_channel_gnt_0}),  
    .HP_inout_select(north_HP_inout_select),
    .LP_inout_select(north_LP_inout_select),
    .HP_output_req(north_HP_output_req),
    .LP_output_req(north_LP_output_req),
    .HP_sel(north_HP_sel),
    .LP_sel(north_LP_sel)
);

  channel_control s_controller(
    .clk(clk),
    .rst(rst),
    .HP_input_req(south_HP_input_req),
    .LP_input_req(south_LP_input_req),
    .HP_channel_req({south_HP_channel_req_9,south_HP_channel_req_8,
	                south_HP_channel_req_7,south_HP_channel_req_6,
					south_HP_channel_req_5,south_HP_channel_req_4,
					south_HP_channel_req_3,south_HP_channel_req_2,
					south_HP_channel_req_1,south_HP_channel_req_0}),
    .LP_channel_req({south_LP_channel_req_9,south_LP_channel_req_8,
	                south_LP_channel_req_7,south_LP_channel_req_6,
					south_LP_channel_req_5,south_LP_channel_req_4,
					south_LP_channel_req_3,south_LP_channel_req_2,
					south_LP_channel_req_1,south_LP_channel_req_0}),
    .HP_channel_gnt({south_HP_channel_gnt_9,south_HP_channel_gnt_8,
	                south_HP_channel_gnt_7,south_HP_channel_gnt_6,
					south_HP_channel_gnt_5,south_HP_channel_gnt_4,
					south_HP_channel_gnt_3,south_HP_channel_gnt_2,
					south_HP_channel_gnt_1,south_HP_channel_gnt_0}),
    .LP_channel_gnt({south_LP_channel_gnt_9,south_LP_channel_gnt_8,
	                south_LP_channel_gnt_7,south_LP_channel_gnt_6,
					south_LP_channel_gnt_5,south_LP_channel_gnt_4,
					south_LP_channel_gnt_3,south_LP_channel_gnt_2,
					south_LP_channel_gnt_1,south_LP_channel_gnt_0}),  
    .HP_inout_select(south_HP_inout_select),
    .LP_inout_select(south_LP_inout_select),
    .HP_output_req(south_HP_output_req),
    .LP_output_req(south_LP_output_req),
    .HP_sel(south_HP_sel),
    .LP_sel(south_LP_sel)
);

  channel_control l_controller(
    .clk(clk),
    .rst(rst),
    .HP_input_req(local_HP_input_req),
    .LP_input_req(local_LP_input_req),
    .HP_channel_req({local_HP_channel_req_9,local_HP_channel_req_8,
	                local_HP_channel_req_7,local_HP_channel_req_6,
					local_HP_channel_req_5,local_HP_channel_req_4,
					local_HP_channel_req_3,local_HP_channel_req_2,
					local_HP_channel_req_1,local_HP_channel_req_0}),
    .LP_channel_req({local_LP_channel_req_9,local_LP_channel_req_8,
	                local_LP_channel_req_7,local_LP_channel_req_6,
					local_LP_channel_req_5,local_LP_channel_req_4,
					local_LP_channel_req_3,local_LP_channel_req_2,
					local_LP_channel_req_1,local_LP_channel_req_0}),
    .HP_channel_gnt({local_HP_channel_gnt_9,local_HP_channel_gnt_8,
	                local_HP_channel_gnt_7,local_HP_channel_gnt_6,
					local_HP_channel_gnt_5,local_HP_channel_gnt_4,
					local_HP_channel_gnt_3,local_HP_channel_gnt_2,
					local_HP_channel_gnt_1,local_HP_channel_gnt_0}),
    .LP_channel_gnt({local_LP_channel_gnt_9,local_LP_channel_gnt_8,
	                local_LP_channel_gnt_7,local_LP_channel_gnt_6,
					local_LP_channel_gnt_5,local_LP_channel_gnt_4,
					local_LP_channel_gnt_3,local_LP_channel_gnt_2,
					local_LP_channel_gnt_1,local_LP_channel_gnt_0}),  
    .HP_inout_select(local_HP_inout_select),
    .LP_inout_select(local_LP_inout_select),
    .HP_output_req(local_HP_output_req),
    .LP_output_req(local_LP_output_req),
    .HP_sel(local_HP_sel),
    .LP_sel(local_LP_sel)
);
//-----------------port------------------------
  port w_HP( 
    .clk(clk), 
    .rst(rst), 
	.Packet(westPacket_0),
    .inout_select(west_HP_inout_select),
    .channel_gnt({
	  local_LP_channel_gnt_0,local_HP_channel_gnt_0,             
	  south_LP_channel_gnt_0,south_HP_channel_gnt_0,
	  east_LP_channel_gnt_0,east_HP_channel_gnt_0,
	  north_LP_channel_gnt_0,north_HP_channel_gnt_0,
	  west_LP_channel_gnt_0,west_HP_channel_gnt_0}),
	.full(west_full_0), 
	.channel_req({
	  local_LP_channel_req_0,local_HP_channel_req_0,             
	  south_LP_channel_req_0,south_HP_channel_req_0,
	  east_LP_channel_req_0,east_HP_channel_req_0,
	  north_LP_channel_req_0,north_HP_channel_req_0,
	  west_LP_channel_req_0,west_HP_channel_req_0}),
    .PacketInPort0(westPacket_in_0),
	.PacketInPort1(westPacket_in_1),
	.PacketInPort2(northPacket_in_0),
	.PacketInPort3(northPacket_in_1),
	.PacketInPort4(eastPacket_in_0),
	.PacketInPort5(eastPacket_in_1),
	.PacketInPort6(southPacket_in_0),
	.PacketInPort7(southPacket_in_1),
	.PacketInPort8(localPacket_in_0),
	.PacketInPort9(localPacket_in_1),
	.sel(west_HP_sel),
	.Packetout(westPacket_in_0)
  );	

port w_LP( 
    .clk(clk), 
    .rst(rst), 
	.Packet(westPacket_1),
    .inout_select(west_LP_inout_select),
    .channel_gnt({
	  local_LP_channel_gnt_1,local_HP_channel_gnt_1,             
	  south_LP_channel_gnt_1,south_HP_channel_gnt_1,
	  east_LP_channel_gnt_1,east_HP_channel_gnt_1,
	  north_LP_channel_gnt_1,north_HP_channel_gnt_1,
	  west_LP_channel_gnt_1,west_HP_channel_gnt_1}),
	.full(west_full_1), 
	.channel_req({
	  local_LP_channel_req_1,local_HP_channel_req_1,             
	  south_LP_channel_req_1,south_HP_channel_req_1,
	  east_LP_channel_req_1,east_HP_channel_req_1,
	  north_LP_channel_req_1,north_HP_channel_req_1,
	  west_LP_channel_req_1,west_HP_channel_req_1}),
    .PacketInPort0(westPacket_in_0),
	.PacketInPort1(westPacket_in_1),
	.PacketInPort2(northPacket_in_0),
	.PacketInPort3(northPacket_in_1),
	.PacketInPort4(eastPacket_in_0),
	.PacketInPort5(eastPacket_in_1),
	.PacketInPort6(southPacket_in_0),
	.PacketInPort7(southPacket_in_1),
	.PacketInPort8(localPacket_in_0),
	.PacketInPort9(localPacket_in_1),
	.sel(west_LP_sel),
	.Packetout(westPacket_in_1)
  );		

port n_HP( 
    .clk(clk), 
    .rst(rst), 
	.Packet(northPacket_0),
    .inout_select(north_HP_inout_select),
    .channel_gnt({
	  local_LP_channel_gnt_2,local_HP_channel_gnt_2,             
	  south_LP_channel_gnt_2,south_HP_channel_gnt_2,
	  east_LP_channel_gnt_2,east_HP_channel_gnt_2,
	  north_LP_channel_gnt_2,north_HP_channel_gnt_2,
	  west_LP_channel_gnt_2,west_HP_channel_gnt_2}),
	.full(north_full_0), 
	.channel_req({
	  local_LP_channel_req_2,local_HP_channel_req_2,             
	  south_LP_channel_req_2,south_HP_channel_req_2,
	  east_LP_channel_req_2,east_HP_channel_req_2,
	  north_LP_channel_req_2,north_HP_channel_req_2,
	  west_LP_channel_req_2,west_HP_channel_req_2}),
    .PacketInPort0(westPacket_in_0),
	.PacketInPort1(westPacket_in_1),
	.PacketInPort2(northPacket_in_0),
	.PacketInPort3(northPacket_in_1),
	.PacketInPort4(eastPacket_in_0),
	.PacketInPort5(eastPacket_in_1),
	.PacketInPort6(southPacket_in_0),
	.PacketInPort7(southPacket_in_1),
	.PacketInPort8(localPacket_in_0),
	.PacketInPort9(localPacket_in_1),
	.sel(north_HP_sel),
	.Packetout(northPacket_in_0)
  );		

port n_LP( 
    .clk(clk), 
    .rst(rst), 
	.Packet(northPacket_1),
    .inout_select(north_LP_inout_select),
    .channel_gnt({
	  local_LP_channel_gnt_3,local_HP_channel_gnt_3,             
	  south_LP_channel_gnt_3,south_HP_channel_gnt_3,
	  east_LP_channel_gnt_3,east_HP_channel_gnt_3,
	  north_LP_channel_gnt_3,north_HP_channel_gnt_3,
	  west_LP_channel_gnt_3,west_HP_channel_gnt_3}),
	.full(north_full_1), 
	.channel_req({
	  local_LP_channel_req_3,local_HP_channel_req_3,             
	  south_LP_channel_req_3,south_HP_channel_req_3,
	  east_LP_channel_req_3,east_HP_channel_req_3,
	  north_LP_channel_req_3,north_HP_channel_req_3,
	  west_LP_channel_req_3,west_HP_channel_req_3}),
    .PacketInPort0(westPacket_in_0),
	.PacketInPort1(westPacket_in_1),
	.PacketInPort2(northPacket_in_0),
	.PacketInPort3(northPacket_in_1),
	.PacketInPort4(eastPacket_in_0),
	.PacketInPort5(eastPacket_in_1),
	.PacketInPort6(southPacket_in_0),
	.PacketInPort7(southPacket_in_1),
	.PacketInPort8(localPacket_in_0),
	.PacketInPort9(localPacket_in_1),
	.sel(north_LP_sel),
	.Packetout(northPacket_in_1)
  );		

port e_HP( 
    .clk(clk), 
    .rst(rst), 
	.Packet(eastPacket_0),
    .inout_select(east_HP_inout_select),
    .channel_gnt({
	  local_LP_channel_gnt_4,local_HP_channel_gnt_4,             
	  south_LP_channel_gnt_4,south_HP_channel_gnt_4,
	  east_LP_channel_gnt_4,east_HP_channel_gnt_4,
	  north_LP_channel_gnt_4,north_HP_channel_gnt_4,
	  west_LP_channel_gnt_4,west_HP_channel_gnt_4}),
	.full(east_full_0), 
	.channel_req({
	  local_LP_channel_req_4,local_HP_channel_req_4,             
	  south_LP_channel_req_4,south_HP_channel_req_4,
	  east_LP_channel_req_4,east_HP_channel_req_4,
	  north_LP_channel_req_4,north_HP_channel_req_4,
	  west_LP_channel_req_4,west_HP_channel_req_4}),
    .PacketInPort0(westPacket_in_0),
	.PacketInPort1(westPacket_in_1),
	.PacketInPort2(northPacket_in_0),
	.PacketInPort3(northPacket_in_1),
	.PacketInPort4(eastPacket_in_0),
	.PacketInPort5(eastPacket_in_1),
	.PacketInPort6(southPacket_in_0),
	.PacketInPort7(southPacket_in_1),
	.PacketInPort8(localPacket_in_0),
	.PacketInPort9(localPacket_in_1),
	.sel(east_HP_sel),
	.Packetout(eastPacket_in_0)
  );

port e_LP( 
    .clk(clk), 
    .rst(rst), 
	.Packet(eastPacket_1),
    .inout_select(east_LP_inout_select),
    .channel_gnt({
	  local_LP_channel_gnt_5,local_HP_channel_gnt_5,             
	  south_LP_channel_gnt_5,south_HP_channel_gnt_5,
	  east_LP_channel_gnt_5,east_HP_channel_gnt_5,
	  north_LP_channel_gnt_5,north_HP_channel_gnt_5,
	  west_LP_channel_gnt_5,west_HP_channel_gnt_5}),
	.full(east_full_1), 
	.channel_req({
	  local_LP_channel_req_5,local_HP_channel_req_5,             
	  south_LP_channel_req_5,south_HP_channel_req_5,
	  east_LP_channel_req_5,east_HP_channel_req_5,
	  north_LP_channel_req_5,north_HP_channel_req_5,
	  west_LP_channel_req_5,west_HP_channel_req_5}),
    .PacketInPort0(westPacket_in_0),
	.PacketInPort1(westPacket_in_1),
	.PacketInPort2(northPacket_in_0),
	.PacketInPort3(northPacket_in_1),
	.PacketInPort4(eastPacket_in_0),
	.PacketInPort5(eastPacket_in_1),
	.PacketInPort6(southPacket_in_0),
	.PacketInPort7(southPacket_in_1),
	.PacketInPort8(localPacket_in_0),
	.PacketInPort9(localPacket_in_1),
	.sel(east_LP_sel),
	.Packetout(eastPacket_in_1)
  );

  port s_HP( 
    .clk(clk), 
    .rst(rst), 
	.Packet(southPacket_0),
    .inout_select(south_HP_inout_select),
    .channel_gnt({
	  local_LP_channel_gnt_6,local_HP_channel_gnt_6,             
	  south_LP_channel_gnt_6,south_HP_channel_gnt_6,
	  east_LP_channel_gnt_6,east_HP_channel_gnt_6,
	  north_LP_channel_gnt_6,north_HP_channel_gnt_6,
	  west_LP_channel_gnt_6,west_HP_channel_gnt_6}),
    .full(south_full_0), 
	.channel_req({
	  local_LP_channel_req_6,local_HP_channel_req_6,             
	  south_LP_channel_req_6,south_HP_channel_req_6,
	  east_LP_channel_req_6,east_HP_channel_req_6,
	  north_LP_channel_req_6,north_HP_channel_req_6,
	  west_LP_channel_req_6,west_HP_channel_req_6}),
    .PacketInPort0(westPacket_in_0),
	.PacketInPort1(westPacket_in_1),
	.PacketInPort2(northPacket_in_0),
	.PacketInPort3(northPacket_in_1),
	.PacketInPort4(eastPacket_in_0),
	.PacketInPort5(eastPacket_in_1),
	.PacketInPort6(southPacket_in_0),
	.PacketInPort7(southPacket_in_1),
	.PacketInPort8(localPacket_in_0),
	.PacketInPort9(localPacket_in_1),
	.sel(south_HP_sel),
	.Packetout(southPacket_in_0)
  );
  
  port s_LP( 
    .clk(clk), 
    .rst(rst), 
	.Packet(southPacket_1),
    .inout_select(south_LP_inout_select),
    .channel_gnt({
	  local_LP_channel_gnt_7,local_HP_channel_gnt_7,             
	  south_LP_channel_gnt_7,south_HP_channel_gnt_7,
	  east_LP_channel_gnt_7,east_HP_channel_gnt_7,
	  north_LP_channel_gnt_7,north_HP_channel_gnt_7,
	  west_LP_channel_gnt_7,west_HP_channel_gnt_7}),
    .full(south_full_1), 
	.channel_req({
	  local_LP_channel_req_7,local_HP_channel_req_7,             
	  south_LP_channel_req_7,south_HP_channel_req_7,
	  east_LP_channel_req_7,east_HP_channel_req_7,
	  north_LP_channel_req_7,north_HP_channel_req_7,
	  west_LP_channel_req_7,west_HP_channel_req_7}),
    .PacketInPort0(westPacket_in_0),
	.PacketInPort1(westPacket_in_1),
	.PacketInPort2(northPacket_in_0),
	.PacketInPort3(northPacket_in_1),
	.PacketInPort4(eastPacket_in_0),
	.PacketInPort5(eastPacket_in_1),
	.PacketInPort6(southPacket_in_0),
	.PacketInPort7(southPacket_in_1),
	.PacketInPort8(localPacket_in_0),
	.PacketInPort9(localPacket_in_1),
	.sel(south_LP_sel),
	.Packetout(southPacket_in_1)
  );
  port l_HP( 
    .clk(clk), 
    .rst(rst), 
	.Packet(localPacket_0),
    .inout_select(local_HP_inout_select),
    .channel_gnt({
	  local_LP_channel_gnt_8,local_HP_channel_gnt_8,             
	  south_LP_channel_gnt_8,south_HP_channel_gnt_8,
	  east_LP_channel_gnt_8,east_HP_channel_gnt_8,
	  north_LP_channel_gnt_8,north_HP_channel_gnt_8,
	  west_LP_channel_gnt_8,west_HP_channel_gnt_8}),
	.full(local_full_0), 
	.channel_req({
	  local_LP_channel_req_8,local_HP_channel_req_8,             
	  south_LP_channel_req_8,south_HP_channel_req_8,
	  east_LP_channel_req_8,east_HP_channel_req_8,
	  north_LP_channel_req_8,north_HP_channel_req_8,
	  west_LP_channel_req_8,west_HP_channel_req_8}),
    .PacketInPort0(westPacket_in_0),
	.PacketInPort1(westPacket_in_1),
	.PacketInPort2(northPacket_in_0),
	.PacketInPort3(northPacket_in_1),
	.PacketInPort4(eastPacket_in_0),
	.PacketInPort5(eastPacket_in_1),
	.PacketInPort6(southPacket_in_0),
	.PacketInPort7(southPacket_in_1),
	.PacketInPort8(localPacket_in_0),
	.PacketInPort9(localPacket_in_1),
	.sel(local_HP_sel),
	.Packetout(localPacket_in_0)
  );
  
  port l_LP( 
    .clk(clk), 
    .rst(rst), 
	.Packet(localPacket_1),
    .inout_select(local_LP_inout_select),
    .channel_gnt({
	  local_LP_channel_gnt_9,local_HP_channel_gnt_9,             
	  south_LP_channel_gnt_9,south_HP_channel_gnt_9,
	  east_LP_channel_gnt_9,east_HP_channel_gnt_9,
	  north_LP_channel_gnt_9,north_HP_channel_gnt_9,
	  west_LP_channel_gnt_9,west_HP_channel_gnt_9}),
    .full(local_full_1), 
	.channel_req({
	  local_LP_channel_req_9,local_HP_channel_req_9,             
	  south_LP_channel_req_9,south_HP_channel_req_9,
	  east_LP_channel_req_9,east_HP_channel_req_9,
	  north_LP_channel_req_9,north_HP_channel_req_9,
	  west_LP_channel_req_9,west_HP_channel_req_9}),
    .PacketInPort0(westPacket_in_0),
	.PacketInPort1(westPacket_in_1),
	.PacketInPort2(northPacket_in_0),
	.PacketInPort3(northPacket_in_1),
	.PacketInPort4(eastPacket_in_0),
	.PacketInPort5(eastPacket_in_1),
	.PacketInPort6(southPacket_in_0),
	.PacketInPort7(southPacket_in_1),
	.PacketInPort8(localPacket_in_0),
	.PacketInPort9(localPacket_in_1),
	.sel(local_LP_sel),
	.Packetout(localPacket_in_1)
  );
  
endmodule