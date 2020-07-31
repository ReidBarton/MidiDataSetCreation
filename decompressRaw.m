function decompressRaw(fileName)    


    test1 = fileread(fileName);
    str = regexprep(test1,' ','\n');
    fh = fopen(fileName, 'wt');
    fprintf(fh,str);
    fclose(fh);

    fh = fopen(fileName, 'r');
%     fh2 = fopen([fileName(1:end-4) '_temp.txt'], 'wt');
    newline = fgetl(fh);

    count = 0;
    mega = [];
  
    while(~isequal(newline,-1))
       barloc = find(newline == 'z'); 
       numtimes = str2double(newline(barloc+1:end));
       for idx = 1:numtimes
%            fprintf(fh2,[newline(1:barloc-1) ' ']);
            mega = [mega newline(1:barloc-1) ' '];
       end
       newline = fgetl(fh);
    end

    fclose(fh);
%     fclose(fh2);
    fh = fopen(fileName, 'wt');
    fprintf(fh,mega);
    fclose(fh);
    

end