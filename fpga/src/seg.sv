module seg(
    input logic s[3:0]
    output logic seg[6:0]
);
    case(s)
        4b'0000: assign seg = 7b'0000001
        4b'0001: assign seg = 7b'1001111
        4b'0010: assign seg = 7b'0010010
        4b'0011: assign seg = 7b'0000110
        4b'0100: assign seg = 7b'1001100
        4b'0101: assign seg = 7b'0100100
        4b'0110: assign seg = 7b'0100000
        4b'0111: assign seg = 7b'0001111
        4b'1000: assign seg = 7b'0000000
        4b'1001: assign seg = 7b'0001100
        4b'1010: assign seg = 7b'0000010
        4b'1011: assign seg = 7b'1100000
        4b'1100: assign seg = 7b'0110001
        4b'1101: assign seg = 7b'1000010
        4b'1110: assign seg = 7b'0110000
        4b'1111: assign seg = 7b'0111000
        default : assign seg = 7b'1111111
    endcase
endmodule
