module address_decoder (
    input [31:0] addr,
    output sel_ram,
    output sel_dma,
    output sel_periph
);

    assign sel_ram     = (addr < 32'h00001000);
    assign sel_dma     = (addr >= 32'h00001000 && addr < 32'h00001100);
    assign sel_periph  = (addr >= 32'h00002000 && addr < 32'h00002100);

endmodule