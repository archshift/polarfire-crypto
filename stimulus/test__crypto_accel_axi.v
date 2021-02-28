`timescale 1ns/100ps
`include "assert.v"

module test__crypto_accel_axi;

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


//////////////////////////////////////////////////////////////////////
// Device Under Test
//////////////////////////////////////////////////////////////////////
reg [37:0] wraddr, rdaddr;
reg [31:0] wr_dat;
wire [31:0] rd_dat;
wire [1:0] wrresp_dat, rdresp_dat;
wire wraddr_ready, rdaddr_ready, wr_ready, wrresp_valid, rd_valid;
reg wraddr_valid, rdaddr_valid, wr_valid, wrresp_ready, rd_ready;

wire [255:0] aes_key;
wire [127:0] aes_ctr, aes_in_block, aes_out_block;
wire aes_in_valid, aes_in_ready;
wire aes_out_valid, aes_out_ready;
wire aes_fifo_empty;
wire aes_rst;

crypto_accel crypto_accel(
    .clk(SYSCLK),
    .rst(!NSYSRESET),
    
    .wraddr_ready(wraddr_ready),
    .wraddr_valid(wraddr_valid),
    .wraddr(wraddr),
    
    .wr_ready(wr_ready),
    .wr_valid(wr_valid),
    .wr_dat(wr_dat),
    
    .wrresp_ready(wrresp_ready),
    .wrresp_valid(wrresp_valid),
    .wrresp_dat(wrresp_dat),
    
    .rdaddr_ready(rdaddr_ready),
    .rdaddr_valid(rdaddr_valid),
    .rdaddr(rdaddr),
    
    .rd_ready(rd_ready),
    .rd_valid(rd_valid),
    .rd_dat(rd_dat),
    .rdresp_dat(rdresp_dat),

    .aes_key(aes_key),
    .aes_ctr(aes_ctr),
    .aes_in_ready(aes_in_ready),
    .aes_in_valid(aes_in_valid),
    .aes_in_block(aes_in_block),
    .aes_out_ready(aes_out_ready),
    .aes_out_valid(aes_out_valid),
    .aes_out_block(aes_out_block),
    .aes_fifo_empty(aes_fifo_empty),
    .aes_rst(aes_rst)
);

aes256_fifo aes (
    .clk(SYSCLK),
    .rst(aes_rst),
    
    .aes_in_valid(aes_in_valid),
    .aes_in_ready(aes_in_ready),
    .aes_in_block(aes_in_block),
    .aes_ctr(aes_ctr),
    
    .aes_key(aes_key),
    
    .aes_out_ready(aes_out_ready),
    .aes_out_valid(aes_out_valid),
    .aes_out_block(aes_out_block),
    
    .empty(aes_fifo_empty)
);

function [31:0] bswap(input [31:0] w);
    bswap = {w[7:0], w[15:8], w[23:16], w[31:24]};
endfunction

task write_io(input [37:0] address, input [31:0] data);
    begin
        // Check that we're in the idle state, waiting for an address to come in
        `assert(wraddr_ready);
        `assert(rdaddr_ready);
        `assert(!wr_ready);
        `assert(!rd_valid);
        `assert(!wrresp_valid);
        
        // Send the write address request
        wraddr = address;
        wraddr_valid = 1'b1;
        @(negedge SYSCLK);
        wraddr_valid = 0;
        
        // Check that we're in the write state
        `assert(!wraddr_ready);
        `assert(!rdaddr_ready);
        `assert(wr_ready);
        `assert(!rd_valid);
        `assert(!wrresp_valid);

        // Send the write data request
        wr_dat = data;
        wr_valid = 1'b1;        
        @(negedge SYSCLK);
        wr_valid = 0;
        
        // Check that we're in the write response state
        `assert(!wraddr_ready);
        `assert(!rdaddr_ready);
        `assert(!wr_ready);
        `assert(!rd_valid);
        `assert(wrresp_valid);
        
        // Check the write response
        wrresp_ready = 1'b1;
        `assert(wrresp_dat == 2'b0);
        @(negedge SYSCLK);
        wrresp_ready = 0;
    end
endtask

task read_io(input [37:0] address, output [31:0] data);
    begin
        // Check that we're in the idle state, waiting for an address to come in
        `assert(wraddr_ready);
        `assert(rdaddr_ready);
        `assert(!wr_ready);
        `assert(!rd_valid);
        `assert(!wrresp_valid);
        
        // Send the read address request
        rdaddr = address;
        rdaddr_valid = 1'b1;
        @(negedge SYSCLK);
        rdaddr_valid = 0;
        
        // Check that we're in the read state
        `assert(!wraddr_ready);
        `assert(!rdaddr_ready);
        `assert(!wr_ready);
        `assert(rd_valid);
        `assert(!wrresp_valid);

        // Check the read response
        `assert(rdresp_dat == 2'b0);
        rd_ready = 1'b1;
	    data = rd_dat;
        @(negedge SYSCLK);
        rd_ready = 0;
    end
endtask

reg [31:0] read_out;
reg [31:0] input_vec [7:0];
reg [31:0] output_vec [7:0];
`define o_fifo_in_full read_out[2]
`define o_fifo_out_empty read_out[1]
`define o_busy read_out[0]

// "random" numbers
integer rng;
integer prime = 32'd2417361181;
integer modulus = 32'd3969582061;
task rng_seed(input integer seed);
    rng = seed;
endtask
task rng_next();
    rng = (rng * prime) % modulus;
endtask

integer i, blk;
initial
begin
    // Uses 0-key, 0-ctr, but autoincrementing ctr

    wraddr_valid = 0;
    rdaddr_valid = 0;
    wr_valid = 0;
    rd_ready = 0;
    wrresp_ready = 0;
    
    #(SYSCLK_PERIOD * 15 )
    @(negedge SYSCLK)

    write_io(32'h0000, 32'h40000000); // enable auto-increment
    `assert(crypto_accel.auto_increment);

    read_io(32'h0000, read_out);
    `assert(!`o_busy);
    `assert(!`o_fifo_in_full);
    `assert(`o_fifo_out_empty);

    rng_seed(prime);
    for (i = 0; i < 8; i = i+1) begin
        write_io(32'h0004, bswap(rng));
        input_vec[i] = rng;
        rng_next();
    end

    rng_seed(prime);
    for (blk = 0; blk < 2; blk = blk + 1) begin
        // wait for output to be ready
        read_io(32'h0000, read_out);
        while (`o_fifo_out_empty) begin
            read_io(32'h0000, read_out);
        end
        
        // read output
        for (i = 0; i < 4; i = i+1) begin
            read_io(32'h0008, read_out); 
            output_vec[blk*4 + i] = bswap(read_out);
            rng_next();
        end
    end
    
    `assert(output_vec[0] == 32'h4c83c165);
    `assert(output_vec[1] == 32'h5587bce6);
    `assert(output_vec[2] == 32'h5efddab2);
    `assert(output_vec[3] == 32'h9dcf7049);
    `assert(output_vec[4] == 32'hac596787);
    `assert(output_vec[5] == 32'hcc304014);
    `assert(output_vec[6] == 32'ha3179e91);
    `assert(output_vec[7] == 32'hc9af4b2c);

    $finish;
end

endmodule
