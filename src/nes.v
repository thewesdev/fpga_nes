module nes (
    input wire CLK_24,

    output wire LED_RST,
    output wire LED_RUNNING,
    output wire LED_MASTER_CLK,
    output wire LED_CPU_CLK
);
    wire w_master_clk;
    wire w_locked_sync;
    wire w_pll_locked;
    wire w_rst;

    reg [1:0] r_lock_sync;
    reg [4:0] r_counter;
    reg r_rst;

    assign w_locked_sync = r_lock_sync[1];
    assign w_rst = r_rst;
    assign LED_RST = w_rst;
    assign LED_RUNNING = !w_rst;
    assign LED_MASTER_CLK = w_master_clk && !w_rst;

    pll pll (
        .clk(CLK_24),
        .master_clk(w_master_clk),
        .pll_locked(w_pll_locked)
    );

    always @(posedge w_master_clk or negedge w_pll_locked) begin
        if (!w_pll_locked) r_lock_sync <= 2'b00;
        else r_lock_sync <= {r_lock_sync[0], 1'b1};
    end

    always @(posedge w_master_clk or negedge w_locked_sync) begin
        if (!w_locked_sync) begin
            r_counter <= 5'd0;
            r_rst <= 1'b1;
        end
        else begin
            if (r_counter != 5'd21) begin
                r_counter <= r_counter + 5'd1;
            end

            r_rst <= r_counter != 5'd21;
        end
    end

    wire w_cpu_clk;
    wire [15:0] w_cpu_addr_bus;
    wire [7:0] w_cpu_data_bus;
    wire w_cpu_rw;

    assign LED_CPU_CLK = w_cpu_clk && !w_rst;

    rp2a03 cpu (
        .m_clk(w_master_clk),
        .rst(w_rst),

        .addr_bus(w_cpu_addr_bus),
        .phi2(w_cpu_clk),
        .rw(w_cpu_rw),

        .data_bus(w_cpu_data_bus)
    );

    mb8416a15sk wram (
        .m_clk(w_master_clk),
        .phi2(w_cpu_clk),
        .addr_bus(w_cpu_addr_bus),
        .data_bus(w_cpu_data_bus),
        .rw(w_cpu_rw)
    );
endmodule
