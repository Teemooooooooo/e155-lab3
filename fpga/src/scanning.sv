// Ellen Yu ellyu@g.hmc.edu Sep. 10 2026
// Outputs {0001, 0010, 0100, 1000} rotating at 2 Hz

module scanning(
    input  logic        reset, enable,clk,
    output logic [3:0]  scan_out
);
    logic [24:0] count;
    logic  slow_clk;
    counter #(25, 320000) counter_scan(.clk, .reset, .slow_clk, .enable, .counter(count)); 

    assign scan_out[0] = (count < 25'd80000);
    assign scan_out[1] = ((25'd80000 <= count) & (count < 25'd160000));
    assign scan_out[2] = ((25'd160000 <= count) & (count < 25'd240000));
    assign scan_out[3] = ((25'd240000 <= count) & (count <= 25'd320000));
endmodule