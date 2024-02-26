import matplotlib.pyplot as plt
import csv
import pandas as pd
import numpy as np



df = pd.read_excel('covid-data deaths.xlsx')

df2 = pd.read_excel('covid-data vax.xlsx')


xpoints = np.array([0, 6])
ypoints = np.array([0, 250])

plt.plot(xpoints, ypoints)
plt.show()