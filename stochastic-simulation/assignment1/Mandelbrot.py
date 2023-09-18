# -*- coding: utf-8 -*-
"""
Created on Sun Nov  8 14:15:02 2020

@author: Oscar
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from datetime import datetime

# Get time at start of simulation
start_time = datetime.now()
print(f'Simulation started at {start_time}.\n')

# Initialize simulation setttings
i = 100 # number of iterations
res = 5000 # resolution of axes
Rmin = -2
Rmax = 2
Imin = -2
Imax = 2

# Initialize all possible values of c
c = np.linspace(Rmin,Rmax,res)[:,np.newaxis] + 1j*np.linspace(Imin,Imax,res)[np.newaxis,:]
z = 0

# Initialize array for colors
ones = np.ones(np.shape(c), np.int)
color = ones * i

# Initialize plot
fs = 50    # figsize value also used for label font sizes
fig, ax1 = plt.subplots(figsize = (fs,fs))
ax1.set_xlabel('Re', fontsize=2*fs)
ax1.set_ylabel('Im (i)', fontsize=2*fs)
plt.tick_params(axis='both', which='major', labelsize=2*fs, pad=fs)
plt.tick_params(axis='both', which='minor', labelsize=2*fs, pad=fs)
ax1.set_xlim(-1,-0.5)
ax1.set_ylim(0,0.5)


# Calculate Mandelbrot set
for n in range(0,i):
      z = z**2 + c
      # Store iteration number for which series diverges and use for color
      i_div = np.abs(z)>2
      color[i_div] = np.minimum(color[i_div], ones[i_div]*n)
      
# Plot figure using contour plot
ax1.contourf(c.real, c.imag, color, cmap=cm.jet)
plt.savefig('MandelPlot.png')
plt.show()

# Calculate simulation time
print(f'\nThe simulation took {datetime.now()-start_time} (HH:mm:ss) to complete.\n')
