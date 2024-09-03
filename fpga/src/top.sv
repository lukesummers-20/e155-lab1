module led(
    input logic s[3:0],
    output logic led[1:0]
);
    assign led[0] = ~(s[1] ^ s[0]);
    assign led[1] = ~(s[3] & s[2]);
endmodule

module seg(
    input logic s[3:0],
    output logic seg[6:0]
);
    case(s)
        4b'0000: assign seg = 7b'0000001;
        4b'0001: assign seg = 7b'1001111;
        4b'0010: assign seg = 7b'0010010;
        4b'0011: assign seg = 7b'0000110;
        4b'0100: assign seg = 7b'1001100;
        4b'0101: assign seg = 7b'0100100;
        4b'0110: assign seg = 7b'0100000;
        4b'0111: assign seg = 7b'0001111;
        4b'1000: assign seg = 7b'0000000;
        4b'1001: assign seg = 7b'0001100;
        4b'1010: assign seg = 7b'0000010;
        4b'1011: assign seg = 7b'1100000;
        4b'1100: assign seg = 7b'0110001;
        4b'1101: assign seg = 7b'1000010;
        4b'1110: assign seg = 7b'0110000;
        4b'1111: assign seg = 7b'0111000;
        default : assign seg = 7b'1111111;
    endcase
endmodule

module top(
    input   logic   s[3:0],
	output 	logic   sevseg[6:0],
    output  logic   ledOut[2:0]
);

	logic int_osc;
	logic led_state = 0;
	logic [25:0] counter = 0;
	
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	// Simple clock divider
	always_ff @(posedge int_osc)
		begin
			counter <= counter + 1;
            if (counter == 20000000) begin
                led_state <= ~led_state;
                counter <= 0;
            end
		end
	
    // logic for first 2 leds 
    logic leds[1:0];
    led(s, leds);

    //logic for seven segment display
    logic seg[6:0];
    seg(s, seg);

    assign ledOut[1:0] = leds;
    assign ledOut[2] = led_state;
    assign sevseg = seg;

endmodule