module uni_in_out_port(
  input logic inout_select1,
  input logic inout_select2,
  input logic [31:0] IN1,
  input logic [31:0] IN2,
  output logic [31:0] OUT1,
  output logic [31:0] OUT2
);
	assign OUT1 = (inout_select2 & !inout_select1) ? IN2:32'hzzzz_zzzz;
	assign OUT2 = (inout_select1 & !inout_select2) ? IN1:32'hzzzz_zzzz;		  
endmodule