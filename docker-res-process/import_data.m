inputFiles = dir('*.txt');
numfiles = length(inputFiles);
delim = ',';

for i=1:numfiles
    eval(['data' num2str(i) ' = importdata(inputFiles(i).name)']);
end