`timescale 1ns/100ps

module test__aes256_fifo;

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

reg aes_in_valid, aes_out_ready;
wire aes_out_valid, aes_in_ready;
reg [127:0] aes_in_block, aes_ctr;
wire [127:0] aes_out_block;
reg [255:0] aes_key;    

aes256_fifo dut (
    .clk(SYSCLK),
    .rst(!NSYSRESET),
    
    .aes_in_valid(aes_in_valid),
    .aes_in_ready(aes_in_ready),
    .aes_in_block(aes_in_block),
    
    .aes_out_valid(aes_out_valid),
    .aes_out_ready(aes_out_ready),
    .aes_out_block(aes_out_block),
    
    .aes_key(aes_key),
    .aes_ctr(aes_ctr)
);

always @(SYSCLK)
    #(SYSCLK_PERIOD) $display("%t: %h   :   %h : %h : %h : %h : %h : %h", $time, aes_in_block, dut.aes_cipher_block, dut.aes_pipeline_block, dut.done_fifo.wr_data_i, dut.aes_pipeline_valid, dut.aes_rd_trigger, aes_out_block);

`define assert(cond) assert(cond)

initial begin
    aes_key = 0;
    aes_ctr = 0;
    aes_in_valid = 0;
    aes_out_ready = 0;
    aes_in_block = 0;

    #(SYSCLK_PERIOD * 15)
    
    // Reset done, put in one block of input
    `assert(aes_in_ready);
    `assert(!aes_out_valid);
    aes_in_valid = 1'b1;
    aes_in_block = 128'b1;
    aes_out_ready = 1'b1;
    #(SYSCLK_PERIOD * 1);
    aes_in_valid = 0;
    
    #1;
    `assert(aes_in_ready);
    `assert(!aes_in_valid);
    
    #(SYSCLK_PERIOD * 19); #1;
    `assert(aes_in_ready);
    `assert(!aes_out_valid);
    
    #(SYSCLK_PERIOD * 10); #1;
    `assert(aes_in_ready);
    `assert(aes_out_valid);
    
    #(SYSCLK_PERIOD * 1); #1;
    `assert(aes_in_ready);
    `assert(!aes_out_valid);
    
    #(SYSCLK_PERIOD * 2);
    $finish;
end

endmodule

