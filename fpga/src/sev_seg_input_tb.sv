

`timescale 1 ns/1 ns


module sev_seg_input_tb();
	logic 		clk, update, reset;
	logic [3:0] s_next;
	logic [3:0] s0, s1;
	
	sev_seg_input DUT(.clk, .update, .reset, .s_next, .s0, .s1);
	
	always begin
		clk = 0; #5;
		clk = 1; #5;
	end
	
	initial begin
		reset = 0;
		update = 0;
		# 20 reset = 1;
		
		// testing reset values 
		
		assert (s0 == 4'b1111)
			$display( "Passed! Reset successed" );
		else
			$display("Failed! s0 did not reset properly");
			
		assert (s1 == 4'b1111)
			$display( "Passed! Reset successed" );
		else
			$display("Failed! s1 did not reset properly");
			
		s_next = 4'b1001;
		# 20 // should not update: update is not 1
		
		assert (s0 == 4'b1111)
			$display( "Passed! Reset successed" );
		else
			$display("Failed! s0 = %0b", s0);
			
		assert (s1 == 4'b1111)
			$display( "Passed! Reset successed" );
		else
			$display("Failed! s1 = %0b", s1);
			
		update = 1'b1;
		#10
		
		assert (s0 == 4'b1001)
			$display( "Passed! s0 = 1001" );
		else
			$display("Failed! s0 = %0b", s0);
			
		assert (s1 == 4'b1111)
			$display( "Passed! s1 = 0" );
		else
			$display("Failed! s1 = %0b", s1);
		update = 1'b0;
		#20
		update = 1'b1;
		s_next = 4'b1011;
		#20
		
		assert (s0 == 4'b1011)
			$display( "Passed! s0 = 1011" );
		else
			$display("Failed! s0 = %0b", s0);
			
		assert (s1 == 4'b1001)
			$display( "Passed! s1 = 1001" );
		else
			$display("Failed! s1 = %0b", s1);
			
		#100 $stop;
		
	end
	
endmodule