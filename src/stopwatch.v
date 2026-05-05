


module stopwatch (
	input Clk_50MHz, reset,
	output A,
	output reg [9:0] storage,
	output [6:0] o_HEX0,
	output [6:0] o_HEX1,
	output [6:0] o_HEX2
);

	reg[22:0] count_reg =0;
	reg[9:0] store =0;
	always @(posedge Clk_50MHz or negedge reset) begin
		if(!reset) begin
			count_reg <= 23'b0;
			store <= 10'b0;
		end
		else if (store < 10'd300) begin
		
			if (count_reg == 4999999) begin
				count_reg <= 0;
				store <= store + 1'b1;
				storage <= store + 1'b1;
			end
			
			else begin
				count_reg <= count_reg + 1'b1;
			end
		end
	end
	 
	
	wire[3:0] tenths = store % 10;
	wire[3:0] ones = (store / 10) % 10;
	wire[3:0] tens = (store / 100) % 10;
	
	assign A = 1'b0;
	
	hex_7seg_decoder
	 #(.COMMON_ANODE_CATHODE(0))
			HEX0
	  (
	  .in (tenths),
	  .o_a(o_HEX0[0]),
	  .o_b(o_HEX0[1]),
	  .o_c(o_HEX0[2]),
	  .o_d(o_HEX0[3]),
	  .o_e(o_HEX0[4]),
	  .o_f(o_HEX0[5]),
	  .o_g(o_HEX0[6])
	  );
	  
	  
	  hex_7seg_decoder
		#(.COMMON_ANODE_CATHODE(0))
			HEX1
		 (
		 .in (ones),
		 .o_a(o_HEX1[0]),
	    .o_b(o_HEX1[1]),
	    .o_c(o_HEX1[2]),
	    .o_d(o_HEX1[3]),
	    .o_e(o_HEX1[4]),
	    .o_f(o_HEX1[5]),
	    .o_g(o_HEX1[6])
		 );
		 
		 hex_7seg_decoder
		 #(.COMMON_ANODE_CATHODE(0))
			HEX2
		  (
		  .in (tens),
		  .o_a(o_HEX2[0]),
	     .o_b(o_HEX2[1]),
	     .o_c(o_HEX2[2]),
	     .o_d(o_HEX2[3]),
	     .o_e(o_HEX2[4]),
	     .o_f(o_HEX2[5]),
	     .o_g(o_HEX2[6])
		  );
endmodule 
