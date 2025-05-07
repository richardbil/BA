import pandas as pd
import matplotlib.pyplot as plt
import os
import re

# Deine Ergebnisdateien
files = [
    "results_conjugacy_pslp.txt",
    "results_conjugacy_pslqi.txt",
    "results_conjugacy_sym-alt.txt",
    "results_normal_cpi.txt",
    "results_slow_sym-alt.txt"
]

# Gruppentyp bestimmen
def get_type(groupname):
    if "PSL2_q" in groupname:
        return "PSLqi"
    elif "PSL2" in groupname:
        return "PSLp"
    elif groupname.startswith("C_"):
        return "Cyclic"
    elif groupname.startswith("S"):
        return "Symmetric"
    elif groupname.startswith("A"):
        return "Alternating"
    else:
        return "Unknown"

# Hauptloop über alle Dateien
for file in files:
    if not os.path.exists(file):
        print(f"Datei {file} nicht gefunden, übersprungen.")
        continue

    df = pd.read_csv(file)
    df.columns = df.columns.str.strip()

    df["Type"] = df["GroupName"].apply(get_type)
    df["n"] = df["GroupName"].str.extract(r'(\d+)').astype(int)

    plt.figure(figsize=(10, 6))

    if "pslqi" in file:
        df["q"] = df["GroupName"].str.extract(r'q(\d+)').astype(int)
        for q_val in sorted(df["q"].dropna().unique()):
            sub = df[df["q"] == q_val]
            plt.plot(sub["n"], sub["E(G)value_decimal"], marker='o', label=f"q = {q_val}")
        plt.title("E(G) für PSL(2, q^i)")
        plot_filename = "plot_pslqi.png"
    else:
        for typ in df["Type"].unique():
            sub = df[df["Type"] == typ]
            plt.plot(sub["n"], sub["E(G)value_decimal"], marker='o', label=typ)

        title_map = {
            "results_conjugacy_pslp.txt": "E(G) für PSL(2, p)",
            "results_conjugacy_sym-alt.txt": "E(G) für Symmetrische und Alternierende Gruppen",
            "results_normal_cpi.txt": "E(G) für Zyklische p-Gruppen",
            "results_slow_sym-alt.txt": "Langsame Version: Sym/Alt",
        }

        plt.title(title_map.get(file, f"E(G) aus {file}"))
        plot_filename = "plot_" + os.path.splitext(file)[0] + ".png"

    plt.xlabel("n")
    plt.ylabel("E(G) (Dezimal)")
    plt.legend()
    plt.grid(True)
    plt.tight_layout()

    plt.savefig(plot_filename)
    print(f"✓ Plot gespeichert als: {plot_filename}")
    plt.show()
