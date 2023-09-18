#!/usr/bin/env python
# coding: utf-8

# In[2]:


from numba import jit
import numpy as np
import matplotlib.pyplot as plt
import random
import math
import scipy.stats as st
from smt.sampling_methods import LHS
from datetime import datetime


# In[4]:


@jit
def mandelbrot(a,b,max_iter):
    c = complex(a,b)
    z = 0.0j
    
    for i in range(max_iter):
        z = z*z + c
        if(abs(z) >= 2):
            return i
        
    return max_iter

start_time = datetime.now() # Get time at start of simulation
print(f'Computation of Mandelbrot set started at {datetime.now().strftime("%H:%M:%S")} local time.\n')

columns = 2000 #Resolution of image
rows = 2000

mand = np.zeros([rows, columns]) #variable that stores the critical iterations
mand_zoom = np.zeros([rows, columns]) #for the zoomed plot

for row_index, Re in enumerate(np.linspace(-2, 1, num=rows)):  #Real axis points
    for column_index, Im in enumerate(np.linspace(-1.5, 1.5, num=columns)):  #Imaginary axis points
        mand[row_index, column_index] = mandelbrot(Re, Im, 100)   # maxiteration of 100
        
for row_index, Re in enumerate(np.linspace(-1, -0.5, num=rows)):  #zoom on the sea horse valley
    for column_index, Im in enumerate(np.linspace(0, 0.5, num=columns)):  
        mand_zoom[row_index, column_index] = mandelbrot(Re, Im, 100)   
        
print(f'The computation took {datetime.now()-start_time} (HH:mm:ss) to complete.\n') # Calculate Mandelbrot area computation time  

print('Plotting results...\n')
fig = plt.figure(figsize=(10,6), dpi =300)
plt.subplot(121)
plt.imshow(mand.T, cmap='Spectral', extent=[-2, 1, -1.5, 1.5])
plt.xlabel('Re')
plt.ylabel('Im ($\it{i}$)')
plt.title('Mandelbrot Set')

plt.subplot(122)      
plt.imshow(np.flipud(mand_zoom.T), cmap='Spectral', extent=[-1, -0.5, 0, 0.5])
plt.xlabel('Re')
plt.ylabel('Im (i)')
plt.title('Mandelbrot Set Zoomed in at -0.75+0.25i')
plt.show()


# In[4]:


#function that checks if our sample point is in mandelbrot set or not

def mandel_val(a,b,max_iter):   
    
    c = complex(a,b)
    z = 0.0j
    i = 0
    for i in range(max_iter):
        z = z*z + c
        if(abs(z) >= 2):
            return 0
    
    return c   


# In[6]:


# MC Random Sampling
'''
Computationally Expensive to implement on a Intel Core i7-9750H CPU , 16 GB RAM system.
'''      

start_time = datetime.now() # Get time at start of simulation
print(f'Computation of Mandelbrot set area started at {datetime.now().strftime("%H:%M:%S")} local time.\n')

a = -2.0                         #upper limit of x & y coordinates
b = 2.0                          #lower limit of x & y coordinates
smax = 500                      # max samples drawn
imax = 5000                     # max no. of iterations
iterlist = np.arange(10,imax+10,10)
samplist = np.arange(10,smax+5,5)

def draw_randsamp(s):           #Random sampling function
    samp = []
    for i in range(s):                 
        X = a + (b-a)*random.uniform(0,1)
        Y = a + (b-a)*random.uniform(0,1)
        samp.append((X,Y)) 
    return samp


limit_areas = []           #areas when iterations -> imax & sample sizes -> smax

for j in range(imax):       #max iterations    
    k = 0
    sample = draw_randsamp(smax)    #max sample size 

    for i in (sample):
        if(mandel_val(i[0], i[1], 100)!= 0):
            k = k + 1

    limit_areas.append((k/smax)*16)

Am = np.mean(limit_areas)         #limiting area Am
Varm = np.var(limit_areas)        #limiting Variance
intv = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas), scale=st.sem(limit_areas)) #95% confidence interval

print(f'The computation took {datetime.now()-start_time} (HH:mm:ss) to complete.\n') # Calculate Mandelbrot area computation time
print('Limiting Area: ',Am,'\nLimiting Variance: ',Varm,'\n95% confidence interval: ',intv,'\n')

start_time = datetime.now() # Get new start time
print(f'Computation of |Aj,s - Ai,s| and |Ai,r - Ai,s| started at {datetime.now().strftime("%H:%M:%S")} local time.\n')

Aj = []                         # areas for constant sample size
var_j = []                      # variances for constant sample size

for iter in iterlist:
    areas = []
    
    for j in range(iter):       #variable iterations
        k = 0
        sample = draw_randsamp(50)    #constant sample size of 50 

        for i in (sample):
            if(mandel_val(i[0], i[1], 100)!= 0):
                k = k + 1

        areas.append((k/50)*16)       #Monte carlo approximation. Total area enclosed by x=-2 , x=2 , y=2, y =-2 of 16 sq. units 
    Aj.append(np.mean(areas))
    var_j.append(np.var(areas))
    
As = []                           # areas for constant iterations
var_s = []                        # variances for constant iterations

for s in samplist:                #variable sample sizes
    areas = []
    
    for j in range(100):         #constant iterations of 100
        k = 0
        sample = draw_randsamp(s) 
        
        for i in (sample):
            if(mandel_val(i[0], i[1], 100)!= 0):
                k = k + 1

        areas.append((k/s)*16)
    As.append(np.mean(areas))
    var_s.append(np.var(areas))


diff_j = abs(Aj - Am)  
diff_s = abs(As - Am)

print(f'Computation of |Aj,s - Ai,s| and |Ai,r - Ai,s| took {datetime.now()-start_time} (HH:mm:ss) to complete.\n') # Calculate convergence computation time

print('Plotting results...\n')
plt.figure(figsize=(10,5),dpi =300)
plt.subplot(121)
plt.title('Constant Sample Size (s=50) \n With Varying Number of Iterations')
plt.plot(iterlist, diff_j, label = r'$|A_{j,s}-A_{i,s}|$')
plt.plot(iterlist, var_j, label = r'$Variance_j$')
plt.axhline(y=0, c= 'k',ls = '--',alpha=0.6)
plt.axhline(y=Varm, c='r',ls = '--',alpha=0.6,label = 'Limiting Variance')
plt.ylabel('Magnitude of Differences and Variances')
plt.xlabel('j')
plt.legend(shadow=True)

plt.subplot(122)
plt.title('Constant Iterations (i=100) \n With Varying Sample Size')
plt.plot(samplist, diff_s, label = r'$|A_{i,r}-A_{i,s}|$')
plt.plot(samplist, var_s, label = r'$Variance_s$')
plt.axhline(y=0, c ='k',ls = '--',alpha=0.6)
plt.axhline(y=Varm, c='r',ls = '--',alpha=0.6,label = 'Limiting Variance')
plt.ylabel('Magnitude of Differences and Variances')
plt.xlabel('r')
plt.legend(shadow=True)

plt.show()


# In[7]:


# MC LHS Sampling
'''
We lower the maximum samples and iterations and get lower variances and faster convergences which shows
LHS sampling is better.
'''

start_time = datetime.now() # Get time at start of simulation
print(f'Computation of Mandelbrot set area started at {datetime.now().strftime("%H:%M:%S")} local time.\n')

smax = 500                      # max samples 
imax = 5000                     # max no. of iterations
iterlist = np.arange(10,imax+10,10)
samplist = np.arange(10,smax+5,5)

def draw_lhsamp(s):             #LHS sampling function
    arr = np.array([[a, b], [a, b]])
    sampling = LHS(xlimits = arr)
    samp = sampling(s)
    return np.ndarray.tolist(samp)

limit_areas = []           #areas when iterations -> imax & sample sizes -> smax

for j in range(imax):       #max iterations  
    k = 0
    sample = draw_lhsamp(smax)    #max sample size 

    for i in (sample):
        if(mandel_val(i[0], i[1], 100)!= 0):
            k = k + 1

    limit_areas.append((k/smax)*16)

Am = np.mean(limit_areas)            #limiting area Am
Varm = np.var(limit_areas)           #limiting Variance
intv = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas), scale=st.sem(limit_areas)) #95% confidence interval

print(f'The computation took {datetime.now()-start_time} (HH:mm:ss) to complete.\n') # Calculate Mandelbrot area computation time
print('Limiting Area: ',Am,'\nLimiting Variance: ',Varm,'\n95% confidence interval: ',intv,'\n')

start_time = datetime.now() # Get new start time
print(f'Computation of |Aj,s - Ai,s| and |Ai,r - Ai,s| started at {datetime.now().strftime("%H:%M:%S")} local time.\n')

Aj_lh = []                         # areas for constant sample size
var_j_lh = []                      # variances for constant sample size


for iter in iterlist:  
    areas = []
    
    for j in range(iter):       #variable iterations
        k = 0
        sample = draw_lhsamp(50)    #constant sample size of 50   
        
        for i in (sample):
            if(mandel_val(i[0], i[1], 100)!= 0):
                k = k + 1

        areas.append((k/50)*16)
        
    Aj_lh.append(np.mean(areas))
    var_j_lh.append(np.var(areas))
    
As_lh = []                           # areas for constant iterations
var_s_lh = []                        # variances for constant iterations


for s in samplist:                #variable sample sizes  
    areas = []
    
    for j in range(100):         #constant iterations of 100
        k = 0
        sample = draw_lhsamp(s)
   
        for i in (sample):
            if(mandel_val(i[0], i[1], 100)!= 0):
                k = k + 1

        areas.append((k/s)*16)
        
    As_lh.append(np.mean(areas))
    var_s_lh.append(np.var(areas))


diff_j_lh = abs(Aj_lh - Am)  
diff_s_lh = abs(As_lh - Am)  

print(f'Computation of |Aj,s - Ai,s| and |Ai,r - Ai,s| took {datetime.now()-start_time} (HH:mm:ss) to complete.\n') # Calculate convergence computation time

print('Plotting results...\n')
plt.figure(figsize=(10,5),dpi =300)
plt.subplot(121)
plt.title('Constant Sample Size (s=50) \n With Varying Number of Iterations')
plt.plot(iterlist, diff_j_lh, label = r'$|A_{j,s}-A_{i,s}|$')
plt.plot(iterlist, var_j_lh, label = r'$Variance_j$')
plt.axhline(y=0, c= 'k',ls = '--',alpha=0.6)
plt.axhline(y=Varm, c='r',ls = '--',alpha=0.6,label = 'Limiting Variance')
plt.ylabel('Magnitude of Differences and Variances')
plt.xlabel('j')
plt.legend(shadow=True)

plt.subplot(122)
plt.title('Constant Iterations (i=100) \n With Varying Sample Size')
plt.plot(samplist, diff_s_lh, label = r'$|A_{i,r}-A_{i,s}|$')
plt.plot(samplist, var_s_lh, label = r'$Variance_s$')
plt.axhline(y=0, c ='k',ls = '--',alpha=0.6)
plt.axhline(y=Varm, c='r',ls = '--',alpha=0.6,label = 'Limiting Variance')
plt.ylabel('Magnitude of Differences and Variances')
plt.xlabel('r')
plt.legend(shadow=True)

plt.show()


# In[8]:


# MC Orthogonal Sampling
'''
We further lower the iterations and still get improved results which shows Orthogonal sampling is an improvement on LHS.

'''

start_time = datetime.now() # Get time at start of simulation
print(f'Computation of Mandelbrot set area started at {datetime.now().strftime("%H:%M:%S")} local time.\n')

smax = 23**2                      # max samples drawn is a perfect square to ensure we get a square matrix
imax = 5000                     # max no. of iterations
iterlist = np.arange(10,imax+10,10) 
samplist = np.array([n**2 for n in range(3,24)])   

def draw_orthosamp(samples):   #Orthogonal Sampling function 
    
    major = int(math.sqrt(samples))
    xlist = np.zeros((major,major))
    ylist = np.zeros((major,major))
    scale = 4/samples           # from -2 to 2 . 
    m = 0
    samp = []
    
    for i in range(major):
        
        for j in range (major):
            xlist[i][j] = ylist[i][j] = m
            m+=1
            
    for i in range(major):
        xlist[i] = np.random.permutation(xlist[i])
        ylist[i] = np.random.permutation(ylist[i])

    for i in range(major):

        for j in range(major):
            x = -2.0 + scale * (xlist[i][j] + np.random.random()) 
            y = -2.0 + scale * (ylist[j][i] + np.random.random())
            samp.append((x,y)) 
                
    return samp 


limit_areas = []

for j in range(imax):       #max iterations
    k = 0
    sample = draw_orthosamp(smax)  #max samples
    
    for i in (sample):
        if(mandel_val(i[0], i[1], 100)!= 0):
            k = k + 1

    limit_areas.append((k/smax)*16)

Am = np.mean(limit_areas)          #limiting area Am
Varm = np.var(limit_areas)          #limiting Variance
intv = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas), scale=st.sem(limit_areas)) #95% confidence interval

print(f'The computation took {datetime.now()-start_time} (HH:mm:ss) to complete.\n') # Calculate Mandelbrot area computation time
print('Limiting Area: ',Am,'\nLimiting Variance: ',Varm,'\n95% confidence interval: ',intv,'\n')

Aj_lh = []                         # areas for constant sample size
var_j_lh = []                      # variances for constant sample size


for iter in iterlist:
    areas = []
    
    for j in range(iter):       #variable iterations
        k = 0
        sample = draw_orthosamp(7**2)    #constant sample size of 49
   
        for i in (sample):
            if(mandel_val(i[0], i[1], 100)!= 0):
                k = k + 1

        areas.append((k/49)*16)
    Aj_lh.append(np.mean(areas))
    var_j_lh.append(np.var(areas))
    
As_lh = []                           # areas for constant iterations
var_s_lh = []                        # variances for constant iterations


for s in samplist:                #variable sample sizes
    areas = []
    
    for j in range(100):         #constant iterations of 100
        k = 0
        sample = draw_orthosamp(s)
   
        for i in (sample):
            if(mandel_val(i[0], i[1], 100)!= 0):
                k = k + 1

        areas.append((k/s)*16)
    As_lh.append(np.mean(areas))
    var_s_lh.append(np.var(areas))


diff_j_lh = abs(Aj_lh - Am)  
diff_s_lh = abs(As_lh - Am)  


print(f'Computation of |Aj,s - Ai,s| and |Ai,r - Ai,s| took {datetime.now()-start_time} (HH:mm:ss) to complete.\n') # Calculate convergence computation time

print('Plotting results...\n')
plt.figure(figsize=(10,5),dpi =300)
plt.subplot(121)
plt.title('Constant Sample Size (s=49) \n With Varying Number of Iterations')
plt.plot(iterlist, diff_j_lh, label = r'$|A_{j,s}-A_{i,s}|$')
plt.plot(iterlist, var_j_lh, label = r'$Variance_j$')
plt.axhline(y=0, c= 'k',ls = '--',alpha=0.6)
plt.axhline(y=Varm, c='r',ls = '--',alpha=0.6,label = 'Limiting Variance')
plt.ylabel('Magnitude of Differences and Variances')
plt.xlabel('j')
plt.legend(shadow=True)

plt.subplot(122)
plt.title('Constant Iterations (i=100) \n With Varying Sample Size')
plt.plot(samplist, diff_s_lh, label = r'$|A_{i,r}-A_{i,s}|$')
plt.plot(samplist, var_s_lh, label = r'$Variance_s$')
plt.axhline(y=0, c ='k',ls = '--',alpha=0.6)
plt.axhline(y=Varm, c='r',ls = '--',alpha=0.6,label = 'Limiting Variance')
plt.ylabel('Magnitude of Differences and Variances')
plt.xlabel('r')
plt.legend(shadow=True)

plt.show()


# In[5]:


# MC Random Sampling with Control Variate
'''
Computationally Expensive to implement on a Intel Core i7-9750H CPU , 16 GB RAM system.
'''      

start_time = datetime.now() # Get time at start of simulation
print(f'Computation of Mandelbrot set area started at {datetime.now().strftime("%H:%M:%S")} local time.\n')

a = -2.0                         #upper limit of x & y coordinates
b = 2.0                          #lower limit of x & y coordinates
smax = 500                      # max samples drawn
imax = 5000                     # max no. of iterations
iterlist = np.arange(10,imax+10,10)
samplist = np.arange(10,smax+5,5)

def draw_randsamp(s):           #Random sampling function
    samp = []
    for i in range(s):                 
        X = a + (b-a)*random.uniform(0,1)
        Y = a + (b-a)*random.uniform(0,1)
        samp.append((X,Y))
    return samp


limit_areas = []           #areas when iterations -> imax & sample sizes -> smax
limit_areas_CV = []        # Control variate area list
limit_areas_Z = []        # New random value Z area list

for j in range(imax):       #max iterations    
    k = 0
    l = 0
    sample = draw_randsamp(smax)    #max sample size 

    for i in (sample):
        if(mandel_val(i[0], i[1], 100)!= 0):
            k = k + 1
            l = np.sqrt(k)

    limit_areas.append((k/smax)*16)
    limit_areas_CV.append((l/smax)*16)

Am = np.mean(limit_areas)         #limiting area Am
Varm = np.var(limit_areas)        #limiting Variance
intv = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas), scale=st.sem(limit_areas)) #95% confidence interval

Am_CV = np.mean(limit_areas_CV)         #limiting area Am control variate
Varm_CV = np.var(limit_areas_CV)        #limiting Variance control variate
intv_CV = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas_CV), scale=st.sem(limit_areas_CV)) #95% confidence interval control variate

mu_CV = Am_CV # = np.mean(limit_areas_CV)
cs = -np.sum((limit_areas - Am)*(limit_areas_CV - Am_CV))/np.sum((limit_areas_CV - Am_CV)**2)
limit_areas_Z = limit_areas + cs*(limit_areas_CV - mu_CV)

Am_Z = np.mean(limit_areas_Z)         #limiting area Am new random variable Z
Varm_Z = np.var(limit_areas_Z)        #limiting Variance new random variable Z
intv_Z = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas_Z), scale=st.sem(limit_areas_Z)) #95% confidence interval control variate


print(f'The computation took {datetime.now()-start_time} (HH:mm:ss) to complete.\n') # Calculate Mandelbrot area computation time
print('Limiting Area: ',Am,'\nLimiting Variance: ',Varm,'\n95% confidence interval: ',intv,'\n')
print('Limiting Area control variate: ',Am_CV,'\nLimiting Variance control variate: ',Varm_CV,'\n95% confidence interval control variate: ',intv_CV,'\n')
print('Limiting Area Z: ',Am_Z,'\nLimiting Variance Z: ',Varm_Z,'\n95% confidence interval Z: ',intv_Z,'\n')
print('Variance reduction: ',Varm/Varm_Z)


# In[6]:


# MC LHS Sampling with control variate
'''
We lower the maximum samples and iterations and get lower variances and faster convergences which shows
LHS sampling is better.
'''

start_time = datetime.now() # Get time at start of simulation
print(f'Computation of Mandelbrot set area started at {datetime.now().strftime("%H:%M:%S")} local time.\n')

smax = 500                      # max samples 
imax = 5000                     # max no. of iterations
iterlist = np.arange(10,imax+10,10)
samplist = np.arange(10,smax+5,5)

def draw_lhsamp(s):             #LHS sampling function
    arr = np.array([[a, b], [a, b]])
    sampling = LHS(xlimits = arr)
    samp = sampling(s)
    return np.ndarray.tolist(samp)

limit_areas = []           #areas when iterations -> imax & sample sizes -> smax
limit_areas_CV = []        # Control variate area list
limit_areas_Z = []        # New random value Z area list

for j in range(imax):       #max iterations  
    k = 0
    l = 0
    sample = draw_lhsamp(smax)    #max sample size 

    for i in (sample):
        if(mandel_val(i[0], i[1], 100)!= 0):
            k = k + 1
            l = np.sqrt(k)

    limit_areas.append((k/smax)*16)
    limit_areas_CV.append((l/smax)*16)

Am = np.mean(limit_areas)         #limiting area Am
Varm = np.var(limit_areas)        #limiting Variance
intv = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas), scale=st.sem(limit_areas)) #95% confidence interval

Am_CV = np.mean(limit_areas_CV)         #limiting area Am control variate
Varm_CV = np.var(limit_areas_CV)        #limiting Variance control variate
intv_CV = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas_CV), scale=st.sem(limit_areas_CV)) #95% confidence interval control variate

mu_CV = Am_CV # = np.mean(limit_areas_CV)
cs = -np.sum((limit_areas - Am)*(limit_areas_CV - Am_CV))/np.sum((limit_areas_CV - Am_CV)**2)
limit_areas_Z = limit_areas + cs*(limit_areas_CV - mu_CV)

Am_Z = np.mean(limit_areas_Z)         #limiting area Am new random variable Z
Varm_Z = np.var(limit_areas_Z)        #limiting Variance new random variable Z
intv_Z = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas_Z), scale=st.sem(limit_areas_Z)) #95% confidence interval control variate

print(f'The computation took {datetime.now()-start_time} (HH:mm:ss) to complete.\n') # Calculate Mandelbrot area computation time
print('Limiting Area: ',Am,'\nLimiting Variance: ',Varm,'\n95% confidence interval: ',intv,'\n')
print('Limiting Area control variate: ',Am_CV,'\nLimiting Variance control variate: ',Varm_CV,'\n95% confidence interval control variate: ',intv_CV,'\n')
print('Limiting Area Z: ',Am_Z,'\nLimiting Variance Z: ',Varm_Z,'\n95% confidence interval Z: ',intv_Z,'\n')
print('Variance reduction: ',Varm/Varm_Z)


# In[7]:


# MC Orthogonal Sampling with control variate
'''
We further lower the iterations and still get improved results which shows Orthogonal sampling is an improvement on LHS.

'''

start_time = datetime.now() # Get time at start of simulation
print(f'Computation of Mandelbrot set area started at {datetime.now().strftime("%H:%M:%S")} local time.\n')

smax = 23**2                      # max samples drawn is a perfect square to ensure we get a square matrix
imax = 5000                     # max no. of iterations
iterlist = np.arange(10,imax+10,10) 
samplist = np.array([n**2 for n in range(3,24)])   

def draw_orthosamp(samples):   #Orthogonal Sampling function 
    
    major = int(math.sqrt(samples))
    xlist = np.zeros((major,major))
    ylist = np.zeros((major,major))
    scale = 4/samples           # from -2 to 2 . 
    m = 0
    samp = []
    
    for i in range(major):
        
        for j in range (major):
            xlist[i][j] = ylist[i][j] = m
            m+=1
            
    for i in range(major):
        xlist[i] = np.random.permutation(xlist[i])
        ylist[i] = np.random.permutation(ylist[i])

    for i in range(major):

        for j in range(major):
            x = -2.0 + scale * (xlist[i][j] + np.random.random()) 
            y = -2.0 + scale * (ylist[j][i] + np.random.random())
            samp.append((x,y)) 
                
    return samp 


limit_areas = []           #areas when iterations -> imax & sample sizes -> smax
limit_areas_CV = []        # Control variate area list
limit_areas_Z = []        # New random value Z area list

for j in range(imax):       #max iterations
    k = 0
    l = 0
    sample = draw_orthosamp(smax)  #max samples
    
    for i in (sample):
        if(mandel_val(i[0], i[1], 100)!= 0):
            k = k + 1
            l = np.sqrt(k)

    limit_areas.append((k/smax)*16)
    limit_areas_CV.append((l/smax)*16)

Am = np.mean(limit_areas)         #limiting area Am
Varm = np.var(limit_areas)        #limiting Variance
intv = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas), scale=st.sem(limit_areas)) #95% confidence interval

Am_CV = np.mean(limit_areas_CV)         #limiting area Am control variate
Varm_CV = np.var(limit_areas_CV)        #limiting Variance control variate
intv_CV = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas_CV), scale=st.sem(limit_areas_CV)) #95% confidence interval control variate

mu_CV = Am_CV # = np.mean(limit_areas_CV)
cs = -np.sum((limit_areas - Am)*(limit_areas_CV - Am_CV))/np.sum((limit_areas_CV - Am_CV)**2)
limit_areas_Z = limit_areas + cs*(limit_areas_CV - mu_CV)

Am_Z = np.mean(limit_areas_Z)         #limiting area Am new random variable Z
Varm_Z = np.var(limit_areas_Z)        #limiting Variance new random variable Z
intv_Z = st.norm.interval(alpha=0.95, loc=np.mean(limit_areas_Z), scale=st.sem(limit_areas_Z)) #95% confidence interval control variate

print(f'The computation took {datetime.now()-start_time} (HH:mm:ss) to complete.\n') # Calculate Mandelbrot area computation time
print('Limiting Area: ',Am,'\nLimiting Variance: ',Varm,'\n95% confidence interval: ',intv,'\n')
print('Limiting Area control variate: ',Am_CV,'\nLimiting Variance control variate: ',Varm_CV,'\n95% confidence interval control variate: ',intv_CV,'\n')
print('Limiting Area Z: ',Am_Z,'\nLimiting Variance Z: ',Varm_Z,'\n95% confidence interval Z: ',intv_Z,'\n')
print('Variance reduction: ',Varm/Varm_Z)