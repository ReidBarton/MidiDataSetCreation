%% MASTER SCRIPT
clear; clc;

NUMSONGS = 1;           % how many songs should we use
GENERATECSV = true;    % do we need to generate .csv files first (true if we do)
CSVCLEAN = true;       % will generate a csv with all midi channels compressed and standardized timing
APPEND = true;

%%

for ii = 1:NUMSONGS
    fprintf('Processing song %d ... \n', ii);
    filebase = ['songs/song(' num2str(ii) ')']; % what the files are going to be called
    
    % generate the csv files from the midi file for processing
    if(GENERATECSV)
        midi2csv(filebase);
    end

    songData = csvExtract(filebase); % extract the relavent song data from the csv file
    
    if(CSVCLEAN) 
        data2csv(songData, [filebase '_clean']);
    end
    
    data2raw(songData,'songs/input.txt', APPEND); % append data to text file for rnn
    
end
%%
fprintf('Compressing File ... \n');
compressRaw('songs/input.txt');
%% 
fprintf('Deompressing File ... \n');
decompressRaw('output_from_RNN.txt');
fprintf('Converting to Midi ... \n');
songData = raw2data('output_from_RNN.txt'); 
data2csv(songData, 'output_from_RNN');
csv2midi('output_from_RNN');







