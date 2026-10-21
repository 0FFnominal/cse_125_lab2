module debounce
  #(parameter min_delay_p = 4
    )
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [0:0] button_i
   ,output logic [0:0] button_o);

   // Your code here:
  
  localparam count_width_lp = $clog2(min_delay_p);
  localparam [count_width_lp-1:0] threshold_lp = count_width_lp'(min_delay_p - 1);
  wire [count_width_lp-1:0] count_o;

  counter #(
    .width_p(count_width_lp)
  ) press_counter (
    .clk_i(clk_i),
    .reset_i(reset_i | !button_i),
    .up_i(button_i),
    .down_i(1'b0),
    .count_o(count_o)
  );

  always_ff @(posedge clk_i) begin
    if (reset_i || !button_i) begin
      button_o <= 1'b0;
    end else if (count_o > threshold_lp) begin
      button_o <= 1'b1;
    end
  end
endmodule
