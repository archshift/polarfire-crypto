module key_ram #(
    parameter WORDS = 4,
    parameter WORD_SIZE = 32
) (
    input clk,
    input rst,

    input [$clog2(WORDS)-1:0] widx,
    input wen,
    input [WORD_SIZE-1:0] wdata,
    output [WORDS * WORD_SIZE - 1 : 0] stored
);

reg [WORD_SIZE-1:0] stored_words [WORDS];

genvar i;
generate
    for (i = 0; i < WORDS; i = i+1) begin
        // Note: we reverse the word order to accomodate how the AES block expects
        assign stored[(i+1) * WORD_SIZE - 1 : i * WORD_SIZE] = stored_words[WORDS-1-i];

        always @(posedge clk, posedge rst) begin
            if (rst) stored_words[i] <= 0;
            else if (wen & (widx == i)) stored_words[i] <= wdata;
        end
    end
endgenerate

endmodule

