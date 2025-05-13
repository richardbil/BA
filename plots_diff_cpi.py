import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load data
df = pd.read_csv("results_normal_cpi.txt")

# Clean headers: Remove any leading or trailing spaces
df.columns = df.columns.str.strip()

# Check if the necessary columns exist
print(df.columns)

# Extract base prime p and exponent k from the GroupName
df["n"] = df["GroupName"].str.extract(r'_(\d+)').astype(int)

# Function to extract the base prime p and exponent k
def get_base_and_exp(n):
    for p in range(2, int(n ** 0.5) + 2):
        k = 0
        m = n
        while m % p == 0:
            m //= p
            k += 1
        if m == 1 and k > 0:
            return p, k
    return n, 1  # if n is prime

# Extract base prime p and exponent k for each group
df[["p", "k"]] = df["n"].apply(lambda x: pd.Series(get_base_and_exp(x)))

# Ensure the required columns 'o(G)value_decimal' and 'E(G)value_decimal' are present
if 'o(G)value_decimal' not in df.columns or 'E(G)value_decimal' not in df.columns:
    print("Error: One or both required columns ('o(G)value_decimal', 'E(G)value_decimal') are missing.")
else:
    # Calculate the difference Delta = o(G) - E(G)
    df["Delta"] = df["o(G)value_decimal"] - df["E(G)value_decimal"]

    # Plot setup
    plt.figure(figsize=(12, 7))

    # Plot each prime p as a separate curve
    for p in sorted(df["p"].unique()):
        subdf = df[df["p"] == p].sort_values("k")
        plt.plot(subdf["k"], subdf["Delta"], marker='o', label=f"p = {p}")

    # Labels and legend
    plt.title("Differenz o(G) - E(G) für Cyclic Groups $C_{p^k}$", fontsize=14)
    plt.xlabel("Exponent k (in $C_{p^k}$)", fontsize=12)
    plt.ylabel("Differenz o(G) - E(G) (decimal)", fontsize=12)
    plt.legend(title="Prime p")
    plt.grid(True)
    plt.tight_layout()
    plt.show()
