`timescale 1ns/1ns
module envelope #(
	parameter SAMPLE_CLK_FREQ = 44100,
	parameter ACCUMULATOR_BITS = 26
)
(
	input clk,
	input gate,
	input [7:0] a,
	input [7:0] r,
	output reg [7:0] volume = 0
);

// state machine that advances volume while key pressed
localparam WAIT    = 2'd0;
localparam ATTACK  = 2'd1;
localparam SUSTAIN = 2'd2;
localparam RELEASE = 2'd3;

reg[1:0] state;

initial begin
	state = WAIT;
	volume = 0;
end
// local duplicate of sample clock.  why?  routability?  can just pull in
// global sample clock if that helps
reg sample_clock       = 0;
reg [7:0] sample_count = 0;
always @(posedge clk) begin
	sample_count <= sample_count + 1;
	sample_clock <= sample_count[7];
end

// game here is to update an A/R counter 
// when overflows, add/sub one from volume
// faster counter overflows, faster the volume changes
// the counter is zero when it shouldn't be ramping
/* reg [7:0] attack_increment = 0; */
reg [8:0] attack_counter = 0;

/* reg [7:0] release_increment = 0; */
reg [8:0] release_counter = 0;

/* always @(posedge sample_clock) begin */
/* 	attack_counter <= attack_counter[7:0] + attack_increment; */
/* 	release_counter <= release_counter[7:0] + release_increment; */
/* end */

// state machine
always @(posedge sample_clock)
begin
	case (state)
		WAIT:  if (gate) begin state <= ATTACK; attack_counter <= 0; end
		ATTACK: begin
			attack_counter <= attack_counter[7:0] + a;
			if (attack_counter[8]) 				
				volume = volume < 255 ? volume + 1 : volume;
			if (volume == 255) begin state <= SUSTAIN; end
			if (!gate) begin state <= RELEASE; release_counter <= 0; end
		end
	SUSTAIN: begin
		if (!gate) begin state <= RELEASE; release_counter <= 0; end
	end
	RELEASE: 
	begin
		release_counter <= release_counter[7:0] + r;
			if (release_counter[8]) 				
				volume = volume > 0 ? volume - 1: volume;  // change me later for expo decay?
			if (volume == 0) state <= WAIT; 
			if (gate) begin state <= ATTACK; attack_counter <= 0; end
	end

endcase
end // state machine loop

endmodule
