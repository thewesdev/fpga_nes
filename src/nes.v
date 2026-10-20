module nes (
    input wire CLK_24,

    output wire LED_RST,
    output wire LED_RUNNING,
    output wire LED_MASTER_CLK,

    output wire [17:0] SRAM_ADDR,
    inout wire [15:0] SRAM_DQ,
    output wire SRAM_WE_N,
    output wire SRAM_OE_N,
    output wire SRAM_CE_N,
    output wire SRAM_LB_N,
    output wire SRAM_UB_N
);
    `include "decoder_defs.vh"

    wire w_master_clk;
    wire w_pll_locked;
    wire w_rst;

    assign LED_RST = w_rst;
    assign LED_RUNNING = !w_rst;
    assign LED_MASTER_CLK = w_master_clk && !w_rst;

    pll pll (
        .clk(CLK_24),
        .master_clk(w_master_clk),
        .pll_locked(w_pll_locked)
    );

    clock_stabilizer clk_stab (
        .clk(w_master_clk),
        .pll_locked(w_pll_locked),
        .rst(w_rst)
    );

    wire [15:0] w_cpu_addr_bus;
    wire [7:0] w_cpu_data_bus;
    wire w_cpu_rw;

    cpu cpu (
        .m_clk(w_master_clk),
        .rst(w_rst),

        .addr_bus(w_cpu_addr_bus),
        .rw(w_cpu_rw),

        .data_bus(w_cpu_data_bus)
    );

    wire [9:0] w_sel;

    decoder decoder (
        .cpu_addr_msb(w_cpu_addr_bus[15]),
        .sel(w_sel)
    );
endmodule
