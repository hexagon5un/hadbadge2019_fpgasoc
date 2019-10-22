/* Quick and dirty sigma-delta converter */
module dac #(parameter BITDEPTH=12) (
	input clk,
	input sample_clock,
	input [BITDEPTH-1:0] pcm,
	output out
);


reg [BITDEPTH:0] accumulator;
reg [BITDEPTH:0] sample;

// buffer at sample clock
always @(posedge sample_clock) begin
	sample = pcm;
end

always @(posedge clk) begin
	accumulator <= accumulator[BITDEPTH-1:0] + sample;
end

assign out = accumulator[BITDEPTH];

endmodule

