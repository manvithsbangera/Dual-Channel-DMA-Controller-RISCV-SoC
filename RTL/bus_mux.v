module bus_mux (
    input cpu_grant,
    input dma_grant,

    // CPU side
    input cpu_valid,
    input [31:0] cpu_addr,
    input [31:0] cpu_wdata,
    input [3:0] cpu_wstrb,

    // DMA side
    input dma_valid,
    input [31:0] dma_addr,
    input [31:0] dma_wdata,
    input [3:0] dma_wstrb,

    // Shared bus
    output mem_valid,
    output [31:0] mem_addr,
    output [31:0] mem_wdata,
    output [3:0] mem_wstrb
);

    assign mem_valid = dma_grant ? dma_valid : cpu_valid;
    assign mem_addr  = dma_grant ? dma_addr  : cpu_addr;
    assign mem_wdata = dma_grant ? dma_wdata : cpu_wdata;
    assign mem_wstrb = dma_grant ? dma_wstrb : cpu_wstrb;

endmodule