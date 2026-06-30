module dma_channel (
    input  clk,
    input  rst_n,
    input  start,
    input  mem_ready,
    input  [7:0] size,

    output reg mem_valid,
    output reg mem_we,
    output reg done,
    output reg active,
    output reg [31:0]addr
);

// ? declarations
reg [1:0] state;
reg [7:0] count;

localparam IDLE  = 2'd0,
           READ  = 2'd1,
           WRITE = 2'd2,
           DONE  = 2'd3;

// ? FSM
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state     <= IDLE;
        count     <= 0;
        done      <= 0;
        active    <= 0;
        mem_valid <= 0;
        mem_we    <= 0;
        addr <= 0;
    end else begin
        case (state)

        IDLE: begin
            done      <= 0;
            active    <= 0;
            mem_valid <= 0;

            if (start) begin
                count  <= size;
                active <= 1;
                addr <= 0;
                state  <= READ;
            end
        end

        READ: begin
            mem_valid <= 1;
            mem_we    <= 0;

            if (mem_ready) begin
                mem_valid <= 0;
                state     <= WRITE;
            end
        end

        WRITE: begin
            mem_valid <= 1;
            mem_we    <= 1;
        
            if (mem_ready) begin
                mem_valid <= 0;
        
                addr <= addr + 4;   // ? increment HERE
        
                if (count == 1) begin
                    state <= DONE;
                end else begin
                    count <= count - 1;
                    state <= READ;
                end
            end
        end

        DONE: begin
            done   <= 1;
            active <= 0;
            state  <= IDLE;
        end

        endcase
    end
end

endmodule