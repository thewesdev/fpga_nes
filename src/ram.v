module ram (
    input wire m_clk,
    input wire phi2,
    input wire sel,
    input wire [10:0] addr_bus,
    inout wire [7:0] data_bus,
    input wire rw
);
    reg [7:0] mem[0:2047];

    assign data_bus = (rw && phi2 && !sel) ? mem[addr_bus[10:0]] : 8'hZZ;

    always @(posedge m_clk) begin
        if (!rw && phi2 && !sel) mem[addr_bus[10:0]] <= data_bus;
    end
endmodule
