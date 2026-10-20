module sram (
    input wire rw,
    input wire [15:0] addr,
    input wire [7:0] idata,

    inout wire [7:0] SRAM_DATA,

    output wire [7:0] odata,
    output wire [15:0] SRAM_ADDR,
    output wire SRAM_CE,
    output wire SRAM_LB,
    output wire SRAM_WE,
    output wire SRAM_OE
);
    assign SRAM_CE = 1'b0;
    assign SRAM_LB = 1'b0;
    assign SRAM_WE = rw;
    assign SRAM_OE = !rw;
    assign SRAM_ADDR = addr;

    assign SRAM_DATA = !SRAM_WE ? idata : 8'hZZ;
    assign odata = SRAM_DATA;
endmodule