module xnor2
  (input [0:0] a_i
  ,input [0:0] b_i
  ,output [0:0] c_o);

   // For Lab 2, you may use assign statements!
   // Your code here:
   assign c_o = ~(a_i ^ b_i);

endmodule
