module adder
  #(parameter width_p = 5)
  // You must fill in the bit widths of a_i, b_i and sum_o. a_i and
  // b_i must be width_p bits.
  (input logic [width_p-1:0] a_i
  ,input logic [width_p-1:0] b_i
  ,output logic [width_p:0] sum_o);

   // For Lab 2, you may use assign statements!
   // Your code here
  always_comb begin
    sum_o = a_i + b_i;
  end
endmodule
