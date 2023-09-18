# -*- coding: utf-8 -*-
"""
Created on Thu Nov  5 22:12:49 2020

@author: Oscar
"""

import numpy as np
import matplotlib.pyplot as plt
from datetime import datetime
import time

# Runtime scales with square of number of samples and is independent of resolution
# Using Spyder on x64-Windows 10 with i7-7700K 4x4.20 GHz and 16 GB RAM:
#2,000 samples takes approx. 6 sec.
#10,000 samples takes approx. 2 min.
#50,000 samples takes approx. 50 min.

# Get time at start of simulation
start_time = datetime.now()
print(f'Simulation started at {start_time}.\n')

# Seed RNG
np.random.seed(int(time.time()))

# Initialize simulation parameters and x and y axes
runs = 2000    # Number of samples
resolution = 10000    # Steps from X0 to Xmax (and Y0 to Ymax)
r = 1    # Radius of circle
X = np.linspace(-r,r,resolution+1)
Y = X

# Initialize circle parameters
circleX = np.sqrt(r**2 - Y**2)
circleY = np.sqrt(r**2 - X**2)
circle = np.vstack((circleX,circleY)).T

# Initialize random point array
RAND_point = np.vstack((circleX,np.array((resolution+1)*[0]))).T

# Initialize hit and miss counters    
circleHit = 0
graphHit = 0

# Initialize plot
fig, ax1 = plt.subplots(figsize = (5,5))
plt.xlabel("X")
plt.ylabel("Y")

# Hit and miss algorithm
for i in range(runs):
    RAND_int = np.random.randint(0,resolution+1)
    RAND_point[RAND_int,1] = 2*np.random.uniform(0,r) - r    # U(-r,r)
    if abs(RAND_point[RAND_int,1]) <= abs(circle[RAND_int,1]):
        #print(f'Inside circle! Run #{i}')
        circleHit += 1
        ax1.scatter(X[RAND_int],RAND_point[RAND_int,1], c='red', s=(72./fig.dpi)**2)
    else:
        #print(f'Outside! Difference = {abs(RAND_point[RAND_int,1]) - abs(circle[RAND_int,1])}; RAND_int = {RAND_int}')
        graphHit += 1
        ax1.scatter(X[RAND_int],RAND_point[RAND_int,1], color='black', s=(72./fig.dpi)**2)
    if i > 0 and i % 500 == 0:
        print(f'{int(i/runs*100)} % of {runs} runs complete...\n')

# Calculate area of circle and estimation of pi
circleArea = circleHit / (circleHit+graphHit)         
piEstimate = 4*circleHit / (circleHit+graphHit)  

print(f'Area circle / Area square = {circleArea}\n')
print(f'pi = {piEstimate}\n')

# Add circle to plot
ax1.plot(X,circle[:,1],c='black')
ax1.plot(X,-circle[:,1],c='black')

# Calculate simulation time
print(f'The simulation took {datetime.now()-start_time} (HH:mm:ss) to complete.\n')
