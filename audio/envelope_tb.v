`timescale 1ns/1ns
module test();
/* localparam SAMPLEFREQ = 8000000 / 2**8; */
/* localparam BD=12; */

initial begin
	$dumpvars(0,test);
	$display("Go!");
	// $monitor();
end
/* Clocks */
reg clk = 0;
always 
	#62 clk = !clk; // 8 MHz = 125 ns. Awkward.

/* Wires, registers, and module here */
reg gate = 0;
reg [7:0] a = 220;
reg [7:0] r = 60;
wire [7:0] volume;

envelope myenv
(
	.clk(clk),
	.gate(gate),
	.a(a),
	.r(r),
	.volume(volume)
);

initial begin
	// full cycle, attack, sustain, release
	#10000 gate = 1;
	#30000000 gate = 0;
	// attack, interrupted by gate 
	#50000000 a=100; gate = 1;
	#10000000 gate = 0;
	// 

	#100000000 $finish;


end

endmodule // test
