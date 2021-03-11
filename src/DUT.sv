module DUT(dut_if.port_in in_inter, dut_if.port_out out_inter, output enum logic [2:0] {INITIAL,WAIT,WAIT1,WAIT2,SEND} state);
    
    fpmul_sv fpmul_under_test(.A(in_inter.A),.B(in_inter.B),.OUT(out_inter.data),.CLK(in_inter.clk),.RST_N( in_inter.rst) );

    integer i=0;

    always_ff @(posedge in_inter.clk)
    begin
        if(in_inter.rst) begin
            in_inter.ready <= 0;
            out_inter.data <= 'x;
            out_inter.valid <= 0;
            state <= INITIAL;
	    i=0;
        end
        else case(state)
                INITIAL: begin
                    in_inter.ready <= 1;
                    state <= WAIT;
		    i=0;
                end
                
                WAIT: begin
                    if(in_inter.valid) begin
                        in_inter.ready <= 0;
                        //out_inter.data <= in_inter.A + in_inter.B;
                        $display("mbe: input A = %f, input B = %f",$bitstoshortreal(in_inter.A),$bitstoshortreal(in_inter.B));
                        $display("mbe: input A = %b, input B = %b",in_inter.A,in_inter.B);
			out_inter.valid <= 0;
			state<=WAIT1;
                    end
                end

		WAIT1: begin
			in_inter.ready <= 0;
			out_inter.valid <= 0;
			if (i<4) begin
				state<=WAIT1;
				i=i+1;
			end else begin
				state<=WAIT2;
			end
		end

		WAIT2: begin
			in_inter.ready <= 0;
			out_inter.valid <= 1;
                       $display("mbe: output OUT = %f", $bitstoshortreal(out_inter.data));
                       $display("mbe: output OUT = %b", out_inter.data);
			state<=SEND;
		end
                
                SEND: begin
                    if(out_inter.ready) begin
                        out_inter.valid <= 0;	//Multiplier output not ready
                        in_inter.ready <= 1;
                        state <= WAIT;
                        i=0;
                    end
                end
        endcase
    end
endmodule: DUT
