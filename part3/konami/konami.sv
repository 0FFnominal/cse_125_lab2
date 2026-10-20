module konami
  (input [0:0] clk_i
  ,input [0:0] reset_i
  ,input [0:0] up_i
  ,input [0:0] unup_i
  ,input [0:0] down_i
  ,input [0:0] undown_i
  ,input [0:0] left_i
  ,input [0:0] unleft_i
  ,input [0:0] right_i
  ,input [0:0] unright_i
  ,input [0:0] b_i
  ,input [0:0] unb_i
  ,input [0:0] a_i
  ,input [0:0] una_i
  ,input [0:0] start_i
  ,input [0:0] unstart_i
  ,output [0:0] cheat_code_unlocked_o);

  typedef enum logic [4:0] {
    STATE_IDLE =        5'd0,
    STATE_UP_1 =        5'd1,
    STATE_UNUP_1 =      5'd2,
    STATE_UP_2 =        5'd3,
    STATE_UNUP_2 =      5'd4,
    STATE_DOWN_1 =      5'd5,
    STATE_UNDOWN_1 =    5'd6,
    STATE_DOWN_2 =      5'd7,
    STATE_UNDOWN_2 =    5'd8,
    STATE_LEFT_1 =      5'd9,
    STATE_UNLEFT_1 =    5'd10,
    STATE_RIGHT_1 =     5'd11,
    STATE_UNRIGHT_1 =   5'd12,
    STATE_LEFT_2 =      5'd13,
    STATE_UNLEFT_2 =    5'd14,
    STATE_RIGHT_2 =     5'd15,
    STATE_UNRIGHT_2 =   5'd16,
    STATE_B_BTN =       5'd17,
    STATE_UNB_BTN =     5'd18,
    STATE_A_BTN =       5'd19,
    STATE_UNA_BTN =     5'd20,
    STATE_START_BTN =   5'd21,
    STATE_UNSTART_BTN = 5'd22
  } state_t;

  state_t current_state = STATE_IDLE;
  state_t next_state;

  // Sequential block to update current state
  always_ff @(posedge clk_i) begin
    if (reset_i) begin
      current_state <= STATE_IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  wire [0:0] pressed = up_i | down_i | left_i | right_i | b_i | a_i | start_i;
  wire [0:0] unpressed = unup_i | undown_i | unleft_i | unright_i | unb_i | una_i | unstart_i;

  assign cheat_code_unlocked_o = (current_state == STATE_UNSTART_BTN);

  // Combinational block to calculate next state
  always_comb begin
    // no input default
    next_state = current_state;
    unique case (current_state)
      STATE_IDLE: if (up_i) next_state = STATE_UP_1;
      STATE_UP_1: begin
        if (unup_i) begin
          next_state = STATE_UNUP_1;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNUP_1: begin
        if (up_i) begin
          next_state = STATE_UP_2;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UP_2: begin
        if (unup_i) begin
          next_state = STATE_UNUP_2;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNUP_2: begin
        if (down_i) begin
          next_state = STATE_DOWN_1;
        end else if (up_i) begin
          next_state = STATE_UP_2;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_DOWN_1: begin
        if (undown_i) begin
          next_state = STATE_UNDOWN_1;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNDOWN_1: begin
        if (down_i) begin
          next_state = STATE_DOWN_2;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_DOWN_2: begin
        if (undown_i) begin
          next_state = STATE_UNDOWN_2;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNDOWN_2: begin
        if (left_i) begin
          next_state = STATE_LEFT_1;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_LEFT_1: begin
        if (unleft_i) begin
          next_state = STATE_UNLEFT_1;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNLEFT_1: begin
        if (right_i) begin
          next_state = STATE_RIGHT_1;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_RIGHT_1: begin
        if (unright_i) begin
          next_state = STATE_UNRIGHT_1;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNRIGHT_1: begin
        if (left_i) begin
          next_state = STATE_LEFT_2;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_LEFT_2: begin
        if (unleft_i) begin
          next_state = STATE_UNLEFT_2;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNLEFT_2: begin
        if (right_i) begin
          next_state = STATE_RIGHT_2;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_RIGHT_2: begin
        if (unright_i) begin
          next_state = STATE_UNRIGHT_2;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNRIGHT_2: begin
        if (b_i) begin
          next_state = STATE_B_BTN;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_B_BTN: begin
        if (unb_i) begin
          next_state = STATE_UNB_BTN;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNB_BTN: begin
        if (a_i) begin
          next_state = STATE_A_BTN;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_A_BTN: begin
        if (una_i) begin
          next_state = STATE_UNA_BTN;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNA_BTN: begin
        if (start_i) begin
          next_state = STATE_START_BTN;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_START_BTN: begin
        if (unstart_i) begin
          next_state = STATE_UNSTART_BTN;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      STATE_UNSTART_BTN: begin
        if (up_i) begin
          next_state = STATE_UP_1;
        end else if (pressed | unpressed) begin
          next_state = STATE_IDLE;
        end
      end
      default: next_state = STATE_IDLE;
    endcase
  end
endmodule
