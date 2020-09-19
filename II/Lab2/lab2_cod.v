
module lab2_cod
(
    input   [ 1:0]  KEY,
    input   [ 3:0]  SW,
    output  LEDR
);

	timeQuest_wrapper2(KEY[1],SW,LEDR,KEY[0]);
	
endmodule

module timeQuest_wrapper2(clock,SW,LED,enable);
	input clock,enable;
	input [3:0] SW;
	output LED;
 
	reg [3:0] SW_reg;
	reg  LED_reg; // registers for 'catching' time
 
	wire LED_wire;
	wire [3:0] SW_wire;
	
	assign SW_wire = SW_reg;
	
	sdnf_ne_min (SW_reg,LED_wire,enable);

	always @(posedge clock)
		begin
			SW_reg <= SW; // avoiding race and latch by setting '<=' instead of '='
			LED_reg<=LED_wire;
		end
	assign LED = LED_reg;
endmodule


module sdnf_ne_min(
   input [3:0] in,
   output binary_out,
   input enable
  );

  assign binary_out = ( ((~in[2]) & (~in[3])) | ((~in[0]) & (~in[3])) | ((~in[0]) & (~in[1]) & (~in[2]) | (in[0] | in[2] | in[3]) | (in[0] | in[1] | (~in[2])))) & enable;
  

endmodule


