// Luke Summers lsummers@g.hmc.edu 9/5/24
// combinational logic for driving 3 LEDs and an instantiation 
// of a module for the logic of a seven segment display
module lab1(
    input   logic   [3:0] s,
    input   logic         reset,
    output logic   [6:0] sevSegOut,
    output  logic   [2:0] ledOut
);
	//Blink LED at 2.4Hz
	twoPointFourHzLed blinkingLed(ledOut[2]);

	// logic for first 2 leds
	assign ledOut[0] = s[1] ^ s[0];
	assign ledOut[1] = s[3] & s[2];

	//logic for seven segment display
	sevSegLogic segLogic(s, sevSegOut);
  
endmodule