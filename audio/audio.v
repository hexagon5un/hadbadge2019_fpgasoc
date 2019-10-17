module top( 
	input clk, 
	input [7:0] btn, 
	output [5:0] led, 
	output pwmout, 
	output [5:0] sao1 
);
/* Button and audio workout */


reg [23:0] counter;
reg audio;
wire [3:0] button;

button_number button_number_1(
	.clk (clk), 
	.btn (btn), 
	.button (button)
);


// Chromatic divisors of 8 MHz, starting with C3
// 15289, 14431, 13621, 12856, 12135, 11454, 10811, 10204, 9631, 9091, 8581, 8099

always@(posedge clk) begin 
	counter <= counter + 1;
	audio <= counter[15];

end

assign led[3:0] = button;
/* assign pwmout = audio; */

endmodule
