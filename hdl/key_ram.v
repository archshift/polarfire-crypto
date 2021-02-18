module key_ram #(
    parameter WORDS = 4,
    parameter WORD_SIZE = 32
) (
    input clk,
    input rst,

    input [$clog2(WORDS)-1:0] widx,
    input wen,
    input [WORD_SIZE-1:0] wdata,
    output [WORD_SIZE*WORDS-1:0] stored
);

localparam BLOCK_SIZE = WORD_SIZE * WORDS;
localparam BLOCK_BYTES = BLOCK_SIZE / 8;

reg [WORD_SIZE-1:0] stored_words [WORDS];
wire [BLOCK_SIZE-1:0] stored_le;

genvar i;
generate
    for (i = 0; i < WORDS; i = i+1) begin
        assign stored_le[(i+1) * WORD_SIZE - 1 : i * WORD_SIZE] = stored_words[i];

        always @(posedge clk, posedge rst) begin
            if (rst) stored_words[i] <= 0;
            else if (wen & (widx == i)) stored_words[i] <= wdata;
        end
    end
endgenerate

// Byte swap stored_le because AES expects BE numbers
generate
    genvar b;
    for (b = 0; b < BLOCK_BYTES; b = b+1) begin
        localparam hb = BLOCK_BYTES - 1 - b;
        assign stored[(b+1)*8-1 : b*8] = stored_le[(hb+1)*8-1 : hb*8];
    end
endgenerate

endmodule

