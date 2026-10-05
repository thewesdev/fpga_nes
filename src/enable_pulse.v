module enable_pulse #(
    parameter integer CLK_DIVIDER = 12,
    parameter integer BIT_WIDTH = 4
) (
    input clk,
    output enable
);
    localparam integer MaxCount = CLK_DIVIDER - 1;

    reg [BIT_WIDTH-1:0] r_i = 8'd0;
    reg r_enable = 1'b0;

    assign enable = r_enable;

    always @(posedge clk) begin
        r_enable <= (r_i == MaxCount);
        r_i <= (r_i == MaxCount) ? 8'd0 : r_i + 8'd1;
    end
endmodule
