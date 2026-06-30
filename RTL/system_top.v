module system_top (
    input clk,
    input rst
);

wire mem_valid;
wire mem_ready;
wire [31:0] mem_addr;
wire [31:0] mem_wdata;
wire [31:0] mem_rdata;
wire [3:0] mem_wstrb;

// ?? TEMP (for now keep it simple)
wire start0 = 1'b1;
wire start1 = 1'b0;   // only one channel for now

// =====================================================
// DMA Controller
// =====================================================
dma_controller u_dma (
    .clk(clk),
    .rst(rst),
    .start0(start0),
    .start1(start1),
    .mem_valid(mem_valid),
    .mem_ready(mem_ready),
    .mem_addr(mem_addr),
    .mem_wdata(mem_wdata),
    .mem_wstrb(mem_wstrb)
);

// =====================================================
// RAM (FIXED MODULE NAME)
// =====================================================
ram u_ram (   // ? NOT simple_ram
    .clk(clk),
    .mem_valid(mem_valid),
    .mem_ready(mem_ready),
    .mem_addr(mem_addr),
    .mem_wdata(mem_wdata),
    .mem_rdata(mem_rdata),
    .mem_wstrb(mem_wstrb)
);

endmodule