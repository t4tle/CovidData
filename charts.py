import matplotlib.pyplot as plt
import csv
import pandas as pd
import numpy as np



dfd = pd.read_excel('covid-data deaths.xlsx')

dfv = pd.read_excel('covid-data vax.xlsx')


afgan = dfd.loc[dfd['location'] == 'Afghanistan']

#print(afgan['total_cases'])


xpoints = np.array(afgan['date'])
ypoints = np.array(afgan['total_cases'])

plt.title(' Afghanistan covid cases')
plt.xlabel('date')
plt.ylabel('cases')
plt.legend
plt.grid(axis = 'y')
plt.plot(xpoints, ypoints, label = 'covid count', marker = '*')
plt.show()