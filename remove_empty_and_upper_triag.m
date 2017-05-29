struct = UFget('AG-Monien/3elt');
mat = triu(struct.A);

mat( :, ~any(mat,1) ) = [];  %columns
mat( all( ~any( mat), 2 ), : ) = []; 

outmat = mat;

find(mat(:,100))

output = fopen('3elt.mtx','w+');
    
[rows, columns] = size(outmat);
fprintf(output, '%c%c', char(37), char(37));
fprintf(output, 'MatrixMarket matrix coordinate real general\n');
fprintf(output, '%d %d %d\n', rows, columns, nnz(outmat));
[row,col,val] = find(outmat);
for i=1:numel(val)
    fprintf(output, '%d %d %f', row(i), col(i), val(i));
    fprintf(output, '\n');
end
fclose(output);