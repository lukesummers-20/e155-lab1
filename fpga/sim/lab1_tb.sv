// Luke Summers lsummers@g.hmc.edu 9/5/24
// testbench to test lab1.sv
module sevSegLogic(
    input logic [3:0] s,
    output logic [6:0] sevSegOut
);
	always_comb
		case(s)
			4'b0000: sevSegOut = 7'b1000000; 
			4'b0001: sevSegOut = 7'b1111001;
			4'b0010: sevSegOut = 7'b0100100;
			4'b0011: sevSegOut = 7'b0110000;
			4'b0100: sevSegOut = 7'b0011001;
			4'b0101: sevSegOut = 7'b0010010;
			4'b0110: sevSegOut = 7'b0000010;
			4'b0111: sevSegOut = 7'b1111000;
			4'b1000: sevSegOut = 7'b0000000;
			4'b1001: sevSegOut = 7'b0011000;
			4'b1010: sevSegOut = 7'b0100000;
			4'b1011: sevSegOut = 7'b0000011;
			4'b1100: sevSegOut = 7'b1000110;
			4'b1101: sevSegOut = 7'b0100001;
			4'b1110: sevSegOut = 7'b0000110;
			4'b1111: sevSegOut = 7'b0001110;
			default: sevSegOut = 7'bxxxxxxx;
		endcase
endmodule
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
module lab1(
    input   logic   [3:0] s,
    input   logic         reset,
    output logic   [6:0] sevSegOut,
    output  logic   [2:0] ledOut
);
	//Blink LED at 2.4Hz
	twoPointFourHzLed blinkingLed(reset, ledOut[2]);

	// logic for first 2 leds
	assign ledOut[0] = s[1] ^ s[0];
	assign ledOut[1] = s[3] & s[2];

	//logic for seven segment display
	sevSegLogic segLogic(s, sevSegOut);
  
endmodule

module tb();
    logic clk, reset;

    logic [2:0] ledOut;
    logic [1:0] ledOutExpected;
    logic [6:0] sevSegOut, sevSegOutExpected;
    logic [3:0] s;

    logic [13:0] testvectors[15:0];
    logic [4:0] vecNum, errors;

    lab1 dut(s, clk, reset, sevSegOut, ledOut);

    initial begin
        $readmemb("lab1_tv.tv", testvectors);
        vecNum = 0;
        errors = 0;
        reset = 1;
        #20;
        reset = 0;
    end
    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end
    always @(posedge clk) begin
        #1; {s, ledOutExpected, sevSegOutExpected} = testvectors[vecNum];
    end
    always @(negedge clk) begin
        vecNum = vecNum + 1;
        if (ledOut[1:0] != ledOutExpected) begin
            $display(" ledOut = %b ledOutExpected = %b with s = %b", ledOut[1:0], ledOutExpected, s);
            errors = errors + 1;
        end if (seg != seg_expected) begin
            $display(" sevSegOut = %b sevSegOutExpected = %b with s = %b", sevSegOut, sevSegOutExpected, s);
            errors = errors + 1;
        end if (vecNum > 15) begin
            $display("test completed with %d errors", errors);
            $stop;
        end
    end


endmodule