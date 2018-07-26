function out = runs(mouse, date, server)
%SBXRUNS List all runs in a folder

    % If date is an integer, convert to string
    if ~ischar(date), date = num2str(date); end
    if nargin < 3, server = []; end
    
    % Initialize the base directory and scan directory
    % Get the base directory from sbxDir.
    
    searchdir = pipe.lab.datedir(mouse, date, server);
    if isempty(searchdir), disp('ERROR: Directory not found'); return; end
    matchstr = sprintf('%s_%s_run', date, mouse);
    out = [];
    
    % Search for all directory titles that match a run
    fs = dir(searchdir);
    for i=1:length(fs)
        if fs(i).isdir
            if length(fs(i).name) > length(matchstr)
                if strcmp(fs(i).name(1:length(matchstr)), matchstr)
                    runnum = [];
                    j = length(matchstr) + 1;
                    while j <= length(fs(i).name) && isstrprop(fs(i).name(j), 'digit')
                        runnum = [runnum fs(i).name(j)];
                        j = j + 1;
                    end
                    out = [out str2num(runnum)];
                end
            end
        end
    end
    out = sort(out);
end

