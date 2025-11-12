# Happy-Birthday-Design
 Overview:
 The Happy Birthday Design Problem aims to implement a simple digital system comprising a
 Transmitter and Receiver. The system transmits a randomly generated bit stream and the
 receiver detects your date of birth in the sequence and displays the number of times it is
 detected on a seven segment display.

  Architecture:
 [Example:
 Encodes the month number (1–12)
 Encodes the date (1–31)
 Combined sequence (Month + Date)
 July = 0111
 10 = 01010
 011101010]
 The system contains two major blocks, the data generator & transmitter and the detector &
 BCDencoder. The system operates on a 10KHz clock source common for trans-receive
 blocks.
 TRANSMITTER:
 The Transmitter Block generates 10-bit data words and transmits them serially at a defined
 rate using the system clock.– Generator: A 10-bit counter acts as the data source, producing values from 0 to
 1023. The counter increments once per completed transmission, ensuring that a new
 10-bit word is generated only after the previous one has been sent. This prevents
 overlap between data generation and transmission. (Slow Decade Counter: HDL
 Bits)– Each10-bit value is transmitted one bit per clock cycle, starting with the least
 significant bit (LSB). The transmitter therefore outputs a continuous serial stream
 synchronized with the 10 kHz system clock.
 Control Flow:
 When i_tx_ena_n is low, transmission is active.
 The transmitter shifts out 10 bits, one per clock, on its output line.
 After 10 cycles, a tx_done pulse signals completion.
 The generator counter increments once on tx_done, preparing the next 10-bit word.
 Timing Summary:
 · Clock frequency: 10 kHz
 · Bits per frame: 10
 · Bitrate: 10 kHz
 · Framerate: 1 kHz
 Thus, each full 10-bit frame is sent every 1 ms, and the complete counter cycle repeats
 approximately every 1.024 s.
RECEIVER:
 The Receiver Block monitors the incoming serial data stream and detects a fixed 9-bit
 birthday pattern (Month + Date). Each successful detection increments a counter, whose
 value is displayed once per second.– Thereceiver samples one bit per clock from the shared 10 kHz system clock. The
 incoming data is LSB-first, matching the transmitter’s bit order. The receiver must
 maintain a running record of the last nine received bits for pattern comparison. The
 design approach is open-ended:
 o Youmayimplement the detector as a finite state machine (FSM) that
 transitions through states according to partial pattern matches, or
 o Useashift-register and comparator method that checks all nine bits in parallel
 each clock cycle.
 Either method must ensure correct handling of overlapping pattern occurrences,
 meaning the same bit sequence can contribute to multiple detections if it reappears with
 shared bits.– Eachvalid detection increments a counter. The counter may be implemented as a
 simple up-counter with synchronous reset. It records the total number of matches
 observed during the current measurement interval.
 Display Update (Bonus Feature):
 To quantify detections, the receiver includes a mechanism to present the hit count on a
 seven-segment display once every second.
 At each one-second interval (derived from a clock divider on the 10 kHz system clock):– Thecurrent hit count value is latched and transferred to the display driver, encoded in
 BCD.– Thehit counter resets to begin counting afresh for the next second.– Avalidity pulse (o_hit_count_valid) may be asserted to indicate new display data.
 This ensures that the display represents the number of successful detections per second,
 synchronized with the system clock

<img width="824" height="166" alt="image" src="https://github.com/user-attachments/assets/dff8ddfc-ac99-408e-bdd9-c11dd0bc28ab" />


<img width="827" height="420" alt="image" src="https://github.com/user-attachments/assets/63b7ad31-f661-406a-9751-58db63fc4313" />














 
