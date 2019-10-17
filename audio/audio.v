module top( 
	input clk, 
	input [7:0] btn, 
	output [5:0] led, 
	output [5:0] sao1,
	output pwmout
);
/* Button and audio workout */

dac mydac (
	.clk (clk),
	.pcm (mix),
	.out (pwmout)
);

reg [23:0] counter = 0;
reg [15:0] ramp1 = 0; 
reg [15:0] ramp2 = 0; 
wire [15:0] mix; 

/* Set up divider counter */
always @(posedge clk) begin 
	counter <= counter + 1;
end

// this value controls the frequency
always @(posedge counter[7]) begin 
	ramp1 <= ramp1 + 108; // six-hundred step ramp waveform
end
always @(posedge counter[7]) begin 
	ramp2 <= ramp2 + 109; // six-hundred step ramp waveform
end

assign mix = ramp1/2 + ramp2/2;

endmodule
