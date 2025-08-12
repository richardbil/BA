import pandas as pd, matplotlib.pyplot as plt
from fractions import Fraction

df = pd.read_csv("results_averageorder_near_67_24.txt", sep=",\s*", engine="python")
df["Diff"] = (df["AvgElementOrder"].apply(lambda x: float(Fraction(str(x)))) - float(Fraction("67/24"))).abs()
df = df.sort_values("Diff")

plt.bar(df["GroupName"], df["Diff"], color=plt.cm.viridis(df["Diff"]/df["Diff"].max()))
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.show()
