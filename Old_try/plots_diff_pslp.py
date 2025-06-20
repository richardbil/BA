import pandas as pd
import matplotlib.pyplot as plt

# Datei laden
df = pd.read_csv("results_compare_pslp.txt")
df.columns = df.columns.str.strip()  # Whitespace entfernen

# Extrahiere n (also p) aus dem Gruppennamen
df["n"] = df["GroupOrder"]

# Berechne Differenz
df["Delta"] = df["o(G)value_decimal"] - df["E(G)value_decimal"]

# Plot
plt.figure(figsize=(8, 5))
plt.plot(df["n"], df["Delta"], marker='o', label="o(G) - E(G)")
plt.title("Differenz o(G) - E(G) für PSL(2, p)")
plt.xlabel("p")
plt.ylabel("o(G) - E(G) (decimal)")
plt.grid(True)
plt.legend()
plt.tight_layout()
plt.show()
