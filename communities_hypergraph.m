% Takes a network with communities and builds a hypergraph where a
% community is respesented as a hyperedge and members of community -- as
% vertices in it
% http://socialnetworks.mpi-sws.org/data-imc2007.html

membershipsfile = fopen('communities/release-flickr-groupmemberships.txt', 'r');
memberships = (fscanf(membershipsfile, '%d %d', [2 Inf]))';
fclose(membershipsfile);

memberships(:,3) = 1;

mat = sparse(memberships(:, 2), memberships(:, 1), memberships(:, 3));

output = fopen('flickr.mtx','w+');

[rows, columns] = size(mat);
fprintf(output, '%c%c', char(37), char(37));
fprintf(output, 'MatrixMarket matrix coordinate real general\n');
fprintf(output, '%d %d %d\n', rows, columns, nnz(mat));
[row,col,val] = find(mat);
for i=1:numel(val)
   fprintf(output, '%d %d %f', row(i), col(i), val(i));
   fprintf(output, '\n');
end
fclose(output);