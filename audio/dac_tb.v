module test;

initial begin
	$dumpvars(0,test);
	$display("Go!");
	// $monitor();
end

/* Wires, registers, and module here */


/* Clocks */
reg clk = 0;
always 
	#1 clk = !clk;


initial
	#100 $finish;

endmodule // test
