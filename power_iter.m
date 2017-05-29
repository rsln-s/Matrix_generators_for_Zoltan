% run power iteration on some graphs, see what happens

% first, generate a matrix ? a row-net representation of a hypergraph

vnum = 50; % number of vertices in a clique
enum = 50; % number of hedges in a clique

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

row7 = zeros(5, 4*vnum); % bridge between A1 and A4
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

row8 = zeros(5, 4*vnum); % bridge between A2 and A3
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

mat = vertcat(row1, row2, row3, row4, row5, row6, row7, row8);

% second, convert the matrix to bipartite representation
%     V    E
% ____________
% |      |   |
% |  A1  |   | V
% |______|___|
% |      | A2| E
% |______|___|


[rows, columns] = size(mat);
A1 = zeros(columns, columns);
A2 = zeros(rows,rows);
row1 = horzcat(A1, transpose(mat));
row2 = horzcat(mat, A2);
mat = vertcat(row1, row2);

% third, do N rounds of relaxation

N = 20;

b = randi([0,1], rows+columns, 1);

for i = 1:N
    Ab = mat*b;
    b = Ab/norm(Ab);
end

b

