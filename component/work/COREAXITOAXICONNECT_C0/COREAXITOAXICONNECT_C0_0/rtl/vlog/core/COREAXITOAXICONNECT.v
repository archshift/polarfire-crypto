//Core AXI2AXIConnect

module COREAXITOAXICONNECT_C0_COREAXITOAXICONNECT_C0_0_COREAXITOAXICONNECT #
(
  parameter 	SLAVE_ID_WIDTH 		=	1,
  parameter 	SLAVE_DATA_WIDTH	=	64,
  parameter 	SLAVE_ADDR_WIDTH	=	32,
  parameter 	SLAVE_USER_WIDTH	=	1,
  parameter 	[1:0]SLAVE_TYPE 	=	2'b00 // Valid Values - 00 = AXI4, 01=AXI4-Lite, 11 = AXI3
)
											
(
  // Master Write Address Ports
  input									MASTER_AWREADY,
  
  // Master Write Data Ports
  input 								MASTER_WREADY,		
  
  // Master Write Response Ports
  input		[SLAVE_ID_WIDTH-1:0 ]  		MASTER_BID,
  input 	[1:0]                  		MASTER_BRESP,
  input 	[SLAVE_USER_WIDTH-1:0] 		MASTER_BUSER,
  input                        			MASTER_BVALID,
  
  // Master Read Address Ports
  input                        			MASTER_ARREADY,	
  
// Master Read Data Ports
  input 	[SLAVE_ID_WIDTH-1:0]		MASTER_RID,
  input 	[SLAVE_DATA_WIDTH-1:0]		MASTER_RDATA,
  input 	[1:0] 						MASTER_RRESP,
  input 								MASTER_RLAST,										
  input 	[SLAVE_USER_WIDTH-1:0]		MASTER_RUSER,									
  input 								MASTER_RVALID,										
																													
// Slave Write Address Port
  input 	[SLAVE_ID_WIDTH-1:0]		SLAVE_AWID,        // Slave ID is composed of Master Port ID concatenated with transaction ID
  input 	[SLAVE_ADDR_WIDTH-1:0]		SLAVE_AWADDR,
  input 	[7:0] 						SLAVE_AWLEN,
  input 	[2:0] 						SLAVE_AWSIZE,
  input 	[1:0] 						SLAVE_AWBURST,
  input 	[1:0] 						SLAVE_AWLOCK,
  input 	[3:0] 						SLAVE_AWCACHE,
  input 	[2:0] 						SLAVE_AWPROT,
  input 	[3:0] 						SLAVE_AWREGION,    // not used
  input 	[3:0] 						SLAVE_AWQOS,      // not used
  input 	[SLAVE_USER_WIDTH-1:0]		SLAVE_AWUSER,
  input 								SLAVE_AWVALID,
   
  // Slave Write Data Ports
  input 	[SLAVE_ID_WIDTH-1:0]		SLAVE_WID,
  input 	[SLAVE_DATA_WIDTH-1:0]		SLAVE_WDATA,
  input 	[(SLAVE_DATA_WIDTH/8)-1:0]	SLAVE_WSTRB,
  input								  	SLAVE_WLAST,
  input 	[SLAVE_USER_WIDTH-1:0]		SLAVE_WUSER,
  input 								SLAVE_WVALID,
  
   // Slave Write Response Ports
  input 								SLAVE_BREADY,
  
  // Slave Read Address Port
  input 	[SLAVE_ID_WIDTH-1:0]		SLAVE_ARID,
  input 	[SLAVE_ADDR_WIDTH-1:0]		SLAVE_ARADDR,
  input 	[7:0] 						SLAVE_ARLEN,
  input 	[2:0] 						SLAVE_ARSIZE,
  input 	[1:0] 						SLAVE_ARBURST,
  input 	[1:0] 						SLAVE_ARLOCK,
  input 	[3:0] 						SLAVE_ARCACHE,
  input 	[2:0] 						SLAVE_ARPROT,
  input 	[3:0] 						SLAVE_ARREGION,    
  input 	[3:0] 						SLAVE_ARQOS,      
  input 	[SLAVE_USER_WIDTH-1:0] 		SLAVE_ARUSER,
  input 								SLAVE_ARVALID,
  
  // Slave Read Data Ports
  input 								SLAVE_RREADY,										
										
 
// Master Write Address Ports
  output 	[SLAVE_ID_WIDTH-1:0]		MASTER_AWID,
  output 	[SLAVE_ADDR_WIDTH-1:0]		MASTER_AWADDR,
  output 	[7:0] 						MASTER_AWLEN,
  output 	[2:0] 						MASTER_AWSIZE,
  output 	[1:0] 						MASTER_AWBURST,
  output 	[1:0] 						MASTER_AWLOCK,
  output 	[3:0] 						MASTER_AWCACHE,
  output 	[2:0] 						MASTER_AWPROT,
  output 	[3:0] 						MASTER_AWREGION,
  output 	[3:0] 						MASTER_AWQOS,        
  output 	[SLAVE_USER_WIDTH-1:0]		MASTER_AWUSER,        
  output 								MASTER_AWVALID,
  
//Master Write Data Ports
  output 	[SLAVE_ID_WIDTH-1:0]        MASTER_WID,
  output 	[SLAVE_DATA_WIDTH-1:0]      MASTER_WDATA,
  output 	[(SLAVE_DATA_WIDTH/8)-1:0]  MASTER_WSTRB,
  output 							 	MASTER_WLAST,
  output 	[SLAVE_USER_WIDTH-1:0]      MASTER_WUSER,
  output 							 	MASTER_WVALID,

// Master Write Response Ports
  output 							    MASTER_BREADY,

  // Master Read Address Ports
  output 	[SLAVE_ID_WIDTH-1:0]		MASTER_ARID,
  output 	[SLAVE_ADDR_WIDTH-1:0]		MASTER_ARADDR,
  output 	[7:0] 						MASTER_ARLEN,
  output 	[2:0] 						MASTER_ARSIZE,
  output 	[1:0] 						MASTER_ARBURST,
  output 	[1:0] 						MASTER_ARLOCK,
  output 	[3:0]						MASTER_ARCACHE,
  output 	[2:0] 						MASTER_ARPROT,
  output 	[3:0] 						MASTER_ARREGION,
  output 	[3:0] 						MASTER_ARQOS,    
  output 	[SLAVE_USER_WIDTH-1:0]		MASTER_ARUSER,
  output 								MASTER_ARVALID,
  
  // Master Read Data Ports
  output 								MASTER_RREADY,
  
  //Slave Write Address Port
  output 								SLAVE_AWREADY,
  
  // Slave Write Data Ports
  output 								SLAVE_WREADY,
  
  // Slave Write Response Ports
  output 	[SLAVE_ID_WIDTH-1:0]		SLAVE_BID,
  output 	[1:0] 						SLAVE_BRESP,
  output 	[SLAVE_USER_WIDTH-1:0]		SLAVE_BUSER,
  output 								SLAVE_BVALID,
  
  // Slave Read Address Port
  output 								SLAVE_ARREADY,
  
  // Slave Read Data Ports
  output 	[SLAVE_ID_WIDTH-1:0]		SLAVE_RID,
  output 	[SLAVE_DATA_WIDTH-1:0]		SLAVE_RDATA,
  output 	[1:0]SLAVE_RRESP,
  output 								SLAVE_RLAST,
  output 	[SLAVE_USER_WIDTH-1:0]		SLAVE_RUSER,   
  output 								SLAVE_RVALID
  
);
										

										

//Write Address Ports
assign 		MASTER_AWID			=		SLAVE_AWID;
assign		MASTER_AWADDR   	=		SLAVE_AWADDR;
assign		MASTER_AWLEN		=		SLAVE_AWLEN	;
assign		MASTER_AWSIZE		=		SLAVE_AWSIZE;
assign		MASTER_AWBURST		=		SLAVE_AWBURST;
assign		MASTER_AWLOCK		=		SLAVE_AWLOCK;
assign 		MASTER_AWCACHE		=		SLAVE_AWCACHE;
assign		MASTER_AWPROT		=		SLAVE_AWPROT;
assign		MASTER_AWREGION		=		SLAVE_AWREGION;
assign		MASTER_AWQOS		=       SLAVE_AWQOS;
assign		MASTER_AWUSER		=       SLAVE_AWUSER; 
assign		MASTER_AWVALID		=		SLAVE_AWVALID;					
assign 		SLAVE_AWREADY		=		MASTER_AWREADY;


//Write Data ports
assign		MASTER_WID			= 		SLAVE_WID;
assign		MASTER_WDATA		=		SLAVE_WDATA;
assign		MASTER_WSTRB		=		SLAVE_WSTRB;
assign		MASTER_WLAST		=		SLAVE_WLAST;
assign		MASTER_WUSER		=		SLAVE_WUSER;
assign		MASTER_WVALID		=		SLAVE_WVALID;
assign		SLAVE_WREADY		=		MASTER_WREADY;

//Write Response ports
assign		SLAVE_BID			=		MASTER_BID;
assign		SLAVE_BRESP			=		MASTER_BRESP;
assign		SLAVE_BUSER			=		MASTER_BUSER;
assign		SLAVE_BVALID		=		MASTER_BVALID;
assign		MASTER_BREADY		=		SLAVE_BREADY;


//Read Address ports			
assign		MASTER_ARID			=		SLAVE_ARID;
assign		MASTER_ARADDR		=		SLAVE_ARADDR;
assign		MASTER_ARLEN		=		SLAVE_ARLEN;
assign		MASTER_ARSIZE		=		SLAVE_ARSIZE;
assign		MASTER_ARBURST		=		SLAVE_ARBURST;
assign		MASTER_ARLOCK		=		SLAVE_ARLOCK;
assign		MASTER_ARCACHE		=		SLAVE_ARCACHE;
assign		MASTER_ARPROT		=		SLAVE_ARPROT;
assign		MASTER_ARREGION		=		SLAVE_ARREGION;
assign		MASTER_ARQOS   		=		SLAVE_ARQOS;
assign		MASTER_ARUSER		=		SLAVE_ARUSER;
assign		MASTER_ARVALID		=		SLAVE_ARVALID;
assign		SLAVE_ARREADY		=		MASTER_ARREADY;

			
//Read data ports
assign		SLAVE_RID			=		MASTER_RID;
assign		SLAVE_RDATA			=		MASTER_RDATA;
assign		SLAVE_RRESP			=		MASTER_RRESP;
assign		SLAVE_RLAST			=		MASTER_RLAST;
assign		SLAVE_RUSER   		=		MASTER_RUSER;
assign		SLAVE_RVALID		=		MASTER_RVALID;
assign		MASTER_RREADY		=		SLAVE_RREADY;

endmodule		