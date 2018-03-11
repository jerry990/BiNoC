`include "router.sv"
module BiNoc_2_2(
  input clk,
  input rst
);

  logic eastreq_HP_LP_00_w,eastreq_LP_HP_00_w,
        westreq_LP_HP_10_e,westreq_HP_LP_10_e;
  
  logic westgnt_HP_LP_00_e,westgnt_LP_HP_00_e,
        eastgnt_LP_HP_10_w,eastgnt_HP_LP_10_w;

  wire [31:0] packet,Packet_00_01_0,Packet_00_01_1;
  
  router n00(
  .clk(clk),
  .rst(rst),
  .west_HP_input_req(1'bz),
  .east_HP_input_req(west_LP_input_req_10),
  .north_HP_input_req(1'bz),
  .south_HP_input_req(1'bz),
  .local_HP_input_req(local_HP_input_req_00),
  
  .west_HP_input_gnt(),
  .east_HP_input_gnt(),
  .north_HP_input_gnt(),
  .south_HP_input_gnt(),
  .local_HP_input_gnt(local_HP_input_gnt_00),
 
 
  .west_LP_input_gnt(),
  .east_LP_input_gnt(),
  .north_LP_input_gnt(),
  .south_LP_input_gnt(),
  .local_LP_input_gnt(local_HP_input_gnt_00),
  
  .west_full_0(),
  .west_full_1(),
  .north_full_0(),
  .north_full_1(),
  .south_full_0(),
  .south_full_1(),
  .local_full_0(),
  .local_full_1(),
  .east_full_0(),
  .east_full_1(),
  
 
  .west_LP_input_req(1'bz),
  .east_LP_input_req(westreq_HP_LP_10_e),
  .north_LP_input_req(1'bz),
  .south_LP_input_req(1'bz),
  .local_LP_input_req(local_LP_input_req_00),
  
  .west_HP_output_req(),
  .west_LP_output_req(),
  .east_HP_output_req(eastreq_HP_LP_00_w),
  .east_LP_output_req(),
  .north_HP_output_req(),
  .north_LP_output_req(),
  .south_HP_output_req(),
  .south_LP_output_req(),
  .local_HP_output_req(),
  .local_LP_output_req(),
  
  .westPacket_0(),
  .westPacket_1(),
  .eastPacket_0(Packet_00_01_0),
  .eastPacket_1(Packet_00_01_1),
  .northPacket_0(),
  .northPacket_1(),
  .southPacket_0(),
  .southPacket_1(),
  .localPacket_0(),
  .localPacket_1()  
 
);

router n10(
  .clk(clk),
  .rst(rst),
  .west_HP_input_req(east_LP_HP_00_w),
  .east_HP_input_req(1'bz),
  .north_HP_input_req(1'bz),
  .south_HP_input_req(1'bz),
  .local_HP_input_req(local_HP_input_req_10),
  
  .west_HP_input_gnt(east_HP_LP_10_gnt),
  .east_HP_input_gnt(),
  .north_HP_input_gnt(),
  .south_HP_input_gnt(),
  .local_HP_input_gnt(local_HP_input_gnt_10),
 
 
  .west_LP_input_gnt(),
  .east_LP_input_gnt(),
  .north_LP_input_gnt(),
  .south_LP_input_gnt(),
  .local_LP_input_gnt(local_LP_input_gnt_10),
  
  .west_full_0(),
  .west_full_1(),
  .north_full_0(),
  .north_full_1(),
  .south_full_0(),
  .south_full_1(),
  .local_full_0(),
  .local_full_1(),
  .east_full_0(),
  .east_full_1(),
  
 
  .west_LP_input_req(eastreq_HP_LP_00_w),
  .east_LP_input_req(),
  .north_LP_input_req(),
  .south_LP_input_req(),
  .local_LP_input_req(local_LP_input_req_10),
  
  .west_HP_output_req(),
  .west_LP_output_req(),
  .east_HP_output_req(),
  .east_LP_output_req(),
  .north_HP_output_req(),
  .north_LP_output_req(),
  .south_HP_output_req(),
  .south_LP_output_req(),
  .local_HP_output_req(),
  .local_LP_output_req(),
  
  .westPacket_0(Packet_00_01_0),
  .westPacket_1(Packet_00_01_1),
  .eastPacket_0(),
  .eastPacket_1(packet),
  .northPacket_0(),
  .northPacket_1(),
  .southPacket_0(),
  .southPacket_1(),
  .localPacket_0(),
  .localPacket_1()  
 
);

test_in t(
 .test_packet(32'h29),
 .bio(packet),
 .sel(1'b1)
);
endmodule

//-------------test module------------
module test_in(
  input logic [31:0] test_packet,
  inout [31:0] bio,
  input logic sel
);
  
  assign bio = (sel) ? test_packet:32'hzzzz_zzzz;

endmodule