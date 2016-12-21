files = dir('hard/*.txt');
numfiles = numel(files);

parfor k=1:numfiles
    file_obj = files(k);
    filename = strcat('hard/', file_obj.name);
    file = fopen(filename);
    
    
    curr_edge_num = 1;
    curr_line_num = 1;
    
    %first line is 'nodes edges'

    first_line = str2num(fgetl(file));
    vnum = first_line(1);
    enum = first_line(2);
 
    mat = sparse(enum, vnum);
    
    while ~feof(file)
        tl = fgetl(file);
        tlarr = str2num(tl);
        [row1,col1] = find(mat(:,curr_line_num));
        for i=1:numel(tlarr)
            
            % check if edge already exists
            [row2,col2] = find(mat(:,tlarr(i)));
            comm_rows = intersect(row1, row2);
            if numel(comm_rows) > 0
                continue
            end
            
            % if not, create
            mat(curr_edge_num, curr_line_num) = 1;
            mat(curr_edge_num, tlarr(i)) = 1;
            curr_edge_num = curr_edge_num + 1;
        end
        curr_line_num = curr_line_num + 1;
    end
    
    outputname = strcat('hard_converted/zoltan_', file_obj.name);
    output = fopen(outputname,'w+');
    
    [rows, columns] = size(mat);
    fprintf(output, '%%MatrixMarket matrix coordinate real general');
    fprintf(output, '%d %d %d\n', rows, columns, nnz(mat));
    [row,col,val] = find(mat);
    for i=1:numel(val)
       fprintf(output, '%d %d %f', row(i), col(i), val(i));
       fprintf(output, '\n');
    end
    fclose(output);
end
