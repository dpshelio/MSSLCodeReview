#---------------------------Import-------------------------------------#

import numpy as np
from physics import *
from _random import *
import pylab

#---------------------------Initial Set Up-----------------------------#

N=10                                    #Fixed Number of cars

V_max=5                                 #Speed limit
V_trans=3                               #transition v for prob
P_fast=0.02                             #brake prob for fast car
P_slow=0.25                             #brake prob for slow car

L_max=20*N                              #Max no. of cells in road
L_start=1*N                             #Min no. of cells in road
L_int=1                                 #L interval

t_count=100                             #Time to start counting
t_max=1000                              #End time of simulation
N_exp=1                                 #Number of expiriments to average

#-------------------------Arrays For Plotting---------------------------#

L_array=[]               #just making the necessary arrays for plotting           
density_array=[]
all_counts=[]
counts_to_average=np.zeros(((L_max)-L_start)/L_int)
counts_averaged=[]
v_to_average=np.zeros(((L_max)-L_start)/L_int)
exp_avg_v=[]

for s in range(L_start,L_max,L_int): #array dimesnions
    L_array.append(s)                   
    density_array.append((float(N)/float(s))*(1000./6.))#km conversion
    counts_averaged.append(0)
    exp_avg_v.append(0)

#-------------------------Assigning------------------------------------#

for exp in range(1,N_exp+1):
    print "experiment number", exp, "of", N_exp
    avg_v=[]

    for L in range(L_start,L_max,L_int): #length of road
        
        t=0                                     #Start at time = zero
        count=0                                 #Traffic initial zero
        sum_of_v=0

        x=random.sample(range(L), N)                    #Position
        #assign car i out of N a slot on a road length L. One per slot

        v=[random.randint(1,V_max) for i in range(0,N)]     #velocity
        #assign car i out of N an initial v between 1 and V_max

#----------------------------code: tendency to accelerate-------------------#

        while t<t_max:

            for j in range(0,N):                #pick car j out of the N cars
                a=[]    #use this to check whether or not to accelerate
                D=[]    #to store the d's so we can later pick the right one
                for i in range(0,N):        #pick car i out of N to check
                    if i!=j:                #won't check a car against itself
                        d=x[i]-x[j]         #distance between cars
                        if d>0:             #don't look at cars behind us
                            if v[j]>=d:         #if car j would hit car i
                                a.append(-N)    #to give -ve sum, decelerate
                                D.append(d)     #store each d to later pick           
                                
                            elif v[j]==V_max and v[j]<d:   
                                a.append(0)     #0 means don't accelerate
                                
                            else:           #not at V_max and no car ahead
                                a.append(1)     #1 means can accelerate
                
                        else:       #ignore cars behind
                            i=i+1   #moves on to the next car
                    else:           #Don't check the car against itself
                        i=i+1       #moves on to the next car

                if sum(D)!=0:       #if D isn't empty...
                    d=min(D)        #pick min value to actually as d
                else:
                    d=0             #if D is empty, d=0
                
#---------------------------checks: how to change speed--------------------#
                
                if all(a)==1 and sum(a)>0: #if all elements have modulus > 0 
                    v[j]=v[j]+1 #accelerate the car

                elif sum(a)<0 and d<=v: #<0 means wants to decel
                    v[j]=d-1 #decel to speed d-1

                elif sum(a)==0: #no cars ahead of it
                    v[j]=v[j]+1 #accelerate the car
                    

            for k in range(0,N):        #final checks
                if v[k]!=0:             #for cars that will move
                    if x[k]+v[k] in x:  #check if it would crash
                        v[k]=v[k]-1     #lower speed so won't crash

                    if v[k]>V_max:      #if above speed limit
                        v[k]=V_max      #enforce speed limit

            for n in range(0,N):            #circular check
                if v[n]!=0:                 #if car is moving at all
                    for m in range (0,N):   #check against other cars
                        if n!=m:            #but not against itself
                            if x[m]<=((x[n]-L)+v[n]): #crash w/ circle:
                                v[n]=(((L-x[n])+x[m])-1) #decel                            

            for o in range(0,N):
                if v[o]>0:              #for moving cars
                    p=uniform(1)        #probability

                    if v[o]>=V_trans and p<P_fast:
                        v[o]=v[o]-1     
                    if v[o]<V_trans and p<P_slow:
                        v[o]=v[o]-1
                        
                        
            for l in range(0,N):
                x[l]=x[l]+v[l]          #move the cars
                
                if x[l]>L-1:            #if moves to position >L
                    x[l]=x[l]-L         #subtract L

                    if t_count<=t<=t_max: #wait for setady state
                        count=count+1     #count cars pass the 'end'

            if t_count<=t<=t_max:
                sum_of_v=sum_of_v+sum(v) #add velocities from all times
            
            t=t+1                       #move on to next time step
            
        all_counts.append(count) #store number of counts at each L
        
        avg_v.append((float(sum_of_v)/float((N*((t_max-t_count)+1)))))
        
    for z in range(((L_max)-L_start)/L_int): #add counts from each exp
        counts_to_average[z]=counts_to_average[z]+all_counts[z]
        v_to_average[z]=v_to_average[z]+avg_v[z]

for y in range(((L_max)-L_start)/L_int): #average counts over exp
    counts_averaged[y]=int(counts_to_average[y]/N_exp) 
    exp_avg_v[y]=(v_to_average[y]/N_exp)*13.421618 #mph

#--------------------Results------------------------------------------#
max_elem=counts_averaged.index(max(counts_averaged))
#which element of counts corresponds to the max no. of counts

print "element", max_elem, "of counts gives maximum"
print "which is for road length:", L_array[max_elem], "cells"
print "ie at density of", density_array[max_elem], "cars per km"
print "an optimum average velocity of", exp_avg_v[max_elem], "mph" 

pylab.plot(density_array, exp_avg_v) #mph
pylab.xlabel("Density of Cars on Road / No. of Cars per km")
pylab.ylabel("Averaged Velocity / mph")
#pylab.title("Average Velocity vs Density of Cars")
pylab.show()

pylab.plot(exp_avg_v, counts_averaged)#mph
pylab.xlabel("Average Velocity / mph")
pylab.ylabel("Averaged Total Counts")
#pylab.title("Traffic Flow vs Average Velocity")
pylab.show()

pylab.plot(density_array, counts_averaged)
pylab.xlabel("Density of Cars on Road / No. of Cars per km")
pylab.ylabel("Averaged Total counts")
#pylab.title("Traffic Flow vs Density of Cars")
pylab.show()

#---------------------------------------------------------------------#
