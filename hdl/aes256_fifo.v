// FIFO interface for the AES256 module.
// Any given block of data will be ready at the output in 30 cycles, if the FIFO is not allowed to back up.
module aes256_fifo(
    input clk,
    input rst,
    
    input aes_in_valid,
    output reg aes_in_ready,
    input [127:0] aes_in_block,
    input [127:0] aes_ctr,
    
    input [255:0] aes_key,
    
    input aes_out_ready,
    output aes_out_valid,
    output [127:0] aes_out_block,
    
    output empty
);
    wire aes_pipeline_valid;
    wire [127:0] aes_cipher_block, aes_pipeline_block;
    reg [4:0] aes_pending_blocks, aes_pending_blocks_next;
    wire fifo_empty;
    wire aes_rd_trigger = aes_out_ready & aes_out_valid;
    wire aes_wr_trigger = aes_in_ready & aes_in_valid;

    aes_256 aes256_pipelined( .clk(clk), .state(aes_ctr), .key(aes_key), .out(aes_cipher_block) );
    shift_reg #(.WIDTH(1), .DEPTH(29)) block_valid_reg( .clk(clk), .rst(rst), .din(aes_wr_trigger), .dout(aes_pipeline_valid) );
    shift_reg #(.WIDTH(128), .DEPTH(29)) block_input_reg( .clk(clk), .rst(rst), .din(aes_in_block), .dout(aes_pipeline_block) );
    
    fifo #(.DATA_WIDTH(128), .DEPTH_WIDTH($clog2(29))) done_fifo (
        .clk(clk),
        .rst(rst),
        
        .wr_data_i(aes_cipher_block ^ aes_pipeline_block),
        .wr_en_i(aes_pipeline_valid),
        
        .rd_data_o(aes_out_block),
        .rd_en_i(aes_rd_trigger),
        
        .empty_o(fifo_empty)
    );
    
    assign aes_out_valid = !fifo_empty;
    assign empty = aes_pending_blocks == 0;
    
    always @(posedge clk, posedge rst) begin
        if (rst) aes_pending_blocks <= 0;
        else aes_pending_blocks <= aes_pending_blocks_next;
    end
    
    always @* begin
        aes_in_ready = 0;
        if (aes_pending_blocks - aes_rd_trigger < 5'd29) begin
            aes_pending_blocks_next = aes_pending_blocks - aes_rd_trigger + aes_wr_trigger;
            aes_in_ready = 1;
        end
    end
endmodule

