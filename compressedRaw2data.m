function total = compressedRaw2data(fileName)    

    times = [];
    notes = [];
    velocity = [];
    
    
        
    test1 = fileread(fileName);
    str = regexprep(test1,' ','\n');
    fh = fopen(fileName, 'wt');
    fprintf(fh,str);
    fclose(fh);
    
    fh = fopen(fileName, 'r');
    newline = fgetl(fh);

    count = 0;

  
    while(~isequal(newline,-1))
        keys = [];

        for idx = 1:length(newline)
            if(isequal(newline(idx),'|')
                break
            end
            key = double(newline(idx));
            keys = [keys key];
        end
        
        
                
                            if(key == 35)
                    notes = [notes 74]
                else
                    notes = [notes key-18]
                end
                velocity = [velocity 100]
                times = [times count];
                idx = idx+1;
            
            count = count + str2double(newline(idx+1)); 
        end
                    
        newline = fgetl(fh);
        count = count+1;
    end

    total = [times' notes' velocity'];

    fclose(fh);

end