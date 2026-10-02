module pll (
    input wire clk,
    output wire master_clk,
    output wire pll_locked
);
    wire [5:0] clk_bus;

    assign master_clk = clk_bus[0];

    altpll #(
        .OPERATION_MODE("NORMAL"),
        .INTENDED_DEVICE_FAMILY("Cyclone II"),
        .INCLK0_INPUT_FREQUENCY(27000),
        .CLK0_MULTIPLY_BY(35),
        .CLK0_DIVIDE_BY(44),
        .COMPENSATE_CLOCK("CLK0"),
        .PORT_LOCKED("PORT_USED")
    ) pll (
        .inclk({1'b0, clk}),
        .clk(clk_bus),
        .areset(1'b0),
        .locked(pll_locked)
    );
endmodule