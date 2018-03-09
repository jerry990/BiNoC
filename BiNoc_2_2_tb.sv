`include "BiNoc_2_2.sv"
module BiNoc_2_2_tb;

  logic clk,rst;
  always #1 clk = ~clk;
  BiNoc_2_2 b22(
    .clk(clk),
    .rst(rst)
  );
  
  

  
  initial 
    begin
	  clk = 1'b0;
	  rst = 1'b1;
	  #2
	  rst = 1'b0;
	
	
	end
  
  initial 
    begin
	  $fsdbDumpfile("BiNoc_2_2.fsdb");
      $fsdbDumpvars(0,BiNoc_2_2_tb);
	  #(100)
	  $finish;
	end





endmodule