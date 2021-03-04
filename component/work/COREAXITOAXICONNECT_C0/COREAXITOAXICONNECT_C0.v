//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed Mar  3 02:42:03 2021
// Version: v12.6 12.900.20.24
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of COREAXITOAXICONNECT_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS250T_ES-FCVG484E
# Create and Configure the core component COREAXITOAXICONNECT_C0
create_and_configure_core -core_vlnv {Actel:DirectCore:COREAXITOAXICONNECT:2.0.101} -component_name {COREAXITOAXICONNECT_C0} -params {\
"SLAVE_ADDR_WIDTH:38"  \
"SLAVE_DATA_WIDTH:64"  \
"SLAVE_ID_WIDTH:1"  \
"SLAVE_TYPE:1"  \
"SLAVE_USER_WIDTH:1"   }
# Exporting Component Description of COREAXITOAXICONNECT_C0 to TCL done
*/

// COREAXITOAXICONNECT_C0
module COREAXITOAXICONNECT_C0(
    // Inputs
    MASTER_ARREADY,
    MASTER_AWREADY,
    MASTER_BID,
    MASTER_BRESP,
    MASTER_BUSER,
    MASTER_BVALID,
    MASTER_RDATA,
    MASTER_RID,
    MASTER_RLAST,
    MASTER_RRESP,
    MASTER_RUSER,
    MASTER_RVALID,
    MASTER_WREADY,
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
    MASTER_ARADDR,
    MASTER_ARBURST,
    MASTER_ARCACHE,
    MASTER_ARID,
    MASTER_ARLEN,
    MASTER_ARLOCK,
    MASTER_ARPROT,
    MASTER_ARQOS,
    MASTER_ARREGION,
    MASTER_ARSIZE,
    MASTER_ARUSER,
    MASTER_ARVALID,
    MASTER_AWADDR,
    MASTER_AWBURST,
    MASTER_AWCACHE,
    MASTER_AWID,
    MASTER_AWLEN,
    MASTER_AWLOCK,
    MASTER_AWPROT,
    MASTER_AWQOS,
    MASTER_AWREGION,
    MASTER_AWSIZE,
    MASTER_AWUSER,
    MASTER_AWVALID,
    MASTER_BREADY,
    MASTER_RREADY,
    MASTER_WDATA,
    MASTER_WLAST,
    MASTER_WSTRB,
    MASTER_WUSER,
    MASTER_WVALID,
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
input         MASTER_ARREADY;
input         MASTER_AWREADY;
input  [0:0]  MASTER_BID;
input  [1:0]  MASTER_BRESP;
input  [0:0]  MASTER_BUSER;
input         MASTER_BVALID;
input  [63:0] MASTER_RDATA;
input  [0:0]  MASTER_RID;
input         MASTER_RLAST;
input  [1:0]  MASTER_RRESP;
input  [0:0]  MASTER_RUSER;
input         MASTER_RVALID;
input         MASTER_WREADY;
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
output [37:0] MASTER_ARADDR;
output [1:0]  MASTER_ARBURST;
output [3:0]  MASTER_ARCACHE;
output [0:0]  MASTER_ARID;
output [7:0]  MASTER_ARLEN;
output [1:0]  MASTER_ARLOCK;
output [2:0]  MASTER_ARPROT;
output [3:0]  MASTER_ARQOS;
output [3:0]  MASTER_ARREGION;
output [2:0]  MASTER_ARSIZE;
output [0:0]  MASTER_ARUSER;
output        MASTER_ARVALID;
output [37:0] MASTER_AWADDR;
output [1:0]  MASTER_AWBURST;
output [3:0]  MASTER_AWCACHE;
output [0:0]  MASTER_AWID;
output [7:0]  MASTER_AWLEN;
output [1:0]  MASTER_AWLOCK;
output [2:0]  MASTER_AWPROT;
output [3:0]  MASTER_AWQOS;
output [3:0]  MASTER_AWREGION;
output [2:0]  MASTER_AWSIZE;
output [0:0]  MASTER_AWUSER;
output        MASTER_AWVALID;
output        MASTER_BREADY;
output        MASTER_RREADY;
output [63:0] MASTER_WDATA;
output        MASTER_WLAST;
output [7:0]  MASTER_WSTRB;
output [0:0]  MASTER_WUSER;
output        MASTER_WVALID;
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
wire   [37:0] AXI4_MASTER_3_ARADDR;
wire   [1:0]  AXI4_MASTER_3_ARBURST;
wire   [3:0]  AXI4_MASTER_3_ARCACHE;
wire   [0:0]  AXI4_MASTER_3_ARID;
wire   [7:0]  AXI4_MASTER_3_ARLEN;
wire   [1:0]  AXI4_MASTER_3_ARLOCK;
wire   [2:0]  AXI4_MASTER_3_ARPROT;
wire   [3:0]  AXI4_MASTER_3_ARQOS;
wire          MASTER_ARREADY;
wire   [3:0]  AXI4_MASTER_3_ARREGION;
wire   [2:0]  AXI4_MASTER_3_ARSIZE;
wire   [0:0]  AXI4_MASTER_3_ARUSER;
wire          AXI4_MASTER_3_ARVALID;
wire   [37:0] AXI4_MASTER_3_AWADDR;
wire   [1:0]  AXI4_MASTER_3_AWBURST;
wire   [3:0]  AXI4_MASTER_3_AWCACHE;
wire   [0:0]  AXI4_MASTER_3_AWID;
wire   [7:0]  AXI4_MASTER_3_AWLEN;
wire   [1:0]  AXI4_MASTER_3_AWLOCK;
wire   [2:0]  AXI4_MASTER_3_AWPROT;
wire   [3:0]  AXI4_MASTER_3_AWQOS;
wire          MASTER_AWREADY;
wire   [3:0]  AXI4_MASTER_3_AWREGION;
wire   [2:0]  AXI4_MASTER_3_AWSIZE;
wire   [0:0]  AXI4_MASTER_3_AWUSER;
wire          AXI4_MASTER_3_AWVALID;
wire   [0:0]  MASTER_BID;
wire          AXI4_MASTER_3_BREADY;
wire   [1:0]  MASTER_BRESP;
wire   [0:0]  MASTER_BUSER;
wire          MASTER_BVALID;
wire   [63:0] MASTER_RDATA;
wire   [0:0]  MASTER_RID;
wire          MASTER_RLAST;
wire          AXI4_MASTER_3_RREADY;
wire   [1:0]  MASTER_RRESP;
wire   [0:0]  MASTER_RUSER;
wire          MASTER_RVALID;
wire   [63:0] AXI4_MASTER_3_WDATA;
wire          AXI4_MASTER_3_WLAST;
wire          MASTER_WREADY;
wire   [7:0]  AXI4_MASTER_3_WSTRB;
wire   [0:0]  AXI4_MASTER_3_WUSER;
wire          AXI4_MASTER_3_WVALID;
wire   [37:0] SLAVE_ARADDR;
wire   [1:0]  SLAVE_ARBURST;
wire   [3:0]  SLAVE_ARCACHE;
wire   [0:0]  SLAVE_ARID;
wire   [7:0]  SLAVE_ARLEN;
wire   [1:0]  SLAVE_ARLOCK;
wire   [2:0]  SLAVE_ARPROT;
wire   [3:0]  SLAVE_ARQOS;
wire          AXI4_SLAVE_ARREADY;
wire   [3:0]  SLAVE_ARREGION;
wire   [2:0]  SLAVE_ARSIZE;
wire   [0:0]  SLAVE_ARUSER;
wire          SLAVE_ARVALID;
wire   [37:0] SLAVE_AWADDR;
wire   [1:0]  SLAVE_AWBURST;
wire   [3:0]  SLAVE_AWCACHE;
wire   [0:0]  SLAVE_AWID;
wire   [7:0]  SLAVE_AWLEN;
wire   [1:0]  SLAVE_AWLOCK;
wire   [2:0]  SLAVE_AWPROT;
wire   [3:0]  SLAVE_AWQOS;
wire          AXI4_SLAVE_AWREADY;
wire   [3:0]  SLAVE_AWREGION;
wire   [2:0]  SLAVE_AWSIZE;
wire   [0:0]  SLAVE_AWUSER;
wire          SLAVE_AWVALID;
wire   [0:0]  AXI4_SLAVE_BID;
wire          SLAVE_BREADY;
wire   [1:0]  AXI4_SLAVE_BRESP;
wire   [0:0]  AXI4_SLAVE_BUSER;
wire          AXI4_SLAVE_BVALID;
wire   [63:0] AXI4_SLAVE_RDATA;
wire   [0:0]  AXI4_SLAVE_RID;
wire          AXI4_SLAVE_RLAST;
wire          SLAVE_RREADY;
wire   [1:0]  AXI4_SLAVE_RRESP;
wire   [0:0]  AXI4_SLAVE_RUSER;
wire          AXI4_SLAVE_RVALID;
wire   [63:0] SLAVE_WDATA;
wire          SLAVE_WLAST;
wire          AXI4_SLAVE_WREADY;
wire   [7:0]  SLAVE_WSTRB;
wire   [0:0]  SLAVE_WUSER;
wire          SLAVE_WVALID;
wire          AXI4_SLAVE_AWREADY_net_0;
wire          AXI4_SLAVE_WREADY_net_0;
wire   [0:0]  AXI4_SLAVE_BID_net_0;
wire   [1:0]  AXI4_SLAVE_BRESP_net_0;
wire          AXI4_SLAVE_BVALID_net_0;
wire          AXI4_SLAVE_ARREADY_net_0;
wire   [0:0]  AXI4_SLAVE_RID_net_0;
wire   [63:0] AXI4_SLAVE_RDATA_net_0;
wire   [1:0]  AXI4_SLAVE_RRESP_net_0;
wire          AXI4_SLAVE_RLAST_net_0;
wire          AXI4_SLAVE_RVALID_net_0;
wire   [0:0]  AXI4_SLAVE_BUSER_net_0;
wire   [0:0]  AXI4_SLAVE_RUSER_net_0;
wire   [0:0]  AXI4_MASTER_3_AWID_net_0;
wire   [37:0] AXI4_MASTER_3_AWADDR_net_0;
wire   [7:0]  AXI4_MASTER_3_AWLEN_net_0;
wire   [2:0]  AXI4_MASTER_3_AWSIZE_net_0;
wire   [1:0]  AXI4_MASTER_3_AWBURST_net_0;
wire   [1:0]  AXI4_MASTER_3_AWLOCK_net_0;
wire   [3:0]  AXI4_MASTER_3_AWCACHE_net_0;
wire   [2:0]  AXI4_MASTER_3_AWPROT_net_0;
wire   [3:0]  AXI4_MASTER_3_AWQOS_net_0;
wire   [3:0]  AXI4_MASTER_3_AWREGION_net_0;
wire          AXI4_MASTER_3_AWVALID_net_0;
wire   [63:0] AXI4_MASTER_3_WDATA_net_0;
wire   [7:0]  AXI4_MASTER_3_WSTRB_net_0;
wire          AXI4_MASTER_3_WLAST_net_0;
wire          AXI4_MASTER_3_WVALID_net_0;
wire          AXI4_MASTER_3_BREADY_net_0;
wire   [0:0]  AXI4_MASTER_3_ARID_net_0;
wire   [37:0] AXI4_MASTER_3_ARADDR_net_0;
wire   [7:0]  AXI4_MASTER_3_ARLEN_net_0;
wire   [2:0]  AXI4_MASTER_3_ARSIZE_net_0;
wire   [1:0]  AXI4_MASTER_3_ARBURST_net_0;
wire   [1:0]  AXI4_MASTER_3_ARLOCK_net_0;
wire   [3:0]  AXI4_MASTER_3_ARCACHE_net_0;
wire   [2:0]  AXI4_MASTER_3_ARPROT_net_0;
wire   [3:0]  AXI4_MASTER_3_ARQOS_net_0;
wire   [3:0]  AXI4_MASTER_3_ARREGION_net_0;
wire          AXI4_MASTER_3_ARVALID_net_0;
wire          AXI4_MASTER_3_RREADY_net_0;
wire   [0:0]  AXI4_MASTER_3_AWUSER_net_0;
wire   [0:0]  AXI4_MASTER_3_WUSER_net_0;
wire   [0:0]  AXI4_MASTER_3_ARUSER_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net    = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign AXI4_SLAVE_AWREADY_net_0      = AXI4_SLAVE_AWREADY;
assign SLAVE_AWREADY                 = AXI4_SLAVE_AWREADY_net_0;
assign AXI4_SLAVE_WREADY_net_0       = AXI4_SLAVE_WREADY;
assign SLAVE_WREADY                  = AXI4_SLAVE_WREADY_net_0;
assign AXI4_SLAVE_BID_net_0[0]       = AXI4_SLAVE_BID[0];
assign SLAVE_BID[0:0]                = AXI4_SLAVE_BID_net_0[0];
assign AXI4_SLAVE_BRESP_net_0        = AXI4_SLAVE_BRESP;
assign SLAVE_BRESP[1:0]              = AXI4_SLAVE_BRESP_net_0;
assign AXI4_SLAVE_BVALID_net_0       = AXI4_SLAVE_BVALID;
assign SLAVE_BVALID                  = AXI4_SLAVE_BVALID_net_0;
assign AXI4_SLAVE_ARREADY_net_0      = AXI4_SLAVE_ARREADY;
assign SLAVE_ARREADY                 = AXI4_SLAVE_ARREADY_net_0;
assign AXI4_SLAVE_RID_net_0[0]       = AXI4_SLAVE_RID[0];
assign SLAVE_RID[0:0]                = AXI4_SLAVE_RID_net_0[0];
assign AXI4_SLAVE_RDATA_net_0        = AXI4_SLAVE_RDATA;
assign SLAVE_RDATA[63:0]             = AXI4_SLAVE_RDATA_net_0;
assign AXI4_SLAVE_RRESP_net_0        = AXI4_SLAVE_RRESP;
assign SLAVE_RRESP[1:0]              = AXI4_SLAVE_RRESP_net_0;
assign AXI4_SLAVE_RLAST_net_0        = AXI4_SLAVE_RLAST;
assign SLAVE_RLAST                   = AXI4_SLAVE_RLAST_net_0;
assign AXI4_SLAVE_RVALID_net_0       = AXI4_SLAVE_RVALID;
assign SLAVE_RVALID                  = AXI4_SLAVE_RVALID_net_0;
assign AXI4_SLAVE_BUSER_net_0[0]     = AXI4_SLAVE_BUSER[0];
assign SLAVE_BUSER[0:0]              = AXI4_SLAVE_BUSER_net_0[0];
assign AXI4_SLAVE_RUSER_net_0[0]     = AXI4_SLAVE_RUSER[0];
assign SLAVE_RUSER[0:0]              = AXI4_SLAVE_RUSER_net_0[0];
assign AXI4_MASTER_3_AWID_net_0[0]   = AXI4_MASTER_3_AWID[0];
assign MASTER_AWID[0:0]              = AXI4_MASTER_3_AWID_net_0[0];
assign AXI4_MASTER_3_AWADDR_net_0    = AXI4_MASTER_3_AWADDR;
assign MASTER_AWADDR[37:0]           = AXI4_MASTER_3_AWADDR_net_0;
assign AXI4_MASTER_3_AWLEN_net_0     = AXI4_MASTER_3_AWLEN;
assign MASTER_AWLEN[7:0]             = AXI4_MASTER_3_AWLEN_net_0;
assign AXI4_MASTER_3_AWSIZE_net_0    = AXI4_MASTER_3_AWSIZE;
assign MASTER_AWSIZE[2:0]            = AXI4_MASTER_3_AWSIZE_net_0;
assign AXI4_MASTER_3_AWBURST_net_0   = AXI4_MASTER_3_AWBURST;
assign MASTER_AWBURST[1:0]           = AXI4_MASTER_3_AWBURST_net_0;
assign AXI4_MASTER_3_AWLOCK_net_0    = AXI4_MASTER_3_AWLOCK;
assign MASTER_AWLOCK[1:0]            = AXI4_MASTER_3_AWLOCK_net_0;
assign AXI4_MASTER_3_AWCACHE_net_0   = AXI4_MASTER_3_AWCACHE;
assign MASTER_AWCACHE[3:0]           = AXI4_MASTER_3_AWCACHE_net_0;
assign AXI4_MASTER_3_AWPROT_net_0    = AXI4_MASTER_3_AWPROT;
assign MASTER_AWPROT[2:0]            = AXI4_MASTER_3_AWPROT_net_0;
assign AXI4_MASTER_3_AWQOS_net_0     = AXI4_MASTER_3_AWQOS;
assign MASTER_AWQOS[3:0]             = AXI4_MASTER_3_AWQOS_net_0;
assign AXI4_MASTER_3_AWREGION_net_0  = AXI4_MASTER_3_AWREGION;
assign MASTER_AWREGION[3:0]          = AXI4_MASTER_3_AWREGION_net_0;
assign AXI4_MASTER_3_AWVALID_net_0   = AXI4_MASTER_3_AWVALID;
assign MASTER_AWVALID                = AXI4_MASTER_3_AWVALID_net_0;
assign AXI4_MASTER_3_WDATA_net_0     = AXI4_MASTER_3_WDATA;
assign MASTER_WDATA[63:0]            = AXI4_MASTER_3_WDATA_net_0;
assign AXI4_MASTER_3_WSTRB_net_0     = AXI4_MASTER_3_WSTRB;
assign MASTER_WSTRB[7:0]             = AXI4_MASTER_3_WSTRB_net_0;
assign AXI4_MASTER_3_WLAST_net_0     = AXI4_MASTER_3_WLAST;
assign MASTER_WLAST                  = AXI4_MASTER_3_WLAST_net_0;
assign AXI4_MASTER_3_WVALID_net_0    = AXI4_MASTER_3_WVALID;
assign MASTER_WVALID                 = AXI4_MASTER_3_WVALID_net_0;
assign AXI4_MASTER_3_BREADY_net_0    = AXI4_MASTER_3_BREADY;
assign MASTER_BREADY                 = AXI4_MASTER_3_BREADY_net_0;
assign AXI4_MASTER_3_ARID_net_0[0]   = AXI4_MASTER_3_ARID[0];
assign MASTER_ARID[0:0]              = AXI4_MASTER_3_ARID_net_0[0];
assign AXI4_MASTER_3_ARADDR_net_0    = AXI4_MASTER_3_ARADDR;
assign MASTER_ARADDR[37:0]           = AXI4_MASTER_3_ARADDR_net_0;
assign AXI4_MASTER_3_ARLEN_net_0     = AXI4_MASTER_3_ARLEN;
assign MASTER_ARLEN[7:0]             = AXI4_MASTER_3_ARLEN_net_0;
assign AXI4_MASTER_3_ARSIZE_net_0    = AXI4_MASTER_3_ARSIZE;
assign MASTER_ARSIZE[2:0]            = AXI4_MASTER_3_ARSIZE_net_0;
assign AXI4_MASTER_3_ARBURST_net_0   = AXI4_MASTER_3_ARBURST;
assign MASTER_ARBURST[1:0]           = AXI4_MASTER_3_ARBURST_net_0;
assign AXI4_MASTER_3_ARLOCK_net_0    = AXI4_MASTER_3_ARLOCK;
assign MASTER_ARLOCK[1:0]            = AXI4_MASTER_3_ARLOCK_net_0;
assign AXI4_MASTER_3_ARCACHE_net_0   = AXI4_MASTER_3_ARCACHE;
assign MASTER_ARCACHE[3:0]           = AXI4_MASTER_3_ARCACHE_net_0;
assign AXI4_MASTER_3_ARPROT_net_0    = AXI4_MASTER_3_ARPROT;
assign MASTER_ARPROT[2:0]            = AXI4_MASTER_3_ARPROT_net_0;
assign AXI4_MASTER_3_ARQOS_net_0     = AXI4_MASTER_3_ARQOS;
assign MASTER_ARQOS[3:0]             = AXI4_MASTER_3_ARQOS_net_0;
assign AXI4_MASTER_3_ARREGION_net_0  = AXI4_MASTER_3_ARREGION;
assign MASTER_ARREGION[3:0]          = AXI4_MASTER_3_ARREGION_net_0;
assign AXI4_MASTER_3_ARVALID_net_0   = AXI4_MASTER_3_ARVALID;
assign MASTER_ARVALID                = AXI4_MASTER_3_ARVALID_net_0;
assign AXI4_MASTER_3_RREADY_net_0    = AXI4_MASTER_3_RREADY;
assign MASTER_RREADY                 = AXI4_MASTER_3_RREADY_net_0;
assign AXI4_MASTER_3_AWUSER_net_0[0] = AXI4_MASTER_3_AWUSER[0];
assign MASTER_AWUSER[0:0]            = AXI4_MASTER_3_AWUSER_net_0[0];
assign AXI4_MASTER_3_WUSER_net_0[0]  = AXI4_MASTER_3_WUSER[0];
assign MASTER_WUSER[0:0]             = AXI4_MASTER_3_WUSER_net_0[0];
assign AXI4_MASTER_3_ARUSER_net_0[0] = AXI4_MASTER_3_ARUSER[0];
assign MASTER_ARUSER[0:0]            = AXI4_MASTER_3_ARUSER_net_0[0];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------COREAXITOAXICONNECT_C0_COREAXITOAXICONNECT_C0_0_COREAXITOAXICONNECT   -   Actel:DirectCore:COREAXITOAXICONNECT:2.0.101
COREAXITOAXICONNECT_C0_COREAXITOAXICONNECT_C0_0_COREAXITOAXICONNECT #( 
        .SLAVE_ADDR_WIDTH ( 38 ),
        .SLAVE_DATA_WIDTH ( 64 ),
        .SLAVE_ID_WIDTH   ( 1 ),
        .SLAVE_TYPE       ( 1 ),
        .SLAVE_USER_WIDTH ( 1 ) )
COREAXITOAXICONNECT_C0_0(
        // Inputs
        .MASTER_AWREADY  ( MASTER_AWREADY ),
        .MASTER_WREADY   ( MASTER_WREADY ),
        .MASTER_BVALID   ( MASTER_BVALID ),
        .MASTER_ARREADY  ( MASTER_ARREADY ),
        .MASTER_RLAST    ( MASTER_RLAST ),
        .MASTER_RVALID   ( MASTER_RVALID ),
        .SLAVE_AWVALID   ( SLAVE_AWVALID ),
        .SLAVE_WLAST     ( SLAVE_WLAST ),
        .SLAVE_WVALID    ( SLAVE_WVALID ),
        .SLAVE_BREADY    ( SLAVE_BREADY ),
        .SLAVE_ARVALID   ( SLAVE_ARVALID ),
        .SLAVE_RREADY    ( SLAVE_RREADY ),
        .MASTER_BID      ( MASTER_BID ),
        .MASTER_BRESP    ( MASTER_BRESP ),
        .MASTER_BUSER    ( MASTER_BUSER ),
        .MASTER_RID      ( MASTER_RID ),
        .MASTER_RDATA    ( MASTER_RDATA ),
        .MASTER_RRESP    ( MASTER_RRESP ),
        .MASTER_RUSER    ( MASTER_RUSER ),
        .SLAVE_AWID      ( SLAVE_AWID ),
        .SLAVE_AWADDR    ( SLAVE_AWADDR ),
        .SLAVE_AWLEN     ( SLAVE_AWLEN ),
        .SLAVE_AWSIZE    ( SLAVE_AWSIZE ),
        .SLAVE_AWBURST   ( SLAVE_AWBURST ),
        .SLAVE_AWLOCK    ( SLAVE_AWLOCK ),
        .SLAVE_AWCACHE   ( SLAVE_AWCACHE ),
        .SLAVE_AWPROT    ( SLAVE_AWPROT ),
        .SLAVE_AWREGION  ( SLAVE_AWREGION ),
        .SLAVE_AWQOS     ( SLAVE_AWQOS ),
        .SLAVE_AWUSER    ( SLAVE_AWUSER ),
        .SLAVE_WID       ( GND_net ), // tied to 1'b0 from definition
        .SLAVE_WDATA     ( SLAVE_WDATA ),
        .SLAVE_WSTRB     ( SLAVE_WSTRB ),
        .SLAVE_WUSER     ( SLAVE_WUSER ),
        .SLAVE_ARID      ( SLAVE_ARID ),
        .SLAVE_ARADDR    ( SLAVE_ARADDR ),
        .SLAVE_ARLEN     ( SLAVE_ARLEN ),
        .SLAVE_ARSIZE    ( SLAVE_ARSIZE ),
        .SLAVE_ARBURST   ( SLAVE_ARBURST ),
        .SLAVE_ARLOCK    ( SLAVE_ARLOCK ),
        .SLAVE_ARCACHE   ( SLAVE_ARCACHE ),
        .SLAVE_ARPROT    ( SLAVE_ARPROT ),
        .SLAVE_ARREGION  ( SLAVE_ARREGION ),
        .SLAVE_ARQOS     ( SLAVE_ARQOS ),
        .SLAVE_ARUSER    ( SLAVE_ARUSER ),
        // Outputs
        .MASTER_AWVALID  ( AXI4_MASTER_3_AWVALID ),
        .MASTER_WLAST    ( AXI4_MASTER_3_WLAST ),
        .MASTER_WVALID   ( AXI4_MASTER_3_WVALID ),
        .MASTER_BREADY   ( AXI4_MASTER_3_BREADY ),
        .MASTER_ARVALID  ( AXI4_MASTER_3_ARVALID ),
        .MASTER_RREADY   ( AXI4_MASTER_3_RREADY ),
        .SLAVE_AWREADY   ( AXI4_SLAVE_AWREADY ),
        .SLAVE_WREADY    ( AXI4_SLAVE_WREADY ),
        .SLAVE_BVALID    ( AXI4_SLAVE_BVALID ),
        .SLAVE_ARREADY   ( AXI4_SLAVE_ARREADY ),
        .SLAVE_RLAST     ( AXI4_SLAVE_RLAST ),
        .SLAVE_RVALID    ( AXI4_SLAVE_RVALID ),
        .MASTER_AWID     ( AXI4_MASTER_3_AWID ),
        .MASTER_AWADDR   ( AXI4_MASTER_3_AWADDR ),
        .MASTER_AWLEN    ( AXI4_MASTER_3_AWLEN ),
        .MASTER_AWSIZE   ( AXI4_MASTER_3_AWSIZE ),
        .MASTER_AWBURST  ( AXI4_MASTER_3_AWBURST ),
        .MASTER_AWLOCK   ( AXI4_MASTER_3_AWLOCK ),
        .MASTER_AWCACHE  ( AXI4_MASTER_3_AWCACHE ),
        .MASTER_AWPROT   ( AXI4_MASTER_3_AWPROT ),
        .MASTER_AWREGION ( AXI4_MASTER_3_AWREGION ),
        .MASTER_AWQOS    ( AXI4_MASTER_3_AWQOS ),
        .MASTER_AWUSER   ( AXI4_MASTER_3_AWUSER ),
        .MASTER_WID      (  ),
        .MASTER_WDATA    ( AXI4_MASTER_3_WDATA ),
        .MASTER_WSTRB    ( AXI4_MASTER_3_WSTRB ),
        .MASTER_WUSER    ( AXI4_MASTER_3_WUSER ),
        .MASTER_ARID     ( AXI4_MASTER_3_ARID ),
        .MASTER_ARADDR   ( AXI4_MASTER_3_ARADDR ),
        .MASTER_ARLEN    ( AXI4_MASTER_3_ARLEN ),
        .MASTER_ARSIZE   ( AXI4_MASTER_3_ARSIZE ),
        .MASTER_ARBURST  ( AXI4_MASTER_3_ARBURST ),
        .MASTER_ARLOCK   ( AXI4_MASTER_3_ARLOCK ),
        .MASTER_ARCACHE  ( AXI4_MASTER_3_ARCACHE ),
        .MASTER_ARPROT   ( AXI4_MASTER_3_ARPROT ),
        .MASTER_ARREGION ( AXI4_MASTER_3_ARREGION ),
        .MASTER_ARQOS    ( AXI4_MASTER_3_ARQOS ),
        .MASTER_ARUSER   ( AXI4_MASTER_3_ARUSER ),
        .SLAVE_BID       ( AXI4_SLAVE_BID ),
        .SLAVE_BRESP     ( AXI4_SLAVE_BRESP ),
        .SLAVE_BUSER     ( AXI4_SLAVE_BUSER ),
        .SLAVE_RID       ( AXI4_SLAVE_RID ),
        .SLAVE_RDATA     ( AXI4_SLAVE_RDATA ),
        .SLAVE_RRESP     ( AXI4_SLAVE_RRESP ),
        .SLAVE_RUSER     ( AXI4_SLAVE_RUSER ) 
        );


endmodule
