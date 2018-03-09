module bcp_check(
                input [3:0] CLAUSE_ASSIGN,
			    output logic [3:0] UNIT_CLAUSE
				);
	
 
  always_comb begin	
 	  case(CLAUSE_ASSIGN)
		    4'b0111:
			    UNIT_CLAUSE[3] =1'b1;
	        4'b1011:
		        UNIT_CLAUSE[2]<=1'b1;
			4'b1101:
			   UNIT_CLAUSE[1]<=1'b1;
	     	4'b1110:	
		      UNIT_CLAUSE[0]<=1'b1;
	    	default:
				UNIT_CLAUSE<=4'b0;
		  endcase 
  end	
endmodule		
		
