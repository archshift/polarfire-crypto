`timescale 1ns/100ps
`include "assert.v"

module test__words_block;

parameter SYSCLK_PERIOD = 100;// 10MHZ

reg SYSCLK;
reg NSYSRESET;

initial
begin
    SYSCLK = 1'b0;
    NSYSRESET = 1'b0;
end

//////////////////////////////////////////////////////////////////////
// Reset Pulse
//////////////////////////////////////////////////////////////////////
initial
begin
    #(SYSCLK_PERIOD * 10 )
        NSYSRESET = 1'b1;
end


//////////////////////////////////////////////////////////////////////
// Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;

reg word_valid;
wire word_ready;
reg [31:0] word;

wire block_valid;
reg block_ready;
wire [127:0] block;

be_block_builder words_block(
    .clk(SYSCLK),
    .rst(!NSYSRESET),
    
    .word_valid(word_valid),
    .word_ready(word_ready),
    .word(word),
    
    .block_valid(block_valid),
    .block_ready(block_ready),
    .block(block)
);

function [31:0] le_word(input [7:0] b0, input [7:0] b1, input [7:0] b2, input [7:0] b3);
    le_word = {b3, b2, b1, b0};
endfunction

initial
begin
    word_valid = 0;
    word = 0;
    block_ready = 0;
    
    #(SYSCLK_PERIOD * 15 )
    
//////////////////////////////////////////////////////////////////////
// Test at maximum throughput
//////////////////////////////////////////////////////////////////////
    
    block_ready = 1'b1;
    
    // Word 1
    word = le_word(8'h01, 8'h23, 8'h45, 8'h67);
    word_valid = 1'b1;
    #1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    
    // Word 2
    word = le_word(8'h89, 8'hAB, 8'hCD, 8'hEF);
    word_valid = 1'b1;
    #1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    
    // Word 3
    word = le_word(8'hA0, 8'hA0, 8'hA0, 8'hA0);
    word_valid = 1'b1;
    #1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    
    // Word 4
    word = le_word(8'hF9, 8'hF9, 8'hF9, 8'hF9);
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    
    @(posedge SYSCLK); #1;
    
    // Word 5; Read out the block
    word = le_word(8'h76, 8'h54, 8'h32, 8'h10);
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(block_valid);
    `assert(block == 128'h0123456789ABCDEFA0A0A0A0F9F9F9F9);
    @(posedge SYSCLK); #1;
    
    // Word 6
    word = le_word(8'hFE, 8'hDC, 8'hBA, 8'h98);
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    
    // Word 7
    word = le_word(8'hB1, 8'hB1, 8'hB1, 8'hB1);
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    
    // Word 8
    word = le_word(8'hE8, 8'hE8, 8'hE8, 8'hE8);
    word_valid = 1'b1;
    #1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    word_valid = 0;
    
    // Read out the block
    block_ready = 1'b1;
    `assert(word_ready);
    `assert(block_valid);
    `assert(block == 128'h76543210FEDCBA98B1B1B1B1E8E8E8E8);
    @(posedge SYSCLK);
    
    block_ready = 0;
    
//////////////////////////////////////////////////////////////////////
// Test with artificial delays
//////////////////////////////////////////////////////////////////////

    NSYSRESET = 0;
    #(SYSCLK_PERIOD * 5);
    NSYSRESET = 1;
    #(SYSCLK_PERIOD * 5);
    
    // Word 1
    #1;
    word = le_word(8'h01, 8'h23, 8'h45, 8'h67);
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK);
    word_valid = 0;
    
    #(SYSCLK_PERIOD * 5);
    
    // Word 2
    #1;
    word = le_word(8'h89, 8'hAB, 8'hCD, 8'hEF);
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK);
    word_valid = 0;
    
    #(SYSCLK_PERIOD * 5);
    
    // Word 3
    #1;
    word = le_word(8'hA0, 8'hA0, 8'hA0, 8'hA0);
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK);
    word_valid = 0;
    
    #(SYSCLK_PERIOD * 5);
    
    // Word 4
    #1;
    word = le_word(8'hF9, 8'hF9, 8'hF9, 8'hF9);
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK);
    word_valid = 0;
    
    #(SYSCLK_PERIOD * 5);
    
    // Word 5; Read out the block
    #1;
    block_ready = 1'b1;
    word = le_word(8'h76, 8'h54, 8'h32, 8'h10);
    `assert(block_valid);
    `assert(block == 128'h0123456789ABCDEFA0A0A0A0F9F9F9F9);
    @(posedge SYSCLK);

    block_ready = 0;

    $finish;
end

endmodule

