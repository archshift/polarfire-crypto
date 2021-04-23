module crypto_accel(
    input clk,
    input rst,
    
    // Register file interface
    input ctl_strobe,
    input ctl_auto_inc,
    input ctl_rst,
    output ctl_busy,
    output ctl_ofifo_empty,
    output ctl_ififo_full,
    
    input ctr_addr[0:0],
    input ctr_wdata[63:0],
    input ctr_wen,
    input key_addr[1:0],
    input key_wdata[63:0],
    input key_wen,
    
    input fifo_wdata[63:0],
    output fifo_rdata[63:0],
    input fifo_wen,
    input fifo_ren,
    
    // AES interface signals
    output [255:0] aes_key,
    output [127:0] aes_ctr,
    input aes_in_ready,
    output aes_in_valid,
    output [127:0] aes_in_block,
    output aes_out_ready,
    input aes_out_valid,
    input [127:0] aes_out_block,
    input aes_fifo_empty,
    input [4:0] aes_pending_blks,
    output aes_rst
    );

`define STATE_EXPECT_ADDR 2'b00
`define STATE_READ_RESP 2'b10
`define STATE_EXPECT_WRITE_REQ 2'b01
`define STATE_WRITE_RESP 2'b11

reg [1:0] state, next_state;
reg [37:0] addr, next_addr;
wire [15:0] reg_offs = addr[15:0];


/***************************
 ** REGISTER DEFINITIONS
 ***************************/

assign aes_rst = rst | ctl_rst;

wire aes_in_word_ready;
wire aes_in_fifo_empty, aes_out_fifo_empty;
be_block_builder aes_in_builder (
    .clk(clk),
    .rst(aes_rst),
    
    .word_valid(fifo_wen),
    .word_ready(aes_in_word_ready),
    .word(fifo_wdata),
    
    .block_valid(aes_in_valid),
    .block_ready(aes_in_ready),
    .block(aes_in_block),
    
    //.state(fifo_in_state),
    .empty(aes_in_fifo_empty)
);
assign ctl_ififo_full = !aes_in_word_ready;
assign ctl_busy = !aes_fifo_empty | !aes_in_fifo_empty | !aes_out_fifo_empty;

wire aes_out_word_valid;
// TODO: read latency?
be_block_splitter aes_out_splitter (
    .clk(clk),
    .rst(aes_rst),
    
    .block_valid(aes_out_valid),
    .block_ready(aes_out_ready),
    .block(aes_out_block),
    
    .word_valid(aes_out_word_valid),
    .word_ready(fifo_ren),
    .word(fifo_rdata),
    
    //.state(fifo_out_state),
    .empty(aes_out_fifo_empty)
);
assign ctl_ofifo_empty = !aes_out_word_valid;

key_ram #(
    .WORDS(2),
    .WORD_SIZE(64)
) aes_ctr_ram (
    .clk(clk),
    .rst(aes_rst),
    
    .widx(ctr_addr),
    .wdata(ctr_wdata),
    .wen(ctr_wen),
    .increment(ctl_auto_inc & aes_in_ready & aes_in_valid),
    .stored(aes_ctr)
);

key_ram #(
    .WORDS(4),
    .WORD_SIZE(64)
) aes_key_ram (
    .clk(clk),
    .rst(aes_rst),
    
    .widx(key_addr),
    .wdata(key_wdata),
    .wen(key_wen),
    .increment(1'b0),
    .stored(aes_key)
);




endmodule
