import pandas as pd
import matplotlib.pyplot as plt

# Daten einlesen
df = pd.read_csv("results_compare_pslp.txt")
df.columns = df.columns.str.strip()

# p aus dem Gruppennamen extrahieren
df["p"] = df["GroupName"].str.extract(r'_(\d+)').astype(int)

# Plot-Vorbereitung
plt.figure(figsize=(10, 6))

# Beide Werte gegen p plotten
plt.plot(df["p"], df["E(G)value_decimal"], marker='o', linestyle='-', label="E(G) (ohne neutrales Element)")
plt.plot(df["p"], df["o(G)value_decimal"], marker='s', linestyle='--', label="o(G) (inkl. neutrales Element)")

# Achsen und Legende
plt.title("Vergleich von E(G) und o(G) für PSL(2,p)")
plt.xlabel("Primzahl p")
plt.ylabel("Wert (dezimal)")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
