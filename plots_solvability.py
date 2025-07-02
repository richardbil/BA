import pandas as pd
import matplotlib.pyplot as plt


df = pd.read_csv('results_sumoforder.txt', sep=', ')


df['PsiValue'] = df['PsiValue'].apply(eval)

df['Group'] = df['GroupName'].str.split('_').str[0]

df = df.sort_values(by='Group')

for group in df['Group'].unique():
    sub = df[df['Group'] == group]
    plt.plot(sub['GroupOrder'], sub['PsiValue'], 'o', label=group)

plt.xlabel('Group Order')
plt.ylabel('Psi Value')
plt.title('Group Order vs Psi Value')
plt.legend()
plt.grid(True)
plt.show()