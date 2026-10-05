module ram (
    input wire m_clk,
    input wire sel,
    input wire [10:0] addr_bus,
    inout wire [7:0] data_bus,
    input wire rw
);
    wire w_phi2_pulse;
    reg [7:0] mem[0:2047];

    assign data_bus = (rw && w_phi2_pulse && !sel) ? mem[addr_bus[10:0]] : 8'hZZ;

    enable_pulse phi2_pulse (
        .clk(m_clk),
        .enable(w_phi2_pulse)
    );

    always @(posedge m_clk) begin
        if (!rw && w_phi2_pulse && !sel) mem[addr_bus[10:0]] <= data_bus;
    end
endmodule
