# 6T SRAM Cell Simulation and Analysis

This project contains the schematic, SPICE netlist, and simulation results for a **6-transistor (6T) SRAM cell**, including DC transfer characteristics, the butterfly curve, and noise margin calculation.

## Contents

- **Schematic** of the 6T SRAM cell.
- **DC sweep plot** showing the voltage transfer curves of internal nodes.
- **Butterfly curve** for static noise margin (SNM) analysis.
- Python code for netlist parsing and data extraction (explained below).

## Schematic

![SRAM Schematic](docs/images/sram_6t_dc_analysis.png)

The 6T SRAM cell consists of:
- Two cross-coupled CMOS inverters (M1–M2 and M17–M26).
- Two NMOS access transistors (M3, M4) controlled by the word line (WL).
- Bit lines **BL** and **BLB** for read/write operations.

## Simulation Plots

### DC Sweep
![DC Sweep](docs/images/dc_analysis_sram.png)

This plot shows the DC sweep of the internal nodes **q** (red) and **qbar** (blue) as the input sweep voltage is varied. It illustrates the inverter transfer characteristics and the bistable nature of the SRAM cell.

### Butterfly Curve
![Butterfly Curve](docs/images/butterfly_curve_sram.png)

The butterfly curve is obtained by plotting the inverter characteristics against each other. The **static noise margin (SNM)** is determined from the largest square that can fit inside the lobes of this curve.

---

## How to Run Simulations

### Viewing the Schematic
To open the schematic in Xschem:
```bash
xschem sram_6t_cell.sch
