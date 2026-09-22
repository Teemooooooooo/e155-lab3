// Ellen Yu ellyu@g.hmc.edu Sep. 19 2026
// outputs the inputs into the time-multiplexed seven segment display module

module sev_seg_input(
    input  logic          clk, update, reset,
    input  logic  [3:0]   s_next, // the incoming number that needs to be displayed
    output logic  [3:0]   s0, s1 //binary representation of the displayed number    
    );
	logic [3:0] s_mid;

	// used to delay s_next by one clk cycle so that it comes in at the same time as when update is triggered
	always_ff @(posedge clk)
		if (~reset) begin s_mid <= ~4'b0; end
		else
				begin
					s_mid <= s_next;
				end
				
				
    always_ff @(posedge clk)
        if (~reset) begin s0 <= ~4'b0; s1 <= ~4'b0; end
		else
			if (update)
				begin
					s0 <= s_mid;
					s1 <= s0;
				end

	assign move = ~(s_next == 4'b0000);
	
endmodule