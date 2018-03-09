`include "bi_link_1.sv"
`include "bi_link_2.sv"
module bi_link(
            input logic inout_select1,
			input logic inout_select2,
            input logic [31:0] IN1,	  
            output logic [31:0] OUT1,
			input logic [31:0] IN2,
            output logic [31:0] OUT2
              );
			  
	bi_link_2 b1(inout_select1,
              IN1,
	          bio,		  
              OUT1);
	bi_link_2 b2(inout_select2,
              IN2,
	          bio,		  
              OUT2);
    
endmodule