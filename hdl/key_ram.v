module key_ram #(
    parameter WORDS = 4,
    parameter WORD_SIZE = 32
) (
    input clk,
    input rst,

    input [$clog2(WORDS)-1:0] widx,
    input wen,
    input [WORD_SIZE-1:0] wdata,
    input increment,

    output reg [WORD_SIZE*WORDS-1:0] stored
);

localparam BLOCK_SIZE = WORD_SIZE * WORDS;
localparam BLOCK_BYTES = BLOCK_SIZE / 8;
localparam WORD_BYTES = WORD_SIZE / 8;

// Byte swap wdata because AES expects BE numbers
wire [WORD_SIZE-1:0] wdata_be;
generate
    genvar b;
    for (b = 0; b < WORD_BYTES; b = b+1) begin
        localparam hb = WORD_BYTES - 1 - b;
        assign wdata_be[(b+1)*8-1 : b*8] = wdata[(hb+1)*8-1 : hb*8];
    end
endgenerate

always @(posedge clk, posedge rst) begin
    if (rst)
        stored <= 0;
    else if (!wen)
        stored <= stored + increment; 
end

// Stores wdata into the N-i word to complete the byte swap
genvar i;
generate
    for (i = 0; i < WORDS; i = i+1) begin
        always @(posedge clk, posedge rst) begin
            if (!rst & wen & (i == WORDS - widx))
                stored[(i+1) * WORD_SIZE - 1 : i * WORD_SIZE] <= wdata_be;
        end
    end
endgenerate

endmodule

