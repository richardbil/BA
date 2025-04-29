import pandas as pd
import matplotlib.pyplot as plt

# Read the results from the file
df = pd.read_csv("alt_Sym_conjugacy_results.txt")

# Split the GroupName and GroupOrder columns to separate the letter (S, A, D) and the number
df['GroupName'] = df['GroupName'].str.extract('([A-Za-z]+)')
df['GroupOrder'] = df['GroupOrder'].astype(int)

# Plot E(G) for each group type and its corresponding order
plt.figure(figsize=(10, 6))

# For each group (Symmetric, Alternating, Dihedral), plot the E(G) vs GroupOrder
for group in df['GroupName'].unique():
    subset = df[df['GroupName'] == group]
    plt.plot(subset['GroupOrder'], subset['E(G)value'], label=group, marker='o')

plt.xlabel('Group Order')
plt.ylabel('E(G) Value')
plt.title('Plot of E(G) vs Group Order for Symmetric, Alternating')
plt.legend()

# Show the plot
plt.grid(True)
plt.show()
