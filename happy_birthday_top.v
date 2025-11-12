`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 20:39:20
// Design Name: 
// Module Name: happy_birthday_top
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
// HAPPY BIRTHDAY SYSTEM - TOP MODULE
//============================================================
module happy_birthday_top (
    input  wire       i_clk,          // 10kHz system clock
    input  wire       i_rst,          // Active-high reset
    input  wire       i_tx_en_n,      // Active-low transmit enable
    output wire [6:0] o_seg_ones,
    output wire [6:0] o_seg_tens,
    output wire       o_hit_count_valid
);
    wire serial_data;
    wire [15:0] hit_count;
    wire hit_count_valid;

    // Transmitter subsystem
    seq_det_tx_top U_TXSYS (
        .i_clk         (i_clk),
        .i_rst         (i_rst),
        .i_tx_en_n     (i_tx_en_n),
        .o_serial_data (serial_data)
    );

    // Receiver subsystem
    seq_det_rx #(.BDAY_PATTERN(9'b100000101)) U_RXSYS ( //  Aug 5
        .i_clk             (i_clk),
        .i_reset           (i_rst),
        .i_serial_in       (serial_data),
        .o_hit_count       (hit_count),
        .o_hit_count_valid (hit_count_valid)
    );

    // 7-segment display driver (2 digits)
    wire [3:0] ones = hit_count % 10;
    wire [3:0] tens = (hit_count / 10) % 10;

    bcd_to_7seg U_SEG1 (.bcd(ones), .seg(o_seg_ones));
    bcd_to_7seg U_SEG2 (.bcd(tens), .seg(o_seg_tens));

    assign o_hit_count_valid = hit_count_valid;
endmodule