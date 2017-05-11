# Generates similar network using a generator. This is the version used for obtaining results from the paper. use edgelisttomtx_naive.m to create a .mtx file after this

from networkit import *
import sys
from subprocess import Popen, PIPE
from joblib import Parallel, delayed
import multiprocessing

def generate_similar(filename, multiplier):

    G = readGraph(filename, Format.EdgeListSpaceOne)
    
    filename_list = filename.split('.')
    name = filename_list[0]

    print("Started generating for graph ", name, " with multiplier ", multiplier)

    gen = generators.BarabasiAlbertGenerator.fit(G, scale=multiplier)

    R = gen.generate()

    print("Finished generating and started writing to disk for graph ", name, " with multiplier ", multiplier)

    outname = 'communities/' + name + '_x' + str(int(multiplier)) + '_' + str(int((multiplier - int(multiplier))*10)) + '.edgelist'

    writeGraph(R, outname, Format.EdgeListSpaceOne)


multipliers = [0.1, 0.25, 0.5, 0.75, 1.5, 2.0]

if len(sys.argv) != 2:
    print('You have to pass filename to this script')
    sys.exit(-1)

filename = sys.argv[1]

if len(filename.split('.')) != 2: 
    print('TODO fix the script! Cant handle it now')
    sys.exit(-1)


num_cores = len(multipliers) 
Parallel(n_jobs=num_cores)(delayed(generate_similar)(filename, multiplier) for multiplier in multipliers)
