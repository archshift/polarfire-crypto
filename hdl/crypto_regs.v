// -----------------------------------------------------------------------------
// 'SoftAES' Register Component
// Revision: 17
// -----------------------------------------------------------------------------
// Generated on 2021-04-22 at 08:51 (UTC) by airhdl version 2021.03.1
// -----------------------------------------------------------------------------
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
// POSSIBILITY OF SUCH DAMAGE.
// -----------------------------------------------------------------------------

`default_nettype none

module SoftAES_regs #(
    parameter AXI_ADDR_WIDTH = 38, // width of the AXI address bus
    parameter logic [37:0] BASEADDR = 38'h60010000 // the register file's system base address 
    ) (
    // Clock and Reset
    input  wire                      axi_aclk,
    input  wire                      axi_aresetn,
                                     
    // AXI Write Address Channel     
    input  wire [AXI_ADDR_WIDTH-1:0] s_axi_awaddr,
    input  wire [2:0]                s_axi_awprot,
    input  wire                      s_axi_awvalid,
    output wire                      s_axi_awready,
                                     
    // AXI Write Data Channel        
    input  wire [63:0]               s_axi_wdata,
    input  wire [7:0]                s_axi_wstrb,
    input  wire                      s_axi_wvalid,
    output wire                      s_axi_wready,
                                     
    // AXI Read Address Channel      
    input  wire [AXI_ADDR_WIDTH-1:0] s_axi_araddr,
    input  wire [2:0]                s_axi_arprot,
    input  wire                      s_axi_arvalid,
    output wire                      s_axi_arready,
                                     
    // AXI Read Data Channel         
    output wire [63:0]               s_axi_rdata,
    output wire [1:0]                s_axi_rresp,
    output wire                      s_axi_rvalid,
    input  wire                      s_axi_rready,
                                     
    // AXI Write Response Channel    
    output wire [1:0]                s_axi_bresp,
    output wire                      s_axi_bvalid,
    input  wire                      s_axi_bready,
    
    // User Ports
    output wire ctl_strobe, // Strobe logic for register 'CTL' (pulsed when the register is written from the bus)
    input wire [0:0] ctl_busy, // Value of register 'CTL', field 'BUSY'
    input wire [0:0] ctl_ofifo_empty, // Value of register 'CTL', field 'OFIFO_EMPTY'
    input wire [0:0] ctl_ififo_full, // Value of register 'CTL', field 'IFIFO_FULL'
    output wire [0:0] ctl_auto_inc, // Value of register 'CTL', field 'AUTO_INC'
    output wire [0:0] ctl_rst, // Value of register 'CTL', field 'RST'
    output wire [0:0] ctr_addr, // read/write address for memory 'CTR'
    output wire [63:0] ctr_wdata, // write data for memory 'CTR'         
    output wire [0:0] ctr_wen , // write-enable for memory 'CTR'
    output wire [1:0] key_addr, // read/write address for memory 'KEY'
    output wire [63:0] key_wdata, // write data for memory 'KEY'         
    output wire [0:0] key_wen , // write-enable for memory 'KEY'
    output wire [8:0] fifo_addr, // read/write address for memory 'FIFO'
    output wire [63:0] fifo_wdata, // write data for memory 'FIFO'
    output wire [0:0] fifo_wen , // write-enable for memory 'FIFO'
    output wire [0:0] fifo_ren , // read-enable for memory 'FIFO'
    input wire [63:0] fifo_rdata // read data for memory 'FIFO'            
    );

    // Constants
    localparam logic [1:0]                      AXI_OKAY        = 2'b00;
    localparam logic [1:0]                      AXI_DECERR      = 2'b11;

    // Registered signals
    logic                                       s_axi_awready_r;
    logic                                       s_axi_wready_r;
    logic [$bits(s_axi_awaddr)-1:0]             s_axi_awaddr_reg_r;
    logic                                       s_axi_bvalid_r;
    logic [$bits(s_axi_bresp)-1:0]              s_axi_bresp_r;
    logic                                       s_axi_arready_r;
    logic [$bits(s_axi_araddr)-1:0]             s_axi_araddr_reg_r;
    logic                                       s_axi_rvalid_r;
    logic [$bits(s_axi_rresp)-1:0]              s_axi_rresp_r;
    logic [$bits(s_axi_wdata)-1:0]              s_axi_wdata_reg_r;
    logic [$bits(s_axi_wstrb)-1:0]              s_axi_wstrb_reg_r;
    logic [$bits(s_axi_rdata)-1:0]              s_axi_rdata_r;

    // User-defined registers
    logic s_ctl_strobe_r;
    logic [0:0] s_reg_ctl_busy_r;
    logic [0:0] s_reg_ctl_ofifo_empty_r;
    logic [0:0] s_reg_ctl_ififo_full_r;
    logic [0:0] s_reg_ctl_auto_inc_r;
    logic [0:0] s_reg_ctl_rst_r;
    logic [0:0] s_ctr_waddr_r;
    logic [0:0] s_ctr_wen_r;
    logic [63:0] s_ctr_wdata_r;        
    logic [1:0] s_key_waddr_r;
    logic [0:0] s_key_wen_r;
    logic [63:0] s_key_wdata_r;        
    logic [8:0] s_fifo_raddr_r;
    logic [63:0] s_fifo_rdata;
    logic [8:0] s_fifo_waddr_r;
    logic [0:0] s_fifo_wen_r;
    logic [0:0] s_fifo_ren_r;
    logic [63:0] s_fifo_wdata_r;

    //--------------------------------------------------------------------------
    // Inputs
    //
    assign s_fifo_rdata = fifo_rdata; 

    //--------------------------------------------------------------------------
    // Read-transaction FSM
    //    
    localparam MAX_MEMORY_LATENCY = 2;

    typedef enum {
        READ_IDLE,
        READ_REGISTER,
        WAIT_MEMORY_RDATA,
        READ_RESPONSE,
        READ_DONE
    } read_state_t;

    always_ff@(posedge axi_aclk or negedge axi_aresetn) begin: read_fsm
        // registered state variables
        read_state_t v_state_r;
        logic [63:0] v_rdata_r;
        logic [1:0] v_rresp_r;
        int v_mem_wait_count_r;
        // combinatorial helper variables
        logic v_addr_hit;
        logic [AXI_ADDR_WIDTH-1:0] v_mem_addr;
        if (~axi_aresetn) begin
            v_state_r          <= READ_IDLE;
            v_rdata_r          <= '0;
            v_rresp_r          <= '0;
            v_mem_wait_count_r <= 0;            
            s_axi_arready_r    <= '0;
            s_axi_rvalid_r     <= '0;
            s_axi_rresp_r      <= '0;
            s_axi_araddr_reg_r <= '0;
            s_axi_rdata_r      <= '0;
            s_fifo_ren_r <= '0;
            s_fifo_raddr_r <= '0;
        end else begin
            // Default values:
            s_axi_arready_r <= 1'b0;
            s_fifo_ren_r <= '0;
            s_fifo_raddr_r <= '0;

            case (v_state_r)

                // Wait for the start of a read transaction, which is 
                // initiated by the assertion of ARVALID
                READ_IDLE: begin
                    if (s_axi_arvalid) begin
                        s_axi_araddr_reg_r <= s_axi_araddr;     // save the read address
                        s_axi_arready_r    <= 1'b1;             // acknowledge the read-address
                        v_state_r          <= READ_REGISTER;
                    end
                end

                // Read from the actual storage element
                READ_REGISTER: begin
                    // defaults:
                    v_addr_hit = 1'b0;
                    v_rdata_r  <= '0;
                    
                    // register 'CTL' at address offset 0x0
                    if (s_axi_araddr_reg_r == BASEADDR + SoftAES_regs_pkg::CTL_OFFSET) begin
                        v_addr_hit = 1'b1;
                        v_rdata_r[0:0] <= s_reg_ctl_busy_r;
                        v_rdata_r[1:1] <= s_reg_ctl_ofifo_empty_r;
                        v_rdata_r[2:2] <= s_reg_ctl_ififo_full_r;
                        v_rdata_r[62:62] <= s_reg_ctl_auto_inc_r;
                        v_rdata_r[63:63] <= s_reg_ctl_rst_r;
                        v_state_r <= READ_RESPONSE;
                    end
                    // memory 'FIFO' at address offset 0x1000
                    if (s_axi_araddr_reg_r >= BASEADDR + SoftAES_regs_pkg::FIFO_OFFSET && 
                        s_axi_araddr_reg_r < BASEADDR + SoftAES_regs_pkg::FIFO_OFFSET + SoftAES_regs_pkg::FIFO_DEPTH * 8) begin
                        v_addr_hit = 1'b1;
                        // generate memory read address:
                        v_mem_addr = s_axi_araddr_reg_r - BASEADDR - SoftAES_regs_pkg::FIFO_OFFSET;
                        s_fifo_ren_r <= 1'b1;
                        s_fifo_raddr_r <= v_mem_addr[11:3]; // output address has 8-byte granularity
                        
                        // added the following because s_fifo_rdata has instantaneous reads
                        v_rdata_r <= s_fifo_rdata;
                        v_state_r <= READ_RESPONSE;
                        // v_mem_wait_count_r <= SoftAES_regs_pkg::FIFO_READ_LATENCY;
                        // v_state_r <= WAIT_MEMORY_RDATA;
                    end
                    if (v_addr_hit) begin
                        v_rresp_r <= AXI_OKAY;
                    end else begin
                        v_rresp_r <= AXI_DECERR;
                        // pragma translate_off
                        $warning("ARADDR decode error");
                        // pragma translate_on
                        v_state_r <= READ_RESPONSE;
                    end
                end
                
                // Wait for memory read data
                WAIT_MEMORY_RDATA: begin
                    if (v_mem_wait_count_r == 0) begin
                        // memory 'FIFO' at address offset 0x1000
                        if (s_axi_araddr_reg_r >= BASEADDR + SoftAES_regs_pkg::FIFO_OFFSET && 
                            s_axi_araddr_reg_r < BASEADDR + SoftAES_regs_pkg::FIFO_OFFSET + SoftAES_regs_pkg::FIFO_DEPTH * 8) begin
                            v_rdata_r[63:0] <= s_fifo_rdata[63:0];
                        end
                        v_state_r <= READ_RESPONSE;
                    end else begin
                        v_mem_wait_count_r <= v_mem_wait_count_r - 1;
                    end
                end

                // Generate read response
                READ_RESPONSE: begin
                    s_axi_rvalid_r <= 1'b1;
                    s_axi_rresp_r  <= v_rresp_r;
                    s_axi_rdata_r  <= v_rdata_r;
                    v_state_r      <= READ_DONE;
                end

                // Write transaction completed, wait for master RREADY to proceed
                READ_DONE: begin
                    if (s_axi_rready) begin
                        s_axi_rvalid_r <= 1'b0;
                        s_axi_rdata_r  <= '0;
                        v_state_r      <= READ_IDLE;
                    end
                end        
                                    
            endcase
        end
    end: read_fsm

    //--------------------------------------------------------------------------
    // Write-transaction FSM
    //    

    typedef enum {
        WRITE_IDLE,
        WRITE_ADDR_FIRST,
        WRITE_DATA_FIRST,
        WRITE_UPDATE_REGISTER,
        WRITE_DONE
    } write_state_t;

    always_ff@(posedge axi_aclk or negedge axi_aresetn) begin: write_fsm
        // registered state variables
        write_state_t v_state_r;
        // combinatorial helper variables
        logic v_addr_hit;
        logic [AXI_ADDR_WIDTH-1:0] v_mem_addr;
        if (~axi_aresetn) begin
            v_state_r                   <= WRITE_IDLE;
            s_axi_awready_r             <= 1'b0;
            s_axi_wready_r              <= 1'b0;
            s_axi_awaddr_reg_r          <= '0;
            s_axi_wdata_reg_r           <= '0;
            s_axi_wstrb_reg_r           <= '0;
            s_axi_bvalid_r              <= 1'b0;
            s_axi_bresp_r               <= '0;
                        
            s_ctl_strobe_r <= '0;
            s_reg_ctl_busy_r <= SoftAES_regs_pkg::CTL_BUSY_RESET;
            s_reg_ctl_ofifo_empty_r <= SoftAES_regs_pkg::CTL_OFIFO_EMPTY_RESET;
            s_reg_ctl_ififo_full_r <= SoftAES_regs_pkg::CTL_IFIFO_FULL_RESET;
            s_reg_ctl_auto_inc_r <= SoftAES_regs_pkg::CTL_AUTO_INC_RESET;
            s_reg_ctl_rst_r <= SoftAES_regs_pkg::CTL_RST_RESET;
            s_ctr_waddr_r <= '0;
            s_ctr_wen_r <= '0;
            s_ctr_wdata_r <= '0;
            s_key_waddr_r <= '0;
            s_key_wen_r <= '0;
            s_key_wdata_r <= '0;
            s_fifo_waddr_r <= '0;
            s_fifo_wen_r <= '0;
            s_fifo_wdata_r <= '0;

        end else begin
            // Default values:
            s_axi_awready_r <= 1'b0;
            s_axi_wready_r  <= 1'b0;
            s_ctl_strobe_r <= '0;
            s_reg_ctl_busy_r <= ctl_busy;
            s_reg_ctl_ofifo_empty_r <= ctl_ofifo_empty;
            s_reg_ctl_ififo_full_r <= ctl_ififo_full;
            s_ctr_waddr_r <= '0; // always reset to zero because of wired OR
            s_ctr_wen_r <= '0;
            s_key_waddr_r <= '0; // always reset to zero because of wired OR
            s_key_wen_r <= '0;
            s_fifo_waddr_r <= '0; // always reset to zero because of wired OR
            s_fifo_wen_r <= '0;
            v_addr_hit = 1'b0;
            
            // Self-clearing fields:
            s_reg_ctl_rst_r <= '0;

            case (v_state_r)

                // Wait for the start of a write transaction, which may be 
                // initiated by either of the following conditions:
                //   * assertion of both AWVALID and WVALID
                //   * assertion of AWVALID
                //   * assertion of WVALID
                WRITE_IDLE: begin
                    if (s_axi_awvalid && s_axi_wvalid) begin
                        s_axi_awaddr_reg_r <= s_axi_awaddr; // save the write-address 
                        s_axi_awready_r    <= 1'b1; // acknowledge the write-address
                        s_axi_wdata_reg_r  <= s_axi_wdata; // save the write-data
                        s_axi_wstrb_reg_r  <= s_axi_wstrb; // save the write-strobe
                        s_axi_wready_r     <= 1'b1; // acknowledge the write-data
                        v_state_r          <= WRITE_UPDATE_REGISTER;
                    end else if (s_axi_awvalid) begin
                        s_axi_awaddr_reg_r <= s_axi_awaddr; // save the write-address 
                        s_axi_awready_r    <= 1'b1; // acknowledge the write-address
                        v_state_r          <= WRITE_ADDR_FIRST;
                    end else if (s_axi_wvalid) begin
                        s_axi_wdata_reg_r <= s_axi_wdata; // save the write-data
                        s_axi_wstrb_reg_r <= s_axi_wstrb; // save the write-strobe
                        s_axi_wready_r    <= 1'b1; // acknowledge the write-data
                        v_state_r         <= WRITE_DATA_FIRST;
                    end
                end

                // Address-first write transaction: wait for the write-data
                WRITE_ADDR_FIRST: begin
                    if (s_axi_wvalid) begin
                        s_axi_wdata_reg_r <= s_axi_wdata; // save the write-data
                        s_axi_wstrb_reg_r <= s_axi_wstrb; // save the write-strobe
                        s_axi_wready_r    <= 1'b1; // acknowledge the write-data
                        v_state_r         <= WRITE_UPDATE_REGISTER;
                    end
                end

                // Data-first write transaction: wait for the write-address
                WRITE_DATA_FIRST: begin
                    if (s_axi_awvalid) begin
                        s_axi_awaddr_reg_r <= s_axi_awaddr; // save the write-address 
                        s_axi_awready_r    <= 1'b1; // acknowledge the write-address
                        v_state_r          <= WRITE_UPDATE_REGISTER;
                    end
                end

                // Update the actual storage element
                WRITE_UPDATE_REGISTER: begin
                    s_axi_bresp_r  <= AXI_OKAY; // default value, may be overriden in case of decode error
                    s_axi_bvalid_r <= 1'b1;

                    // register 'CTL' at address offset 0x0
                    if (s_axi_awaddr_reg_r == BASEADDR + SoftAES_regs_pkg::CTL_OFFSET) begin
                        v_addr_hit = 1'b1;
                        s_ctl_strobe_r <= 1'b1;
                        // field 'AUTO_INC':
                        if (s_axi_wstrb_reg_r[7]) begin
                            s_reg_ctl_auto_inc_r[0] <= s_axi_wdata_reg_r[62]; // AUTO_INC[0]
                        end
                        // field 'RST':
                        if (s_axi_wstrb_reg_r[7]) begin
                            s_reg_ctl_rst_r[0] <= s_axi_wdata_reg_r[63]; // RST[0]
                        end
                    end

                    // memory 'CTR' at address offset 0x10                    
                    if (s_axi_awaddr_reg_r >= BASEADDR + SoftAES_regs_pkg::CTR_OFFSET && 
                        s_axi_awaddr_reg_r < BASEADDR + SoftAES_regs_pkg::CTR_OFFSET + SoftAES_regs_pkg::CTR_DEPTH * 8) begin
                        v_addr_hit = 1'b1;
                        v_mem_addr = s_axi_awaddr_reg_r - BASEADDR - SoftAES_regs_pkg::CTR_OFFSET;
                        s_ctr_waddr_r <= v_mem_addr[3:3]; // output address has 8-byte granularity
                        s_ctr_wen_r <= |(s_axi_wstrb_reg_r);
                        s_ctr_wdata_r <= s_axi_wdata_reg_r;
                    end    

                    // memory 'KEY' at address offset 0x20                    
                    if (s_axi_awaddr_reg_r >= BASEADDR + SoftAES_regs_pkg::KEY_OFFSET && 
                        s_axi_awaddr_reg_r < BASEADDR + SoftAES_regs_pkg::KEY_OFFSET + SoftAES_regs_pkg::KEY_DEPTH * 8) begin
                        v_addr_hit = 1'b1;
                        v_mem_addr = s_axi_awaddr_reg_r - BASEADDR - SoftAES_regs_pkg::KEY_OFFSET;
                        s_key_waddr_r <= v_mem_addr[4:3]; // output address has 8-byte granularity
                        s_key_wen_r <= |(s_axi_wstrb_reg_r);
                        s_key_wdata_r <= s_axi_wdata_reg_r;
                    end    

                    // memory 'FIFO' at address offset 0x1000                    
                    if (s_axi_awaddr_reg_r >= BASEADDR + SoftAES_regs_pkg::FIFO_OFFSET && 
                        s_axi_awaddr_reg_r < BASEADDR + SoftAES_regs_pkg::FIFO_OFFSET + SoftAES_regs_pkg::FIFO_DEPTH * 8) begin
                        v_addr_hit = 1'b1;
                        v_mem_addr = s_axi_awaddr_reg_r - BASEADDR - SoftAES_regs_pkg::FIFO_OFFSET;
                        s_fifo_waddr_r <= v_mem_addr[11:3]; // output address has 8-byte granularity
                        s_fifo_wen_r <= |(s_axi_wstrb_reg_r);
                        s_fifo_wdata_r <= s_axi_wdata_reg_r;
                    end    

                    if (!v_addr_hit) begin
                        s_axi_bresp_r   <= AXI_DECERR;
                        // pragma translate_off
                        $warning("AWADDR decode error");
                        // pragma translate_on
                    end
                    v_state_r <= WRITE_DONE;
                end

                // Write transaction completed, wait for master BREADY to proceed
                WRITE_DONE: begin
                    if (s_axi_bready) begin
                        s_axi_bvalid_r <= 1'b0;
                        v_state_r      <= WRITE_IDLE;
                    end
                end
            endcase


        end
    end: write_fsm

    //--------------------------------------------------------------------------
    // Outputs
    //
    assign s_axi_awready = s_axi_awready_r;
    assign s_axi_wready  = s_axi_wready_r;
    assign s_axi_bvalid  = s_axi_bvalid_r;
    assign s_axi_bresp   = s_axi_bresp_r;
    assign s_axi_arready = s_axi_arready_r;
    assign s_axi_rvalid  = s_axi_rvalid_r;
    assign s_axi_rresp   = s_axi_rresp_r;
    assign s_axi_rdata   = s_axi_rdata_r;

    assign ctl_strobe = s_ctl_strobe_r;
    assign ctl_auto_inc = s_reg_ctl_auto_inc_r;
    assign ctl_rst = s_reg_ctl_rst_r;
    assign ctr_addr = s_ctr_waddr_r;     
    assign ctr_wen = s_ctr_wen_r;   
    assign ctr_wdata = s_ctr_wdata_r;
    assign key_addr = s_key_waddr_r;     
    assign key_wen = s_key_wen_r;   
    assign key_wdata = s_key_wdata_r;
    assign fifo_addr = s_fifo_waddr_r | s_fifo_raddr_r; // using wired OR as read/write address multiplexer
    assign fifo_wen = s_fifo_wen_r;
    assign fifo_ren = s_fifo_ren_r;
    assign fifo_wdata = s_fifo_wdata_r;

endmodule: SoftAES_regs

`resetall
