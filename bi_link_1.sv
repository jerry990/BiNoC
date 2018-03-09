module bi_link_1(
            input logic inout_select,
            input logic [31:0] IN1,
			inout  [31:0] bio,		  
            output logic [31:0] OUT1
	//		input logic [31:0] IN2,
     //       output logic [31:0] OUT2
              );
			  
	assign bio =  (inout_select) ? IN1:32'hzzzz_zzzz;
	assign OUT1 = bio;		  
    
	//assign OUT2 = (~inout_select) ? bio:32'hzzzz_zzzz;		  
  
endmodule