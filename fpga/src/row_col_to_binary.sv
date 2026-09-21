//

module row_col_to_binary(
    input  logic         clk, reset,
    input  logic [3:0]   c_sync, r_sync,
    output logic         press,
    output logic [3:0]   s_next
    );
    logic [15:0] key;

    enable_flop flop_R0(.clk, .reset, .enable(r_sync[0]) .d(c_sync), .d_out({key[10],key[3:1]}));
    enable_flop flop_R1(.clk, .reset, .enable(r_sync[1]) .d(c_sync), .d_out({key[11],key[6:4]}));
    enable_flop flop_R2(.clk, .reset, .enable(r_sync[2]) .d(c_sync), .d_out({key[12],key[9:7]}));
    enable_flop flop_R3(.clk, .reset, .enable(r_sync[3]) .d(c_sync), .d_out({key[13],key[14],key[0],key[15]}));

    always_comb
    case (key)
        16'b0000000000000001: begin s_next = 4'b0000; press = 1; end
        16'b0000000000000010: begin s_next = 4'b0000; press = 1; end
        16'b0000000000000100: begin s_next = 4'b0000; press = 1; end
        16'b0000000000001000: begin s_next = 4'b0000; press = 1; end
        16'b0000000000010000: begin s_next = 4'b0000; press = 1; end
        16'b0000000000100000: begin s_next = 4'b0000; press = 1; end
        16'b0000000001000000: begin s_next = 4'b0000; press = 1; end
        16'b0000000010000000: begin s_next = 4'b0000; press = 1; end
        16'b0000000100000000: begin s_next = 4'b0000; press = 1; end
        16'b0000001000000000: begin s_next = 4'b0000; press = 1; end
        16'b0000010000000000: begin s_next = 4'b0000; press = 1; end
        16'b0000100000000000: begin s_next = 4'b0000; press = 1; end
        16'b0001000000000000: begin s_next = 4'b0000; press = 1; end
        16'b0010000000000000: begin s_next = 4'b0000; press = 1; end
        16'b0100000000000000: begin s_next = 4'b0000; press = 1; end
        16'b1000000000000000: begin s_next = 4'b0000; press = 1; end
        default: begin s_next = 4'b0000; press = 0; end
    endcase



endmodule
