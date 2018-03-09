`timescale 1ns/10ps
`include "arbiter.sv"
module a_tb;

logic clk;
logic rst;
logic req0,req1,req2,req3,req4,req5,req6,req7,req8,req9;
logic gnt0,gnt1,gnt2,gnt3,gnt4,gnt5,gnt6,gnt7,gnt8,gnt9;
//logic [3:0] tt;
always #1 clk =~clk;

arbiter r1(clk,
rst,
req9,
req8,
req7,
req6,
req5,
req4,
req3,
req2,
req1,
req0,
gnt9,
gnt8,
gnt7,
gnt6,
gnt5,
gnt4,
gnt3,
gnt2,
gnt1,
gnt0);



initial begin
  clk = 1'b0;
  rst = 1'b1;
  #3
  rst= 1'b0;
  req0 = 1'b1;
  req1 = 1'b1;
  req2 = 1'b1;
  req3 = 1'b1;
  req4 = 1'b1;
  req5 = 1'b1;
  req6 = 1'b1;
  req7 = 1'b1;
  req8 = 1'b1;
  req9 = 1'b1;
 /* #3
  rst= 1'b0;
  req0 = 1'b1;
  req1 = 1'b0;
  req2 = ;
  req3 = 1'b0;
  req4 = 1'b0;
  #2
  req0 = 1'b0;
  */
  end

initial
  begin
    $fsdbDumpfile("a.fsdb");
    $fsdbDumpvars(0, a_tb);
    #1000 $finish;
  end

endmodule