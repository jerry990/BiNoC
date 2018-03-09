`include "channel_control.sv"
module channel_control_tb;

logic clk;
logic rst;
logic HP_input_req,LP_input_req;
logic HP_output_req,LP_output_req;
logic [9:0] channel_req,arb_req;
logic in_out_select;

channel_control cc(
  clk,
  rst,
  HP_input_req,
  LP_input_req,
  channel_req,
  arb_req,
  in_out_select,
  output_req
);
always #1 clk =~clk; 
initial begin
  clk = 1'b0;
  rst = 1'b1;
  #3
  rst= 1'b0;
  input_req = 1'b0;
  channel_req = 10'b00_0000_0000;
  #3
  input_req = 1'b1;
  #3
  channel_req = 10'b00_0000_0001;
 
end

initial
  begin
    $fsdbDumpfile("channel_control.fsdb");
    $fsdbDumpvars(0, channel_control_tb);
    #10000 $finish;
  end

endmodule