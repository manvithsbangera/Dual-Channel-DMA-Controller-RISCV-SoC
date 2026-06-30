module arbiter (
    input clk,
    input rst,

    // CPU request
    input cpu_valid,
    output reg cpu_grant,

    // DMA request
    input dma_valid,
    output reg dma_grant
);

    always @(*) begin
        if (dma_valid) begin
            dma_grant = 1;
            cpu_grant = 0;
        end else begin
            dma_grant = 0;
            cpu_grant = 1;
        end
    end

endmodule