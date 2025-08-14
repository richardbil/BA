import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("elem_abel_solv_res.txt", skipinitialspace=True)
df["isElemAbel2"] = df["isElemAbel2"].astype(str).str.strip().str.lower()
df["GroupOrder"] = df["GroupOrder"].astype(int)
df["AvgElementOrder"] = df["AvgElementOrder"].apply(lambda x: float(eval(x)))

plt.figure(figsize=(10,6))
plt.scatter(df[df["isElemAbel2"]=="true"]["GroupOrder"],
            df[df["isElemAbel2"]=="true"]["AvgElementOrder"],
            color="blue", label="Elementary Abelian 2-Group = True")
plt.scatter(df[df["isElemAbel2"]=="false"]["GroupOrder"],
            df[df["isElemAbel2"]=="false"]["AvgElementOrder"],
            color="red", label="Elementary Abelian 2-Group = False")

s4_avg_order = df[df["GroupName"]=="S3"]["AvgElementOrder"].values[0]  # Replace S3 with S4 if present
plt.axhline(y=s4_avg_order, color="black", linestyle="--", label="S₄ target line")

plt.xlabel("Group Order")
plt.ylabel("Average Element Order")
plt.title("Elementary Abelian 2-Groups with S₄ Target")
plt.legend()
plt.show()
