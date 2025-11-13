# 🎉 Happy Birthday – Pattern Detection System
📘 Overview

The Happy Birthday Design Problem implements a simple yet elegant digital communication system with a Transmitter and Receiver.
The transmitter sends a continuous bitstream, and the receiver detects your date of birth pattern within it — counting how many times it appears and displaying the count on a seven-segment display.

🧠 Concept

Birthday Encoding:

Month (1–12) ➜ 4-bit binary

Date (1–31) ➜ 5-bit binary

Combined ➜ 9-bit unique birthday pattern

Example:

July = 0111

10 = 01010

Final pattern ➜ 011101010

🧩 Architecture Overview

The system consists of two main modules:

Module	Function
🛰️ Transmitter	Generates 10-bit data frames and serially transmits them bit-by-bit at 10 kHz.
🎯 Receiver	Detects the 9-bit birthday pattern and counts its occurrences every second.
⚙️ Transmitter Design

10-bit data generator counter produces values from 0000000000 to 1111111111 (0–1023).

Each value is sent serially (LSB-first) using the 10 kHz system clock.

A tx_done pulse marks the end of every 10-bit frame, triggering the next word generation.

Control Flow:

i_tx_ena_n = 0 ➜ transmission active

One bit transmitted per clock cycle

Counter increments on every completed frame

🕒 Timing Summary:

Parameter	Value
Clock Frequency	10 kHz
Bits per Frame	10
Bitrate	10 kbps
Frame Rate	1 kHz
Full Counter Cycle	≈ 1.024 s
📡 Receiver Design

Samples one bit per clock (synchronized with the 10 kHz transmitter clock).

Maintains a sliding 9-bit shift register for real-time pattern matching.

Detects overlapping birthday patterns efficiently using either:

🧩 FSM-based detector, or

🔍 Shift-register + comparator logic

Each valid detection increments a hit counter, stored until the next 1-second update.

🔢 Display and Counting

Every 1 s (derived from a 10 kHz clock divider):

The hit count is latched and sent to a BCD encoder.

Count value is displayed on a seven-segment display.

Counter resets for the next 1 s interval.

Optional o_hit_count_valid signal indicates display update timing.

📺 Display Behavior Example:

Time Interval	Detections Found	7-Segment Display Output
0–1 s	3	003
1–2 s	1	001
2–3 s	0	000
🛠️ Technical Summary

Language: Verilog HDL

Toolchain: Xilinx Vivado

Clock: 10 kHz system clock (common for Tx/Rx)

Modules:

data_generator.v

piso_transmitter.v

pattern_detector.v

bcd_encoder.v

seven_seg_driver.v

🧪 Verification

Verified serial transmission, pattern detection, and display logic in Vivado simulation.

Confirmed detection accuracy and overlapping pattern handling through waveform analysis.

Validated correct one-second interval updates on the seven-segment display.

🎯 Outcome

✅ Detected and counted the 9-bit birthday pattern in a continuous data stream.
✅ Achieved seamless transmitter–receiver synchronization.
✅ Demonstrated accurate visual feedback via seven-segment display updates.

<img width="824" height="166" alt="image" src="https://github.com/user-attachments/assets/dff8ddfc-ac99-408e-bdd9-c11dd0bc28ab" />


<img width="827" height="420" alt="image" src="https://github.com/user-attachments/assets/63b7ad31-f661-406a-9751-58db63fc4313" />














 
