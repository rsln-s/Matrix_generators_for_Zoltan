vnum = 1000;
enum = 1001;

A_left = randi([0 1], ((enum-1)/2), (vnum/2));
B_right = randi([0,1], ((enum-1)/2), (vnum/2));
row = zeros(1, vnum);
row(((vnum/2)-1):((vnum/2)+1)) = 1;
A_right = zeros(((enum-1)/2),(vnum/2));
B_left = zeros(((enum-1)/2),(vnum/2));
A = horzcat(A_left, A_right);
B = horzcat(B_left, B_right);
mat1 = vertcat(A, row, B);
mat2 = zeros(size(mat1));
mat12 = horzcat(mat1, mat2);
[rows12, cols12] = size(mat12);
row23 = zeros(1, cols12);
row23(((cols12/2)-1):((cols12/2)+1)) = 1;
mat34 = horzcat(mat2, mat1);
row41 = zeros(1, cols12);
row41((vnum/2):((vnum/2)+1)) = 1;
row41((cols12-5):(cols12-4)) = 1;

mat = vertcat(mat12, row23, mat34, row41);

output = fopen('trivial_four_parts_small.txt','w+');
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