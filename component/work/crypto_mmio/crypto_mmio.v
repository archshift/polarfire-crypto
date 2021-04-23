//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Apr 22 16:58:29 2021
// Version: v12.6 12.900.20.24
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// crypto_mmio
module crypto_mmio(
    // Inputs
    ARESETN,
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
input         ARESETN;
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
wire   [4:0]   aes256_fifo_0_pending_blks;
wire           ARESETN;
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
wire   [2:0]   COREAXITOAXICONNECT_C0_0_MASTER_ARPROT;
wire           COREAXITOAXICONNECT_C0_0_MASTER_ARVALID;
wire   [37:0]  COREAXITOAXICONNECT_C0_0_MASTER_AWADDR;
wire   [2:0]   COREAXITOAXICONNECT_C0_0_MASTER_AWPROT;
wire           COREAXITOAXICONNECT_C0_0_MASTER_AWVALID;
wire           COREAXITOAXICONNECT_C0_0_MASTER_BREADY;
wire           COREAXITOAXICONNECT_C0_0_MASTER_RREADY;
wire   [63:0]  COREAXITOAXICONNECT_C0_0_MASTER_WDATA_3;
wire   [7:0]   COREAXITOAXICONNECT_C0_0_MASTER_WSTRB;
wire           COREAXITOAXICONNECT_C0_0_MASTER_WVALID;
wire   [127:0] crypto_accel_0_aes_ctr;
wire   [127:0] crypto_accel_0_aes_in_block;
wire           crypto_accel_0_aes_in_valid;
wire   [255:0] crypto_accel_0_aes_key;
wire           crypto_accel_0_aes_out_ready;
wire           crypto_accel_0_aes_rst;
wire           crypto_accel_0_ctl_busy;
wire           crypto_accel_0_ctl_ififo_full;
wire           crypto_accel_0_ctl_ofifo_empty;
wire   [63:0]  crypto_accel_0_fifo_rdata;
wire   [0:0]   SoftAES_regs_0_ctl_auto_inc;
wire   [0:0]   SoftAES_regs_0_ctl_rst;
wire           SoftAES_regs_0_ctl_strobe;
wire   [0:0]   SoftAES_regs_0_ctr_addr_1;
wire   [63:0]  SoftAES_regs_0_ctr_wdata;
wire   [0:0]   SoftAES_regs_0_ctr_wen;
wire   [0:0]   SoftAES_regs_0_fifo_ren;
wire   [63:0]  SoftAES_regs_0_fifo_wdata;
wire   [0:0]   SoftAES_regs_0_fifo_wen;
wire   [1:0]   SoftAES_regs_0_key_addr_1;
wire   [63:0]  SoftAES_regs_0_key_wdata;
wire   [0:0]   SoftAES_regs_0_key_wen;
wire           SoftAES_regs_0_s_axi_arready;
wire           SoftAES_regs_0_s_axi_awready;
wire   [1:0]   SoftAES_regs_0_s_axi_bresp;
wire           SoftAES_regs_0_s_axi_bvalid;
wire   [63:0]  SoftAES_regs_0_s_axi_rdata;
wire   [1:0]   SoftAES_regs_0_s_axi_rresp;
wire           SoftAES_regs_0_s_axi_rvalid;
wire           SoftAES_regs_0_s_axi_wready;
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
assign rst_IN_POST_INV0_0 = ~ ARESETN;
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
        .aes_out_block ( aes256_fifo_0_aes_out_block ),
        .pending_blks  ( aes256_fifo_0_pending_blks ) 
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
        .MASTER_AWREADY  ( SoftAES_regs_0_s_axi_awready ),
        .MASTER_WREADY   ( SoftAES_regs_0_s_axi_wready ),
        .MASTER_BVALID   ( SoftAES_regs_0_s_axi_bvalid ),
        .MASTER_ARREADY  ( SoftAES_regs_0_s_axi_arready ),
        .MASTER_RLAST    ( GND_net ), // tied to 1'b0 from definition
        .MASTER_RVALID   ( SoftAES_regs_0_s_axi_rvalid ),
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
        .MASTER_BRESP    ( SoftAES_regs_0_s_axi_bresp ),
        .MASTER_RID      ( GND_net ), // tied to 1'b0 from definition
        .MASTER_RDATA    ( SoftAES_regs_0_s_axi_rdata ),
        .MASTER_RRESP    ( SoftAES_regs_0_s_axi_rresp ),
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
        .MASTER_AWPROT   ( COREAXITOAXICONNECT_C0_0_MASTER_AWPROT ),
        .MASTER_AWQOS    (  ),
        .MASTER_AWREGION (  ),
        .MASTER_WDATA    ( COREAXITOAXICONNECT_C0_0_MASTER_WDATA_3 ),
        .MASTER_WSTRB    ( COREAXITOAXICONNECT_C0_0_MASTER_WSTRB ),
        .MASTER_ARID     (  ),
        .MASTER_ARADDR   ( COREAXITOAXICONNECT_C0_0_MASTER_ARADDR ),
        .MASTER_ARLEN    (  ),
        .MASTER_ARSIZE   (  ),
        .MASTER_ARBURST  (  ),
        .MASTER_ARLOCK   (  ),
        .MASTER_ARCACHE  (  ),
        .MASTER_ARPROT   ( COREAXITOAXICONNECT_C0_0_MASTER_ARPROT ),
        .MASTER_ARQOS    (  ),
        .MASTER_ARREGION (  ),
        .MASTER_AWUSER   (  ),
        .MASTER_WUSER    (  ),
        .MASTER_ARUSER   (  ) 
        );

//--------crypto_accel
crypto_accel crypto_accel_0(
        // Inputs
        .clk              ( CLK ),
        .rst              ( rst_IN_POST_INV0_0 ),
        .ctl_strobe       ( SoftAES_regs_0_ctl_strobe ),
        .ctl_auto_inc     ( SoftAES_regs_0_ctl_auto_inc ),
        .ctl_rst          ( SoftAES_regs_0_ctl_rst ),
        .ctr_addr         ( SoftAES_regs_0_ctr_addr_1 ),
        .ctr_wdata        ( SoftAES_regs_0_ctr_wdata ),
        .ctr_wen          ( SoftAES_regs_0_ctr_wen ),
        .key_addr         ( SoftAES_regs_0_key_addr_1 ),
        .key_wdata        ( SoftAES_regs_0_key_wdata ),
        .key_wen          ( SoftAES_regs_0_key_wen ),
        .fifo_wdata       ( SoftAES_regs_0_fifo_wdata ),
        .fifo_wen         ( SoftAES_regs_0_fifo_wen ),
        .fifo_ren         ( SoftAES_regs_0_fifo_ren ),
        .aes_in_ready     ( aes256_fifo_0_aes_in_ready ),
        .aes_out_valid    ( aes256_fifo_0_aes_out_valid ),
        .aes_out_block    ( aes256_fifo_0_aes_out_block ),
        .aes_fifo_empty   ( aes256_fifo_0_empty ),
        .aes_pending_blks ( aes256_fifo_0_pending_blks ),
        // Outputs
        .ctl_busy         ( crypto_accel_0_ctl_busy ),
        .ctl_ofifo_empty  ( crypto_accel_0_ctl_ofifo_empty ),
        .ctl_ififo_full   ( crypto_accel_0_ctl_ififo_full ),
        .fifo_rdata       ( crypto_accel_0_fifo_rdata ),
        .aes_key          ( crypto_accel_0_aes_key ),
        .aes_ctr          ( crypto_accel_0_aes_ctr ),
        .aes_in_valid     ( crypto_accel_0_aes_in_valid ),
        .aes_in_block     ( crypto_accel_0_aes_in_block ),
        .aes_out_ready    ( crypto_accel_0_aes_out_ready ),
        .aes_rst          ( crypto_accel_0_aes_rst ) 
        );

//--------SoftAES_regs
SoftAES_regs SoftAES_regs_0(
        // Inputs
        .axi_aclk        ( CLK ),
        .axi_aresetn     ( ARESETN ),
        .s_axi_awaddr    ( COREAXITOAXICONNECT_C0_0_MASTER_AWADDR ),
        .s_axi_awprot    ( COREAXITOAXICONNECT_C0_0_MASTER_AWPROT ),
        .s_axi_awvalid   ( COREAXITOAXICONNECT_C0_0_MASTER_AWVALID ),
        .s_axi_wdata     ( COREAXITOAXICONNECT_C0_0_MASTER_WDATA_3 ),
        .s_axi_wstrb     ( COREAXITOAXICONNECT_C0_0_MASTER_WSTRB ),
        .s_axi_wvalid    ( COREAXITOAXICONNECT_C0_0_MASTER_WVALID ),
        .s_axi_araddr    ( COREAXITOAXICONNECT_C0_0_MASTER_ARADDR ),
        .s_axi_arprot    ( COREAXITOAXICONNECT_C0_0_MASTER_ARPROT ),
        .s_axi_arvalid   ( COREAXITOAXICONNECT_C0_0_MASTER_ARVALID ),
        .s_axi_rready    ( COREAXITOAXICONNECT_C0_0_MASTER_RREADY ),
        .s_axi_bready    ( COREAXITOAXICONNECT_C0_0_MASTER_BREADY ),
        .ctl_busy        ( crypto_accel_0_ctl_busy ),
        .ctl_ofifo_empty ( crypto_accel_0_ctl_ofifo_empty ),
        .ctl_ififo_full  ( crypto_accel_0_ctl_ififo_full ),
        .fifo_rdata      ( crypto_accel_0_fifo_rdata ),
        // Outputs
        .s_axi_awready   ( SoftAES_regs_0_s_axi_awready ),
        .s_axi_wready    ( SoftAES_regs_0_s_axi_wready ),
        .s_axi_arready   ( SoftAES_regs_0_s_axi_arready ),
        .s_axi_rdata     ( SoftAES_regs_0_s_axi_rdata ),
        .s_axi_rresp     ( SoftAES_regs_0_s_axi_rresp ),
        .s_axi_rvalid    ( SoftAES_regs_0_s_axi_rvalid ),
        .s_axi_bresp     ( SoftAES_regs_0_s_axi_bresp ),
        .s_axi_bvalid    ( SoftAES_regs_0_s_axi_bvalid ),
        .ctl_strobe      ( SoftAES_regs_0_ctl_strobe ),
        .ctl_auto_inc    ( SoftAES_regs_0_ctl_auto_inc ),
        .ctl_rst         ( SoftAES_regs_0_ctl_rst ),
        .ctr_addr        ( SoftAES_regs_0_ctr_addr_1 ),
        .ctr_wdata       ( SoftAES_regs_0_ctr_wdata ),
        .ctr_wen         ( SoftAES_regs_0_ctr_wen ),
        .key_addr        ( SoftAES_regs_0_key_addr_1 ),
        .key_wdata       ( SoftAES_regs_0_key_wdata ),
        .key_wen         ( SoftAES_regs_0_key_wen ),
        .fifo_addr       (  ),
        .fifo_wdata      ( SoftAES_regs_0_fifo_wdata ),
        .fifo_wen        ( SoftAES_regs_0_fifo_wen ),
        .fifo_ren        ( SoftAES_regs_0_fifo_ren ) 
        );


endmodule
