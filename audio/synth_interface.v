// License and description
// Reg: one for each instrument.  Maybe 12?  Let's say up to 16.
// Currently thinking that PCM should be out on its own.  Still will need to
// interface with mixer peripheral, though.
// 1 bit Config Flag, 7 tuning bits, 8 attack, 8 decay, 7 note, 1 bit gate.
// If config flag is not set, ignores tuning, attack, decay bits.  
// Allows 8-bit state?

module synth_interface(
	//CPU interface
	input clk,
	input rst,
	input [3:0] addr, // 16 instruments?  should be enough.
	input [31:0] data_in,
	input wen,
	input ren,
	output wire ready,
	// Audio/mixer i/o
	output pwmout
);

reg ready_n;
// buffer ready signal
always @(posedge clk) begin
	if (rst) begin
		ready_n <= 0;
	end else begin
		ready_n <= (wen || ren);
	end
end
assign ready = ready_n & (ren || wen);


always @(posedge clk) begin
	if (rst) begin
// clear all interface state
	end else begin
		// do the work 

	end
end

endmodule

