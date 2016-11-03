antIndices = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
inputFiles = dir('*.csv');
numfiles = length(inputFiles);
idx = 1

for i=1:numfiles
    k = strfind(inputFiles(i).name, 'red5');
    if (strncmp(inputFiles(i).name, 'server', 6))
        if (isempty(k))
            eval(['server' num2str(i) ' = importdata(inputFiles(i).name)']);
        else
            eval(['serverAnt' num2str(i) ' = importdata(inputFiles(i).name)']);
            antIndices(idx) = i;
            idx = idx + 1;
        end
    else
        eval(['ant' num2str(i) ' = importdata(inputFiles(i).name)']);
    end
end