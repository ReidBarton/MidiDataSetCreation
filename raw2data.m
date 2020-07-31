function total = raw2data(fileName)    

    times = [];
    notes = [];
    velocity = [];

    text = fileread(fileName);
    str = regexprep(text,' ','\n');
    fh = fopen(fileName, 'wt');
    fprintf(fh,str);
    fclose(fh);
    
    fh = fopen(fileName, 'r');
    line = fgetl(fh);
    newline = fgetl(fh);

    count = 0;
  
    while(~isequal(newline,-1))
       % see if a note was added  
       for idx = 1:length(newline)
            if(~any(newline(idx) == line))
                key = double(newline(idx));
                if(key == 35)
                    velocity = [velocity 100];
                    notes = [notes 74];
                else
                    velocity = [velocity 100];
                    notes = [notes key-18];
                end
                times = [times count];
            end
       end
       
       % see if a note was removed
       for idx = 1:length(line)
            if(~any(line(idx) == newline))
                key = double(line(idx));
                if(key == 35)
                    velocity = [velocity 0];
                    notes = [notes 74];
                else
                    velocity = [velocity 0];
                    notes = [notes key-18];
                end
                times = [times count];

            end
       end

        line = newline;
        newline = fgetl(fh);
        count = count+1;
    end

    total = [times' notes' velocity'];

    fclose(fh);
    
    text = fileread(fileName);
    str = regexprep(text,'\n',' ');
    fh = fopen(fileName, 'wt');
    fprintf(fh,str);
    fclose(fh);
    

end