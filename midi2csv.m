function midi2csv(filebase)
        
    songCSV = [filebase '.csv'];
    songMidi = [filebase '.mid'];

    cmd = ['Midicsv.exe ' songMidi ' ' songCSV];
    system(cmd);
end