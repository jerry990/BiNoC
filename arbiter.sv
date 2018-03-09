module arbiter(
  input clk,
  input rst,
  input req9,
  input req8,
  input req7,
  input req6,
  input req5,
  input req4,
  input req3,
  input req2,
  input req1,
  input req0,
  output logic gnt9,
  output logic gnt8,
  output logic gnt7,
  output logic gnt6,
  output logic gnt5,
  output logic gnt4,
  output logic gnt3,
  output logic gnt2,
  output logic gnt1,
  output logic gnt0
);
//parameter [9:0] N = 10'd5;
//output logic [3:0] tt;
//Declarations
//reg 	[N-1:0] pointer_reg;//priority vector
logic 	[9:0] req;//request vector
// ----------------------- Combinational Logic  ------------------------------ //  
assign req = {req9,req8,req7,req6,req5,req4,req3,req2,req1,req0};
//Declarations
logic  [9:0] gnt;
logic  [3:0] cs,ns;  
 
always_ff@(negedge rst or posedge clk)
  begin
    if(rst)
	  cs <= 4'b0000;
	else
	  cs <= ns;
  end  

always_comb 
	begin
	//  gnt0 = gnt[0];
	  {gnt9,gnt8,gnt7,gnt6,gnt5,gnt4,gnt3,gnt2,gnt1,gnt0} = gnt[9:0];
	  case(cs)
	    4'b0000:
		  begin
		    if(req[0])
              gnt = 10'b00_0000_0001;
			else if(req[1])
              gnt = 10'b00_0000_0010;			
 			else if(req[2])
              gnt = 10'b00_0000_0100;			
 			else if(req[3])
              gnt = 10'b00_0000_1000;			
 			else if(req[4])
              gnt = 10'b00_0001_0000;			
 			else if(req[5])
              gnt = 10'b00_0010_0000;
           	else if(req[6])
              gnt = 10'b00_0100_0000;			
            else if(req[7])
              gnt = 10'b00_1000_0000;			
            else if(req[8])
              gnt = 10'b01_0000_0000;			
            else if(req[9])
              gnt = 10'b10_0000_0000;			
 		    else
			  gnt = 10'b00_0000_0000;
		    ns = 4'b0001;	
		  end
	    4'b0001:
		  begin
		    if(req[1])
              gnt = 10'b00_0000_0010;
			else if(req[0])
              gnt = 10'b00_0000_0001;			
 			else if(req[2])
              gnt = 10'b00_0000_0100;			
 			else if(req[3])
              gnt = 10'b00_0000_1000;			
 			else if(req[4])
              gnt = 10'b00_0001_0000;			
 			else if(req[5])
              gnt = 10'b00_0010_0000;
           	else if(req[6])
              gnt = 10'b00_0100_0000;			
            else if(req[7])
              gnt = 10'b00_1000_0000;			
            else if(req[8])
              gnt = 10'b01_0000_0000;			
            else if(req[9])
              gnt = 10'b10_0000_0000;			
 		    else
			  gnt = 10'b00_0000_0000;
		    ns = 4'b0010;	
			
		  end
		4'b0010:
		  begin
		   if(req[2])
              gnt = 10'b00_0000_0100;
			else if(req[0])
              gnt = 10'b00_0000_0001;			
 			else if(req[1])
              gnt = 10'b00_0000_0010;			
 			else if(req[3])
              gnt = 10'b00_0000_1000;			
 			else if(req[4])
              gnt = 10'b00_0001_0000;			
 			else if(req[5])
              gnt = 10'b00_0010_0000;
           	else if(req[6])
              gnt = 10'b00_0100_0000;			
            else if(req[7])
              gnt = 10'b00_1000_0000;			
            else if(req[8])
              gnt = 10'b01_0000_0000;			
            else if(req[9])
              gnt = 10'b10_0000_0000;			
 		    else
			  gnt = 10'b00_0000_0000;
		    ns = 4'b0011;	
		  end
        4'b0011:
		  begin
           if(req[3])
              gnt = 10'b00_0000_1000;
			else if(req[0])
              gnt = 10'b00_0000_0001;			
 			else if(req[1])
              gnt = 10'b00_0000_0010;			
 			else if(req[2])
              gnt = 10'b00_0000_0100;			
 			else if(req[4])
              gnt = 10'b00_0001_0000;			
 			else if(req[5])
              gnt = 10'b00_0010_0000;
           	else if(req[6])
              gnt = 10'b00_0100_0000;			
            else if(req[7])
              gnt = 10'b00_1000_0000;			
            else if(req[8])
              gnt = 10'b01_0000_0000;			
            else if(req[9])
              gnt = 10'b10_0000_0000;			
 		    else
			  gnt = 10'b00_0000_0000;
		    ns = 4'b0100;	
		    
			
 		  end
        4'b0100:
		  begin
	       if(req[4])
              gnt = 10'b00_0001_0000;
			else if(req[0])
              gnt = 10'b00_0000_0001;			
 			else if(req[1])
              gnt = 10'b00_0000_0010;			
 			else if(req[2])
              gnt = 10'b00_0000_0100;			
 			else if(req[3])
              gnt = 10'b00_0000_1000;			
 			else if(req[5])
              gnt = 10'b00_0010_0000;
           	else if(req[6])
              gnt = 10'b00_0100_0000;			
            else if(req[7])
              gnt = 10'b00_1000_0000;			
            else if(req[8])
              gnt = 10'b01_0000_0000;			
            else if(req[9])
              gnt = 10'b10_0000_0000;			
 		    else
			  gnt = 10'b00_0000_0000;
		    ns = 4'b0101;			
	      end
        4'b0101:
		  begin
	       if(req[5])
              gnt = 10'b00_0010_0000;
			else if(req[0])
              gnt = 10'b00_0000_0001;			
 			else if(req[1])
              gnt = 10'b00_0000_0010;			
 			else if(req[2])
              gnt = 10'b00_0000_0100;			
 			else if(req[3])
              gnt = 10'b00_0000_1000;			
 			else if(req[4])
              gnt = 10'b00_0001_0000;
           	else if(req[6])
              gnt = 10'b00_0100_0000;			
            else if(req[7])
              gnt = 10'b00_1000_0000;			
            else if(req[8])
              gnt = 10'b01_0000_0000;			
            else if(req[9])
              gnt = 10'b10_0000_0000;			
 		    else
			  gnt = 10'b00_0000_0000;
		    ns = 4'b0110;			
	      end
		4'b0110:
		  begin
	       if(req[6])
              gnt = 10'b00_0100_0000;
			else if(req[0])
              gnt = 10'b00_0000_0001;			
 			else if(req[1])
              gnt = 10'b00_0000_0010;			
 			else if(req[2])
              gnt = 10'b00_0000_0100;			
 			else if(req[3])
              gnt = 10'b00_0000_1000;			
 			else if(req[4])
              gnt = 10'b00_0001_0000;
           	else if(req[5])
              gnt = 10'b00_0010_0000;			
            else if(req[7])
              gnt = 10'b00_1000_0000;			
            else if(req[8])
              gnt = 10'b01_0000_0000;			
            else if(req[9])
              gnt = 10'b10_0000_0000;			
 		    else
			  gnt = 10'b00_0000_0000;
		    ns = 4'b0111;			
			
		  end
		4'b0111:
		  begin
	       if(req[7])
              gnt = 10'b00_1000_0000;
			else if(req[0])
              gnt = 10'b00_0000_0001;			
 			else if(req[1])
              gnt = 10'b00_0000_0010;			
 			else if(req[2])
              gnt = 10'b00_0000_0100;			
 			else if(req[3])
              gnt = 10'b00_0000_1000;			
 			else if(req[4])
              gnt = 10'b00_0001_0000;
           	else if(req[5])
              gnt = 10'b00_0010_0000;			
            else if(req[6])
              gnt = 10'b00_0100_0000;			
            else if(req[8])
              gnt = 10'b01_0000_0000;			
            else if(req[9])
              gnt = 10'b10_0000_0000;			
 		    else
			  gnt = 10'b00_0000_0000;
		    ns = 4'b1000;			
			
		  end
		4'b1000:
		  begin
	       if(req[8])
              gnt = 10'b01_0000_0000;
			else if(req[0])
              gnt = 10'b00_0000_0001;			
 			else if(req[1])
              gnt = 10'b00_0000_0010;			
 			else if(req[2])
              gnt = 10'b00_0000_0100;			
 			else if(req[3])
              gnt = 10'b00_0000_1000;			
 			else if(req[4])
              gnt = 10'b00_0001_0000;
           	else if(req[5])
              gnt = 10'b00_0010_0000;			
            else if(req[6])
              gnt = 10'b00_0100_0000;			
            else if(req[7])
              gnt = 10'b00_1000_0000;			
            else if(req[9])
              gnt = 10'b10_0000_0000;			
 		    else
			  gnt = 10'b00_0000_0000;
		    ns = 4'b1001;			
			
		  end
		  
		default:
		  begin
	       if(req[9])
              gnt = 10'b10_0000_0000;
			else if(req[0])
              gnt = 10'b00_0000_0001;			
 			else if(req[1])
              gnt = 10'b00_0000_0010;			
 			else if(req[2])
              gnt = 10'b00_0000_0100;			
 			else if(req[3])
              gnt = 10'b00_0000_1000;			
 			else if(req[4])
              gnt = 10'b00_0001_0000;
           	else if(req[5])
              gnt = 10'b00_0010_0000;			
            else if(req[6])
              gnt = 10'b00_0100_0000;			
            else if(req[7])
              gnt = 10'b00_1000_0000;			
            else if(req[8])
              gnt = 10'b01_0000_0000;			
 		    else
			  gnt = 10'b00_0000_0000;
		    ns = 4'b0000;			
			
		  end
        		
	  endcase
	end

endmodule
