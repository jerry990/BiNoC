module bi_link_2(
  input logic inout_select1,
  input logic inout_select2,
  input logic [31:0] IN1,
  input logic [31:0] IN2,
  output logic [31:0] OUT1,
  output logic [31:0] OUT2
);
			  
	assign OUT1 = (inout_select2 & !inout_select1) ? IN2:32'hzzzz_zzzz;
	assign OUT2 = (inout_select1 & !inout_select2) ? IN1:32'hzzzz_zzzz;		  
    
	//assign OUT2 = (~inout_select) ? bio:32'hzzzz_zzzz;		  
  
endmodule

module bi_test;

  logic inout_select1,inout_select2;
  logic [31:0] IN1,IN2,OUT1,OUT2;





    bi_link_2 b(
               inout_select1,
			   inout_select2,
               IN1,	
			   IN2,
               OUT1,
			   OUT2
              );

			  
			  
    initial 
	  begin
	    inout_select1 = 1'b1;
		inout_select2 = 1'b1;
	    IN2= 32'h2;
		IN1= 32'h1;
	  end
			  
    initial 
      begin
        $fsdbDumpfile("bi_test.fsdb");
        $fsdbDumpvars(0, bi_test);
        #(10)
		
        $finish;
      end



endmodule