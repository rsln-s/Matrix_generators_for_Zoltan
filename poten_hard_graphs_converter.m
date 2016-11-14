%converts .graph format: n_vertices n_edges, [list of neighbours for node #line_number]
files = dir('hard/*.txt');
numfiles = numel(files);
parfor k=1:numfiles
    file_obj = files(k);
    filename = strcat('hard/', file_obj.name);
    file = fopen(filename);
    
    curr_node_num = 0;
    curr_edge_num = 1;
    
    %first line is 'nodes edges'

    first_line = str2num(fgetl(file));
    vnum = first_line(1);
    enum = first_line(2);
 
    mat = sparse(enum, vnum);
    
    while ~feof(file)
        tl = fgetl(file);
        curr_node_num = curr_node_num + 1;
        tlarr = str2num(tl);
        if numel(tlarr) == 0
            continue
        end
        [row1,col1] = find(mat(:,curr_node_num));
        for i=1:numel(tlarr)
            
            % check if edge already exists
            [row2,col2] = find(mat(:,tlarr(i)));
            comm_rows = intersect(row1, row2);
            if numel(comm_rows) > 0
                continue
            end
            
            % if not, create
            mat(curr_edge_num, curr_node_num) = 1;
            mat(curr_edge_num, tlarr(i)) = 1;
            curr_edge_num = curr_edge_num + 1;
        end
    end
    
    outputname = strcat('hard_converted/zoltan_', file_obj.name);
    output = fopen(outputname,'w+');
    
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
end
