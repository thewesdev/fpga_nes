module sn74ls139n (
    input wire en,  // pull up
    input wire [1:0] s,
    output wire [3:0] y
);
    reg [3:0] r_y;

    assign y = r_y;

    always @(*) begin
        case (s)
            2'b00: r_y = en ? 4'b1111 : 4'b1110;
            2'b01: r_y = en ? 4'b1111 : 4'b1101;
            2'b10: r_y = en ? 4'b1111 : 4'b1011;
            2'b11: r_y = en ? 4'b1111 : 4'b0111;
            default: r_y = en ? 4'b1111 : 4'b0000;
        endcase
    end
endmodule
