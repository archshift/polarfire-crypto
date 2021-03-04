//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Mar  4 00:29:36 2021
// Version: v12.6 12.900.20.24
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// crypto_mmio
module crypto_mmio(
    // Inputs
    ARESET,
    CLK,
    SLAVE_ARADDR,
    SLAVE_ARBURST,
    SLAVE_ARCACHE,
    SLAVE_ARID,
    SLAVE_ARLEN,
    SLAVE_ARLOCK,
    SLAVE_ARPROT,
    SLAVE_ARQOS,
    SLAVE_ARREGION,
    SLAVE_ARSIZE,
    SLAVE_ARUSER,
    SLAVE_ARVALID,
    SLAVE_AWADDR,
    SLAVE_AWBURST,
    SLAVE_AWCACHE,
    SLAVE_AWID,
    SLAVE_AWLEN,
    SLAVE_AWLOCK,
    SLAVE_AWPROT,
    SLAVE_AWQOS,
    SLAVE_AWREGION,
    SLAVE_AWSIZE,
    SLAVE_AWUSER,
    SLAVE_AWVALID,
    SLAVE_BREADY,
    SLAVE_RREADY,
    SLAVE_WDATA,
    SLAVE_WLAST,
    SLAVE_WSTRB,
    SLAVE_WUSER,
    SLAVE_WVALID,
    // Outputs
    SLAVE_ARREADY,
    SLAVE_AWREADY,
    SLAVE_BID,
    SLAVE_BRESP,
    SLAVE_BUSER,
    SLAVE_BVALID,
    SLAVE_RDATA,
    SLAVE_RID,
    SLAVE_RLAST,
    SLAVE_RRESP,
    SLAVE_RUSER,
    SLAVE_RVALID,
    SLAVE_WREADY
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ARESET;
input         CLK;
input  [37:0] SLAVE_ARADDR;
input  [1:0]  SLAVE_ARBURST;
input  [3:0]  SLAVE_ARCACHE;
input  [0:0]  SLAVE_ARID;
input  [7:0]  SLAVE_ARLEN;
input  [1:0]  SLAVE_ARLOCK;
input  [2:0]  SLAVE_ARPROT;
input  [3:0]  SLAVE_ARQOS;
input  [3:0]  SLAVE_ARREGION;
input  [2:0]  SLAVE_ARSIZE;
input  [0:0]  SLAVE_ARUSER;
input         SLAVE_ARVALID;
input  [37:0] SLAVE_AWADDR;
input  [1:0]  SLAVE_AWBURST;
input  [3:0]  SLAVE_AWCACHE;
input  [0:0]  SLAVE_AWID;
input  [7:0]  SLAVE_AWLEN;
input  [1:0]  SLAVE_AWLOCK;
input  [2:0]  SLAVE_AWPROT;
input  [3:0]  SLAVE_AWQOS;
input  [3:0]  SLAVE_AWREGION;
input  [2:0]  SLAVE_AWSIZE;
input  [0:0]  SLAVE_AWUSER;
input         SLAVE_AWVALID;
input         SLAVE_BREADY;
input         SLAVE_RREADY;
input  [63:0] SLAVE_WDATA;
input         SLAVE_WLAST;
input  [7:0]  SLAVE_WSTRB;
input  [0:0]  SLAVE_WUSER;
input         SLAVE_WVALID;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        SLAVE_ARREADY;
output        SLAVE_AWREADY;
output [0:0]  SLAVE_BID;
output [1:0]  SLAVE_BRESP;
output [0:0]  SLAVE_BUSER;
output        SLAVE_BVALID;
output [63:0] SLAVE_RDATA;
output [0:0]  SLAVE_RID;
output        SLAVE_RLAST;
output [1:0]  SLAVE_RRESP;
output [0:0]  SLAVE_RUSER;
output        SLAVE_RVALID;
output        SLAVE_WREADY;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire           aes256_fifo_0_aes_in_ready;
wire   [127:0] aes256_fifo_0_aes_out_block;
wire           aes256_fifo_0_aes_out_valid;
wire           aes256_fifo_0_empty;
wire           ARESET;
wire   [37:0]  SLAVE_ARADDR;
wire   [1:0]   SLAVE_ARBURST;
wire   [3:0]   SLAVE_ARCACHE;
wire   [0:0]   SLAVE_ARID;
wire   [7:0]   SLAVE_ARLEN;
wire   [1:0]   SLAVE_ARLOCK;
wire   [2:0]   SLAVE_ARPROT;
wire   [3:0]   SLAVE_ARQOS;
wire           AXI4_SLAVE_ARREADY;
wire   [3:0]   SLAVE_ARREGION;
wire   [2:0]   SLAVE_ARSIZE;
wire   [0:0]   SLAVE_ARUSER;
wire           SLAVE_ARVALID;
wire   [37:0]  SLAVE_AWADDR;
wire   [1:0]   SLAVE_AWBURST;
wire   [3:0]   SLAVE_AWCACHE;
wire   [0:0]   SLAVE_AWID;
wire   [7:0]   SLAVE_AWLEN;
wire   [1:0]   SLAVE_AWLOCK;
wire   [2:0]   SLAVE_AWPROT;
wire   [3:0]   SLAVE_AWQOS;
wire           AXI4_SLAVE_AWREADY;
wire   [3:0]   SLAVE_AWREGION;
wire   [2:0]   SLAVE_AWSIZE;
wire   [0:0]   SLAVE_AWUSER;
wire           SLAVE_AWVALID;
wire   [0:0]   AXI4_SLAVE_BID;
wire           SLAVE_BREADY;
wire   [1:0]   AXI4_SLAVE_BRESP;
wire   [0:0]   AXI4_SLAVE_BUSER;
wire           AXI4_SLAVE_BVALID;
wire   [63:0]  AXI4_SLAVE_RDATA;
wire   [0:0]   AXI4_SLAVE_RID;
wire           AXI4_SLAVE_RLAST;
wire           SLAVE_RREADY;
wire   [1:0]   AXI4_SLAVE_RRESP;
wire   [0:0]   AXI4_SLAVE_RUSER;
wire           AXI4_SLAVE_RVALID;
wire   [63:0]  SLAVE_WDATA;
wire           SLAVE_WLAST;
wire           AXI4_SLAVE_WREADY;
wire   [7:0]   SLAVE_WSTRB;
wire   [0:0]   SLAVE_WUSER;
wire           SLAVE_WVALID;
wire           CLK;
wire   [37:0]  COREAXITOAXICONNECT_C0_0_MASTER_ARADDR;
wire           COREAXITOAXICONNECT_C0_0_MASTER_ARVALID;
wire   [37:0]  COREAXITOAXICONNECT_C0_0_MASTER_AWADDR;
wire           COREAXITOAXICONNECT_C0_0_MASTER_AWVALID;
wire           COREAXITOAXICONNECT_C0_0_MASTER_BREADY;
wire           COREAXITOAXICONNECT_C0_0_MASTER_RREADY;
wire   [63:0]  COREAXITOAXICONNECT_C0_0_MASTER_WDATA_2;
wire           COREAXITOAXICONNECT_C0_0_MASTER_WVALID;
wire   [127:0] crypto_accel_0_aes_ctr;
wire   [127:0] crypto_accel_0_aes_in_block;
wire           crypto_accel_0_aes_in_valid;
wire   [255:0] crypto_accel_0_aes_key;
wire           crypto_accel_0_aes_out_ready;
wire           crypto_accel_0_aes_rst;
wire   [63:0]  crypto_accel_0_rd_dat_1;
wire           crypto_accel_0_rd_valid;
wire           crypto_accel_0_rdaddr_ready;
wire   [1:0]   crypto_accel_0_rdresp_dat;
wire           crypto_accel_0_wr_ready;
wire           crypto_accel_0_wraddr_ready;
wire   [1:0]   crypto_accel_0_wrresp_dat;
wire           crypto_accel_0_wrresp_valid;
wire           AXI4_SLAVE_AWREADY_net_0;
wire           AXI4_SLAVE_WREADY_net_0;
wire           AXI4_SLAVE_BVALID_net_0;
wire           AXI4_SLAVE_ARREADY_net_0;
wire           AXI4_SLAVE_RLAST_net_0;
wire           AXI4_SLAVE_RVALID_net_0;
wire   [0:0]   AXI4_SLAVE_BID_net_0;
wire   [1:0]   AXI4_SLAVE_BRESP_net_0;
wire   [0:0]   AXI4_SLAVE_RID_net_0;
wire   [63:0]  AXI4_SLAVE_RDATA_net_0;
wire   [1:0]   AXI4_SLAVE_RRESP_net_0;
wire   [0:0]   AXI4_SLAVE_BUSER_net_0;
wire   [0:0]   AXI4_SLAVE_RUSER_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire           GND_net;
//--------------------------------------------------------------------
// Inverted Nets
//--------------------------------------------------------------------
wire           rst_IN_POST_INV0_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net    = 1'b0;
//--------------------------------------------------------------------
// Inversions
//--------------------------------------------------------------------
assign rst_IN_POST_INV0_0 = ~ ARESET;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign AXI4_SLAVE_AWREADY_net_0  = AXI4_SLAVE_AWREADY;
assign SLAVE_AWREADY             = AXI4_SLAVE_AWREADY_net_0;
assign AXI4_SLAVE_WREADY_net_0   = AXI4_SLAVE_WREADY;
assign SLAVE_WREADY              = AXI4_SLAVE_WREADY_net_0;
assign AXI4_SLAVE_BVALID_net_0   = AXI4_SLAVE_BVALID;
assign SLAVE_BVALID              = AXI4_SLAVE_BVALID_net_0;
assign AXI4_SLAVE_ARREADY_net_0  = AXI4_SLAVE_ARREADY;
assign SLAVE_ARREADY             = AXI4_SLAVE_ARREADY_net_0;
assign AXI4_SLAVE_RLAST_net_0    = AXI4_SLAVE_RLAST;
assign SLAVE_RLAST               = AXI4_SLAVE_RLAST_net_0;
assign AXI4_SLAVE_RVALID_net_0   = AXI4_SLAVE_RVALID;
assign SLAVE_RVALID              = AXI4_SLAVE_RVALID_net_0;
assign AXI4_SLAVE_BID_net_0[0]   = AXI4_SLAVE_BID[0];
assign SLAVE_BID[0:0]            = AXI4_SLAVE_BID_net_0[0];
assign AXI4_SLAVE_BRESP_net_0    = AXI4_SLAVE_BRESP;
assign SLAVE_BRESP[1:0]          = AXI4_SLAVE_BRESP_net_0;
assign AXI4_SLAVE_RID_net_0[0]   = AXI4_SLAVE_RID[0];
assign SLAVE_RID[0:0]            = AXI4_SLAVE_RID_net_0[0];
assign AXI4_SLAVE_RDATA_net_0    = AXI4_SLAVE_RDATA;
assign SLAVE_RDATA[63:0]         = AXI4_SLAVE_RDATA_net_0;
assign AXI4_SLAVE_RRESP_net_0    = AXI4_SLAVE_RRESP;
assign SLAVE_RRESP[1:0]          = AXI4_SLAVE_RRESP_net_0;
assign AXI4_SLAVE_BUSER_net_0[0] = AXI4_SLAVE_BUSER[0];
assign SLAVE_BUSER[0:0]          = AXI4_SLAVE_BUSER_net_0[0];
assign AXI4_SLAVE_RUSER_net_0[0] = AXI4_SLAVE_RUSER[0];
assign SLAVE_RUSER[0:0]          = AXI4_SLAVE_RUSER_net_0[0];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------aes256_fifo
aes256_fifo aes256_fifo_0(
        // Inputs
        .clk           ( CLK ),
        .rst           ( crypto_accel_0_aes_rst ),
        .aes_in_valid  ( crypto_accel_0_aes_in_valid ),
        .aes_out_ready ( crypto_accel_0_aes_out_ready ),
        .aes_in_block  ( crypto_accel_0_aes_in_block ),
        .aes_ctr       ( crypto_accel_0_aes_ctr ),
        .aes_key       ( crypto_accel_0_aes_key ),
        // Outputs
        .aes_in_ready  ( aes256_fifo_0_aes_in_ready ),
        .aes_out_valid ( aes256_fifo_0_aes_out_valid ),
        .empty         ( aes256_fifo_0_empty ),
        .aes_out_block ( aes256_fifo_0_aes_out_block ) 
        );

//--------COREAXITOAXICONNECT_C0
COREAXITOAXICONNECT_C0 COREAXITOAXICONNECT_C0_0(
        // Inputs
        .SLAVE_AWVALID   ( SLAVE_AWVALID ),
        .SLAVE_WLAST     ( SLAVE_WLAST ),
        .SLAVE_WVALID    ( SLAVE_WVALID ),
        .SLAVE_BREADY    ( SLAVE_BREADY ),
        .SLAVE_ARVALID   ( SLAVE_ARVALID ),
        .SLAVE_RREADY    ( SLAVE_RREADY ),
        .MASTER_AWREADY  ( crypto_accel_0_wraddr_ready ),
        .MASTER_WREADY   ( crypto_accel_0_wr_ready ),
        .MASTER_BVALID   ( crypto_accel_0_wrresp_valid ),
        .MASTER_ARREADY  ( crypto_accel_0_rdaddr_ready ),
        .MASTER_RLAST    ( GND_net ), // tied to 1'b0 from definition
        .MASTER_RVALID   ( crypto_accel_0_rd_valid ),
        .SLAVE_AWID      ( SLAVE_AWID ),
        .SLAVE_AWADDR    ( SLAVE_AWADDR ),
        .SLAVE_AWLEN     ( SLAVE_AWLEN ),
        .SLAVE_AWSIZE    ( SLAVE_AWSIZE ),
        .SLAVE_AWBURST   ( SLAVE_AWBURST ),
        .SLAVE_AWLOCK    ( SLAVE_AWLOCK ),
        .SLAVE_AWCACHE   ( SLAVE_AWCACHE ),
        .SLAVE_AWPROT    ( SLAVE_AWPROT ),
        .SLAVE_AWQOS     ( SLAVE_AWQOS ),
        .SLAVE_AWREGION  ( SLAVE_AWREGION ),
        .SLAVE_WDATA     ( SLAVE_WDATA ),
        .SLAVE_WSTRB     ( SLAVE_WSTRB ),
        .SLAVE_ARID      ( SLAVE_ARID ),
        .SLAVE_ARADDR    ( SLAVE_ARADDR ),
        .SLAVE_ARLEN     ( SLAVE_ARLEN ),
        .SLAVE_ARSIZE    ( SLAVE_ARSIZE ),
        .SLAVE_ARBURST   ( SLAVE_ARBURST ),
        .SLAVE_ARLOCK    ( SLAVE_ARLOCK ),
        .SLAVE_ARCACHE   ( SLAVE_ARCACHE ),
        .SLAVE_ARPROT    ( SLAVE_ARPROT ),
        .SLAVE_ARQOS     ( SLAVE_ARQOS ),
        .SLAVE_ARREGION  ( SLAVE_ARREGION ),
        .SLAVE_AWUSER    ( SLAVE_AWUSER ),
        .SLAVE_WUSER     ( SLAVE_WUSER ),
        .SLAVE_ARUSER    ( SLAVE_ARUSER ),
        .MASTER_BID      ( GND_net ), // tied to 1'b0 from definition
        .MASTER_BRESP    ( crypto_accel_0_wrresp_dat ),
        .MASTER_RID      ( GND_net ), // tied to 1'b0 from definition
        .MASTER_RDATA    ( crypto_accel_0_rd_dat_1 ),
        .MASTER_RRESP    ( crypto_accel_0_rdresp_dat ),
        .MASTER_BUSER    ( GND_net ), // tied to 1'b0 from definition
        .MASTER_RUSER    ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .SLAVE_AWREADY   ( AXI4_SLAVE_AWREADY ),
        .SLAVE_WREADY    ( AXI4_SLAVE_WREADY ),
        .SLAVE_BVALID    ( AXI4_SLAVE_BVALID ),
        .SLAVE_ARREADY   ( AXI4_SLAVE_ARREADY ),
        .SLAVE_RLAST     ( AXI4_SLAVE_RLAST ),
        .SLAVE_RVALID    ( AXI4_SLAVE_RVALID ),
        .MASTER_AWVALID  ( COREAXITOAXICONNECT_C0_0_MASTER_AWVALID ),
        .MASTER_WLAST    (  ),
        .MASTER_WVALID   ( COREAXITOAXICONNECT_C0_0_MASTER_WVALID ),
        .MASTER_BREADY   ( COREAXITOAXICONNECT_C0_0_MASTER_BREADY ),
        .MASTER_ARVALID  ( COREAXITOAXICONNECT_C0_0_MASTER_ARVALID ),
        .MASTER_RREADY   ( COREAXITOAXICONNECT_C0_0_MASTER_RREADY ),
        .SLAVE_BID       ( AXI4_SLAVE_BID ),
        .SLAVE_BRESP     ( AXI4_SLAVE_BRESP ),
        .SLAVE_RID       ( AXI4_SLAVE_RID ),
        .SLAVE_RDATA     ( AXI4_SLAVE_RDATA ),
        .SLAVE_RRESP     ( AXI4_SLAVE_RRESP ),
        .SLAVE_BUSER     ( AXI4_SLAVE_BUSER ),
        .SLAVE_RUSER     ( AXI4_SLAVE_RUSER ),
        .MASTER_AWID     (  ),
        .MASTER_AWADDR   ( COREAXITOAXICONNECT_C0_0_MASTER_AWADDR ),
        .MASTER_AWLEN    (  ),
        .MASTER_AWSIZE   (  ),
        .MASTER_AWBURST  (  ),
        .MASTER_AWLOCK   (  ),
        .MASTER_AWCACHE  (  ),
        .MASTER_AWPROT   (  ),
        .MASTER_AWQOS    (  ),
        .MASTER_AWREGION (  ),
        .MASTER_WDATA    ( COREAXITOAXICONNECT_C0_0_MASTER_WDATA_2 ),
        .MASTER_WSTRB    (  ),
        .MASTER_ARID     (  ),
        .MASTER_ARADDR   ( COREAXITOAXICONNECT_C0_0_MASTER_ARADDR ),
        .MASTER_ARLEN    (  ),
        .MASTER_ARSIZE   (  ),
        .MASTER_ARBURST  (  ),
        .MASTER_ARLOCK   (  ),
        .MASTER_ARCACHE  (  ),
        .MASTER_ARPROT   (  ),
        .MASTER_ARQOS    (  ),
        .MASTER_ARREGION (  ),
        .MASTER_AWUSER   (  ),
        .MASTER_WUSER    (  ),
        .MASTER_ARUSER   (  ) 
        );

//--------crypto_accel
crypto_accel crypto_accel_0(
        // Inputs
        .clk            ( CLK ),
        .rst            ( rst_IN_POST_INV0_0 ),
        .wraddr_valid   ( COREAXITOAXICONNECT_C0_0_MASTER_AWVALID ),
        .wr_valid       ( COREAXITOAXICONNECT_C0_0_MASTER_WVALID ),
        .wrresp_ready   ( COREAXITOAXICONNECT_C0_0_MASTER_BREADY ),
        .rdaddr_valid   ( COREAXITOAXICONNECT_C0_0_MASTER_ARVALID ),
        .rd_ready       ( COREAXITOAXICONNECT_C0_0_MASTER_RREADY ),
        .aes_in_ready   ( aes256_fifo_0_aes_in_ready ),
        .aes_out_valid  ( aes256_fifo_0_aes_out_valid ),
        .aes_fifo_empty ( aes256_fifo_0_empty ),
        .wraddr         ( COREAXITOAXICONNECT_C0_0_MASTER_AWADDR ),
        .wr_dat         ( COREAXITOAXICONNECT_C0_0_MASTER_WDATA_2 ),
        .rdaddr         ( COREAXITOAXICONNECT_C0_0_MASTER_ARADDR ),
        .aes_out_block  ( aes256_fifo_0_aes_out_block ),
        // Outputs
        .wraddr_ready   ( crypto_accel_0_wraddr_ready ),
        .wr_ready       ( crypto_accel_0_wr_ready ),
        .wrresp_valid   ( crypto_accel_0_wrresp_valid ),
        .rdaddr_ready   ( crypto_accel_0_rdaddr_ready ),
        .rd_valid       ( crypto_accel_0_rd_valid ),
        .aes_in_valid   ( crypto_accel_0_aes_in_valid ),
        .aes_out_ready  ( crypto_accel_0_aes_out_ready ),
        .aes_rst        ( crypto_accel_0_aes_rst ),
        .wrresp_dat     ( crypto_accel_0_wrresp_dat ),
        .rd_dat         ( crypto_accel_0_rd_dat_1 ),
        .rdresp_dat     ( crypto_accel_0_rdresp_dat ),
        .aes_key        ( crypto_accel_0_aes_key ),
        .aes_ctr        ( crypto_accel_0_aes_ctr ),
        .aes_in_block   ( crypto_accel_0_aes_in_block ) 
        );


endmodule
