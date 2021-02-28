/// FIFO adapter to transform 4 consecutive LE 32-bit words into 1 BE 128-bit block.
/// Maximum throughput: 1 32-bit word per cycle, or 1 block per 4 cycles.
module be_block_builder(
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
wire [31:0] word_be = {word[7:0], word[15:8], word[23:16], word[31:24]};
assign block = {block3, block2, block1, block0};

always @* begin
    block_ren = block_ready & block_valid;
    word_ready = !block_valid | block_ren;
    block_wen = word_valid & word_ready;
    // Reverse the word order to accomodate how the AES block expects
    block0_wen = block_wen & (idx == 3);
    block1_wen = block_wen & (idx == 2);
    block2_wen = block_wen & (idx == 1);
    block3_wen = block_wen & (idx == 0);
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
        
        if (block0_wen) block0 <= word_be;
        if (block1_wen) block1 <= word_be;
        if (block2_wen) block2 <= word_be;
        if (block3_wen) block3 <= word_be;
    end
end

endmodule


/// FIFO adapter to transform 1 BE 128-bit word into 4 consecutive LE 32-bit words.
module be_block_splitter(
    input clk,
    input rst,
    
    output reg word_valid,
    input word_ready,
    output [31:0] word,
    
    output reg block_ready,
    input block_valid,
    input [127:0] block,
    
    output empty
);

reg [1:0] idx, next_idx;
reg [127:0] block_stored;
reg word_ren, block_wen;
wire [31:0] block0, block1, block2, block3;
reg [31:0] word_be;
assign {block3, block2, block1, block0} = block_stored;
assign word = {word_be[7:0], word_be[15:8], word_be[23:16], word_be[31:24]};

assign empty = !word_valid;

always @* begin
    next_idx = idx + 1;
    word_ren = word_valid & word_ready;
    block_ready = ((idx == 2'd3) & word_ren) | empty;
    block_wen = block_valid & block_ready;
    
    // Reverse the word order to accomodate how the AES block expects
    case (idx)
    2'd3 : word_be = block0;
    2'd2 : word_be = block1;
    2'd1 : word_be = block2;
    2'd0 : word_be = block3;
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
