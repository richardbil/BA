import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load data
df = pd.read_csv("results_normal_cpi.txt")

# Clean headers
df.columns = df.columns.str.strip()

# Extract base prime p and exponent k from the GroupName
df["n"] = df["GroupName"].str.extract(r'_(\d+)').astype(int)

# Extract the base prime p from n = p^k by prime factorization (assumes n is a prime power)
def get_base_and_exp(n):
    for p in range(2, int(n ** 0.5) + 2):
        k = 0
        m = n
        while m % p == 0:
            m //= p
            k += 1
        if m == 1 and k > 0:
            return p, k
    return n, 1  # fallback: n is prime

df[["p", "k"]] = df["n"].apply(lambda x: pd.Series(get_base_and_exp(x)))

# Plot
plt.figure(figsize=(12, 7))

# Plot each prime p as a separate curve
for p in sorted(df["p"].unique()):
    subdf = df[df["p"] == p].sort_values("k")
    plt.plot(subdf["k"], subdf["E(G)value_decimal"], marker='o', label=f"p = {p}")

# Labels and legend
plt.title("Average Element Order E(G) for Cyclic Groups $C_{p^k}$", fontsize=14)
plt.xlabel("Exponent k (in $C_{p^k}$)", fontsize=12)
plt.ylabel("E(G) value (decimal)", fontsize=12)
plt.legend(title="Prime p")
plt.grid(True)
plt.tight_layout()
plt.show()
