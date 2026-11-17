# Lab 02 — MicroBlaze IP

**Advanced Hardware Engineering | Team A4**

## Objective
Build a MicroBlaze-based system on the Nexys A7-100T and run a C application that communicates with a PC over UART.

## Design and software
The system uses MicroBlaze, 128 KB local memory, a debug module, clock/reset circuitry, AXI UART Lite, and the AXI interconnect. The application is built in Vitis for the standalone MicroBlaze domain.

## Results
- Vivado block design, constraints and hardware export: see files in this lab folder.
- Timing/utilization reports: see the attached screenshots where available.
- UART demonstration: **add terminal screenshot or log if available**.
- Echo exercise (receive a character and print it back): **mark completed only after testing**.

## Questions
**Why UART?** It provides a serial communication channel between MicroBlaze and the PC.

**What is the XSA?** It describes the hardware platform so Vitis can build software for the configured processor and peripherals.

**What does the ELF do?** It contains the compiled application that is loaded into MicroBlaze memory and executed.
