module bus_demux (
    input dma_grant,

    input mem_ready,
    input [31:0] mem_rdata,

    output cpu_ready,
    output [31:0] cpu_rdata,

    output dma_ready,
    output [31:0] dma_rdata
);

    assign cpu_ready = !dma_grant && mem_ready;
    assign cpu_rdata = mem_rdata;

    assign dma_ready = dma_grant && mem_ready;
    assign dma_rdata = mem_rdata;

endmodule