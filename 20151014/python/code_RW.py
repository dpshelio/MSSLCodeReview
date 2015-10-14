#%pylab inline
import numpy as np
import os.path
import glob
import matplotlib.pyplot as plt


############################################################################################################################

# Function definitions

def read_files():
    
    """Function reads in all the .chn files from a pre-set location"""
    folder_name = ['2015-05-12']
    path = os.path.join(os.path.sep, 'C:/', 'Users', 'Uni & work', 'Dropbox', 'PhD', 'PMT', 'PMT_characterisation', '2015-05-12', 'dark', '*.chn')
    #path = os.path.join(os.path.sep, 'C:/', 'Users', 'Production05', 'Dropbox', 'PhD', 'PMT', 'PMT_characterisation', '2015-05-12', 'dark', '*.chn')
    files = sorted(glob.glob(path)) # list of files from the specified location (path), sorted by name
    HEADER = [] # create an empty list
    DATA = []
    for file in files:
        f=open(file,"rb") # 'b' means binary
        h = np.fromfile(f, dtype=("i2, u2, u2, S2, u4, u4, S7, S1, S4, u2, u2"), count=1)[0]
        HEADER.append(h)
        d_temp = np.fromfile(f, dtype=np.uint32, count=-1)
        d = d_temp[0:2048]
        DATA.append(d)
        f.close()
    DATA = np.asarray(DATA)
    HEADER = np.asarray(HEADER)
    return HEADER, DATA
	
############################################################################################################################

# Main
HEADER1, DATA1 = read_files()

x = np.arange(1, 2049, 1)
plt.plot(x, DATA1[0], label='1200V', linewidth=0.5)
plt.plot(x, DATA1[1], label='1250V', linewidth=0.5)
plt.plot(x, DATA1[2], label='1300V', linewidth=0.5)
plt.plot(x, DATA1[3], label='1350V', linewidth=0.5)
plt.plot(x, DATA1[4], label='1400V', linewidth=0.5)
plt.plot(x, DATA1[5], label='1450V', linewidth=0.5)
plt.plot(x, DATA1[6], label='1500V', linewidth=0.5)
plt.plot(x, DATA1[7], label='1550V', linewidth=0.5)
plt.plot(x, DATA1[8], label='1600V', linewidth=0.5)
plt.plot(x, DATA1[9], label='1650V', linewidth=0.5)
#plt.plot(data7, color='black', lw=1)
#plt.yscale('log')
plt.ylim([0,200])
plt.xlim([0,2048])
#axis([0, 2048, 0, 1e5])
plt.ylabel('Counts')
plt.xlabel('Channel')
plt.grid(True)
legend = plt.legend(loc='upper right', shadow=True, fontsize='medium')
plt.title('Pulse height distribution')
#plt.savefig('C:\PMTdata\PMTlight.png')
plt.show()

