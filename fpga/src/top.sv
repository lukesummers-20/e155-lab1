module top(
    input   logic   [3:0] s,
    input   logic         reset,
    output logic   [6:0] sevseg,
    output  logic   [2:0] ledOut
);

logic int_osc;
logic led_state;
logic [25:0] counter;

// Internal high-speed oscillator
HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

// Simple clock divider
always_ff @(posedge int_osc) begin
    if (reset == 0) begin
        counter <= 0;
        led_state <= 0;
    end else if (counter == 20000000) begin
        led_state <= ~led_state;
        counter <= 0;
        ledOut[2] <= led_state;
    end else counter <= counter + 1;
end

// logic for first 2 leds
assign ledOut[0] = ~(s[1] ^ s[0]);
assign ledOut[1] = ~(s[3] & s[4]);

//logic for seven segment display
logic [6:0] seg;
seg(s, seg);
assign sevseg = seg;

endmodule