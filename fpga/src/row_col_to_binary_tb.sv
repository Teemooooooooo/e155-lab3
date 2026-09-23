`timescale 1 ns/1 ns

module row_col_to_binary_tb();
  logic           clk;    // system clock
  logic           reset;  
  logic   [3:0]   c_sync, r_sync, s_next;     
  logic      	   press;   
  logic	  [15:0]   key;


    row_col_to_binary dut (
        .clk(clk),
        .reset(reset),
        .c_sync,
        .r_sync,
		.s_next,
		.press,
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

	
    
        r_sync = 4'b0001;                
		c_sync = 4'b1111;
        #900000;                        
		
		assert (key == 16'b0)       // check outputs
				$display("PASSED! key is at 0");
			else 
				$error("FAILED! key = %0b",key); 
				
		assert (press == 0)       // check outputs
				$display("PASSED! press = 0");
			else 
				$error("FAILED! press = %0b", press); 
		
		r_sync = 4'b0001;                
		c_sync = 4'b1110;
        #900000;       
		assert (key == 16'b10)       // check outputs
				$display("PASSED! key is at 1");
			else 
				$error("FAILED! key = %0b",key); 
				
		assert (press == 1'b1)       // check outputs
				$display("PASSED! press = 1");
			else 
				$error("FAILED! press = %0b", press); 

		r_sync = 4'b0010;
		c_sync = 4'b1101;
        #900000;
        assert (key == 16'b0000000000100010)       // check outputs
				$display("PASSED! key is at 0");
			else 
				$error("FAILED! key = %0b",key); 
				
		assert (press == 0)       // check outputs
				$display("PASSED! press = 0");
			else 
				$error("FAILED! press = %0b", press); 


    #100 $stop;
  end
endmodule