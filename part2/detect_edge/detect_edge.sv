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

endmodule
