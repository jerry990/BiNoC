`include "router_mesh_2_2.sv"
module router_mesh_2_2_tb;

	// Inputs
	logic clk;
	logic rst;
  /*  logic [31:0] test_in;
	logic [31:0] test_in01;
	logic test_req;
	logic test_req01;*/
	// Instantiate the Unit Under Test (UUT)
	router_mesh_2_2 uut (
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
	  test_in = 32'hzzzz_zzzz;
	  clk = 0;
	  rst = 1;
	  #2
	  rst = 0;
	  test_in=32'h51929227;
	  test_req = 1'b1;
	//  test_req =1;
	  //uut.r00.westReqUpStr=1'b1;
		// Initialize Inputs
	  `ifdef test1
		for(int i=32'h51929228 ;i < 32'h61929300;i++)
		  begin
		   #1 test_req = 1'b0;
		   #3 test_req = 1'b1;
		   #1 test_in = i;
		  // #1 test_req = 1'b0;
		  // #1 test_req = 1'b1;
		  // #1 uut.r00.westReqUpStr = 1'b0; 
		  // #1 uut.r00.westReqUpStr = 1'b1;
		  end
		/*for(int i=32'h41929228 ;i < 32'h41999999;i++)
		  begin
		   #3 test_in = i;
		  // #1 test_req = 1'b0;
		  // #1 test_req = 1'b1;
		  // #1 uut.r00.westReqUpStr = 1'b0; 
		  // #1 uut.r00.westReqUpStr = 1'b1;
		  end*/
	  `elsif test2 //three different direction input 
	    #1 test_req = 1'b0;
		#3 test_req = 1'b1;
		#1 test_in = 32'h51929228; 
		#1 test_req = 1'b0;
		#3 test_req = 1'b1;
		#1 test_in = 32'h12345678;
        #1 test_req = 1'b0;
		#3 test_req = 1'b1;
		#1 test_in = 32'h42345678;
	 	

  	  `endif
		
	end
    
  initial 
	begin
	  test_in01 = 32'hzzzz_zzzz;
	//  clk = 0;
	//  rst = 1;
	  #2
	//  rst = 0;
	  test_in01=32'h41929227;
	  test_req01 = 1'b1;
	//  test_req =1;
	  //uut.r00.westReqUpStr=1'b1;
		// Initialize Inputs
	  `ifdef test1
		for(int j=32'h41929228 ;j < 32'h51929300;j++)
		  begin
		   #1 test_req01 = 1'b0;
		   #3 test_req01 = 1'b1;
		   #1 test_in01 = j;
		  // #1 test_req = 1'b0;
		  // #1 test_req = 1'b1;
		  // #1 uut.r00.westReqUpStr = 1'b0; 
		  // #1 uut.r00.westReqUpStr = 1'b1;
		  end
		/*for(int i=32'h41929228 ;i < 32'h41999999;i++)
		  begin
		   #3 test_in = i;
		  // #1 test_req = 1'b0;
		  // #1 test_req = 1'b1;
		  // #1 uut.r00.westReqUpStr = 1'b0; 
		  // #1 uut.r00.westReqUpStr = 1'b1;
		  end*/
	  `elsif test2 //three different direction input 
	    #1 test_req = 1'b0;
		#3 test_req = 1'b1;
		#1 test_in = 32'h51929228; 
		#1 test_req = 1'b0;
		#3 test_req = 1'b1;
		#1 test_in = 32'h12345678;
        #1 test_req = 1'b0;
		#3 test_req = 1'b1;
		#1 test_in = 32'h42345678;
	 	

  	  `endif
		
	end	
	
	initial 
      begin
        $fsdbDumpfile("router_mesh_2_2.fsdb");
        $fsdbDumpvars(0, router_mesh_2_2_tb);
        #(10000)
		
        $finish;
      end


      
endmodule