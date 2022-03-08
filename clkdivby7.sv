module clkdivby7(
    input logic clk_in,
    input logic rst,
    output logic clk_out
    );

    // state enumeration
    enum {S0, S1, S2, S3, S4, S5, S6} present_state, next_state;

    // state and sync reset logic
    always_ff @(posedge clk_in) begin
        present_state <= rst ? S0 : next_state;
    end

    // state transition logic
    // no functionality but could have used for even clk divs
    always_comb begin
        case(present_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // output logic for functionality below
    logic [3:0] count;

    // dual edge counter to count input clock edges up to 14
    always_ff @(posedge clk_in, negedge clk_in, rst) begin
        count <= (rst || count == 4'b1101) ? 0 : count + 1;
    end

    // switch output clock on every 7th input clock edge
    // gives a 50% duty cycle much simpler than with state logic
    assign clk_out = (count <= 4'b0110);

endmodule