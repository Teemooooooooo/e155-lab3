// Ellen Yu ellyu@g.hmc.edu Sep. 22 2026
// test bench for the main FSM


`timescale 1 ns/1 ns

module main_fsm_tb();
  logic           clk, d_en, press, reset;    // system clock
  logic           update;  


typedef enum logic [1:0] {SCAN, PRESS, HOLD} statetype;

    main_fsm dut (
        .clk(clk),
        .reset(reset),
        .d_en,
		.press,
        .update
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
	
	assert (dut.state == SCAN)       // check outputs
            $display("PASSED! The FSM is in SCAN at time: %0t.", $time);
        else 
            $error("FAILED! The FSM is in %0x at time: %0t.",dut.state,$time); 

    // a full clock cycle (#10)

    // Test moving from scan to press
        // setup inputs
		d_en = 1'b1;
		press = 1'b1;
	#10;
		assert (dut.state == PRESS)       // check outputs
            $display("PASSED! The FSM is in HOLD at time: %0t.", $time);
        else 
            $error("FAILED! The FSM is in %0x at time: %0t.",dut.state,$time); 
			
		assert (dut.nextstate == HOLD)       // check outputs
            $display("PASSED! The FSM is in HOLD at time: %0t.", $time);
        else 
            $error("FAILED! The FSM is in %0x at time: %0t.",dut.state,$time); 
			
		assert (update == 1'b1)       // check outputs
            $display("PASSED! Update is 1 at time: %0t.", $time);
        else 
            $error("FAILED! Update is not 1 at time: %0t.",$time); 
			
	#10; // now it should stuck in HOLD
		assert (dut.state == HOLD)       // check outputs
            $display("PASSED! The FSM is in HOLD at time: %0t.", $time);
        else 
            $error("FAILED! The FSM is in %0x at time: %0t.",dut.state,$time); 
	#1000;
		press = 0;
	#1000;
		assert (dut.state == SCAN)       // check outputs
            $display("PASSED! The FSM is in SCAN at time: %0t.", $time);
        else 
            $error("FAILED! The FSM is in %0x at time: %0t.",dut.state,$time); 
       

    #1000 $stop;
  end
endmodule