module LS161a (
    input [3:0] D,       // Parallel Input
    input CLK,           // Clock
    input CLR_n,         // Active Low Asynchronous Reset
    input LOAD_n,        // Enable Parallel Input
    input ENP,           // Count Enable Parallel
    input ENT,           // Count Enable Trickle
    output reg [3:0] Q,  // Parallel Output
    output RCO           // Ripple Carry Output (Terminal Count)
);

always @(posedge CLK or negedge CLR_n) begin
    if (!CLR_n) begin
        // Active Low Asynchronous Reset
        Q <= 4'b0000;
    end else if (!LOAD_n) begin
        // Parallel Load
        Q <= D;
    end else if (ENP && ENT) begin
        // Counting
        Q <= Q + 1;
    end
end

// Ripple Carry Output (Terminal Count)
assign RCO = (Q == 4'b1111) && ENT;

endmodule

