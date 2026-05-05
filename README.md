# FPGA-Stopwatch-and-Press-Counter
Modular Verilog-based FPGA game system designed in Quartus for the DE-10 LITE featuring a debounced edge-sensitive press counter, a custom stopwatch module utilizing an internal 50MHz clock, and a custom 7-segment display driver.


## Goal 🎯
I aimed to create a button-mashing game that could be easily implemented on a DE-10 LITE to gain practical experience in combinational and sequential digital circuit design. 

---

## Module Info
Below is the list of Verilog modules in this repository:

- **TopModule.v: The top-level entity for this project. 
- **pulse_counter.v: The module responsible for incrementing the score count based on the press-state connected via wire from the debouncer.v module
- **stopwatch.v: The module responsible for dividing the internal 50MHz clock frequency down to 0.1s. 
- **hex_7seg_decoder.v: Uses a decoder to determine the output of the 7-segment display
- **debouncer.v: Debounces the input from the DE-10 LITE's on-board 3.3-V Schmitt Trigger button(KEY[0])

---

## Modular Diagram

![Module Diagram](docs/Module_Diagram.png)

---

## Pin Layout
Make sure to check the specific i/o requirements for your board. For the DE-10 LITE, everything but the input button (KEY[0]) use the 3.3 -V LVTTL. The button (KEY[0]) uses the 3.3-V Schmitt Trigger.

![Pin Planner Quartus](docs/Pin_Layout.png)

---

## Trouble Shooting 🛠

- ** Make sure to set the TopModule.v to top-level-entity in Quartus by going to Project -> Set as Top-Level Entity.
- ** Double check all pin assignments and i/0 standards.
- ** Confirm 50MHz clock frequency.
---