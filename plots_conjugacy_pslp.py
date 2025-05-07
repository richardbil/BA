import pandas as pd
import matplotlib.pyplot as plt

#get the data
df = pd.read_csv("results_conjugacy_pslp.txt")

#so this line strips the dataframe of whitespace 
df.columns = df.columns.str.strip()

#get the n from the first column
df["n"] = df["GroupName"].str.extract(r'_(\d+)').astype(int)
df["Type"] = df["GroupName"].str.extract(r'(PSL)')  

#plot
plt.figure(figsize=(10, 6))

#take the n for each group name and plot against the decimal value 
plt.plot(df["n"], df["E(G)value_decimal"], marker='o', label="PSL2(p)")
#labels
plt.title("Average Element Order E(G) for PSL(2,p) vs p")
plt.xlabel("p")
plt.ylabel("E(G) value")

#readibility, legend, grid in background, adjust spaces between lines etc.
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
