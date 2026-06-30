module dma_controller (
    input  clk,
    input  rst,          // active HIGH reset

    input  start0,
    input  start1,

    // Bus interface (to system)
    output reg         mem_valid,
    input              mem_ready,
    output reg [31:0]  mem_addr,
    output reg [31:0]  mem_wdata,
    output reg [3:0]   mem_wstrb
);

    // ============================================================
    // Channel internal signals
    // ============================================================
    wire ch0_valid, ch1_valid;
    wire [31:0] ch0_addr, ch1_addr;
    wire ch0_we, ch1_we;
    wire ch0_done, ch1_done;

    reg ch0_ready, ch1_ready;

    // ============================================================
    // Channel 0
    // ============================================================
    dma_channel ch0 (
        .clk       (clk),
        .rst_n     (~rst),        // convert to active LOW
        .start     (start0),
        .mem_ready (ch0_ready),
        .size      (8'd16),

        .mem_valid (ch0_valid),
        .mem_we    (ch0_we),
        .done      (ch0_done),
        .active    (),            // unused
        .addr      (ch0_addr)
    );

    // ============================================================
    // Channel 1
    // ============================================================
    dma_channel ch1 (
        .clk       (clk),
        .rst_n     (~rst),
        .start     (start1),
        .mem_ready (ch1_ready),
        .size      (8'd16),

        .mem_valid (ch1_valid),
        .mem_we    (ch1_we),
        .done      (ch1_done),
        .active    (),
        .addr      (ch1_addr)
    );

    // ============================================================
    // Simple Priority Arbiter (ch0 > ch1)
    // ============================================================
    always @(*) begin
        // defaults
        mem_valid = 0;
        mem_addr  = 0;
        mem_wdata = 0;
        mem_wstrb = 0;

        ch0_ready = 0;
        ch1_ready = 0;

        // -------------------------------
        // Channel 0 has priority
        // -------------------------------
        if (ch0_valid) begin
            mem_valid = 1;
            mem_addr  = ch0_addr;
            mem_wdata = 32'hA5A5A5A5;      // dummy write data
            mem_wstrb = {4{ch0_we}};       // write enable

            ch0_ready = mem_ready;
        end 

        // -------------------------------
        // Channel 1 (only if ch0 idle)
        // -------------------------------
        else if (ch1_valid) begin
            mem_valid = 1;
            mem_addr  = ch1_addr;
            mem_wdata = 32'h5A5A5A5A;      // dummy write data
            mem_wstrb = {4{ch1_we}};

            ch1_ready = mem_ready;
        end
    end

endmodule