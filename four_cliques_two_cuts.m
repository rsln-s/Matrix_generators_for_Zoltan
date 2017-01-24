% four cliques with different sizes of cuts horizontally and vertically
% 
%     3
% A1 --- A2
% |       |
% |       | 10
% |       |
% A4 --- A3

vnum = 200; % number of vertices in a clique
enum = 200; % number of hedges in a clique

A = randi([0 1], enum, vnum);
B = zeros(enum, vnum);
row1 = horzcat(A,B,B,B);
row2 = horzcat(B,A,B,B);
row3 = horzcat(B,B,A,B);
row4 = horzcat(B,B,B,A);

row5 = zeros(3, 4*vnum); % bridge between A1 and A2
row5(1, vnum/2) = 1;
row5(1, vnum*1.5) = 1;
row5(2, 1 + vnum/2) = 1;
row5(2, 1 + vnum*1.5) = 1;
row5(3, 2 + vnum/2) = 1;
row5(3, 2 + vnum*1.5) = 1;

row6 = zeros(3, 4*vnum); % bridge between A3 and A4
row6(1, vnum*2.5) = 1;
row6(1, vnum*3.5) = 1;
row6(2, 1 + vnum*2.5) = 1;
row6(2, 1 + vnum*3.5) = 1;
row6(3, 1 + vnum*2.5) = 1;
row6(3, 1 + vnum*3.5) = 1;

row7 = zeros(10, 4*vnum); % bridge between A1 and A4
row7(1, vnum/2) = 1;
row7(1, vnum*3.5) = 1;
row7(2, 1 + vnum/2) = 1;
row7(2, 1 + vnum*3.5) = 1;
row7(3, 2 + vnum/2) = 1;
row7(3, 2 + vnum*3.5) = 1;
row7(4, 3 + vnum/2) = 1;
row7(4, 3 + vnum*3.5) = 1;
row7(5, 4 + vnum/2) = 1;
row7(5, 4 + vnum*3.5) = 1;
row7(6, 5 + vnum/2) = 1;
row7(6, 5 + vnum*3.5) = 1;
row7(7, 6 + vnum/2) = 1;
row7(7, 6 + vnum*3.5) = 1;
row7(8, 7 + vnum/2) = 1;
row7(8, 7 + vnum*3.5) = 1;
row7(9, 8 + vnum/2) = 1;
row7(9, 8 + vnum*3.5) = 1;
row7(10, 9 + vnum/2) = 1;
row7(10, 9 + vnum*3.5) = 1;

row8 = zeros(10, 4*vnum); % bridge between A2 and A3
row8(1, vnum*1.5) = 1;
row8(1, vnum*2.5) = 1;
row8(2, 1 + vnum*1.5) = 1;
row8(2, 1 + vnum*2.5) = 1;
row8(3, 2 + vnum*1.5) = 1;
row8(3, 2 + vnum*2.5) = 1;
row8(4, 3 + vnum*1.5) = 1;
row8(4, 3 + vnum*2.5) = 1;
row8(5, 4 + vnum*1.5) = 1;
row8(5, 4 + vnum*2.5) = 1;
row8(6, 5 + vnum*1.5) = 1;
row8(6, 5 + vnum*2.5) = 1;
row8(7, 6 + vnum*1.5) = 1;
row8(7, 6 + vnum*2.5) = 1;
row8(8, 7 + vnum*1.5) = 1;
row8(8, 7 + vnum*2.5) = 1;
row8(9, 8 + vnum*1.5) = 1;
row8(9, 8 + vnum*2.5) = 1;
row8(10, 9 + vnum*1.5) = 1;
row8(10, 9 + vnum*2.5) = 1;

mat = vertcat(row1, row2, row3, row4, row5, row6, row7, row8);

outputname = 'four_cliques.mtx';
output = fopen(outputname,'w+');

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
