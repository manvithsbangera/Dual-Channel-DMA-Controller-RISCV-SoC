# Dual-Channel DMA Controller for RISC-V SoC

## Overview

This project presents the design and implementation of a Dual-Channel Direct Memory Access (DMA) Controller integrated into a RISC-V System-on-Chip (SoC) using Verilog HDL.

The DMA controller performs efficient memory-to-memory data transfers with minimal CPU intervention and supports both Single and Burst transfer modes.

---

## Features

- Dual-Channel DMA Architecture
- Memory-to-Memory Data Transfer
- Single Transfer Mode
- Burst Transfer Mode
- Round-Robin Arbitration
- AXI4-Lite Interface
- FPGA Implementation
- Software Verification using C

---

## Project Structure

```
RTL/               Verilog RTL source files
Software/          C program for DMA verification
Constraints/       FPGA constraint files
Testbench/         Simulation testbench
SOC_Integration/   RISC-V SoC integration files
Images/            Block diagrams and screenshots
Report/            Project report
```

---

## Tools Used

- Verilog HDL
- Vivado 2018.1
- Spartan-7 FPGA
- RISC-V
- C Programming
- Windows Subsystem for Linux (WSL)

---

## Results

The DMA controller was successfully verified for:

- Single Mode Data Transfer
- Burst Mode Data Transfer
- Memory-to-Memory Copy
- FPGA Implementation
- Software Verification using C

---

## Future Improvements

- Memory-to-Peripheral Transfer
- Peripheral-to-Memory Transfer
- Interrupt-Based DMA
- Scatter-Gather DMA Support

---

## Author

Manvith Shivaram Bangera

Electronics and Communication Engineering

---
