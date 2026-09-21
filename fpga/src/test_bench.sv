`timescale 1 ns/1 ns

module test_bench();
  logic           a0, a1;    // system clock
  logic           reset, enable;  // active high reset
  logic   [3:0]   c, scan_out;      // 4-bit input switches
  logic   [6:0]   seg;    // 2 output leds

    lab3_ey dut(.c,.reset, .enable, .seg, .a0, .a1, .scan_out);


  // apply stimuli and check outputs
  initial begin
    reset = 0;
	enable = 1;
    #22 reset = 1;
	#22;
	c = 4'b 0111;
	
	#20000000;
	c = 4'b 1111;
	
	
	#2000;
	c = 4'b 1101;

    #100000 $stop;
  end
endmodule