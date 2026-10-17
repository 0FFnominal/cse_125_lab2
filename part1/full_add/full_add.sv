module full_add
  (input [0:0] a_i
  ,input [0:0] b_i
  ,input [0:0] carry_i
  ,output [0:0] carry_o
  ,output [0:0] sum_o);

   // For Lab 2, you may use assign statements!
   // Your code here:
  assign sum_o = a_i ^ b_i ^ carry_i;
  assign carry_o = (a_i & b_i) | (a_i & carry_i) | (b_i & carry_i);
endmodule
