`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 20:42:48
// Design Name: 
// Module Name: seq_det_gen
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
// 10-bit Counter (Data Generator)
//============================================================
module seq_det_gen (
    input            i_clk,
    input            i_reset,
    input            i_count_valid,   // Pulse from TX when frame done
    output           o_count_valid,   // Used to load next word in TX
    output reg [9:0] o_count
);
    always @(posedge i_clk) begin
        if (i_reset)
            o_count <= 10'd0;
        else if (i_count_valid)
            o_count <= o_count + 10'd1;
    end

    assign o_count_valid = i_count_valid;  // Same pulse propagates
endmodule