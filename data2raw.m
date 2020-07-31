function data2raw(total, fileName, append)

    times = total(:,1);
    notes = total(:,2);
    velocity = total(:,3);

    keys = zeros(1,88);

    if(append)
        writeType = 'at';
    else
        writeType = 'wt';
    end
    
    fh = fopen(fileName, writeType);

    for idx = 1:max(times)

       spots = find(times == idx);
       for jj = 1:length(spots)
            if(velocity(spots(jj)))
                keys(notes(spots(jj)) -17) = 1;
            else
                keys(notes(spots(jj)) - 17) = 0;
            end
       end

       for kk = 1:length(keys)
           if(keys(kk)) 
               if(kk+35 == 92)
                    fprintf(fh, char(35));
               else
                    fprintf(fh, char(kk+35));
               end
           end
       end

       fprintf(fh, ' ');
    end

    fclose(fh);

end