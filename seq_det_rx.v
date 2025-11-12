`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 20:47:41
// Design Name: 
// Module Name: seq_det_rx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//============================================================
// Receiver: Pattern Detector + 1-Second Counter
//============================================================
module seq_det_rx #(
    parameter [8:0] BDAY_PATTERN = 9'b100000101 // Aug 5
)(
    input  wire        i_clk,
    input  wire        i_reset,
    input  wire        i_serial_in,
    output reg  [15:0] o_hit_count,       // Displayed count
    output reg         o_hit_count_valid  // 1Hz strobe
);
    reg [8:0]  shift_reg;
    reg [15:0] hit_counter;
    reg [13:0] sec_div; // 10kHz ? 1Hz = 10,000 cycles

    always @(posedge i_clk) begin
        if (i_reset) begin
            shift_reg        <= 9'd0;
            hit_counter      <= 16'd0;
            sec_div          <= 14'd0;
            o_hit_count      <= 16'd0;
            o_hit_count_valid<= 1'b0;
        end else begin
            // Shift incoming serial data (LSB-first)
            shift_reg <= {i_serial_in, shift_reg[8:1]};

            // Pattern match check
            if (shift_reg == BDAY_PATTERN)
                hit_counter  <= hit_counter + 16'd1;

            // 1-second divider logic
            if (sec_div == 14'd9999) begin
                sec_div <= 14'd0;
                o_hit_count       <= hit_counter;
                o_hit_count_valid <= 1'b1;
                hit_counter       <= 16'd0;
            end else begin
                sec_div <= sec_div + 14'd1;
                o_hit_count_valid <= 1'b0;
            end
        end
    end
endmodule
