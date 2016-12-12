vnum = 4000;
enum = 4001;

A_left = randi([0 1], ((enum-1)/2), (vnum/2));
B_right = randi([0,1], ((enum-1)/2), (vnum/2));
row = zeros(1, vnum);
row(((vnum/2)-1):((vnum/2)+1)) = 1;
A_right = zeros(((enum-1)/2),(vnum/2));
B_left = zeros(((enum-1)/2),(vnum/2));
A = horzcat(A_left, A_right);
B = horzcat(B_left, B_right);
mat = vertcat(A, row, B);

output = fopen('trivial_two_parts.txt','w+');
[rows, columns] = size(mat);
%fprintf(output, '##Number of vertices\n');
fprintf(output, '%d\n\n', columns);
%fprintf(output, '##list vertices\n');
for i = 1:columns
    fprintf(output,'%d\n', i);
end
fprintf(output,'\n');
%fprintf(output, '##number of hyperedges\n%d');
fprintf(output, '%d\n\n', rows);
%fprintf(output, '##number of nonzero els\n\n');
fprintf(output, '%d\n\n', nnz(mat));
%fprintf(output, '##hyperedge adj\n\n');
for row = 1:rows
    fprintf(output, '%d ', row);
    fprintf(output, '%d ', nnz(mat(row,:)));
    fprintf(output, '%d ', find(mat(row, :)));
    fprintf(output, '\n');
end