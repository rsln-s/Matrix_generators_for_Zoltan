# downloads matrices from UFL using the list of all matrices

while read p; do
		if [[ $p == SNAP* ]]
		then
				wget -qO- https://www.cise.ufl.edu/research/sparse/MM/$p | tar xvz -C /home/rshaydu/dev/matrices/SNAP	
		fi
done < UF_Listing.txt
