# Lab 03 — GPIO, 7-Segment Display and PWM

**Advanced Hardware Engineering | Team A4**

## Objective
Extend the MicroBlaze system with AXI GPIO and a custom PWM IP to control LEDs, switches, a 7-segment display and RGB LEDs.

## Design
The first AXI GPIO connects the switches and LEDs; the second drives the segment lines and digit enables. The custom PWM IP exposes memory-mapped control and duty-cycle registers.

**How does memory-mapped I/O work?** Software reads and writes peripheral registers at fixed addresses using `Xil_In32` and `Xil_Out32`.

**Why does the 7-segment display need multiplexing?** The digits share segment lines. The program activates one digit at a time quickly enough to appear continuous.

**Why are display signals active-low?** A logic 0 turns on the selected segment or digit, so an all-zero output may illuminate several segments.

**What does PWM duty cycle change?** It controls the average on-time and therefore the perceived RGB LED brightness. A duty value of 0 gives minimum output and 255 gives maximum output, subject to the IP's polarity and register definition.
