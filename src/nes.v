module nes (
    input wire CLK_24,

    output wire LED_RST,
    output wire LED_RUNNING,
    output wire LED_MASTER_CLK
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

    wire [3:0] w_y;

    wire w_sel_ram;
    // wire w_sel_ppu;
    // wire w_sel_apu_io;
    // wire w_sel_cartridge_ram;
    // wire w_sel_cartridge_rom0;
    // wire w_sel_cartridge_rom1;
    // wire w_sel_cartridge_rom2;
    // wire w_sel_cartridge_rom3;
    // wire w_sel_bank0;
    // wire w_sel_bank1;

    assign w_sel_ram = w_y[0] || w_cpu_addr_bus[15];
    // assign w_sel_ppu = w_y[1] || w_cpu_addr_bus[15];
    // assign w_sel_apu_io = w_y[2] || w_cpu_addr_bus[15];
    // assign w_sel_cartridge_ram = w_y[3] || w_cpu_addr_bus[15];
    // assign w_sel_cartridge_rom0 = w_y[0] || ~w_cpu_addr_bus[15];
    // assign w_sel_cartridge_rom1 = w_y[1] || ~w_cpu_addr_bus[15];
    // assign w_sel_cartridge_rom2 = w_y[2] || ~w_cpu_addr_bus[15];
    // assign w_sel_cartridge_rom3 = w_y[3] || ~w_cpu_addr_bus[15];
    // assign w_sel_bank0 = w_sel_cartridge_rom0 && w_sel_cartridge_rom1;
    // assign w_sel_bank1 = w_sel_cartridge_rom2 && w_sel_cartridge_rom3;

    decoder decoder (
        .en(1'b0),
        .s(w_cpu_addr_bus[14:13]),
        .y(w_y)
    );

    ram wram (
        .m_clk(w_master_clk),
        .sel(w_sel_ram),
        .addr_bus(w_cpu_addr_bus),
        .data_bus(w_cpu_data_bus),
        .rw(w_cpu_rw)
    );
endmodule
