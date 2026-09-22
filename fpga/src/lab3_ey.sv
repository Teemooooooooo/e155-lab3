// Ellen Yu ellyu@g.hmc.edu Sep. 18 2026
// Top level containing the modules

module lab3_ey(
    input  logic [3:0]   c, 
    input  logic         reset, enable, 
    output logic [6:0]   seg,
    output logic         a0, a1, // control which one is on
    output logic [3:0]   scan_out
);
    logic       int_osc, press, update, d_en;
    logic [3:0] s_next, s0, s1, r_sync, c_sync, s;
    logic [15:0]    key;
    // generating 48MHz clock
    HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));	

    synchronizer synchronizer_row(.clk(int_osc), .reset, .d_in(scan_out), .d_out(r_sync));
    synchronizer synchronizer_col(.clk(int_osc), .reset, .d_in(c), .d_out(c_sync));
    main_fsm main_fsm(.clk(int_osc), .reset, .d_en, .press, .update);
    debounce_fsm debounce_fsm(.clk(int_osc), .reset, .d_en, .key);

    row_col_to_binary row_col_to_binary(.clk(int_osc), .reset, .c_sync, .r_sync, .press, .s_next, .key);
    sev_seg_input sev_seg_input(.clk(int_osc), .update, .s_next, .s0, .s1, .reset);

    multiplex multiplex(.clk(int_osc), .reset, .enable, .s0, .s1, .s, .a0, .a1);
    seven_seg seven_seg(.s, .seg);
	// scanning module declaration
	scanning scanning(.reset, .enable, .clk(int_osc), .scan_out);


    

    
    
endmodule