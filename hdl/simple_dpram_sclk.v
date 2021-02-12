/******************************************************************************
 This Source Code Form is subject to the terms of the
 Open Hardware Description License, v. 1.0. If a copy
 of the OHDL was not distributed with this file, You
 can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

 Description:
 Simple single clocked dual port ram (separate read and write ports),
 with optional bypass logic. Asynchronous read.

 Copyright (C) 2012 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

 ******************************************************************************/

module simple_dpram_sclk
  #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter ENABLE_BYPASS = 1
    )
   (
    input 		    clk,
    input [ADDR_WIDTH-1:0]  raddr,
    input [ADDR_WIDTH-1:0]  waddr,
    input 		    we,
    input [DATA_WIDTH-1:0]  din,
    output [DATA_WIDTH-1:0] dout
    );

   reg [DATA_WIDTH-1:0]     mem[(1<<ADDR_WIDTH)-1:0];
   
   always @(posedge clk) begin
      if (we)
	mem[waddr] <= din;
   end
   
   assign dout = mem[raddr];

endmodule
