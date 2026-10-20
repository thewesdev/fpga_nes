`timescale 1ns / 1ps

module tb_sram;
    wire w_rw;
    wire [15:0] w_addr;
    wire [7:0] w_idata;
    wire [7:0] w_odata;

    reg r_rw;
    reg [15:0] r_addr;
    reg [7:0] r_idata;
    reg [7:0] mem [0:65535];

    assign w_rw = r_rw;
    assign w_addr = r_addr;
    assign w_idata = r_idata;

    wire [7:0] SRAM_DATA;
    wire [15:0] SRAM_ADDR;
    wire SRAM_CE;
    wire SRAM_LB;
    wire SRAM_WE;
    wire SRAM_OE;

    sram sram (
        .rw(w_rw),
        .addr(w_addr),
        .idata(w_idata),
        .odata(w_odata),
        .SRAM_DATA(SRAM_DATA),
        .SRAM_ADDR(SRAM_ADDR),
        .SRAM_CE(SRAM_CE),
        .SRAM_LB(SRAM_LB),
        .SRAM_WE(SRAM_WE),
        .SRAM_OE(SRAM_OE)
    );

    assign SRAM_DATA = (!SRAM_CE && !SRAM_OE)
        ? mem[SRAM_ADDR] : 8'hZZ;

    always @(*) begin
        if (!SRAM_CE && !SRAM_WE) mem[SRAM_ADDR] = SRAM_DATA;
    end

    initial begin
        $dumpfile("tb_sram.vcd");
        $dumpvars(0, tb_sram);

        r_addr = 16'h0000;
        r_idata = 8'h00;
        r_rw = 1'b1;

        #1;

        // T1: SRAM CE
        if (!SRAM_CE) begin
            $display("[tb_sram] sucesso: chip sram ativado");
        end
        else begin
            $fatal(1, "[tb_sram] falha: chip sram desativado");
        end

        // T2: SRAM LB
        if (!SRAM_LB) begin
            $display("[tb_sram] sucesso: low byte ativado");
        end
        else begin
            $fatal(1, "[tb_sram] falha: low byte desativado");
        end

        // T3: Escrita
        r_addr = 16'h0000;
        r_idata = 8'h01;
        #1;
        r_rw = 1'b0;
        #1;
        r_rw = 1'b1;
        #1;

        $display("[tb_sram] Escrita 1: rw = %h, addr = %h, data = %h", w_rw, w_addr, w_idata);

        r_addr = 16'h0001;
        r_idata = 8'h02;
        #1;
        r_rw = 1'b0;
        #1;
        r_rw = 1'b1;
        #1;

        $display("[tb_sram] Escrita 2: rw = %h, addr = %h, data = %h", w_rw, w_addr, w_idata);

        r_addr = 16'h0002;
        r_idata = 8'h03;
        #1;
        r_rw = 1'b0;
        #1;
        r_rw = 1'b1;
        #1;

        $display("[tb_sram] Escrita 3: rw = %h, addr = %h, data = %h", w_rw, w_addr, w_idata);

        // T4: Leitura
        r_addr = 16'h0000;
        #1;
        r_rw = 1;
        #1;

        if (SRAM_DATA == 8'h01) begin
            $display("[tb_sram] sucesso: data_bus = %h", SRAM_DATA);
        end
        else begin
            $fatal(1, "[tb_sram] falha: data_bus = %h, esperado = %h", SRAM_DATA, 8'h01);
        end

        r_addr = 16'h0001;
        #1;
        r_rw = 1'b1;
        #1;

        if (SRAM_DATA == 8'h02) begin
            $display("[tb_sram] sucesso: data_bus = %h", SRAM_DATA);
        end
        else begin
            $fatal(1, "[tb_sram] falha: data_bus = %h, esperado = %h", SRAM_DATA, 8'h02);
        end

        r_addr = 16'h0002;
        #1;
        r_rw = 1'b1;
        #1;

        if (SRAM_DATA == 8'h03) begin
            $display("[tb_sram] sucesso: data_bus = %h", SRAM_DATA);
        end
        else begin
            $fatal(1, "[tb_sram] falha: data_bus = %h, esperado = %h", SRAM_DATA, 8'h03);
        end

        $display("[tb_sram] fim");
        $finish;
    end
endmodule