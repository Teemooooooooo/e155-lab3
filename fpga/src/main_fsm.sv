// Ellen Yu ellyu@g.hmc.edu Sep. 22 2026
// Main finite state machine that controls the update logic

module main_fsm(
    input  logic  clk, reset, d_en, press,
    output logic update
    );
    typedef enum logic [1:0] {SCAN, PRESS, HOLD} statetype;
    statetype state, nextstate;

    always_ff @(posedge clk)
        if (~reset) state <= SCAN;
        else state <= nextstate;

    always_comb
        case (state)
            SCAN:   if (d_en & press)   nextstate = PRESS;
                    else                nextstate = SCAN;     
            PRESS: nextstate = HOLD;
            HOLD:   if (~press)         nextstate = SCAN;
                    else                nextstate = HOLD;
			default: nextstate = SCAN;
        endcase

    assign update = (state == PRESS);

endmodule