`timescale 1ns / 1ps

module tb_ram;
    wire w_m_clk;
    wire w_sel;
    wire [10:0] w_addr_bus;
    wire [7:0] w_data_bus;
    wire w_rw;

    reg r_m_clk;
    reg r_sel;
    reg [10:0] r_addr_bus;
    reg [7:0] r_data_bus;
    reg [7:0] r_mem_drive_data;
    reg r_rw;

    assign w_m_clk = r_m_clk;
    assign w_sel = r_sel;
    assign w_addr_bus = r_addr_bus;
    assign w_rw = r_rw;
    assign w_data_bus = !w_rw && !r_sel ? r_mem_drive_data : 8'hZZ;

    ram wram (
        .m_clk(w_m_clk),
        .sel(w_sel),
        .addr_bus(w_addr_bus),
        .data_bus(w_data_bus),
        .rw(w_rw)
    );

    initial begin
        r_m_clk = 0;

        forever #23.283 r_m_clk = !r_m_clk;
    end

    initial begin
        $dumpfile("tb_ram.vcd");
        $dumpvars(0, tb_ram);

        r_sel = 1'b1;
        r_rw = 1'b1;
        r_addr_bus = 11'h000;
        r_mem_drive_data = 8'h00;

        repeat (12) @(posedge r_m_clk);
        // T1: Write
        $display("[tb_ram] addr=0x0000 data=0x0010");
        r_sel = 1'b0;
        r_rw = 1'b0;
        r_mem_drive_data = 8'h10;

        repeat (12) @(posedge r_m_clk);

        r_rw = 1'b1;

        #1;

        // T2: Read
        $display("[tb_ram] addr: 0x0000");

        if (w_data_bus == 8'h10) begin
            $display("[sucesso] data_bus = %h", w_data_bus);
        end
        else begin
            $fatal(1, "[erro] esperado: 0x0010, obtido: %h", w_data_bus);
        end

        r_sel = 1'b1;

        $display("[tb_ram] fim");
        $finish;
    end
endmodule
