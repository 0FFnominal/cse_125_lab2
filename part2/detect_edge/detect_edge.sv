module detect_edge
   (input [0:0] clk_i
    // reset_i will go low at least one cycle before a button is pushed.
   ,input [0:0] reset_i
   ,input [0:0] button_i
    // Should go high for 1 cycle, after a positive edge
   ,output [0:0] button_o
    // Should go high for 1 cycle, after a negative edge
   ,output [0:0] unbutton_o
   );

   // Your code here:
   // states:
   // button   unbutton
   // 0        0        initial
   // 1        0        positive edge detected
   // 0        1        negative edge detected

   // state = {button_o, unbutton_o}
   logic [1:0] state;
   logic [0:0] last_input = 1'b0;

   always_ff @(posedge clk_i) begin
      if (reset_i) begin
         state <= 2'b00;
         last_input <= 1'b0;
      end else if (button_i != last_input) begin
         if (button_i) begin
            // positive edge
            state <= 2'b10;
         end else begin
            // negative edge
            state <= 2'b01;
         end
         last_input <= button_i;
      end else begin
         state <= 2'b00;
      end
   end

   assign button_o = state[1];
   assign unbutton_o = state[0];
endmodule
