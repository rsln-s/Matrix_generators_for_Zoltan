struct = UFget('LAW/amazon-2008');
mat = struct.A;

%mat = [0 1 0 0; 0 0 1 0; 0 0 0 0; 1 1 1 0];

mat = mat + mat'; % now symmetrical
mat = triu(mat); %left only upper triangle

% iterate over elements in matrix 
% for each el (row,col) create a row in output matrix with two non-zero
% elements in columns (row) and (col)

outmat = sparse(nnz(mat), size(mat,1));
curr_edge_num = 1;
for i=1:size(mat,1)
    for j=1:size(mat,2)
        if mat(i,j) > 0
            outmat(curr_edge_num,i) = 1;
            outmat(curr_edge_num,j) = 1;
            curr_edge_num = curr_edge_num + 1;
            if ~mod(curr_edge_num,100)
                curr_edge_num
            end
        end
    end
end

output = fopen('amazon-2008.mtx','w+');
    
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