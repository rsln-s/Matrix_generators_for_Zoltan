from networkit import *
import sys

multiplier = 2

if len(sys.argv) != 2:
    print('You have to pass filename to this script')
    sys.exit(-1)

filename = sys.argv[1]

if len(filename.split('.')) != multiplier:
    print('TODO fix the script! Cant handle it now')
    sys.exit(-1)

G = readGraph(filename, Format.EdgeListSpaceOne)

gen = generators.LFRGenerator.fit(G, scale=2)

R = gen.generate()


plmPartition = community.PLM(R).run().getPartition()

filename_list = filename.split('.')
outname = filename_list[0] + '_x' + str(multiplier) + '_communities.txt'

with open(outname, 'w+') as outfile:
    for i in plmPartition.getSubsetIds():
        outfile.writelines([str(x+1)+' '+str(i+1)+'\n' for x in plmPartition.getMembers(i)])
