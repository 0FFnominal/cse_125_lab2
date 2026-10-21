module compass
  (
    input logic [0:0]  clk_i,
    input logic [0:0]  reset_i,
    input logic [1:0]  direction_i,
    input logic [0:0]  valid_i,
    output logic [0:0] sequence_detected_o
  );
  typedef enum logic [1:0] {
    STATE_IDLE  = 2'b00,
    STATE_0     = 2'b01,
    STATE_01    = 2'b10,
    STATE_011   = 2'b11
  } state_t;

  state_t current_state = STATE_IDLE;
  state_t next_state;

  // State register
  always_ff @(posedge clk_i) begin
    if (reset_i) current_state <= STATE_IDLE;
    else current_state <= next_state;
  end

  // Combinational logic to calculate next state
  always_comb begin
    next_state = current_state;
    sequence_detected_o = 1'b0;
    if (valid_i) begin
      unique case (current_state)
        STATE_IDLE: begin
          if (direction_i[0] == 1'b0) begin
            next_state = STATE_0;
          end else if (direction_i == 2'b01) begin
            next_state = STATE_01;
          end
        end
        STATE_0: begin
          if (direction_i == 2'b11) begin
            next_state = STATE_011;
          end else if (direction_i == 2'b01) begin
            next_state = STATE_01;
          end else if (direction_i[0] == 1'b0) begin
            next_state = STATE_0;
          end else begin
            next_state = STATE_IDLE;
          end
        end
        STATE_01: begin
          if (direction_i == 2'b10) begin
            // sequence detected
            sequence_detected_o = 1'b1;
            next_state = STATE_0;
          end else if (direction_i[0] == 1'b0) begin
            next_state = STATE_0;
          end else if (direction_i == 2'b01) begin
            next_state = STATE_01;
          end else begin
            next_state = STATE_IDLE;
          end
        end
        STATE_011: begin
          if (direction_i[1] == 1'b0) begin
            // sequence detected
            sequence_detected_o = 1'b1;
            if (direction_i[0] == 1'b0) begin
              next_state = STATE_0;
            end else begin
              next_state = STATE_01;
            end
          end else begin
            if (direction_i[0] == 1'b0) begin
              next_state = STATE_0;
            end else begin
              next_state = STATE_IDLE;
            end
          end
        end
      endcase
    end
  end
endmodule
