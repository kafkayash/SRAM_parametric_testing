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

## How to Run Simulations:

### Viewing the Schematic:
To open the schematic in Xschem:
```bash
xschem sram_6t_cell.sch
```
### Running Ngspice for the plots:
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
.control
 run
let dVQbar=deriv(V(Qbar))
meas dc Vil FIND V(Q) WHEN dVQbar=-1 CROSS=1
meas dc Vih FIND V(Q) WHEN dVQbar=-1 CROSS=2
meas dc Vol FIND V(Qbar) WHEN dVQbar=-1 CROSS=2
meas dc Voh FIND V(Qbar) AT=0.1
let NM_H=Voh-Vih
let NM_L=Vil-Vol
print NM_L NM_H
.endc
```
In ```mySRAM_6t.spice```, Ngspice calculates:

- **NM_L**— lower noise margin.
- **NM_H**— higher noise margin.

**Method:**
  - Sweep input voltage, record **q** and **qbar**.
  - **Mirror one curve** → generate butterfly curve.
  - Fit the largest possible square inside each lobe.

     ```SNM = min(NM_L, NM_H)```
One important thing to consider before running the python script is that ```mySRAM_6t.spice``` uses  uses **placeholders** for transistor dimensions:
```spice
M1 q qbar GND GND nmos W={W_nmos} L={L_nmos}
M2 qbar q VDD VDD pmos W={W_pmos} L={L_pmos}
```
The are set such that widths and lengths are considered to be a varibale to be updated by the python script while running each simulation. The aspect ratios will be taken accordingly and the spice file will be parsed by python and updated. These values are printed in Ngspice output and parsed by the Python script.

**NOTE:**

I have not yet updated the code to for the following functionalities:
1. It does to generate a seperate spice file for each iteration.
2. The manual SNM calculation is not integrated into spice file yet but however its not that hard, for anyone wishing to add the SNM calculation you can refer the following paper and update the given formulas into the ```.control``` block of spice file.
##  Related Research

This work builds upon the foundational static noise margin methodology introduced by:

**E. Seevinck, F. J. List, and J. Lohstroh**, “Static-noise margin analysis of MOS SRAM cells,” *IEEE Journal of Solid-State Circuits*, vol. 22, no. 5, pp. 748–754, Oct. 1987.  
Available via IEEE (requires access): [doi:10.1109/JSSC.1987.1052809](https://doi.org/10.1109/JSSC.1987.1052809)

## Python script for Automation:
The python script ```sram6T_simulation.py``` can be run by the command:
```python
python3 sram6T_simulation.py
```
once its running you will see something like this on your terminal






