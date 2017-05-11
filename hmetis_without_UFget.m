files = dir('hmetis_raw/*.mat');
numfiles = numel(files);

parfor k=1:numfiles
    file_obj = files(k);
    struct = load(strcat(file_obj.folder,'/', file_obj.name));

    mat = struct.Problem.A;

    outname = strcat('hmetis_converted/', file_obj.name, '.hmetis');
    output = fopen(outname,'w+');
    [rows, columns] = size(mat);

    %number of hyperedges, vertices 
    fprintf(output, '%d %d\n', rows, columns);
    for row = 1:rows
           fprintf(output, '%d ', find(mat(row, :)));
           fprintf(output, '\n');
    end
end