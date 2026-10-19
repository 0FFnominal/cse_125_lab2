module hex2ssd
  (input [3:0] hex_i
  ,output logic [6:0] ssd_o
  );

  always_comb begin
    unique case (hex_i)
      4'h0: begin
        ssd_o = 7'b1000000;
      end
      4'h1: begin
        ssd_o = 7'b1111001;
      end
      4'h2: begin
        ssd_o = 7'b0100100;
      end
      4'h3: begin
        ssd_o = 7'b0110000;
      end
      4'h4: begin
        ssd_o = 7'b0011001;
      end
      4'h5: begin
        ssd_o = 7'b0010010;
      end
      4'h6: begin
        ssd_o = 7'b0000010;
      end
      4'h7: begin
        ssd_o = 7'b1111000;
      end
      4'h8: begin
        ssd_o = 7'b0000000;
      end
      4'h9: begin
        ssd_o = 7'b0011000;
      end
      4'hA: begin
        ssd_o = 7'b0001000;
      end
      4'hB: begin
        ssd_o = 7'b0000011;
      end
      4'hC: begin
        ssd_o = 7'b1000110;
      end
      4'hD: begin
        ssd_o = 7'b0100001;
      end
      4'hE: begin
        ssd_o = 7'b0000110;
      end
      4'hF: begin
        ssd_o = 7'b0001110;
      end
      default: ssd_o = '1;
    endcase
  end
endmodule
