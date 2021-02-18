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

reg [37:0] wraddr, rdaddr;
reg [31:0] wr_dat;
wire [31:0] rd_dat;
wire [1:0] wrresp_dat, rdresp_dat;
wire wraddr_ready, rdaddr_ready, wr_ready, wrresp_valid, rd_valid;
reg wraddr_valid, rdaddr_valid, wr_valid, wrresp_ready, rd_ready;

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
    .rdresp_dat(rdresp_dat)
);

task write_io(input [37:0] address, input [31:0] data);
    begin
        // Check that we're in the idle state, waiting for an address to come in
        #1;
        `assert(wraddr_ready);
        `assert(rdaddr_ready);
        `assert(!wr_ready);
        `assert(!rd_valid);
        `assert(!wrresp_valid);
        
        // Send the write address request
        wraddr = address;
        wraddr_valid = 1'b1;
        @(posedge SYSCLK);
        wraddr_valid = 0;
        
        // Check that we're in the write state
        #1;
        `assert(!wraddr_ready);
        `assert(!rdaddr_ready);
        `assert(wr_ready);
        `assert(!rd_valid);
        `assert(!wrresp_valid);

        // Send the write data request
        wr_dat = data;
        wr_valid = 1'b1;        
        @(posedge SYSCLK);
        wr_valid = 0;
        
        // Check that we're in the write response state
        #1;
        `assert(!wraddr_ready);
        `assert(!rdaddr_ready);
        `assert(!wr_ready);
        `assert(!rd_valid);
        `assert(wrresp_valid);
        
        // Check the write response
        wrresp_ready = 1'b1;
        `assert(wrresp_dat == 2'b0);
        @(posedge SYSCLK);
        wrresp_ready = 0;
    end
endtask

task read_io(input [37:0] address, output [31:0] data);
    begin
        // Check that we're in the idle state, waiting for an address to come in
        #1;
        `assert(wraddr_ready);
        `assert(rdaddr_ready);
        `assert(!wr_ready);
        `assert(!rd_valid);
        `assert(!wrresp_valid);
        
        // Send the read address request
        rdaddr = address;
        rdaddr_valid = 1'b1;
        @(posedge SYSCLK);
        rdaddr_valid = 0;
        
        // Check that we're in the read state
        #1;
        `assert(!wraddr_ready);
        `assert(!rdaddr_ready);
        `assert(!wr_ready);
        `assert(rd_valid);
        `assert(!wrresp_valid);

        // Check the read response
        `assert(rdresp_dat == 2'b0);
        rd_ready = 1'b1;
	    data = rd_dat;
        @(posedge SYSCLK);
        rd_ready = 0;
    end
endtask

reg [31:0] read_out;
initial
begin
    wraddr_valid = 0;
    rdaddr_valid = 0;
    wr_valid = 0;
    rd_ready = 0;
    wrresp_ready = 0;
    
    #(SYSCLK_PERIOD * 15 )
    
    write_io(32'hDEADBEEF, 32'hF000BAAA);
    read_io(32'hDEADBEEF, read_out);
    `assert(read_out == 32'hF000BAAA);
end

endmodule

