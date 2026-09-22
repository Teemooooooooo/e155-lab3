// Ellen Yu ellyu@g.hmc.edu Sep 2026
// Test bench for synchronizer

`timescale 1 ns/1 ns

module synchronizer_tb();
  logic           clk;    // system clock
  logic           reset;  // active high reset
  logic   [3:0]   d_in, d_out;      // 4-bit input switches
  

    synchronizer dut (
        .clk(clk),
        .reset(reset),
        .d_in,
		.d_out
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
	// checking resetting behavior
		assert (d_out == 4'b0000)       // check outputs
            $display("PASSED! The output is correctly reset at %0t.", $time);
        else 
            $error("FAILED! The output is %0b at %0t.",d_out, $time); 
	


    // example test 1
        d_in = 4'b1101;                // setup inputs
        #20;                        // wait one clk cycle
        assert (d_out == 4'b1101)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output is %0b at time: %0t.",d_out,$time); 
            
    // test 2
		d_in = 4'b0010;
		
        #20;
        assert (d_out == 4'b0010)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output is %0b at time: %0t.", d_out,$time);
     

    #100 $stop;
  end
endmodule