`include "bi_link.sv"
module bi_link_tb;

   logic inout_select1,inout_select2;
   logic [31:0] IN1,IN2,OUT1,OUT2;





    bi_link b1(
               inout_select1,
			   inout_select2,
               IN1,	  
               OUT1,
			   IN2,
               OUT2
              );

			  
			  
    initial 
	  begin
	    inout_select1 = 1'b0;
		inout_select2 = 1'b1;
	    IN2= 32'h2;
		IN1= 32'h1;
	  end
			  
    initial 
      begin
        $fsdbDumpfile("bi_link_tb.fsdb");
        $fsdbDumpvars(0, bi_link_tb);
        #(10)
		
        $finish;
      end

endmodule