module mbe_sv ( input logic [31:0] A, B,
		     output logic [63:0] OUT );

   mbe MULTIPLIER(.mbe_multiplier(A),
		 .mbe_multiplicand(B),
		 .mbe_out(OUT));
 

endmodule: mbe_sv

		   
