module cpu (
    input wire m_clk,
    input wire rst,
    // input wire nmi,
    // input wire irq,

    output wire [15:0] addr_bus,
    output wire rw,
    // output wire aud0,
    // output wire aud1,

    inout wire [7:0] data_bus
);
    wire w_phi2_pulse;

    reg [15:0] r_addr_bus;
    reg r_rw;

    reg [15:0] r_pc;  // program counter
    reg [7:0] r_acc;  // accumulator
    reg [7:0] r_x;
    reg [7:0] r_y;
    reg [7:0] r_sp;  // stack pointer
    reg [7:0] r_p;  // status

    assign addr_bus = r_addr_bus;
    assign rw = r_rw;

    enable_pulse phi2_pulse (
        .clk(m_clk),
        .enable(w_phi2_pulse)
    );

    always @(posedge m_clk) begin
        if (rst && w_phi2_pulse) begin  // reset
            r_pc <= 16'hFFFC;
            r_addr_bus <= r_pc;
            r_sp <= 8'h00;
            r_p <= 8'h24;
        end

        if (!rst && w_phi2_pulse) begin  // running
            r_pc <= r_pc + 1'b1;
            r_addr_bus <= r_pc;
        end
    end
endmodule
