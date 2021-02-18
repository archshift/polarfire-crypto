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

words_block words_block(
    .clk(SYSCLK),
    .rst(!NSYSRESET),
    
    .word_valid(word_valid),
    .word_ready(word_ready),
    .word(word),
    
    .block_valid(block_valid),
    .block_ready(block_ready),
    .block(block)
);

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
    word = 32'h01234567;
    word_valid = 1'b1;
    #1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    
    // Word 2
    word = 32'h89ABCDEF;
    word_valid = 1'b1;
    #1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    
    // Word 3
    word = 32'hA0A0A0A0;
    word_valid = 1'b1;
    #1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    
    // Word 4
    word = 32'hF9F9F9F9;
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    
    @(posedge SYSCLK); #1;
    
    // Word 5; Read out the block
    word = 32'h76543210;
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(block_valid);
    `assert(block == 128'h0123456789ABCDEFA0A0A0A0F9F9F9F9);
    @(posedge SYSCLK); #1;
    
    // Word 6
    word = 32'hFEDCBA98;
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    
    // Word 7
    word = 32'hB1B1B1B1;
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK); #1;
    
    // Word 8
    word = 32'hE8E8E8E8;
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
    word = 32'h01234567;
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK);
    word_valid = 0;
    
    #(SYSCLK_PERIOD * 5);
    
    // Word 2
    #1;
    word = 32'h89ABCDEF;
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK);
    word_valid = 0;
    
    #(SYSCLK_PERIOD * 5);
    
    // Word 3
    #1;
    word = 32'hA0A0A0A0;
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK);
    word_valid = 0;
    
    #(SYSCLK_PERIOD * 5);
    
    // Word 4
    #1;
    word = 32'hF9F9F9F9;
    word_valid = 1'b1;
    `assert(word_ready);
    `assert(!block_valid);
    @(posedge SYSCLK);
    word_valid = 0;
    
    #(SYSCLK_PERIOD * 5);
    
    // Word 5; Read out the block
    #1;
    block_ready = 1'b1;
    word = 32'h76543210;
    `assert(block_valid);
    `assert(block == 128'h0123456789ABCDEFA0A0A0A0F9F9F9F9);
    @(posedge SYSCLK);

    block_ready = 0;

    $finish;
end

endmodule

