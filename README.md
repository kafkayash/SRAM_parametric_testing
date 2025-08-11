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
```
### Running Ngspice for the plots
This runs the ngspice simulation and shows the plots, note that temp.spice is the file generated after final simulation loop i.e it has maximum defined paramaters. 
```bash
ngspice sram6tplots.spice
```
The plots itself is done by following lines in spice file
```spice
.include "sram_6t_cell.spice"
.control
run
*this plots the voltage transfer characteristics curve(vtc) for 6T cell for the  original W/L ratios, in case you want to vary W/L chnage it in original spice netlist
plot Q Qbar 
*this plots butterfly curve of 6T cell you can calucate SNM(static noise margin)  from this by placing largest fittable square in one upper reigion or finding largest diagonal intersecting the curve
plot v(Q) vs v(Qbar) v(Qbar) vs v(Q) 
.endc
```
### Ngspice noise margin logic:
The .control block added to ngspice takes care of the noise margin calculation, albeit it could've been done in python but its more practical to use spice itself for the calculations because when we have a very large number of cells then importing it to python and calculating it over there is lot slower and to avoid that latency issue its preferred to run it on spice itself.
The calculation is pretty straight forward you just need to find the rate of change of the curve specifically at points where its derivative is negative one for the first time and second time that is what this block handles
```spice

### Python script




