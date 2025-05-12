import pandas as pd
import matplotlib.pyplot as plt

#get the data
df = pd.read_csv("results_compare_sym.txt")

#so this line strips the dataframe of whitespace 
df.columns = df.columns.str.strip()

#get the n from the first column
df["n"] = df["GroupName"].str.extract(r'(\d+)').astype(int)
df["Type"] = df["GroupName"].str.extract(r'(S|SoG])')  

#plot
plt.figure(figsize=(10, 6))

#take the n for each group name and plot against the decimal value 
for group_type in ["S", "SoG"]:
    subdf = df[df["Type"] == group_type]
    plt.plot(subdf["n"], subdf["E(G)o(G)value_decimal"], marker='o', label=f"{group_type}n")

#labels
plt.title("E(G) and o(G) for SymmetricGroups in decimal vs n")
plt.xlabel("n")
plt.ylabel("Value for o(G) or E(G)")

#readibility, legend, grid in background, adjust spaces between lines etc.
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
