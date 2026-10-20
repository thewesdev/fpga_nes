module decoder (
    input [3:0] s,
    output [9:0] y
);
    `include "decoder_defs.vh"

    wire [3:0] w_y;

    nes_decoder nes_decoder (
        .en(1'b0),
        .s(cpu_addr_bus[14:13]),
        .y(w_y)
    );

    assign sel[SelRam] = w_y[0] || cpu_addr_msb;
    assign sel[SelPpu] = w_y[1] || cpu_addr_msb;
    assign sel[SelApuIo] = w_y[2] || cpu_addr_msb;
    assign sel[SelCartrigdeRam] = w_y[3] || cpu_addr_msb;
    assign sel[SelCartridgeRom0] = w_y[0] || ~cpu_addr_msb;
    assign sel[SelCartridgeRom1] = w_y[1] || ~cpu_addr_msb;
    assign sel[SelCartridgeRom2] = w_y[2] || ~cpu_addr_msb;
    assign sel[SelCartridgeRom3] = w_y[3] || ~cpu_addr_msb;
    assign sel[SelBank0] = w_sel_cartridge_rom0 && sel_cartridge_rom1;
    assign sel[SelBank1] = w_sel_cartridge_rom2 && sel_cartridge_rom3;
endmodule
