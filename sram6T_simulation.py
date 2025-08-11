import subprocess
import pandas as pd
import numpy as np

#NMOS and PMOS  values change keeping in mind the pdk constrains W cannot go below 0.3 and L canot go above 1.5
W_nmos_values = np.linspace(1, 10, 10)  # Example NMOS widths
L_nmos_values = np.round(np.linspace(0.15, 1.1, 10),2)  # Example NMOS lengths, rounded only upto 2 decimal places. if np.round isnt used it produces unnecessarily long decimal digits.
W_pmos_values = W_nmos_values*2 # usually pmos widht is twice the nmos alternatively if you want to manually increase in steps of 2 use np.arrange(1,21,2) 
L_pmos_values = np.round(np.linspace(0.35,1.35,10),2) # here it started from 0.35 as it is minimum limit for LVT pmos cell, below which we enter sub threshold regions easily making it unstable anyway
# Create CSV file to store results
results = []

# Read the template SPICE file
with open("mySRAM_6t.spice", "r") as file:
    spice_temp = file.read()

# Iterate over exactly 10 (W_nmos, L_nmos, W_pmos, L_pmos) pairs
for i in range(10):
    W_nmos, L_nmos = W_nmos_values[i], L_nmos_values[i]
    W_pmos, L_pmos = W_pmos_values[i], L_pmos_values[i]

    # Replace placeholders with actual values
    spice_netlist = (
        spice_temp.replace("{W_nmos}", str(W_nmos))
                  .replace("{L_nmos}", str(L_nmos))
                  .replace("{W_pmos}", str(W_pmos))
                  .replace("{L_pmos}", str(L_pmos))
    )

    # Write modified netlist to a temp file
    with open("temp.spice", "w") as file:
        file.write(spice_netlist)

    # Run NGSPICE
    process = subprocess.run(["ngspice", "-b", "temp.spice"], capture_output=True, text=True)

    # Extract NM_L and NM_H from output
    output_lines = process.stdout.split("\n")
    NM_L, NM_H = None, None
    for line in output_lines:
        if "nm_l" in line:
            print("found nm_l: ",line)
            NM_L = float(line.split()[-1])
        if "nm_h" in line:
            print("found nm_h: ",line)
            NM_H = float(line.split()[-1])

    # Store results
    if NM_L is not None and NM_H is not None:
        results.append([W_nmos, L_nmos, W_pmos, L_pmos, NM_L, NM_H])

# Save results to CSV
df = pd.DataFrame(results, columns=["W_nmos", "L_nmos", "W_pmos", "L_pmos", "NM_L", "NM_H"])
df.to_csv("noise_margins_6t.csv", index=False)

print("Automation complete. Results saved to noise_margins_6t.csv.")

