import pandas as pd
import matplotlib.pyplot as plt


df = pd.read_csv("results_compare_dihedral.txt")
df.columns = df.columns.str.strip()


#df["GroupOrder"] = pd.to_numeric(df["GroupOrder"], errors='coerce')
df["diff"] = pd.to_numeric(df["diff"], errors='coerce')


plt.figure(figsize=(10, 6))

# Plot: Gruppenordnung gegen Differenz
plt.plot(df["n"], df["diff"], marker='o', linestyle='-', color='purple', label="o(G) - E(G)")

# Achsen und Legende
plt.title("Differenz o(G) - E(G) für direkte Produkte von D6")
plt.xlabel("Gruppenordnung")
plt.ylabel("Differenz (dezimal)")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
