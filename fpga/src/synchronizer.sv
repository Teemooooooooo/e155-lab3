// Ellen Yu ellyu@g.hmc.edu Sep. 19 2026
// Synchronizer module for handling asynchronous inputs

module synchronizer #(parameter INPUT_SIZE = 4)(
    input logic                         clk, reset,
    input logic     [INPUT_SIZE-1:0]    d,
    output logic    [INPUT_SIZE-1:0]    d_out
    );
    logic [INPUT_SIZE-1 : 0]    d_mid;

    always_ff @(posedge clk)
        if (~reset):
            begin
                d_mid <= 0;
                d_out <= 0;
            end
        else:
            begin
                d_mid <= d;
                d_out <= d_mid;
            end


endmodule