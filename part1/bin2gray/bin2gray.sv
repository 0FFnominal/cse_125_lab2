module bin2gray
  #(parameter width_p = 5)
   // You must fill these in with width_p
  (input logic [width_p-1 : 0] bin_i
  ,output logic [width_p-1 : 0] gray_o);

   // Your code here
  assign gray_o = bin_i ^ (bin_i >> 1);
endmodule
