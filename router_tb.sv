`include "router.sv"
module router_tb;

logic clk;
logic rst;
//logic [31:0] p0,p1,p2,p3,p4,p5,p6,p7,p8,p9;
always #1 clk =~clk;

router r1(
  .clk(clk),
  .rst(rst),
  .west_HP_input_req(1'b1),
  .east_HP_input_req(1'b1),
  .north_HP_input_req(1'b1),
  .south_HP_input_req(1'b1),
  .local_HP_input_req(1'b1),
  
  .west_HP_input_gnt(1'b1),
  .east_HP_input_gnt(1'b1),
  .north_HP_input_gnt(1'b1),
  .south_HP_input_gnt(1'b1),
  .local_HP_input_gnt(1'b1),
 
 
  .west_LP_input_gnt(1'b1),
  .east_LP_input_gnt(1'b1),
  .north_LP_input_gnt(1'b1),
  .south_LP_input_gnt(1'b1),
  .local_LP_input_gnt(1'b1),
  
  .west_full_0(1'b0),
  .west_full_1(1'b0),
  .north_full_0(1'b0),
  .north_full_1(1'b0),
  .south_full_0(1'b0),
  .south_full_1(1'b0),
  .local_full_0(1'b0),
  .local_full_1(1'b0),
  .east_full_0(1'b0),
  .east_full_1(1'b0),
  
 
  .west_LP_input_req(1'b1),
  .east_LP_input_req(1'b1),
  .north_LP_input_req(1'b1),
  .south_LP_input_req(1'b1),
  .local_LP_input_req(1'b1),
  
  .westPacket_0(p0),
  .westPacket_1(p1),
  .eastPacket_0(p4),
  .eastPacket_1(p5),
  .northPacket_0(p2),
  .northPacket_1(p3),
  .southPacket_0(p6),
  .southPacket_1(p7),
  .localPacket_0(p8),
  .localPacket_1(p9)
);
//top top1(clk,rst);






initial begin
  clk = 1'b0;
  rst = 1'b1;
 
  #2
  rst= 1'b0;
  p0 = 32'h123456;
end

initial
  begin
    $fsdbDumpfile("router.fsdb");
    $fsdbDumpvars(0, router_tb);
    #100 $finish;
  end

endmodule