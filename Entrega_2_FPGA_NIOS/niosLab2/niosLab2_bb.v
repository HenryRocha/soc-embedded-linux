
module niosLab2 (
	clk_clk,
	leds_export,
	reset_reset_n,
	switches_export,
	motor_export);	

	input		clk_clk;
	output	[5:0]	leds_export;
	input		reset_reset_n;
	input	[9:0]	switches_export;
	output	[3:0]	motor_export;
endmodule
