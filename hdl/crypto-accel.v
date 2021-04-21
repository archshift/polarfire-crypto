module crypto_accel(
    input clk,
    input rst,
    
    // AXI4-Lite signals
    output reg wraddr_ready,
    input wraddr_valid,
    input [37:0] wraddr,
    
    output reg wr_ready,
    input wr_valid,
    input [63:0] wr_dat,
    
    input wrresp_ready,
    output reg wrresp_valid,
    output reg [1:0] wrresp_dat,
    
    output reg rdaddr_ready,
    input rdaddr_valid,
    input [37:0] rdaddr,
    
    input rd_ready,
    output reg rd_valid,
    output reg [63:0] rd_dat,
    output reg [1:0] rdresp_dat,
    
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

`define REG_AES_CTL (16'h0000)
reg fifo_in_full;
wire fifo_out_empty;
reg aes_busy;
wire [63:0] aes_ctl_out = {
    /* bit 63-3 */ 61'b0,
    /* bit 2    */ fifo_in_full,
    /* bit 1    */ fifo_out_empty,
    /* bit 0    */ aes_busy
};

reg aes_ctl_wen;
reg [63:0] aes_ctl;
wire soft_rst, auto_increment;
assign {
    /* bit 31 */ soft_rst,
    /* bit 30 */ auto_increment
} = aes_ctl[31:30];

assign aes_rst = rst | soft_rst;

`define REG_AES_FIFO (16'h1???)
reg aes_in_word_valid;
wire aes_in_word_ready;
wire aes_in_fifo_empty;
be_block_builder aes_in_builder (
    .clk(clk),
    .rst(aes_rst),
    
    .word_valid(aes_in_word_valid),
    .word_ready(aes_in_word_ready),
    .word(wr_dat),
    
    .block_valid(aes_in_valid),
    .block_ready(aes_in_ready),
    .block(aes_in_block),
    
    .empty(aes_in_fifo_empty)
);

reg aes_out_word_ready;
wire aes_out_word_valid;
wire [63:0] aes_out_word;
be_block_splitter aes_out_splitter (
    .clk(clk),
    .rst(aes_rst),
    
    .block_valid(aes_out_valid),
    .block_ready(aes_out_ready),
    .block(aes_out_block),
    
    .word_valid(aes_out_word_valid),
    .word_ready(aes_out_word_ready),
    .word(aes_out_word),
    
    .empty(fifo_out_empty)
);

`define REG_AES_CTR (16'b0000_0000_0001_????) // 0x0010
reg aes_ctr_word_valid;
key_ram #(
    .WORDS(2),
    .WORD_SIZE(64)
) aes_ctr_ram (
    .clk(clk),
    .rst(aes_rst),
    
    .widx(reg_offs[3:3]),
    .wdata(wr_dat),
    .wen(aes_ctr_word_valid),
    .increment(auto_increment & aes_in_ready & aes_in_valid),
    .stored(aes_ctr)
);

`define REG_AES_KEY (16'b0000_0000_001?_????) // 0x0020
reg aes_key_word_valid;
key_ram #(
    .WORDS(4),
    .WORD_SIZE(64)
) aes_key_ram (
    .clk(clk),
    .rst(aes_rst),
    
    .widx(reg_offs[4:3]),
    .wdata(wr_dat),
    .wen(aes_key_word_valid),
    .increment(1'b0),
    .stored(aes_key)
);


/***************************
 ** MMIO LOGIC
 ***************************/

always @(*) begin    
    wraddr_ready = 0;
    wr_ready = 0;
    wrresp_valid = 0;
    wrresp_dat = 0;
    rdaddr_ready = 0;
    rd_valid = 0;
    rd_dat = 0;
    rdresp_dat = 0;
    next_state = state;
    next_addr = addr;

    fifo_in_full = !aes_in_word_ready;
    aes_busy = !aes_fifo_empty | !aes_in_fifo_empty | !fifo_out_empty;
    aes_in_word_valid = 0;
    aes_out_word_ready = 0;
    aes_ctr_word_valid = 0;
    aes_key_word_valid = 0;
    aes_ctl_wen = 0;

    case (state)
        `STATE_EXPECT_ADDR : begin
            wraddr_ready = 1'b1;
            rdaddr_ready = 1'b1;
            
            if (wraddr_ready & wraddr_valid) begin
                next_state = `STATE_EXPECT_WRITE_REQ;
                next_addr = wraddr;
            end
            if (rdaddr_ready & rdaddr_valid) begin
                next_state = `STATE_READ_RESP;
                next_addr = rdaddr;
            end
        end
        `STATE_READ_RESP : begin
            rd_valid = 1'b1;
            
            casez (reg_offs)
                `REG_AES_CTL : begin
                    rd_dat = aes_ctl_out;
                end
                `REG_AES_FIFO : begin
                    rd_valid = aes_out_word_valid;
                    aes_out_word_ready = rd_ready;
                    rd_dat = aes_out_word;
                end
            endcase

            if (rd_ready & rd_valid) begin
                next_state = `STATE_EXPECT_ADDR;
            end
        end
        `STATE_EXPECT_WRITE_REQ : begin
            wr_ready = 1'b1;
            
            casez (reg_offs)
                `REG_AES_CTL : begin
                    aes_ctl_wen = wr_valid;
                end
                `REG_AES_FIFO : begin
                    wr_ready = aes_in_word_ready;
                    aes_in_word_valid = wr_valid;
                end
                `REG_AES_CTR : begin
                    aes_ctr_word_valid = wr_valid;
                end
                `REG_AES_KEY : begin
                    aes_key_word_valid = wr_valid;
                end
            endcase
            
            if (wr_ready & wr_valid) begin
                next_state = `STATE_WRITE_RESP;                
            end
        end
        `STATE_WRITE_RESP : begin
            wrresp_valid = 1'b1;
            
            if (wrresp_ready & wrresp_valid) begin
                next_state = `STATE_EXPECT_ADDR;
            end
        end
    endcase
end

always @(posedge clk) begin
    if (rst) state <= 0;
    else state <= next_state;

    if (soft_rst) aes_ctl <= 0;
    else if (aes_ctl_wen) aes_ctl <= wr_dat;

    addr <= next_addr;
end


endmodule
