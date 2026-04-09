# AXI UVM Verification Environment

## Overview
A UVM-based verification environment built to verify an AXI protocol slave design, covering randomized write and corresponding read-back transactions, along with basic protocol handshaking compliance (VALID/READY based communication).

## Architecture
- **Interface** - Parameterized AXI interface (axi_inf) supporting address, data, and response channels.
- **Sequences** - Generates random write transactions followed by dependent read transactions (same address/length).
- **Driver** - Implements AXI protocol:
                       - Write: AW → W → B channels
                       - Read: AR → R channels
                       - Handles VALID/READY handshake properly
- **Monitor** - Observes DUT activity:
                       - Captures write data (W channel).
                       - Captures read data (R channel).
- **Scoreboard** - Memory model-based checking:
                       - Stores write data into the reference memory.
                       - Compares read data against expected values.
- **Environment** - Integrates agent and scoreboard.
- **Agent** - Active agent with sequencer, driver, and monitor.

## Protocol Covered
- AXI (AMBA AXI4 – basic features):
      - INCR burst (awburst = 2'b01)
      - Fixed data size (4 bytes)
      - Address-aligned transfers
      - Burst length up to 8 beats

## Tools Used
- Simulation : EDA Playground
- Language: SystemVerilog + UVM

## What Was Verified
- Randomized single and burst write transactions
- Corresponding read-after-write (RAW) verification
- INCR burst behavior
- Address alignment constraints (word aligned)
- Back-to-back write followed by read transactions
- VALID/READY handshake correctness for:
      - AW channel
      - W channel
      - B channel
      - AR channel
      - R channel
- Data integrity check using scoreboard memory model
- Burst boundary condition:
- Address + burst size constrained within 4KB region

## Results
- Directed + constrained-random tests executed successfully
- Read data matched written data for valid transactions
- Scoreboard reported:
      - Correct tracking of total transactions
      - Pass/fail count for read comparisons
- Basic functional correctness of AXI slave validated
- No protocol violations observed for tested scenarios

## Run It Yourself
This testbench was simulated on EDA Playground.
Paste the src/ files into EDA Playground with:
- Language: SystemVerilog/UVM
- Simulator: Aldec Riviera-PRO or Cadence Xcelium
