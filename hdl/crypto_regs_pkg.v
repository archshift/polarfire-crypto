// -----------------------------------------------------------------------------
// 'SoftAES' Register Definitions
// Revision: 17
// -----------------------------------------------------------------------------
// Generated on 2021-04-22 at 08:53 (UTC) by airhdl version 2021.03.1
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

package SoftAES_regs_pkg;


    // Revision number of the 'SoftAES' register map
    localparam SOFTAES_REVISION = 17;

    // Default base address of the 'SoftAES' register map 
    localparam logic [37:0] SOFTAES_DEFAULT_BASEADDR = 64'h60010000;
    
    // Register 'CTL'
    localparam logic [63:0] CTL_OFFSET = 64'h00000000; // address offset of the 'CTL' register
    // Field 'CTL.BUSY'
    localparam CTL_BUSY_BIT_OFFSET = 0; // bit offset of the 'BUSY' field
    localparam CTL_BUSY_BIT_WIDTH = 1; // bit width of the 'BUSY' field
    localparam logic [0:0] CTL_BUSY_RESET = 1'b0; // reset value of the 'BUSY' field
    // Field 'CTL.OFIFO_EMPTY'
    localparam CTL_OFIFO_EMPTY_BIT_OFFSET = 1; // bit offset of the 'OFIFO_EMPTY' field
    localparam CTL_OFIFO_EMPTY_BIT_WIDTH = 1; // bit width of the 'OFIFO_EMPTY' field
    localparam logic [1:1] CTL_OFIFO_EMPTY_RESET = 1'b0; // reset value of the 'OFIFO_EMPTY' field
    // Field 'CTL.IFIFO_FULL'
    localparam CTL_IFIFO_FULL_BIT_OFFSET = 2; // bit offset of the 'IFIFO_FULL' field
    localparam CTL_IFIFO_FULL_BIT_WIDTH = 1; // bit width of the 'IFIFO_FULL' field
    localparam logic [2:2] CTL_IFIFO_FULL_RESET = 1'b0; // reset value of the 'IFIFO_FULL' field
    // Field 'CTL.BLOCK_FIFO_WR'
    localparam CTL_BLOCK_FIFO_WR_BIT_OFFSET = 61; // bit offset of the 'BLOCK_FIFO_WR' field
    localparam CTL_BLOCK_FIFO_WR_BIT_WIDTH = 1; // bit width of the 'BLOCK_FIFO_WR' field
    localparam logic [61:61] CTL_BLOCK_FIFO_WR_RESET = 1'b0; // reset value of the 'BLOCK_FIFO_WR' field
    // Field 'CTL.AUTO_INC'
    localparam CTL_AUTO_INC_BIT_OFFSET = 62; // bit offset of the 'AUTO_INC' field
    localparam CTL_AUTO_INC_BIT_WIDTH = 1; // bit width of the 'AUTO_INC' field
    localparam logic [62:62] CTL_AUTO_INC_RESET = 1'b0; // reset value of the 'AUTO_INC' field
    // Field 'CTL.RST'
    localparam CTL_RST_BIT_OFFSET = 63; // bit offset of the 'RST' field
    localparam CTL_RST_BIT_WIDTH = 1; // bit width of the 'RST' field
    localparam logic [63:63] CTL_RST_RESET = 1'b0; // reset value of the 'RST' field
    
    // Register 'CTR'
    localparam logic [63:0] CTR_OFFSET = 64'h00000010; // address offset of the 'CTR' register
    localparam CTR_DEPTH = 2; // depth of the 'CTR' memory, in elements
    localparam CTR_READ_LATENCY = 1; // read latency of the 'CTR' memory, in clock cycles
    // Field 'CTR.value'
    localparam CTR_VALUE_BIT_OFFSET = 0; // bit offset of the 'value' field
    localparam CTR_VALUE_BIT_WIDTH = 64; // bit width of the 'value' field
    localparam logic [63:0] CTR_VALUE_RESET = 64'b00000000000000000000000000000000; // reset value of the 'value' field
    
    // Register 'KEY'
    localparam logic [63:0] KEY_OFFSET = 64'h00000020; // address offset of the 'KEY' register
    localparam KEY_DEPTH = 4; // depth of the 'KEY' memory, in elements
    localparam KEY_READ_LATENCY = 1; // read latency of the 'KEY' memory, in clock cycles
    // Field 'KEY.value'
    localparam KEY_VALUE_BIT_OFFSET = 0; // bit offset of the 'value' field
    localparam KEY_VALUE_BIT_WIDTH = 64; // bit width of the 'value' field
    localparam logic [63:0] KEY_VALUE_RESET = 64'b00000000000000000000000000000000; // reset value of the 'value' field
    
    // Register 'FIFO'
    localparam logic [63:0] FIFO_OFFSET = 64'h00001000; // address offset of the 'FIFO' register
    localparam FIFO_DEPTH = 512; // depth of the 'FIFO' memory, in elements
    localparam FIFO_READ_LATENCY = 1; // read latency of the 'FIFO' memory, in clock cycles
    // Field 'FIFO.value'
    localparam FIFO_VALUE_BIT_OFFSET = 0; // bit offset of the 'value' field
    localparam FIFO_VALUE_BIT_WIDTH = 64; // bit width of the 'value' field
    localparam logic [63:0] FIFO_VALUE_RESET = 64'b00000000000000000000000000000000; // reset value of the 'value' field

endpackage: SoftAES_regs_pkg
