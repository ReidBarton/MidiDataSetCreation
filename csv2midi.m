function csv2midi(filebase)

    songCSV = [filebase '.csv'];
    songMidi = [filebase '.mid'];
    
    cmd = ['Csvmidi.exe ' songCSV ' ' songMidi];
    system(cmd);
end
 