import pandas as pd
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv("results_compare_cpi.txt")
df.columns = df.columns.str.strip()

# Extract n = p^k
df["n"] = df["GroupName"].str.extract(r'_(\d+)').astype(int)

# Extract p and k
def get_base_and_exp(n):
    for p in range(2, int(n**0.5) + 2):
        k = 0
        m = n
        while m % p == 0:
            m //= p
            k += 1
        if m == 1 and k > 0:
            return p, k
    return n, 1

df[["p", "k"]] = df["n"].apply(lambda x: pd.Series(get_base_and_exp(x)))

# Plot
plt.figure(figsize=(12, 7))

# For each prime p, plot both E(G) and o(G) against k
for p in sorted(df["p"].unique()):
    subdf = df[df["p"] == p].sort_values("k")
    
    # E(G)
    plt.plot(subdf["k"], subdf["E(G)value_decimal"], marker='o', linestyle='-', label=f"E(G), p={p}")
    
    # o(G)
    plt.plot(subdf["k"], subdf["o(G)value_decimal"], marker='s', linestyle='--', label=f"o(G), p={p}")

# Labels
plt.title("Vergleich: E(G) vs o(G) für $C_{p^k}$", fontsize=14)
plt.xlabel("Exponent k (in $C_{p^k}$)", fontsize=12)
plt.ylabel("Wert (dezimal)", fontsize=12)
plt.legend(title="Kurventyp und p")
plt.grid(True)
plt.tight_layout()
plt.show()
