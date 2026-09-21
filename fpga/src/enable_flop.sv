//

module enable_flop #(parameter FLOP_SIZE = 4)(
    input  logic         clk, reset, enable
    input  logic [FLOP_SIZE-1:0]   d_in,
    output logic [FLOP_SIZE-1:0]   d_out
    );
    logic [15:0] pressed_key;

    alwawys_ff @(posedge clk)
        if (~reset)
            d_out <= 0;
        else
            if (enable)
                d_out <= d_in;
            

endmodule
