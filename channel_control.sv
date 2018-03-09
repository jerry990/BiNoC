`include "arbiter.sv"
module channel_control(
  input clk,
  input rst,
  input HP_input_req,
  input LP_input_req,
  input [9:0] HP_channel_req,
  input [9:0] LP_channel_req,
  output logic [9:0] HP_channel_gnt,
  output logic [9:0] LP_channel_gnt,  
 
  output logic HP_inout_select,
  output logic LP_inout_select,
  output logic HP_output_req,
  output logic LP_output_req,
  output logic [3:0] HP_sel,
  output logic [3:0] LP_sel
);

  logic [1:0] HP_cs,HP_ns,LP_cs,LP_ns,HP_cnt;
  logic [2:0] LP_cnt;

  parameter idle = 2'b00,
            free = 2'b01,
			wait_s = 2'b10;
  assign HP_sel = {(HP_channel_gnt[9] | HP_channel_gnt[8]),
                   (HP_channel_gnt[7] | HP_channel_gnt[6] | HP_channel_gnt[5] | HP_channel_gnt[4]),
				   (HP_channel_gnt[7] | HP_channel_gnt[6] | HP_channel_gnt[3] | HP_channel_gnt[2]), 
				   (HP_channel_gnt[9] | HP_channel_gnt[7] | HP_channel_gnt[5] | HP_channel_gnt[3] | HP_channel_gnt[1])
				  };
  assign LP_sel = {(LP_channel_gnt[9] | LP_channel_gnt[8]),
                   (LP_channel_gnt[7] | LP_channel_gnt[6] | LP_channel_gnt[5] | LP_channel_gnt[4]),
				   (LP_channel_gnt[7] | LP_channel_gnt[6] | LP_channel_gnt[3] | LP_channel_gnt[2]), 
				   (LP_channel_gnt[9] | LP_channel_gnt[7] | LP_channel_gnt[5] | LP_channel_gnt[3] | LP_channel_gnt[1])
				  };
  
  always_ff@(posedge clk)
    begin
	  if(rst)
	    begin
		  HP_cs <= free;
		  LP_cs <= idle;
		  
		end
	  else
	    begin
	      HP_cs <= HP_ns;
          LP_cs <= LP_ns;		  
		end
    end
	
  always_comb
    begin
      case(HP_cs)
        free:
		  begin
		    HP_inout_select = 1'b0;
		    if(!HP_input_req || HP_channel_req)
			  HP_ns = free;
		    else if(HP_input_req  && HP_channel_req == 10'b0)
			  HP_ns = idle;
			else
			  HP_ns = free;
		  end
		idle:
		  begin
		    HP_inout_select = 1'b1;
		    if(HP_channel_req == 10'b0)
			  HP_ns = idle;
			else 
			  HP_ns = wait_s;
		  end
		wait_s:
		  begin
		    HP_inout_select = 1'b0;
		    if(HP_cnt < 2'b10)
			  HP_ns = wait_s;
			else
			  HP_ns = free;
		  end
      endcase
      
	  case(LP_cs)
        free:
		  begin
		    LP_inout_select = 1'b1;
		    if(!LP_input_req)
			  LP_ns = free;
			else
			  LP_ns = idle;
		  end
		idle:
		  begin
		    LP_inout_select = 1'b1;
		    if(LP_channel_req == 10'b0 || LP_input_req)
			  LP_ns = idle;
			else 
			  LP_ns = wait_s;
		  end
		wait_s:
		  begin
		    LP_inout_select = 1'b1;
		    if(LP_cnt < 3'b100)
			  LP_ns = wait_s;
			else
			  LP_ns = free;
		  end
      endcase
     
	end

//output_req	
    always_comb
	  begin
	    case(HP_cs)
		  free: HP_output_req = 1'b1;
	      idle: HP_output_req = 1'b0;
		  default: HP_output_req = 1'b1;
	    endcase  	
	  end
    
	
	
	always_ff@(posedge clk)
	  if(rst)
	    HP_cnt = 2'b00;
	  else
	    begin
	      case(HP_cs)
		    idle: HP_cnt <= 2'b00;
		    default: HP_cnt <= HP_cnt+2'b01;
	      endcase  
	    end
	
	always_ff@(posedge clk)
	  if(rst)
	    LP_cnt = 3'b000;
	  else
	    begin
	      case(LP_cs)
		    idle: LP_cnt <= 3'b000;
		    default: LP_cnt <= LP_cnt+3'b001;
	      endcase  
	    end

  arbiter HP_RR_arbiter(
    .clk(clk),
    .rst(rst),
    .req9(HP_channel_req[9]),
    .req8(HP_channel_req[8]),
    .req7(HP_channel_req[7]),
    .req6(HP_channel_req[6]),
    .req5(HP_channel_req[5]),
    .req4(HP_channel_req[4]),
    .req3(HP_channel_req[3]),
    .req2(HP_channel_req[2]),
    .req1(HP_channel_req[1]),
    .req0(HP_channel_req[0]),
    .gnt9(HP_channel_gnt[9]),
    .gnt8(HP_channel_gnt[8]),
    .gnt7(HP_channel_gnt[7]),
    .gnt6(HP_channel_gnt[6]),
    .gnt5(HP_channel_gnt[5]),
    .gnt4(HP_channel_gnt[4]),
    .gnt3(HP_channel_gnt[3]),
    .gnt2(HP_channel_gnt[2]),
    .gnt1(HP_channel_gnt[1]),
    .gnt0(HP_channel_gnt[0])  
  );
  arbiter LP_RR_arbiter(
    .clk(clk),
    .rst(rst),
    .req9(LP_channel_req[9]),
    .req8(LP_channel_req[8]),
    .req7(LP_channel_req[7]),
    .req6(LP_channel_req[6]),
    .req5(LP_channel_req[5]),
    .req4(LP_channel_req[4]),
    .req3(LP_channel_req[3]),
    .req2(LP_channel_req[2]),
    .req1(LP_channel_req[1]),
    .req0(LP_channel_req[0]),
    .gnt9(LP_channel_gnt[9]),
    .gnt8(LP_channel_gnt[8]),
    .gnt7(LP_channel_gnt[7]),
    .gnt6(LP_channel_gnt[6]),
    .gnt5(LP_channel_gnt[5]),
    .gnt4(LP_channel_gnt[4]),
    .gnt3(LP_channel_gnt[3]),
    .gnt2(LP_channel_gnt[2]),
    .gnt1(LP_channel_gnt[1]),
    .gnt0(LP_channel_gnt[0])  
  );
endmodule			