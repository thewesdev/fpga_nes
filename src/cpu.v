module rp2a03 (
    input wire m_clk,
    input wire rst,
    // input wire nmi,
    // input wire irq,

    output wire [15:0] addr_bus,
    output wire phi2,
    output wire rw,
    // output wire aud0,
    // output wire aud1,

    inout wire [7:0] data_bus
);
    wire w_cpu_clk_enable;
    wire [15:0] w_addr_bus;
    wire w_rw;

    reg r_cpu_clk_enable;
    reg [15:0] r_addr_bus;
    reg r_rw;

    reg [15:0] r_pc;  // program counter
    reg [7:0] r_acc;  // accumulator
    reg [7:0] r_x;
    reg [7:0] r_y;
    reg [7:0] r_sp;  // stack pointer
    reg [7:0] r_p;  // status

    assign w_cpu_clk_enable = r_cpu_clk_enable;
    assign w_addr_bus = r_addr_bus;
    assign w_rw = r_rw;

    assign addr_bus = w_addr_bus;
    assign phi2 = w_cpu_clk_enable;
    assign rw = w_rw;

    reg [3:0] r_i;

    always @(posedge m_clk) begin
        r_cpu_clk_enable <= (r_i == 4'd11);
        r_i <= (r_i == 4'd11) ? 4'd0 : r_i + 4'd1;

        if (rst && w_cpu_clk_enable) begin  // reset
            r_pc <= 16'hFFFC;
            r_addr_bus <= r_pc;
            r_sp <= 8'h00;
            r_p <= 8'h24;
        end

        if (!rst && w_cpu_clk_enable) begin  // running
            r_pc <= r_pc + 1'b1;
            r_addr_bus <= r_pc;
        end
    end
endmodule