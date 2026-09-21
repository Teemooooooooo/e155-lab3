// Ellen Yu ellyu@g.hmc.edu Sep. 19 2026
// outputs the inputs into the time-multiplexed seven segment display module

module sev_seg_input(
    input  logic          clk, update, reset,
    input  logic  [3:0]   s_next, // the incoming number that needs to be displayed
    output logic  [3:0]   s0, s1 //binary representation of the displayed number    
    );

    always_ff @(posedge clk)
        if (~reset) begin s0 <= ~4'b0; s1 <= ~4'b0; end
		else
			if (update)
				begin
					s0 <= s_next;
					s1 <= s0;
				end


endmodule