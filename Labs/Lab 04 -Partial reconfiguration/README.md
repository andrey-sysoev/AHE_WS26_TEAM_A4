# Lab 04 — Partial Reconfiguration with MicroBlaze

## Overview

The goal was to change part of an FPGA design at runtime without reprogramming the entire device. The **static region** contains the MicroBlaze processor, memory, UART and AXI GPIO. The **reconfigurable partition** (`u_rm`, inside `pblock_u_rm`) supports three interchangeable modules with identical interfaces:

| Module | Function | Example |
|---|---|---|
| RM A | Pass-through | `0x0001 → 0x0001` |
| RM B | Bitwise inversion | `0x0001 → 0xFFFE` |
| RM C | Swap the two bytes | `0x0001 → 0x0100` |

The Pblock was configured with `SNAPPING_MODE ON` and `RESET_AFTER_RECONFIG true`. The AXI GPIO base address used in `main.c` is `0x40000000`.

## Implementation and Bitstreams

Synthesis and routing completed for all three configurations. The design passed the checked DRC rules before implementation. The bitstream sizes observed in Windows Explorer were approximately:

| File | Size |
|---|---:|
| `impl_1/top.bit` (full, RM A) | 3.64 MB |
| `impl_1/u_rm_rm_a_partial.bit` | 534 KB |
| `child_0_impl_1/u_rm_rm_b_partial.bit` | 534 KB |
| `child_1_impl_1/u_rm_rm_c_partial.bit` | 534 KB |

The partial bitstreams are about **6.8 times smaller** than the full bitstream (using rounded displayed sizes).

## Hardware Test

The full bitstream was loaded through Vivado Hardware Manager. The application `lab04.elf` ran on MicroBlaze and printed results over **COM13, 9600 baud**. Then the partial bitstreams for RM B, RM C and RM A were loaded in sequence without intentionally restarting the application.

Recorded UART examples:

```text
loaded: RM A (pass-through)  in=0157 out=0157
loaded: RM B (invert)        in=0351 out=FCAE
loaded: RM C (swap bytes)    in=04AD out=AD04
loaded: RM A (pass-through)  in=0616 out=0616
```

All three functions behaved as expected, including the return to RM A. UART output remained available after each swap. The provided screenshots show the results after each reconfiguration; they do not capture an exact before/after transition or any transient `unknown` line.

## Task 4 — Questions

**1. How large are the bitstreams?**  
The full bitstream was approximately 3.64 MB; each partial bitstream was approximately 534 KB.

**2. Why are all three partial bitstreams the same size?**  
They target the same Pblock and contain configuration data for the same FPGA configuration-frame region.

**3. What happened to the terminal output during a swap?**  
After each partial bitstream was loaded, the UART showed the newly selected module's behavior. No `unknown` line was captured.

**4. Why was MicroBlaze not affected?**  
MicroBlaze, memory and UART are in the static region, outside the reconfigurable Pblock. The software continued producing UART output after each swap without needing a new application launch.

**5. When would partial reconfiguration not be useful?**  
Probably not for a small design with fixed functionality,because ordinary static configuration is simpler. DFX adds design complexity, reserved FPGA area and separate implementation runs.
