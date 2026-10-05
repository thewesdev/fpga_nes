`timescale 1ns / 1ps

module tb_ram;
    wire w_m_clk;
    wire w_phi2;
    wire w_sel;
    wire [10:0] w_addr_bus;
    wire [7:0] w_data_bus;
    wire w_rw;

    reg r_m_clk;
    reg r_phi2;
    reg r_sel;
    reg [10:0] r_addr_bus;
    reg [7:0] r_data_bus;
    reg [7:0] r_mem_drive_data;
    reg r_rw;

    assign w_m_clk = r_m_clk;
    assign w_phi2 = r_phi2;
    assign w_sel = r_sel;
    assign w_addr_bus = r_addr_bus;
    assign w_rw = r_rw;
    assign w_data_bus = !w_rw && !r_sel ? r_mem_drive_data : 8'hZZ;

    ram wram (
        .m_clk(w_m_clk),
        .phi2(w_phi2),
        .sel(w_sel),
        .addr_bus(w_addr_bus),
        .data_bus(w_data_bus),
        .rw(w_rw)
    );

    reg [2:0] r_c = 3'b000;

    initial begin
        r_m_clk = 0;
        r_phi2 = 0;

        forever begin
            #23.283 r_m_clk = !r_m_clk;

            if (r_m_clk == 1'b1) begin
                if (r_c == 5) r_phi2 = !r_phi2;
                r_c = (r_c == 5) ? 3'b000 : r_c + 1'b1;
            end
        end
    end

    initial begin
        $dumpfile("tb_ram.vcd");
        $dumpvars(0, tb_ram);

        r_sel = 1'b1;
        r_rw = 1'b1;
        r_addr_bus = 11'h000;
        r_mem_drive_data = 8'h00;

        @(posedge r_phi2);

        // T1: Write
        $display("[tb_ram] addr=0x0000 data=0x0010");
        r_sel = 1'b0;
        r_rw = 1'b0;
        r_mem_drive_data = 8'h10;

        @(posedge r_m_clk);
        #1;

        r_rw = 1'b1;

        #1;

        // T2: Read
        $display("[tb_ram] addr: 0x0000");

        if (w_data_bus == 8'h10) begin
            $display("[sucesso] data_bus = %h", w_data_bus);
        end
        else begin
            $display("[erro] esperado: 0x0010, obtido: %h", w_data_bus);
        end

        r_sel = 1'b1;

        $display("[tb_ram] fim");
        $finish;
    end
endmodule