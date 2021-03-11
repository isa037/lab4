module fpmul_sv ( input logic [31:0] A, B, input logic CLK, RST_N,
		     output logic [31:0] OUT );

	wire rst_int;
	
	assign rst_int = ~(RST_N);


  FPmul_REGISTERED FPMULTIPLIER( 
      .FP_A(A),
      .FP_B(B),
      .clk(CLK),
      .RST_n(rst_int),
      .FP_Z(OUT) );
 
endmodule: fpmul_sv

		   
