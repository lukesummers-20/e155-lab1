// Luke Summers lsummers@g.hmc.edu 9/5/24
// combinational logic for a UA5651-11EWRS seven segment display
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