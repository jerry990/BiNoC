`include "router_mesh_3_3.sv"
module router_mesh_3_3_tb;

	// Inputs
	logic clk;
	logic rst;
  /*  logic [31:0] test_in;
	logic [31:0] test_in01;
	logic test_req;
	logic test_req01;*/
	// Instantiate the Unit Under Test (UUT)
	router_mesh_3_3 uut (
		.clk(clk), 
		.rst(rst)
	//	.test_in(test_in),
	//	.test_in01(test_in01),
	//	.test_req(test_req),
	//	.test_req01(test_req01)
	);

// Clock generator
always	
#1 clk = ~clk;
	initial 
      begin
        clk = 1'b0;
		rst = 1'b1;
		#3
		rst = 1'b0;


      end	  
	
	initial 
      begin
        $fsdbDumpfile("router_mesh_3_3.fsdb");
        $fsdbDumpvars(0, router_mesh_3_3_tb);
        #(10000)
		
        $finish;
      end


      
endmodule