


module pulse_counter 
	#(parameter CLOCK_FREQUENCY = 50_000_000,
	  parameter STABLE_TIME_ms = 20
	  )
	 (
	 input Clk, rst, i_button, active,
	 output [6:0] o_HEX0,
	 output [6:0] o_HEX1,
	 output [6:0] o_HEX2
	 );
	 
	 reg [3:0] counter0;
	 reg [3:0] counter1;
	 reg [3:0] counter2;
	 
	 wire button_debounced;
	 debouncer db(Clk, rst, i_button, button_debounced);
	 
	 reg button_previous;
	 wire button_press_edge_sensitive = button_debounced & ~button_previous;
	 
	 always @ (posedge Clk or negedge rst) begin
		if(!rst) button_previous = 1'b0;
		else button_previous <= button_debounced;
	end
	
	reg[9:0] count;
	
	always @ (posedge Clk or negedge rst) begin
		if(!rst) begin
			count <= 10'd0;
		end
		else if(button_press_edge_sensitive && count < 10'd999 && active) begin
			count <= count + 1'b1;
		end
	end
	
	wire[3:0] ones = count % 10;
	wire[3:0] tens = (count / 10) %10;
	wire[3:0] hundreds = count /100;
	 
	  
	  hex_7seg_decoder
	 #(.COMMON_ANODE_CATHODE(0))
			HEX0
	  (
	  .in (ones),
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
		 .in (tens),
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
		  .in (hundreds),
		  .o_a(o_HEX2[0]),
	     .o_b(o_HEX2[1]),
	     .o_c(o_HEX2[2]),
	     .o_d(o_HEX2[3]),
	     .o_e(o_HEX2[4]),
	     .o_f(o_HEX2[5]),
	     .o_g(o_HEX2[6])
		  );
endmodule 