function total = csvExtract(fileName)

    times = [];
    notes = [];
    velocity = [];
    tempoTimes = [];
    tempoTrigger = [];

    fh = fopen([fileName '.csv'], 'r');
    line = fgetl(fh);

    while(~isequal(line, -1))
        [trackNum,rest] = strtok(line, ',');
        if(str2num(trackNum) == 0)
            [~,rest] = strtok(rest,',');     % get rid of extra 0
            [checkHead, rest] = strtok(rest,','); % get the header comment
            if(isequal(checkHead, ' Header'))
                [~,rest] = strtok(rest,',');
                [~,rest] = strtok(rest,',');
                [division,~] = strtok(rest,',');
                division = str2double(division);    % will use later to ajust timing
            end
        elseif(str2num(trackNum) == 1)
            
            [time,rest] = strtok(rest,',');     % get the time of the event
            [command, rest] = strtok(rest,','); % get the command message (called meta events or channel events)
            [strTemp, rest] = strtok(rest,',');    % get the note
            if(isequal(command, ' Tempo'))
                tempo = str2double(strTemp);
                tempoTimes = [tempoTimes, tempo];
                tempoTime = str2double(time);
                tempoTrigger = [tempoTrigger, tempoTime];
            end
            
        else
            [time,rest] = strtok(rest,',');     % get the time of the event
            [command, rest] = strtok(rest,','); % get the command message (called meta events or channel events)
            [~, rest] = strtok(rest,',');       % get rid of unneeded channel
            [note, rest] = strtok(rest,',');    % get the note
            [vel, rest] = strtok(rest,',');     % get the note velocity (volume?)

            if(isequal(command,' Note_on_c'))
                times = [times, str2double(time)]; 
                notes = [notes, str2double(note)];
                velocity = [velocity, str2double(vel)];
            elseif(isequal(command,' Note_off_c'))
                times = [times, str2double(time)]; 
                notes = [notes, str2double(note)];
                velocity = [velocity, 0];
            end
        end
        line = fgetl(fh);
    end

    fclose(fh);

    % sort the events by time so its all on one track
    [times, idx]= sort(times);
    notes = notes(idx);
    velocity = velocity(idx);

    % get the 
    tempoIdx = [];
    for ii = 1:length(tempoTrigger)
        [~,idx] = min(abs(tempoTrigger(ii)-times));
        tempoIdx = [tempoIdx idx];
        tempoTrigger(ii) = times(idx);
    end

        
    % adjust the timing on the notes so that it best matches 
    % a Tempo of 750000 and note division of 120
    for idx = 1:length(tempoTimes)
        ratio = tempoTimes(idx)/750000*120/division; 
        startSpot = tempoIdx(idx);
        
        if(idx == length(tempoTimes))
            stopSpot = length(times);
        else
            stopSpot = tempoIdx(idx+1);
        end
        
        startTime = times(startSpot);
        endTime = times(stopSpot);        

        for jj = startSpot+1:stopSpot      
           times(jj) = (times(jj) - startTime)*ratio + startTime; 
        end
        
        delta = times(stopSpot) - endTime; 
        for jj = stopSpot+1:length(times)
            times(jj) = times(jj) + delta;
        end
    end
    
    times = round(times);
    
    total = [times' notes' velocity']; %package it all together
end
  