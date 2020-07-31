function compressRaw(fileName)    

    text = fileread(fileName);
    str = regexprep(text,' ','\n');
    fh = fopen(fileName, 'wt');
    fprintf(fh,str);
    fclose(fh);
    
    fh = fopen(fileName, 'r');
%     fh2 = fopen([fileName(1:end-4) '_comp.txt'], 'wt');
    line = fgetl(fh);
    newline = fgetl(fh);
   
    count = 1;
    mega = [];
  
    while(~isequal(newline,-1))
       % see if a note was added  
       if(isequal(newline,line))
           count = count+1;
       else
%            add = [];
%            for j = 1:length(newline)
%                if(isempty(strfind(line,newline(j))))
%                    add = [add newline(j)];
%                end
%            end
%            del = [];
%            for j = 1:length(line)
%                if(isempty(strfind(newline,line(j))))
%                    del = [del line(j)];
%                end
%            end
%   this was an experiment to see if only printing letters add/subtra
%   would reduce the file size, but I had to add a deliniator (+) to tell
%  what was added and what was subtracted...it compressed 12.9 kb to
%  12.8 kb...not worth
           
           
%            mega = [mega del '+' add 'z' num2str(count) ' '];
          mega = [mega line 'z' num2str(count) ' '];

%            fprintf(fh2,);
%            fprintf(fh2,');
%            fprintf(fh2, );
%            fprintf(fh2,' ');
           count = 1;
       end
       
        line = newline;
        newline = fgetl(fh);
    end

    fclose(fh);
    fh = fopen(fileName, 'wt');
    fprintf(fh,mega);
    fclose(fh);

end