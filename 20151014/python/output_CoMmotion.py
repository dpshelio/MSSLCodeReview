# -*- coding: utf-8 -*-
"""
Created on Thu Sep 03 11:54:25 2015

@author: admin
"""
import os
os.chdir('C:/Users/admin/Documents/SAScode')
import SAScode.main as m
import numpy as np
import matplotlib.pyplot as plt


path_attempt2 = 'C:/Users/admin/Documents/firstfewARs/attempt3/'
NAR = 12119
with open(path_attempt2+'NAR{}/info.txt'.format(NAR)) as NARwitht:
    numline = 0
    pos_xy = list()
    neg_xy = list()
    for tstep in NARwitht:
        if numline >= 1:
            pos_x = float(tstep.split()[14])
            pos_y = float(tstep.split()[17])
            neg_x = float(tstep.split()[20])
            neg_y = float(tstep.split()[23])
            pos_xy.append((pos_x, pos_y))
            neg_xy.append((neg_x, neg_y))
        numline += 1
figcenmass = plt.figure()
axonly = figcenmass.add_subplot(1,1,1)
m.list_to_plot(pos_xy, ax=axonly, c='r', label='Positive')
m.list_to_plot(neg_xy, ax=axonly, c='b', label='Negative')
axonly.legend(loc=2)
for signc in ([pos_xy, 'r'], [neg_xy, 'b']):
    mydata = np.asarray(signc[0])
    pos_x = mydata[:, 0]
    pos_y = mydata[:, 1]
    axonly.scatter(pos_x, pos_y, c=signc[1], s=12, lw=0)
axonly.scatter(pos_xy[0][0], pos_xy[0][1], c='r', s=40, lw=0)
axonly.scatter(neg_xy[0][0], neg_xy[0][1], c='b', s=40, lw=0)
axonly.set_ylabel('Y-position [arcsec]')
axonly.set_xlabel('X-position [arcsec]')
plt.savefig(path_attempt2+'NAR{}/CoMmotion.png'.format(NAR))
