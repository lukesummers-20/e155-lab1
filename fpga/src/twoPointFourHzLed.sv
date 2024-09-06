// Luke Summers lsummers@g.hmc.edu 9/5/24
// module for blinking LED at 2.4 Hz
module twoPointFourHzLed(
	input  logic  reset,
    output logic  ledOut
);
    logic intOsc;
	logic ledState;
	logic [25:0] counter;

	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(intOsc));

	// Simple clock divider
	always_ff @(posedge intOsc) begin
		if (reset == 0) begin
			counter <= 0;
			ledState <= 0;
		end else if (counter == 10000000) begin
			ledState <= ~ledState;
			counter <= 0;
			ledOut <= ledState;
		end else counter <= counter + 1;
	end
endmodule