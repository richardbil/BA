import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("results_compare_alt.txt")
df.columns = df.columns.str.strip()
df["n"] = df["GroupName"].str.extract(r'(\d+)').astype(int)
df["Type"] = df["GroupName"].str.extract(r'(A|AoG)')
labels = {"A": "Expected order", "AoG": "Average Element order"}

plt.figure(figsize=(10, 6))
for group_type in ["A", "AoG"]:
    subdf = df[df["Type"] == group_type]
    plt.plot(subdf["n"], subdf["E(G)o(G)value_decimal"], marker='o', label=labels[group_type])

plt.title("E(G) and o(G) for AlternatingGroups vs n")
plt.xlabel("n")
plt.ylabel("Value for o(G) or E(G)")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
