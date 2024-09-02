module led(
    input logic s[3:0]
    output logic led[1:0]
);
    assign led[0] = ~(s[1] ^ s[0])
    assign led[1] = ~(s[3] & s[2])
endmodule