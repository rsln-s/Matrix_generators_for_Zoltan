files = {'QLi/largebasis', 'Mittelmann/cont11_l', 'Springer/ESOC', 'JGD_GL7d/GL7d15', 'Chen/pkustk13', 'DIMACS10/auto', 'Bates/sls', 'Mittelmann/cont1_l', 'vanHeukelum/cage13', 'Chen/pkustk12', 'Rucci/Rucci1', 'Meszaros/degme', 'JGD_GL7d/GL7d16', 'JGD_GL7d/GL7d21', 'JGD_Relat/rel9', 'JGD_Relat/relat9'};
numfiles = numel(files);

% UFL1
% {'QLi/largebasis', 'Mittelmann/cont11_l', 'Springer/ESOC', 'JGD_GL7d/GL7d15', 'Chen/pkustk13', 'DIMACS10/auto', 'Bates/sls', 'Mittelmann/cont1_l', 'vanHeukelum/cage13', 'Chen/pkustk12', 'Rucci/Rucci1', 'Meszaros/degme', 'JGD_GL7d/GL7d16', 'JGD_GL7d/GL7d21', 'JGD_Relat/rel9', 'JGD_Relat/relat9'};

parfor k=1:numfiles
    f = files{k};
    struct = UFget(f);
    mat = struct.A;

    fname = strsplit(f, '/');
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