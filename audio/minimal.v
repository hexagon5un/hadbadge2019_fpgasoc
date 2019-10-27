// This is the file that I flash to the boards.  It should represent the basic
// state of the synth chain, and it's also good for the back-and-forth with
// simulation.  

`include "dac.v"
`include "sample_clock.v"
`include "voice.v" 
`include "mixer4.v"
`include "lfsr.v"

module top( 
	input clk, 
	input [7:0] btn, 
	output [5:0] led, 
	output pwmout
);
/* Button and audio workout */

localparam BITDEPTH    = 14;
localparam BITFRACTION = 6;
localparam SAMPLECLOCK_DIV = 8;
localparam SAMPLEFREQ  = 8000000 / 2**SAMPLECLOCK_DIV;  // 31,250 Hz or 32 us

reg rst = 0;

wire sample_clock;
sample_clock #( .SAMPLECLOCK_DIV(SAMPLECLOCK_DIV) ) mysampleclock ( 
	.clk(clk), .rst(rst), .sample_clock(sample_clock) 
);


reg [3:0] voice =  4'b0010 ;
wire gate1;
wire gate2;
wire gate3;
wire gate4;

wire [BITDEPTH-1:0] osc1_out;
wire [BITDEPTH-1:0] osc2_out;
wire [BITDEPTH-1:0] osc3_out;
wire [BITDEPTH-1:0] osc4_out;
wire [BITDEPTH-1:0] osc5_out;
wire [BITDEPTH-1:0] osc6_out;
wire [BITDEPTH-1:0] osc7_out;
wire [BITDEPTH-1:0] osc8_out;

/* reg [7:0] buttons; */
/* always @(posedge clk) begin */
/* 	buttons <= ~btn[7:0]; */
/* 	gate1 <= buttons[0]; */
/* 	gate2 <= buttons[1]; */
/* 	gate3 <= buttons[2]; */
/* 	gate4 <= buttons[3]; */
/* 	voice <= buttons[7:4]; */
/* end */
reg [15:0] pitch = 29528 ;

reg [18:0] slow_counter=0;
always @(posedge sample_clock) begin
	slow_counter <= slow_counter + 1;
	/* voice <= slow_counter[17] ? 4'b0010 : 4'b1010; */
	pitch <= btn[0] ? 29528 : 35115;
end

wire [7:0] rando;
lfsr mylfsr (
	.clk(slow_counter[15]),
	.rst(rst),
	.dout(rando)
);


assign led[5:0] = rando[7:2];
assign gate1 = slow_counter[15] & slow_counter[12] & slow_counter[13] & slow_counter[14];
assign gate2 = slow_counter[15] & ~slow_counter[11] & slow_counter[13] & slow_counter[14];
assign gate3 = slow_counter[15] & slow_counter[12] & ~slow_counter[13] & ~slow_counter[14];
assign gate4 = ~slow_counter[15] & slow_counter[9] & ~slow_counter[13] & slow_counter[14];



voice osc1 (
	.sample_clock(sample_clock),
	.rst(rst),
	.voice_select(voice),
  	.note(60),
  	.envelope_attack(8'hf0),
  	.envelope_decay(rando >> 2),
	.gate(gate1),
	.out(osc1_out)
);
voice osc2 (
	.sample_clock(sample_clock),
	.rst(rst),
	.voice_select(voice),
  	.note(64),
  	.envelope_attack(8'hf0),
  	.envelope_decay(rando),
	.gate(gate2),
	.out(osc2_out)
);
voice osc3 (
	.sample_clock(sample_clock),
	.rst(rst),
	.voice_select(voice),
  	.note(67),
  	.envelope_attack(8'hf0),
  	.envelope_decay(rando),
	.gate(gate3),
	.out(osc3_out)
);
voice osc4 (
	.sample_clock(sample_clock),
	.rst(rst),
	.voice_select(voice),
  	.note(65),
  	.envelope_attack(8'hf0),
  	.envelope_decay(rando),
	.gate(gate4),
	.out(osc4_out)
);

wire [BITDEPTH-1:0] mix;
mixer4 mixer (
	.in1(osc1_out),
	.in2(osc2_out),
	.in3(osc3_out),
	.in4(osc4_out),
	.mix(mix)
);
voice osc5 (
	.sample_clock(sample_clock),
	.rst(rst),
	.voice_select(voice),
  	.note(59),
  	.envelope_attack(8'hf0),
  	.envelope_decay(rando >> 4),
	.gate(gate1),
	.out(osc5_out)
);
voice osc6 (
	.sample_clock(sample_clock),
	.rst(rst),
	.voice_select(voice),
  	.note(57),
  	.envelope_attack(8'hf0),
  	.envelope_decay(rando >> 4),
	.gate(gate2),
	.out(osc6_out)
);
voice osc7 (
	.sample_clock(sample_clock),
	.rst(rst),
	.voice_select(voice),
  	.note(48),
  	.envelope_attack(8'hf0),
  	.envelope_decay(rando >> 4),
	.gate(gate3),
	.out(osc7_out)
);
voice osc8 (
	.sample_clock(sample_clock),
	.rst(rst),
	.voice_select(voice),
  	.note(52),
  	.envelope_attack(8'hf0),
  	.envelope_decay(rando >> 4),
	.gate(gate4),
	.out(osc8_out)
);

wire [BITDEPTH-1:0] mix2;
mixer4 othermixer (
	.in1(osc5_out),
	.in2(osc6_out),
	.in3(osc7_out),
	.in4(osc8_out),
	.mix(mix2)
);


wire [BITDEPTH-1:0] bigmix;
assign bigmix = (mix >> 1) + (mix2 >> 1);
dac #(.BITDEPTH(BITDEPTH)) mydac (
	.clk (clk),
	.rst(rst),
	.sample_clock (sample_clock),
	.pcm (bigmix), // input to DAC
	.out (pwmout) // connect to PWM pin
);

endmodule

