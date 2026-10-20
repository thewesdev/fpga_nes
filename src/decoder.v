module decoder (
    input [2:0] s,
    output [9:0] y
);
    `include "decoder_defs.vh"

    wire [3:0] w_y;

    nes_decoder nes_decoder (
        .en(1'b0),
        .s(s[1:0]),
        .y(w_y)
    );

    assign y[SelRam] = w_y[0] || s[2];
    assign y[SelPpu] = w_y[1] || s[2];
    assign y[SelApuIo] = w_y[2] || s[2];
    assign y[SelCartrigdeRam] = w_y[3] || s[2];
    assign y[SelCartridgeRom0] = w_y[0] || ~s[2];
    assign y[SelCartridgeRom1] = w_y[1] || ~s[2];
    assign y[SelCartridgeRom2] = w_y[2] || ~s[2];
    assign y[SelCartridgeRom3] = w_y[3] || ~s[2];
    assign y[SelBank0] = y[SelCartridgeRom0] && y[SelCartridgeRom1];
    assign y[SelBank1] = y[SelCartridgeRom2] && y[SelCartridgeRom3];
endmodule
