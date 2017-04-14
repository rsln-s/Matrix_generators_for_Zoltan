function n = num_lines(filename)
    command = ['wc -l ' filename];
    [~,cmdout] = system(command);
    out_l = strsplit(cmdout);
    n = str2double(out_l(1));
end