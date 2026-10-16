module shift
  #(parameter width_p = 5
    /* verilator lint_off WIDTHTRUNC */
   ,parameter [width_p-1:0] reset_val_p = '0)
   /* verilator lint_on WIDTHTRUNC */   
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [0:0] enable_i
   ,input [0:0] d_i
   ,input [0:0] load_i
   ,input [width_p-1:0] data_i
   ,output [width_p-1:0] data_o);

   

endmodule
