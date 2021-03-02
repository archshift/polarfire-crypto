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
localparam WORD_BYTES = WORD_SIZE / 8;

// Stores wdata into the N-i word to swap words into the order our IP expects.
reg [BLOCK_SIZE-1:0] stored_next;
genvar i;
generate
    for (i = 0; i < WORDS; i = i+1) begin
        always @* begin
            if (i == WORDS - widx - 1)
                stored_next[(i+1) * WORD_SIZE - 1 : i * WORD_SIZE] = wdata;
            else
                stored_next[(i+1) * WORD_SIZE - 1 : i * WORD_SIZE] = stored[(i+1) * WORD_SIZE - 1 : i * WORD_SIZE];
        end
    end
endgenerate

always @(posedge clk, posedge rst) begin
    if (rst)
        stored <= 0;
    else if (wen)
        stored <= stored_next;
    else
        stored <= stored + increment;
end

endmodule

