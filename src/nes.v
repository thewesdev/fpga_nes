module nes (
    input wire CLK_27,

    output wire LED_RST,
    output wire LED_RUNNING
);
    wire w_master_clk;
    wire w_pll_locked;
    wire w_rst;

    reg [1:0] r_rst;

    assign w_rst = r_rst[1];
    assign LED_RST = w_rst;
    assign LED_RUNNING = !w_rst;

    pll pll (
        .clk(CLK_27),
        .master_clk(w_master_clk),
        .pll_locked(w_pll_locked)
    );

    always @(posedge w_master_clk or negedge w_pll_locked) begin
        if (!w_pll_locked) r_rst <= 2'b11;
        else r_rst <= {r_rst[0], 1'b0};
    end
endmodule
