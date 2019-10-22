module oscillator 
#(
	parameter BITDEPTH   = 12,
	parameter BITFRACTION   = 12
) (
	input sample_clock,
	input [18:0] increment ,  
	output [BITDEPTH-1:0] out 
);
localparam TOPBIT = BITDEPTH+BITFRACTION-1;
// DDS


reg [TOPBIT:0] accumulator ;  
/* Set up divider counter */
always @(posedge sample_clock) begin 
	accumulator <= accumulator + increment;
end

wire [BITDEPTH:0] saw;
assign saw = accumulator[TOPBIT -: BITDEPTH] ; 
endmodule

