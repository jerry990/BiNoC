`include "define.sv"
`include "bcp_check.sv"
//`include "bcp_assign"
module traveral_engine(input CLK,
                       input RST,
					   input VALUE,
					   input [1:0] OFFSET,
					   input EN,
					   input [`ADDR_SIZE-1:0] BASE,
					   input [`DATA_SIZE-1:0] DATA_IN,//from queue
					   input THREAD,
					   input GntDnStr,
					   output logic [`DATA_SIZE-1:0] DATA_OUT,//connect to constrtaint propagation
					   output logic [1:0] OFFSET_OUT,
					   output logic [11:0] local_link_out,
					   output logic [1:0] base_out,
					   output logic value_out,
                       output logic ReqDnStr,
                       output logic DnStrFull,
                       output logic [31:0] PacketOut
                   );

  parameter read_local_link = 2'b00;
  parameter read_var_assign = 2'b01; 
  parameter read_global_link = 2'b10;
  parameter write_back = 2'b11;
  
  logic [1:0] OFFSET_1,OFFSET_2;
  logic [`ADDR_SIZE-1:0] BASE_1,BASE_2;
  logic THREAD_1,THREAD_2;
  
  
  logic [`DATA_SIZE-1:0] local_link_1,local_link_2,local_link_3;
  logic [`DATA_SIZE-1:0] global_link;
  logic [7:0] assignment,assignment_1;
  
  logic [`ADDR_SIZE-1:0] global_address_p;
  logic global_en;
  logic [`DATA_SIZE-1:0] mem_data[4095:0];
  logic [3:0] CLAUSE_ASSIGN;
  logic [3:0] UNIT_CLAUSE;
  logic VALUE_1,VALUE_2;
  
  bcp_check bc(
                CLAUSE_ASSIGN,
			    UNIT_CLAUSE
				);
  
  
  always_ff@(posedge CLK) begin
    local_link_1 <= mem_data[OFFSET+BASE];
    OFFSET_1 <= OFFSET;		
    BASE_1 <= BASE;
	THREAD_1 <= THREAD;
	VALUE_1 <= VALUE;
  end
  
  always_ff@(posedge CLK) begin
    local_link_2 <= local_link_1;
	if(local_link_1[5]) begin
	  global_en <= 1'b1;
	  global_address_p <= BASE_1+OFFSET_1+local_link_1[4:3];
	end
	else
	  global_en <= 1'b0;
    VALUE_2 <= VALUE_1;
	OFFSET_2 <= OFFSET_1;
	THREAD_2 <= THREAD_1;
	BASE_2 <= BASE_1;
	$display("@%d@%d@%d",BASE_1,THREAD_1,BASE_1-THREAD_1);
	assignment <= mem_data[BASE_1-THREAD_1-1]; 
  end
  
  always_ff@(posedge CLK) begin
    if(global_en)
	  global_link <= mem_data[global_address_p];
	local_link_3 <= local_link_2;
	assignment_1 <= assignment;
	assignment_1[OFFSET_2] <= VALUE_2;
  end
  always_ff@(posedge CLK) begin
    CLAUSE_ASSIGN <= {assignment[7],assignment[5],assignment[3],assignment[1]};
    if(UNIT_CLAUSE[0])
      OFFSET_OUT = 2'b00;
	else if(UNIT_CLAUSE[1])
      OFFSET_OUT = 2'b01;
	else if(UNIT_CLAUSE[2])
      OFFSET_OUT = 2'b10;
	else if(UNIT_CLAUSE[3])
      OFFSET_OUT = 2'b11;
	else  
	  OFFSET_OUT = 2'bzz;
	local_link_out <= local_link_3[17:6];
	if(!local_link_3[2])
	  value_out = 1'b1;
	//DATA_OUT <=   
  end
  //always_ff@(posedge CLK) begin
    
	//DATA_OUT <=   
  //end
  
endmodule
