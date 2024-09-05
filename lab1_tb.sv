lab1_logic(
    input   logic   [3:0] s,
    input   logic         clk, reset,
    output logic   [6:0] sevseg,
    output  logic   [2:0] ledOut
);
	logic led_state;
	logic [25:0] counter;

	// Simple clock divider
	always_ff @(posedge clk) begin
		if (reset == 1) begin
			counter <= 0;
			led_state <= 0;
		end else if (counter == 20000000) begin
			led_state <= ~led_state;
			counter <= 0;
			ledOut[2] <= led_state;
		end else counter <= counter + 1;
	end

	// logic for first 2 leds
	assign ledOut[0] = s[1] ^ s[0];
	assign ledOut[1] = s[3] & s[2];

	//logic for seven segment display
	logic [6:0] segOut;
	seg segLogic(s, segOut);
	assign sevseg = segOut;
endmodule

module tb();
    logic clk, reset;

    logic [1:0] led, led_expected;
    logic [6:0] seg, seg_expected;
    logic [3:0] s;

    logic [13:0] testvectors[15:0];
    logic [4:0] vecNum, errors;

    lab1_logic dut(s, clk, reset, seg, led);

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
        #1; {s, led_expected, seg_expected} = testvectors[vecNum];
    end
    always @(negedge clk) begin
        vecNum = vecNum + 1;
        if !(led == led_expected) begin
            $display(" led = %b led_expected = %b with s = %b", led, led_expected,s);
            errors = errors + 1;
        end if !(seg == seg_expected) begin
            $display(" seg = %b seg_expected = %b with s = %b", seg, seg_expected, s);
            errors = errors + 1;
        end if (vecNum > 15) begin
            $display("test completed with %d errors", errors);
            $stop
        end
    end


endmodule