module gray2bin
  #(parameter width_p = 5)
   // You must fill these in with width_p
   (input [width_p-1 : 0] gray_i
    ,output [width_p-1 : 0] bin_o);

  generate
    for (genvar i = 0; i < width_p; i++) begin : bin_gen
      assign bin_o[i] = ^(gray_i>> i);
    end
  endgenerate
endmodule
