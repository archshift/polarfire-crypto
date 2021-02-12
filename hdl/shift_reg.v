module shift_reg #(
    parameter WIDTH = 32,
    parameter DEPTH = 1
) (
    input clk,
    input rst,
    
    input [WIDTH-1 : 0] din,
    output [WIDTH-1 : 0] dout
);

    reg [WIDTH-1:0] regs [DEPTH-1:0];
    wire [WIDTH-1:0] regs_next [DEPTH-1:0];
    
    assign dout = regs[DEPTH-1];
    assign regs_next[0] = din;
    
    genvar i;
    generate
        for (i = 1; i < DEPTH; i = i+1) begin
            assign regs_next[i] = regs[i-1];
        end
        
        for (i = 0; i < DEPTH; i = i+1) begin
            always @(posedge clk or posedge rst) begin
                if (rst) regs[i] <= 0;
                else regs[i] <= regs_next[i];
            end
        end
    endgenerate
endmodule

