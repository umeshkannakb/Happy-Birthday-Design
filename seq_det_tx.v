`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 20:43:53
// Design Name: 
// Module Name: seq_det_tx
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
// Parallel-In Serial-Out Transmitter
//============================================================
module seq_det_tx (
    input  wire       i_clk,
    input  wire       i_reset,
    input  wire       i_count_valid,  // Load signal from generator
    input  wire [9:0] i_count,        // 10-bit word to send
    output reg        o_serial_data,  // Serial output (LSB first)
    output reg        o_tx_done       // 1-cycle pulse after 10 bits
);
    reg [3:0] bit_count;
    reg [9:0] shift_reg;

    always @(posedge i_clk) begin
        if (i_reset) begin
            bit_count     <= 4'd0;
            shift_reg     <= 10'd0;
            o_serial_data <= 1'b0;
            o_tx_done     <= 1'b0;
        end else begin
            o_tx_done     <= 1'b0; // default low each cycle

            if (i_count_valid) begin
                // Load new 10-bit word when valid pulse arrives
                shift_reg <= i_count;
                bit_count <= 4'd0;
            end else begin
                // Transmit 1 bit per clock, LSB-first
                o_serial_data <= shift_reg[bit_count];
                bit_count     <= bit_count + 4'd1;

                // After 10 bits ? assert tx_done
                if (bit_count == 4'd9)
                    o_tx_done <= 1'b1;
            end
        end
    end
endmodule