`include "amplifier.v"
`include "envelope.v"

module ar (
	input sample_clock,
	input [BITDEPTH-1:0] in,
	input [7:0] envelope_attack,
	input [7:0] envelope_decay,
	input gate,
	output [BITDEPTH-1:0] out
);

localparam BITDEPTH    = 14;
localparam BITFRACTION = 6;
localparam SAMPLECLOCK_DIV = 8;
localparam SAMPLEFREQ  = 8000000 / 2**SAMPLECLOCK_DIV;  // 31,250 Hz or 32 us

localparam VOLBITS  = 8;
localparam OFFSET  = 2**(BITDEPTH -1); // idles at mid-volume


wire [7:0] volume;
envelope myenv
(
	.sample_clock(sample_clock),
	.gate(gate),
	.a(envelope_attack),
	.r(envelope_decay),
	.volume(volume) // returns
);

// Amplifier here.
wire [BITDEPTH+VOLBITS-1:0] summer;
wire [BITDEPTH+VOLBITS-1:0] offset;
assign offset = (2**VOLBITS - volume)*OFFSET;
assign summer = in * volume + offset;
assign out = summer[BITDEPTH+VOLBITS-1 -: BITDEPTH] ;

endmodule
