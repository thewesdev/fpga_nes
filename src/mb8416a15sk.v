module mb8416a15sk (
    input wire m_clk,
    input wire phi2,
    input wire sel,
    input wire [15:0] addr_bus,
    inout wire [7:0] data_bus,
    input wire rw
);
    reg [7:0] mem[0:2047];

    reg [7:0] r_odata;

    assign data_bus = (rw && phi2 && !sel) ? r_odata : 8'hZZ;

    always @(posedge m_clk) begin
        if (phi2 && !sel) begin
            if (!rw) mem[addr_bus[10:0]] <= data_bus;
            else r_odata <= mem[addr_bus[10:0]];
        end
    end
endmodule
