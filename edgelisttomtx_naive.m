% interprets the edgelist as sparse matrix, then interprets it in row-net
% fashion. This script is the next one for the gen_similar.py

files = dir('communities/*.edgelist');
numfiles = numel(files);

parfor k=1:numfiles
    file_obj = files(k);
    inp_filename = strcat('communities/', file_obj.name);
    n_links = num_lines(inp_filename)
    file = fopen(inp_filename);

    row = zeros(1, 2*n_links);
    col = zeros(1, 2*n_links);
    curr_ind = 1;
    while ~feof(file)
        tl = fgetl(file);
        tlarr = str2num(tl);
        if numel(tlarr) ~= 2
            'ERROR'
            continue
        end
        row(curr_ind) = tlarr(2);
        col(curr_ind) = tlarr(1);
        row(curr_ind+1) = tlarr(1);
        col(curr_ind+1) = tlarr(2);
        curr_ind = curr_ind+2;
    end       
    val = ones(1, numel(col));

    mat = sparse(row, col, val);
    
    outputname = strcat('communities_converted/', file_obj.name, '.mtx');
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
end