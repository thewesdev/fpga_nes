module clock_stabilizer #(
    parameter integer RESET_CYCLES = 21
) (
    input wire clk,
    input wire pll_locked,
    output wire rst
);
    wire w_locked_sync;

    reg [1:0] r_lock_sync;
    reg [4:0] r_counter;
    reg r_rst;

    assign w_locked_sync = r_lock_sync[1];

    assign rst = r_rst;

    always @(posedge clk or negedge pll_locked) begin
        if (!pll_locked) r_lock_sync <= 2'b00;
        else r_lock_sync <= {r_lock_sync[0], 1'b1};
    end

    always @(posedge clk or negedge w_locked_sync) begin
        if (!w_locked_sync) begin
            r_counter <= 5'd0;
            r_rst <= 1'b1;
        end
        else begin
            if (r_counter != RESET_CYCLES) begin
                r_counter <= r_counter + 1'b1;
            end

            r_rst <= r_counter != RESET_CYCLES;
        end
    end
endmodule
