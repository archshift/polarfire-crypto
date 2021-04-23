/// FIFO adapter to transform 2 consecutive LE 64-bit words into 1 BE 128-bit block.
/// Maximum throughput: 1 64-bit word per cycle, or 1 block per 2 cycles.
module be_block_builder(
    input clk,
    input rst,
    
    input word_valid,
    output reg word_ready,
    input [63:0] word,
    
    input block_ready,
    output reg block_valid,
    output [127:0] block,
    
    output reg [1:0] state,
    output reg empty
);

reg block0_wen, block1_wen;
reg [63:0] block0, block1;
wire [63:0] word_be = {word[7:0], word[15:8], word[23:16], word[31:24], word[39:32], word[47:40], word[55:48], word[63:56]};
assign block = {block0, block1};

reg [1:0] next_state;
`define BUILD_EMPTY 2'h0
`define BUILD_HAS_W1 2'h1
`define BUILD_HAS_W2 2'h2

always @* begin
    word_ready = 0;
    block_valid = 0;
    block0_wen = 0;
    block1_wen = 0;
    empty = 0;
    next_state = state;

    case (state)
        `BUILD_EMPTY : begin
            word_ready = 1;
            empty = 1;
            block0_wen = word_ready & word_valid;
            if (block0_wen)
                next_state = `BUILD_HAS_W1;
        end
        `BUILD_HAS_W1 : begin
            word_ready = 1;
            block1_wen = word_ready & word_valid;
            if (block1_wen)
                next_state = `BUILD_HAS_W2;
        end
        `BUILD_HAS_W2 : begin
            block_valid = 1;
            word_ready = block_ready & block_valid;
            block0_wen = word_ready & word_valid;
            if (block_ready & block_valid)
                if (block0_wen)
                    next_state = `BUILD_HAS_W1;
                else
                    next_state = `BUILD_EMPTY;
        end
    endcase
end

always @(posedge clk) begin
    if (rst) begin
        state <= 0;
        block0 <= 0;
        block1 <= 0;
    end
    else begin
        state <= next_state;
        if (block0_wen)
            block0 <= word_be;
        if (block1_wen)
            block1 <= word_be;
    end
end

endmodule


/// FIFO adapter to transform 1 BE 128-bit word into 2 consecutive LE 64-bit words.
module be_block_splitter(
    input clk,
    input rst,
    
    output reg word_valid,
    input word_ready,
    output [63:0] word,
    
    output reg block_ready,
    input block_valid,
    input [127:0] block,
    
    output reg [1:0] state,
    output reg empty
);

reg block_wen;
reg [127:0] block_stored;
wire [63:0] block0, block1;
assign {block1, block0} = block_stored;
reg [63:0] word_be;
assign word = {word_be[7:0], word_be[15:8], word_be[23:16], word_be[31:24], word_be[39:32], word_be[47:40], word_be[55:48], word_be[63:56]};

reg [1:0] next_state;
`define SPLIT_AWAIT_BLOCK 2'h0
`define SPLIT_W0 2'h1
`define SPLIT_W1 2'h2

always @* begin
    word_valid = 0;
    block_ready = 0;
    empty = 0;
    block_wen = 0;
    next_state = state;
    word_be = 0;

    case (state)
        `SPLIT_AWAIT_BLOCK : begin
            empty = 1;
            word_valid = 0;
            block_ready = 1;
            block_wen = block_valid & block_ready;
            if (block_wen)
                next_state = `SPLIT_W0;
        end
        // Reverse the word order to accomodate how the AES block expects
        `SPLIT_W0 : begin
            word_be = block1;
            word_valid = 1;
            block_ready = 0;

            if (word_valid & word_ready)
                next_state = `SPLIT_W1;
        end
        `SPLIT_W1 : begin
            word_be = block0;
            word_valid = 1;
            block_ready = word_valid & word_ready;
            block_wen = block_valid & block_ready;

            if (word_valid & word_ready)
                if (block_wen)
                    next_state = `SPLIT_W0;
                else
                    next_state = `SPLIT_AWAIT_BLOCK;
        end
    endcase
end

 always @(posedge clk) begin
    if (rst) begin
        state <= 0;
        block_stored <= 0;
    end
    else begin
        state <= next_state;
        if (block_wen)
            block_stored <= block;
    end
end

endmodule
