// Ellen Yu ellyu@g.hmc.edu Sep. 18 2026
// Switch debouncer that removes switch bouncing to produce 

module debounce(
    input logic          clk, reset,
    input logic          c, // active low column reading
    output logic         debounce_c
    );
    typedef enum logic [1:0] {IDLE, WAIT, PRESSED} statetype;
    statetype state, nextstate;

    logic [19:0] counter;
    logic slow_clock, counter, counter_enable;
    
    counter #(20,524288) counter(.clk, .reset, .slow_clk, .enable(counter_enable), .counter); 


    always_ff @(posedge clk)
        if (reset) state <= IDLE;
        else       state <= nextstate;

    // next state logic 
    always_comb
        case (state)
            IDLE:       nextstate = c ? WAIT : IDLE;
            WAIT:       if (c)                nextstate  = IDLE; // bounce, go bacck to 0
                        else if (counter[19]) nextstate = PRESSED; 
                        else                  nextstate = WAIT;
            PRESSED:    nextstate = IDLE; 
        endcase
    assign debounced_c = (state == PRESSED);
    assign counter_enable = (state == WAIT);
    
endmodule