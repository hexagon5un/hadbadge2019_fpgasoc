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

wire [7:0] volume;
envelope myenv
(
	.sample_clock(sample_clock),
	.gate(gate),
	.a(envelope_attack),
	.r(envelope_decay),
	.volume(volume) // returns
);

wire signed [VOLBITS:0] signed_volume;  // extra bit!
assign signed_volume = {1'b0, volume[VOLBITS-1:0]};
reg signed [BITDEPTH+VOLBITS-1:0] signed_scaled_audio;

always @(posedge sample_clock) begin
	signed_scaled_audio <= (in * signed_volume);
end

assign out = signed_scaled_audio[BITDEPTH+VOLBITS-1 -: BITDEPTH] ;

endmodule
