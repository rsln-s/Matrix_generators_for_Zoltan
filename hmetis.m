files = {'LPnetlib/lp_ken_07','HB/sherman3'};

for f = files
    struct = UFget(f{1});
    mat = struct.A;
    % mat = eye(5);
    % mat(:,1) = 1;

    fname = strsplit(f{1}, '/');
    fname = fname{2};
    
    outname = strcat('hmetis_converted/', fname);
    output = fopen(outname,'w+');
    [rows, columns] = size(mat);

    %number of hyperedges, vertices 
    fprintf(output, '%d %d\n', rows, columns);
    for row = 1:rows
           fprintf(output, '%d ', find(mat(row, :)));
           fprintf(output, '\n');
    end
end