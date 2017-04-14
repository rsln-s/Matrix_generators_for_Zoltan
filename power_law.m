alp = 5;
coeff = 3;
% p(x)=(alpha-1)*x^(-alpha) 

N=20000;

pow_law = zeros(1, N);

for row=1:N
    k=rand ;
    pow_law(1, row) = round(coeff * (1-k)^(1/(-alp+1)));
end

mat_nnz = sum(pow_law);
i = zeros(1,mat_nnz);
j = zeros(1,mat_nnz);
v = zeros(1,mat_nnz);

curr = 1;
for row=1:N
    % put pow_law(row) nonzeros into rowth row
    out1 = randperm(N);
    indices = out1(1:pow_law(row));
    for ind=indices
        i(curr) = row;
        j(curr) = ind;
        v(curr) = 1;
        curr = curr+1;
    end
end


mat = sparse(j,i,v);

mat( ~any(mat,2), : ) = [];  %rows
mat( :, ~any(mat,1) ) = [];  %columns

output = fopen('power_law_20000.mtx','w+');

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
