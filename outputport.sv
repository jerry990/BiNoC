`include "arbiter.sv"
`include "output_mux.sv"
module outputport( input logic clk, 
                   input logic rst,
                   input logic inout_select,				   
				   input logic [31:0] PacketInPort0,
                   input logic [31:0] PacketInPort1,   
                   input logic [31:0] PacketInPort2,
                   input logic [31:0] PacketInPort3,
                   input logic [31:0] PacketInPort4,
                   input logic [31:0] PacketInPort5,   
                   input logic [31:0] PacketInPort6,
                   input logic [31:0] PacketInPort7,
                   input logic [31:0] PacketInPort8,
                   input logic [31:0] PacketInPort9, 
                   output logic [31:0] PacketOut);
// ------------------------ Parameter Declarations --------------------------- //
//  parameter     routerNo = 24; // change depends on mesh size 
//  parameter     dataWidth = 32;// number of bits for data bus
  parameter 	SEND_REQ = 1'b0, 
				WAIT_GRANT = 1'b1;
// ------------------------ Inputs Declarations ------------------------------ //
  logic [9:0] reqInCntr_wEn;// to handle enable signal to Arbiter
  logic [3:0] select;// select wires between Mux and Arbiter
// ------------------------ Registers Declarations --------------------------- //
//register to hold Packet out until makeing arbitration and grant
  logic [31:0] DataBuff;//send_request (databuff -> packetout)
  logic STATE;
  logic Enable_RRA;// Anding reqInCntr with Enable_RRA
  assign select =  { (gntInCntr[9] | gntInCntr[8]),(gntInCntr[7] | gntInCntr[6] | gntInCntr[5] | gntInCntr[4]) ,(gntInCntr[7] | gntInCntr[6] | gntInCntr[3] | gntInCntr[2]) , (gntInCntr[9] | gntInCntr[7] | gntInCntr[5] | gntInCntr[3] | gntInCntr[1])}; //& {,}
  assign reqInCntr_wEn = reqInCntr & {10{(!full1 | !full2) & Enable_RRA }};///{5{Enable_RRA}}; // 
  
// ----------------------- Sequential  Logic  -------------------------------- //

always_ff @(posedge clk or negedge rst)
  begin
    if(rst)//reset all registers
      begin 
	    Enable_RRA 		<= 1;
        reqDnStr  <= 0;
		PacketOut  <= 32'hzzzz_zzzz;
		STATE		<= SEND_REQ;
		//gntInCntr <= 5'b0;
      end
    else
	 begin
	   case(STATE)
	     SEND_REQ:
		   begin	
		     if ( ! full1 & (gntInCntr[0] | gntInCntr[1] | gntInCntr[2] | gntInCntr[3] | gntInCntr[4] | 
			                 gntInCntr[5] | gntInCntr[6] | gntInCntr[7] | gntInCntr[8] | gntInCntr[9]) )
			   begin
			    STATE 		<= WAIT_GRANT;
				reqDnStr 	<= 1;//send_request
				PacketOut   <= DataBuff;
				Enable_RRA 	<= 0;
			   end
			   else if(! full2 & (gntInCntr[0] | gntInCntr[1] | gntInCntr[2] | gntInCntr[3] | gntInCntr[4] | 
			                 gntInCntr[5] | gntInCntr[6] | gntInCntr[7] | gntInCntr[8] | gntInCntr[9]))
			     begin
				   STATE 		<= WAIT_GRANT;
				   reqDnStr 	<= 1;//send_request
				   PacketOut    <= DataBuff;
			  	   Enable_RRA 	<= 0;
				 end 
			   else if(full1 && full2)
			    begin
				    STATE 		<= SEND_REQ;
				    Enable_RRA 	<= 0;
				end
			   else
			     Enable_RRA 	<= 1;
			end
			WAIT_GRANT:
				begin
				if ( gntDnStr )
					begin
					  STATE <= SEND_REQ;
					  reqDnStr <= 0;
					  Enable_RRA <= 1;
					end
				else
					begin
					  STATE <= WAIT_GRANT;
					end
				end
			endcase
		end//else
  end // always 

arbiter rr_Arbiter
(
.clk(clk),
.rst(rst),
.req9(reqInCntr_wEn[9]),
.req8(reqInCntr_wEn[8]),
.req7(reqInCntr_wEn[7]),
.req6(reqInCntr_wEn[6]),
.req5(reqInCntr_wEn[5]),
.req4(reqInCntr_wEn[4]),
.req3(reqInCntr_wEn[3]),
.req2(reqInCntr_wEn[2]),
.req1(reqInCntr_wEn[1]),
.req0(reqInCntr_wEn[0]),
.gnt9(gntInCntr[9]),
.gnt8(gntInCntr[8]),
.gnt7(gntInCntr[7]),
.gnt6(gntInCntr[6]),
.gnt5(gntInCntr[5]),
.gnt4(gntInCntr[4]),
.gnt3(gntInCntr[3]),
.gnt2(gntInCntr[2]),
.gnt1(gntInCntr[1]),
.gnt0(gntInCntr[0])
);

// --------------------------------------------------------------------------- //
/* instantiate mux  */
output_mux  mux1
( 
.PacketInPort0(PacketInPort0),
.PacketInPort1(PacketInPort1),
.PacketInPort2(PacketInPort2),
.PacketInPort3(PacketInPort3),
.PacketInPort4(PacketInPort4),
.PacketInPort5(PacketInPort5),   
.PacketInPort6(PacketInPort6),
.PacketInPort7(PacketInPort7),
.PacketInPort8(PacketInPort8),
.PacketInPort9(PacketInPort9), 
.sel(select),
.PacketOut(DataBuff)
);
endmodule
// ----------------------------- End of File --------------------------------- //