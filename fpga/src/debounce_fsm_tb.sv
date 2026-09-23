// Ellen Yu ellyu@g.hmc.edu Sep. 22 2026
// Testbench for the debounce FSM module


`timescale 1 ns/1 ns

module debounce_fsm_tb();
  logic           clk, reset;    
  logic [15:0]    key;
  logic           d_en;  


typedef enum logic [1:0] {IDLE, WAIT, PRESSED} statetype;

    debounce_fsm dut (
        .clk(clk),
        .reset(reset),
        .d_en,
		.key
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
	
	assert (dut.state == IDLE)       // check outputs
            $display("PASSED! The FSM is in IDLE at time: %0t.", $time);
        else 
            $error("FAILED! The FSM is in %0x at time: %0t.",dut.state,$time); 

    // a full clock cycle (#10)

    // Test moving from IDLE to WAIT
        // setup inputs
		key = 16'b1;
	#10;
		assert (dut.state == WAIT)       // check outputs
            $display("PASSED! The FSM is in WAIT at time: %0t.", $time);
        else 
            $error("FAILED! The FSM is in %0x at time: %0t.",dut.state,$time); 
	
			
		assert (d_en == 1'b0)       // check outputs
            $display("PASSED! d_en is 0 at time: %0t.", $time);
        else 
            $error("FAILED! d_en is 1 at time: %0t.",$time); 
			
		key = 16'b0;
	#10; // now it should go back to IDLE
		assert (dut.state == IDLE)       // check outputs
            $display("PASSED! The FSM is in IDLE at time: %0t.", $time);
        else 
            $error("FAILED! The FSM is in %0x at time: %0t.",dut.state,$time); 
	#10;
		key = 16'b11;
	#6000000;
		assert (dut.state == PRESSED)       // check outputs
            $display("PASSED! The FSM is in PRESSED at time: %0t.", $time);
        else 
            $error("FAILED! The FSM is in %0x at time: %0t.",dut.state,$time); 
       

    #1000 $stop;
  end
endmodule