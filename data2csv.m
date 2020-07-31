function data2csv(total, fileName) 

    fh = fopen([fileName '.csv'], 'wt');

    fprintf(fh, '0, 0, Header, 1, 2, 120');
    fprintf(fh, '\n');
    fprintf(fh, '1, 0, Start_track');
    fprintf(fh, '\n');
    fprintf(fh, '1, 0, Tempo, 750000');
    fprintf(fh, '\n');
    fprintf(fh, '1, 0, End_track');
    fprintf(fh, '\n');
    fprintf(fh, '2, 0, Start_track');
    fprintf(fh, '\n');

    [r,~] = size(total);
    for idx = 1:r
        if(total(idx,3)~=0)
            fprintf(fh, '2, %.0f, Note_on_c, 0, %d, %d', total(idx,1) , total(idx,2), 100); %total(idx,3)
        else
            fprintf(fh, '2, %.0f, Note_on_c, 0, %d, %d', total(idx,1) , total(idx,2), 0);
        end
        fprintf(fh, '\n');
    end

    endSong = total(end,1);
    fprintf(fh, '2, %0.f, End_track', endSong);
    fprintf(fh, '\n');
    fprintf(fh, '0, 0, End_of_file');

    fclose(fh);

end