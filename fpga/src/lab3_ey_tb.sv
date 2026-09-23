// Ellen Yu ellyu@g.hmc.edu Sep. 22 2026
// Testbench for top module

`timescale 1 ns/1 ns

module lab3_ey_tb();
  logic   [3:0] 	c;
  logic   			reset, enable;
  logic   [6:0]		seg;
  logic 			a0, a1;
  logic   [3:0]		scan_out;

	logic [3:0] 	c_press;
	
	//test for row 0
	assign c = scan_out[0] ? c_press:4'b1111;

    lab3_ey dut (
        .c,
		.reset,
		.enable,
		.seg,
		.a0,
		.a1,
		.scan_out
    );


  // apply stimuli and check outputs
  initial begin
    reset = 0;
    #22 reset = 1;
	enable = 1;
	
	// one key pressed
	c_press = 4'b1101;
	#10000
	c_press = 4'b1111;
	#10000
	c_press = 4'b1101;
	
        #100000000;                        
		assert (dut.s0 == 4'b1101)       // check outputs
				$display("PASSED! s0 is at 1101");
			else 
				$error("FAILED! s0 = %0b",dut.s0); 
		
		assert (dut.key == 16'b100)       // check outputs
				$display("PASSED! key is at 100");
			else 
				$error("FAILED! key = %0b",dut.key); 
				
		assert (dut.d_en == 1)       // check outputs
				$display("PASSED! d_en is at 1");
			else 
				$error("FAILED! d_en = %0b",dut.d_en); 
	c_press = 4'b1111;
	#2000000
	assert (dut.key == 16'b0000)       // check outputs
				$display("PASSED! key is at 0000");
			else 
				$error("FAILED! key = %0b",dut.key); 
	assert (dut.d_en == 0)       // check outputs
				$display("PASSED! d_en is at 0");
			else 
				$error("FAILED! d_en = %0b",dut.d_en); 
	c_press = 4'b1001;
	    #10000000; 
		
		assert (dut.key == 16'b1100)       // check outputs
				$display("PASSED! key is at 1100");
			else 
				$error("FAILED! key = %0b",dut.key); 
				
		assert (dut.press == 0)       // check outputs
				$display("PASSED! press is at 0");
			else 
				$error("FAILED! press = %0b",dut.press); 


    #100 $stop;
  end
endmodule