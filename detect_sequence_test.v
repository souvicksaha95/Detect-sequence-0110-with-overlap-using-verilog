`timescale 10ns/1ns

module detect_sequence_test;
	reg clk, reset, in;
	wire out;
	
	detect_sequence DUT(.clk(clk), .in(in), .out(out), .reset(reset));
	
	always
		#5 clk = ~clk;
		
	initial
		begin
			in = 1'bz;
			clk = 1'b0;
			reset = 1'b1;
			#15 reset = 1'b0; 
			$dumpfile("detect_sequence_test.vcd");
			$dumpvars(0, detect_sequence_test);
			$monitor($time, "reset = %b, clk = %b, in = %b, out = %b", reset, clk, in, out);
		end
		
	initial
		begin
			#12 in = 1; #10 in = 0; #10 in = 1; #10 in = 1; 
			#10 in = 0; #10 in = 1; #10 in = 0; #10 in = 1; 
			#10 in = 1; #10 in = 0; #10 in = 0; #10 in = 0; 
			#10 in = 1; #10 in = 0; #10 in = 0; #10 in = 1; 
			#10 in = 1; #10 in = 0; #10 in = 0; #10 in = 1;
			#10 $finish;
		end
		
endmodule