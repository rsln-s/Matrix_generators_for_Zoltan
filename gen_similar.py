from networkit import *
import sys

multiplier = 0.1

if len(sys.argv) != 2:
    print('You have to pass filename to this script')
    sys.exit(-1)

filename = sys.argv[1]

if len(filename.split('.')) != 2: 
    print('TODO fix the script! Cant handle it now')
    sys.exit(-1)

G = readGraph(filename, Format.EdgeListSpaceOne)

gen = generators.BarabasiAlbertGenerator.fit(G, scale=multiplier)

R = gen.generate()

filename_list = filename.split('.')

outname = filename_list[0] + '_x' + str(int(multiplier)) + '_' + str(int(multiplier*10)) + '.edgelist'

writeGraph(R, outname, Format.EdgeListSpaceOne)
