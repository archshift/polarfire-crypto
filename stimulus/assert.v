`define assert(cond) \
    if (!(cond)) begin \
        $display("assertion failed: %s", `"cond`"); \
        $fatal; \
    end
