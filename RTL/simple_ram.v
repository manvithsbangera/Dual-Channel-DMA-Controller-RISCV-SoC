module ram (
    input clk,
    input mem_valid,
    output reg mem_ready,
    input [31:0] mem_addr,
    input [31:0] mem_wdata,
    output reg [31:0] mem_rdata,
    input [3:0] mem_wstrb
);

reg [31:0] memory [0:255];
integer i;

initial begin
    for (i = 0; i < 256; i = i + 1)
        memory[i] = i;
end

always @(posedge clk) begin
    mem_ready <= 0;

    if (mem_valid) begin
        mem_ready <= 1;

        if (mem_wstrb != 0) begin
            memory[mem_addr[9:2]] <= mem_wdata;
        end 
        else begin
            mem_rdata <= memory[mem_addr[9:2]];
        end
    end
end

endmodule