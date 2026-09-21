// Ellen Yu ellyu@g.hmc.edu Sep. 18 2026
// Switch debouncer that removes switch bouncing to produce 

module debounce_fsm(
    input  logic            clk, reset,
    input  logic [3:0]      c, // active low column reading
    output logic            d_en // debounce wait is done
    );
    typedef enum logic [1:0] {IDLE, WAIT, PRESSED} statetype;
    statetype state, nextstate;

    logic [19:0] counter;
    logic slow_clock, counter, counter_enable, counter_reset;
    
    counter #(20,524288) counter(.clk, .reset(counter_reset), .slow_clk, .enable(counter_enable), .counter); 


    always_ff @(posedge clk)
        if (~reset) state <= IDLE;
        else       state <= nextstate;

    // next state logic 
    always_comb
        case (state)
            IDLE:       nextstate = (c == 4'b1111) ? WAIT : IDLE; // stay at IDLE if c all high
            WAIT:       if (c == 4'b1111)                nextstate  = IDLE; // bounce, go bacck to 0
                        else if (counter[19]) nextstate = PRESSED; 
                        else                  nextstate = WAIT;
            PRESSED:    nextstate = (c == 4'b1111) ? PRESSED : IDLE; 
        endcase
    assign d_en = (state == PRESSED);
    assign counter_enable = (state == WAIT);
    assign counter_reset = (~(state == IDLE));
    
endmodule