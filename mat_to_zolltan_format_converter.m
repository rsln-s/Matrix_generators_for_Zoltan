files = dir('matrices/*.mat');
numfiles = numel(files);
for k=1:numfiles
    file = files(k);
    fprintf('began computing for file %s\n', file.name);
    filename = strcat('matrices/', file.name);
    data = load(filename);
    mat = data.Problem.A;
    outputname = strcat('bmi_osu_edu/zoltan_', file.name, '.txt');
    output = fopen(outputname,'w+');
    mat( ~any(mat,2), : ) = [];  %rows
    mat(:, ~any(mat,1)) = []; %remove all empty columns
    [rows, columns] = size(mat);
    fprintf(output, '##Number of vertices\n%d\n\n', columns);
    fprintf(output, '##list vertices\n');
    for i = 1:columns
        fprintf(output,'%d\n', i);
    end
    fprintf(output,'\n');
    fprintf(output, '##number of hyperedges\n%d\n\n', rows);
    fprintf(output, '##number of nonzero els\n\n%d\n\n', nnz(mat));
    fprintf(output, '##hyperedge adj\n\n');
    for row = 1:rows
       fprintf(output, '%d ', row);
       fprintf(output, '%d ', nnz(mat(row,:)));
       fprintf(output, '%d ', find(mat(row, :)));
       fprintf(output, '\n');
    end
    fprintf('finished computing for file %s\n', file.name);
end

