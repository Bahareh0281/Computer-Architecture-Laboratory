# Computer Architecture Lab Projects

This repository contains a collection of projects implemented in **VHDL** and tested on a **SPARTAN3** FPGA board as part of the Computer Architecture Lab. Each project explores different aspects of digital design and hardware implementation.

## Repository Content

1. **Full Adder and BCD to 7-Segment Display**
   - Implements a full adder and a BCD (Binary-Coded Decimal) to 7-segment display converter.
   - Demonstrates the basics of arithmetic operations and digital display interfacing.

2. **7-Segment Counter**
   - A counter that outputs its value to a 7-segment display.
   - Useful for understanding sequential logic and state machines.

3. **Digital Timer**
   - A simple digital timer with start, stop, and reset functionalities.
   - Introduces the concept of timing circuits and clock management in FPGAs.

4. **Serial Communication**
   - Basic serial communication protocols implemented using UART (Universal Asynchronous Receiver/Transmitter).
   - Focuses on data transmission and reception between devices.

5. **Basic Calculations and Sending via UART**
   - Performs simple arithmetic calculations and sends the results through UART.
   - Demonstrates the integration of arithmetic operations with serial communication.

6. **Receive Data from Serial Port**
   - Receives data from a serial port and processes it.
   - Highlights the importance of data handling and synchronization in serial communication.

7. **LED Light Control with Serial - PWM**
   - Controls LED brightness using Pulse Width Modulation (PWM) via serial commands.
   - Explores the application of PWM in brightness control and serial interfacing.

8. **LED Light Control with Counter**
   - Controls LED brightness using a counter-based approach.
   - Shows alternative methods of implementing brightness control.

## Hardware Used

- **FPGA Board:** SPARTAN3
- **Programming Language:** VHDL

## How to Use

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/computer-architecture-lab.git
   cd computer-architecture-lab
   ```

2. **Open the VHDL files:**
   Navigate to the specific project folder to access the VHDL files.

3. **Synthesize and simulate:**
   Use your preferred FPGA development environment (such as Xilinx ISE) to synthesize and simulate the VHDL code.

4. **Deploy to SPARTAN3:**
   Load the synthesized bitstream onto the SPARTAN3 board to test the projects in hardware.

## Acknowledgements

These projects were developed as part of the Computer Architecture Lab coursework. The implementations are tested and verified on the SPARTAN3 FPGA board.
