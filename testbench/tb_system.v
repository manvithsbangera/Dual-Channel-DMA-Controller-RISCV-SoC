`timescale 1ns/1ps

module tb_system;

reg clk;
reg rst;

// Instantiate DUT
system_top uut (
    .clk(clk),
    .rst(rst)
);


// ================= CLOCK =================
initial begin
    clk = 0;
    forever #5 clk = ~clk;   // 10ns clock period
end


// ================= RESET =================
initial begin
    rst = 1;
    #20;
    rst = 0;
end


// ================= SIMULATION CONTROL =================
initial begin
    #1000;   // run long enough for DMA to complete
    $finish;
end


// ================= OPTIONAL MONITOR =================
initial begin
    $monitor("TIME=%0t | addr=%h | wdata=%h | rdata=%h | valid=%b | ready=%b",
        $time,
        uut.mem_addr,
        uut.mem_wdata,
        uut.mem_rdata,
        uut.mem_valid,
        uut.mem_ready
    );
end

endmodule