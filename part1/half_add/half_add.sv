module half_add
  (input [0:0] a_i
  ,input [0:0] b_i
  ,output [0:0] carry_o
  ,output [0:0] sum_o);

   // For Lab 2, you may use assign statements!
   // Your code here:
  assign carry_o = a_i & b_i;
  assign sum_o = a_i ^ b_i;
endmodule
