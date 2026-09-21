`timescale 1 ns/1 ns

module row_col_to_binary_tb();
  logic           clk;    // system clock
  logic           reset;  // active high reset
  logic   [3:0]   c_sync, r_sync, s_next;      // 4-bit input switches
  logic      	   press;    // 2 output leds


    row_col_to_binary dut (
        .clk(clk),
        .reset(reset),
        .c_sync,
        .r_sync,
		.s_next,
		.press
    );

  // generate clock
  always begin
      clk = 0; #5;
      clk = 1; #5;
  end

  // apply stimuli and check outputs
  initial begin
    reset = 0;
    #22 reset = 1;

    // for each test case we setup the inputs, wait for the outputs to update,
    // and then check that the outputs match what we expect using `assert`
    // in this case, the leds use combinational logic, so we don't *need* to wait
    // a full clock cycle (#10)

    // example test 1
        r_sync = 4'b0001;                // setup inputs
		c_sync = 4'b1111;
        #100;                        // wait required time
		r_sync = 4'b0001;                // setup inputs
		c_sync = 4'b1110;
        #100;                        // wait required time
		r_sync = 4'b0010;
		c_sync = 4'b1111;
        
            


    #100 $stop;
  end
endmodule