# Thermostat (VHDL)

A simple yet modular **digital thermostat controller** written in **VHDL**. It continuously monitors the temperature, compares it with user-defined thresholds, and activates heating or cooling outputs accordingly. The project demonstrates how digital logic can be used to build a feedback control system with real-time monitoring and user configurability.

---

## Overview

This project simulates a basic thermostat system designed to maintain a stable environment by controlling heating and cooling mechanisms. The controller reads a simulated temperature input, compares it with stored minimum and maximum thresholds, and drives corresponding output signals.

The system includes several hardware-oriented components, such as a **clock divider**, **memory modules for thresholds**, **comparator logic**, and **7-segment display control**. Together, they provide a complete example of a simple embedded control system implemented purely in VHDL.

The design can be synthesized on an FPGA board or simulated using tools like **GHDL**, **ModelSim**, or **Vivado**. The modular architecture makes it easy to extend, test, and adapt for other digital control applications.

---

## Main Files

| File                            | Description                                                           |
| ------------------------------- | --------------------------------------------------------------------- |
| `digital_clock.vhd`             | Generates timing signals for display updates and control logic        |
| `freq_devider.vhd`              | Divides the main system clock into slower signals for synchronization |
| `ram_mem_tmin.vhd`              | Memory module storing the lower temperature threshold (T_MIN)         |
| `ram_mem_tmax.vhd`              | Memory module storing the upper temperature threshold (T_MAX)         |
| `set_temps.vhd`                 | Logic for setting or updating temperature limits via simulated input  |
| `hex_to_7_seg_dcd.vhd`          | Converts binary or hex values to 7‑segment display encoding           |
| `ssd_dis.vhd`                   | Drives and multiplexes the 7‑segment display to show values           |
| `su.vhd`                        | Top-level control unit that performs comparison and output control    |
| `sim_unit.vhd` / `test_env.vhd` | Testbench and simulation units for verifying correct behavior         |

---

## Notes

* The design is **synthesizable**, except for testbenches and file I/O statements used in simulation.
* The **temperature limits** (T_MIN and T_MAX) can be modified in simulation or through the `set_temps.vhd` logic.
* You can adapt the design for an **FPGA implementation** by mapping the display pins and input controls to your board’s hardware.
* The **7-segment display** can show the current temperature, thresholds, or operational state (heating/cooling) based on logic configuration.
* The system demonstrates modular design principles, making it suitable for learning or teaching digital design concepts.

---

## Possible Extensions

If you want to expand this project, here are some directions to consider:

* **Add hysteresis control** to reduce frequent switching when the temperature fluctuates near threshold values.
* **Introduce button-based user input** for changing T_MIN and T_MAX dynamically.
* **Enhance the display logic** to show both the current and target temperatures alternately.
* **Implement a communication interface** (UART, SPI, or I2C) for external monitoring or control.
* **Integrate sensor simulation or ADC interface** for real temperature readings.
* **Add error detection or safety mechanisms** (e.g., alert if temperature goes out of safe range).

---

This project provides a solid starting point for students or enthusiasts learning VHDL and digital system design. It showcases real-world control logic concepts in a clear and modular way, making it easy to simulate, analyze, and extend.
