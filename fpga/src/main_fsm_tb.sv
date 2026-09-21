`timescale 1 ns/1 ns

module main_fsm_tb();
  logic           clk, d_en, press;    // system clock
  logic           reset, update;  



    main_fsm dut (
        .clk(clk),
        .reset(reset),
        .d_en,
        .update,
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

    // a full clock cycle (#10)

    // Test moving from scan to press
        // setup inputs
		d_en = 1'b1;
		press = 1'b1;
	#10000
		press = 0;
		
       

    #1000 $stop;
  end
endmodule