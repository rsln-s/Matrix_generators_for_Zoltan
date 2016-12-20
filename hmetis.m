% struct = UFget('HB/bcspwr10');
% mat = struct.A;
% mat = eye(5);
% mat(:,1) = 1;
vnum = 200;
enum = 201;

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
[rows, columns] = size(mat)

%number of hyperedges, vertices 
fprintf(output, '%d %d\n', rows, columns);
for row = 1:rows
       fprintf(output, '%d ', find(mat(row, :)));
       fprintf(output, '\n');
end