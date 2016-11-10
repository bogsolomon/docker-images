antIndices = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
perfIndices = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
controlIndices = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
antLocIndices = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
inputFiles = dir('*.csv');
numfiles = length(inputFiles);
idx = 1;
perfIdx = 1;
ctrlIdx = 1;
antLocIdx = 1;

for i=1:numfiles
    k = strfind(inputFiles(i).name, 'red5');
    y = strfind(inputFiles(i).name, 'perf');
    z = strfind(inputFiles(i).name, 'control');
    if (strncmp(inputFiles(i).name, 'server', 6))
        if (isempty(k))
            if (isempty(y))
                if (isempty(z))
                    eval(['server' num2str(i) ' = importdata(inputFiles(i).name)']);
                else
                    eval(['serverControl' num2str(i) ' = importdata(inputFiles(i).name)']);
                    controlIndices(ctrlIdx) = i;
                    ctrlIdx = ctrlIdx + 1;
                end
            else
                eval(['serverPerf' num2str(i) ' = importdata(inputFiles(i).name)']);
                perfIndices(perfIdx) = i;
                perfIdx = perfIdx + 1;
            end
        else
            eval(['serverAnt' num2str(i) ' = importdata(inputFiles(i).name)']);
            antIndices(idx) = i;
            idx = idx + 1;
        end
    else
        eval(['ant' num2str(i) ' = importdata(inputFiles(i).name)']);
        antLocIndices(antLocIdx) = i;
        antLocIdx = antLocIdx + 1;
    end
end