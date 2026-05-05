


module TopModule (
	input clk, reset, input_button, 
	output A,
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5
); 

	wire active;
	
	
	wire [9:0] storage;
	
	assign active = (storage < 10'd300);
	
	
	pulse_counter pc(clk, reset, input_button, active, HEX0, HEX1, HEX2);
	stopwatch stp(clk, reset, A, storage, HEX3, HEX4, HEX5);
	
	
endmodule 