file = fopen('twitter_combined.txt');

row = [];
col = [];
curr_edge_num = 1;
while ~feof(file)
    tl = fgetl(file);
    tlarr = str2num(tl);
    if numel(tlarr) ~= 2
        'ERROR'
        continue
    end
    row = [row, curr_edge_num, curr_edge_num];
    col = [col, tlarr(1), tlarr(2)];
    curr_edge_num = curr_edge_num + 1;
end
numel(col)
numel(row)
val = ones(1, numel(col));
numel(val)

mat = sparse(row, col, val);
output = fopen('twitter_combined.mtx','w+');
    
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