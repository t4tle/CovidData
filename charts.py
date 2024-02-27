import matplotlib.pyplot as plt
import csv
import pandas as pd
import numpy as np



dfd = pd.read_excel('covid-data deaths.xlsx')

dfv = pd.read_excel('covid-data vax.xlsx')


print(dfd.loc[dfd['location'] == 'Afghanistan'])




xpoints = np.array([0, 6])
ypoints = np.array([0, 250])

#plt.title('covid data')
#plt.xlabel('date')
#plt.ylabel('count')
#plt.legend
#plt.plot(xpoints, ypoints, label = 'covid count')
# plt.show()