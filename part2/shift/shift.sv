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
   ,output logic [width_p-1:0] data_o);

  always_ff @( posedge clk_i ) begin : blockName
    if (reset_i) begin
      data_o <= reset_val_p;
    end else if (load_i) begin
      data_o <= data_i;
    end else if (enable_i) begin
      data_o <= {data_o[width_p-2:0], d_i};
    end
  end

endmodule
