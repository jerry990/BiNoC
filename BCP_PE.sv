`include "traversal.sv"
`include "bcp_check.sv"

module BCP_PE(



);


   



 bcp_check bc(
                input [3:0] CLAUSE_ASSIGN,
			    output logic [3:0] UNIT_CLAUSE
				);
				
				
				
traveral_engine te(    input CLK,
                       input RST,
					   input VALUE,
					   input [1:0]OFFSET,
					   output logic [1:0] OFFSET_OUT,
					   output logic [11:0]local_link_out,
					   output logic [1:0]base_out,
					   output logic value_out,
                       input EN,
					   input [`ADDR_SIZE-1:0] BASE,
					   input [`DATA_SIZE-1:0] DATA_IN,//from queue
					   input THREAD,
					   output logic [`DATA_SIZE-1:0] DATA_OUT//connect to constrtaint propagation
                 
                   );