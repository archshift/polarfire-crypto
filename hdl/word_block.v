/// FIFO adapter to transform 4 consecutive 32-bit words into 1 128-bit block.
/// Maximum throughput: 1 32-bit word per cycle, or 1 block per 4 cycles.
module words_block(
    input clk,
    input rst,
    
    input word_valid,
    output reg word_ready,
    input [31:0] word,
    
    input block_ready,
    output reg block_valid,
    output [127:0] block,
    
    output reg empty
);

reg [1:0] idx, next_idx;
reg next_block_valid;
reg block_ren, block_wen, block0_wen, block1_wen, block2_wen, block3_wen;
reg [31:0] block0, block1, block2, block3;
assign block = {block3, block2, block1, block0};

always @* begin
    block_ren = block_ready & block_valid;
    word_ready = !block_valid | block_ren;
    block_wen = word_valid & word_ready;
    block0_wen = block_wen & (idx == 0);
    block1_wen = block_wen & (idx == 1);
    block2_wen = block_wen & (idx == 2);
    block3_wen = block_wen & (idx == 3);
    empty = !block_valid & idx == 0;
  
    next_idx = idx + 1;
    next_block_valid = idx == 2'b11;
end

 always @(posedge clk or posedge rst) begin
    if (rst) begin
        idx <= 0;
        block_valid <= 0;
    end
    else begin
        if (block_wen) idx <= next_idx;
        if (block_wen) block_valid <= next_block_valid;
        else if (block_ren) block_valid <= 0;
        
        if (block0_wen) block0 <= word;
        if (block1_wen) block1 <= word;
        if (block2_wen) block2 <= word;
        if (block3_wen) block3 <= word;
    end
end

endmodule


/// FIFO adapter to transform 1 128-bit word into 4 consecutive 32-bit words.
module block_words(
    input clk,
    input rst,
    
    output reg word_valid,
    input reg word_ready,
    output reg [31:0] word,
    
    output reg block_ready,
    input block_valid,
    input [127:0] block,
    
    output empty
);

reg [1:0] idx, next_idx;
reg [127:0] block_stored;
reg word_ren, block_wen;
wire [31:0] block0, block1, block2, block3;
assign {block3, block2, block1, block0} = block_stored;

assign empty = !word_valid;

always @* begin
    next_idx = idx + 1;
    word_ren = word_valid & word_ready;
    block_ready = ((idx == 2'd3) & word_ren) | empty;
    block_wen = block_valid & block_ready;
    
    case (idx)
    2'd0 : word = block0;
    2'd1 : word = block1;
    2'd2 : word = block2;
    2'd3 : word = block3;
    endcase
end

 always @(posedge clk or posedge rst) begin
    if (rst) begin
        idx <= 0;
        word_valid <= 0;
    end
    else begin
        if (block_wen) begin
            word_valid <= 1;
            block_stored <= block;
            idx <= 0;
        end
        else if (word_ren) begin
            word_valid <= idx != 2'd3;
            idx <= next_idx;
        end
    end
end

endmodule
