module debouncer

	#(parameter CLOCK_FREQUENCY = 50_000_000,
	  parameter STABLE_TIME_ms = 10
	  )
	  (
	  input clk, rst, i_debounce, 
	  output o_debounce
	  );
	  
	  localparam COUNTER_MAX = (CLOCK_FREQUENCY*STABLE_TIME_ms)/1000;
	  
	  reg[1:0] ff_i;
	  reg		  ff_o;
	  reg		  [23:0] counter;
	  
	  wire clear_counter;
	  wire counter_max;
	  
	  always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			ff_i <= 0;
		end else begin
			ff_i[1:0] <= {ff_i[0], i_debounce};
		end
	  end
	  
	  assign clear_counter = ^ff_i;
	  
	  always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			counter <= 0;
		end else if (clear_counter || counter_max) begin
			counter <= 0;
		end else begin
			counter <= counter + 1'b1;
		end
	  end
	  
	  assign counter_max = (counter == COUNTER_MAX);
	  
	  always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			ff_o <= 0;
		end else if(counter_max) begin
			ff_o <= ff_i[1];
		end
	  end
	  
	  assign o_debounce = ff_o;
endmodule 