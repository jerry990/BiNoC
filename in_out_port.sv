module in_out_port(
  input logic [31:0] IN,
  input logic inout_select,
  output logic [31:0] OUT,
  inout [31:0] bio
);
    assign bio = (inout_select) ? 32'hzzzz_zzzz : IN;
	assign OUT = (inout_select) ? bio : 32'hzzzz_zzzz;
endmodule

