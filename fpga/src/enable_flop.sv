// Ellen Yu ellyu@g.hmc.edu Sep. 22 2026
// A resetable, enableable, register with parameterized size

module enable_flop #(parameter FLOP_SIZE = 4)(
    input  logic         clk, reset, enable,
    input  logic [FLOP_SIZE-1:0]   d_in,
    output logic [FLOP_SIZE-1:0]   d_out
    );

    always_ff @(posedge clk)
        if (~reset)
            d_out <= 0;
        else
            if (enable)
                d_out <= d_in;
            

endmodule
