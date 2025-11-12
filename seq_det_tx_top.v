`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 20:53:02
// Design Name: 
// Module Name: seq_det_tx_top
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
// Transmitter Integration (Generator + PISO)
//============================================================
module seq_det_tx_top (
    input  wire i_clk,
    input  wire i_rst,
    input  wire i_tx_en_n,     // Active-low enable
    output wire o_serial_data
);
    reg        tx_en_n_d;
    wire       tx_en_fall;
    wire       tx_done;
    wire [9:0] count;
    wire       count_valid;

    // Detect falling edge of TX enable (HIGH?LOW)
    always @(posedge i_clk)
        tx_en_n_d <= i_tx_en_n;

    assign tx_en_fall = (tx_en_n_d == 1'b1 && i_tx_en_n == 1'b0);

    // Generator
    seq_det_gen U_GEN (
        .i_clk         (i_clk),
        .i_reset       (i_rst),
        .i_count_valid (tx_done),
        .o_count       (count),
        .o_count_valid (count_valid)
    );

    // PISO Transmitter
    seq_det_tx U_TX (
        .i_clk         (i_clk),
        .i_reset       (i_rst),
        .i_count_valid (count_valid),
        .i_count       (count),
        .o_serial_data (o_serial_data),
        .o_tx_done     (tx_done)
    );
endmodule