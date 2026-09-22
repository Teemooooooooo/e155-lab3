// Ellen Yu ellyu@g.hmc.edu Sep.22 2026
// Time-multiplexed output

module multiplex(
    input  logic            clk, reset, enable, 
    input  logic    [3:0]   s0, s1,
    output logic    [3:0]   s,
    output logic            a0, a1
    );
    logic           digit_select;
    logic [15:0]    digit_counter; // trivial output by counter module


    //counter blinking at above 60 Hz would be enough to fool human eyes
    counter #(16,40000) counter_multiplex(.clk, .reset, .slow_clk(digit_select), .enable, .counter(digit_counter)); 
	
    // decides what input switch to use
    assign s = digit_select ? s0 : s1;
    // determine which digit lights up
    assign a0 = digit_select;
    assign a1 = ~ digit_select;

endmodule