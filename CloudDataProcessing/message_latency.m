inputFiles = dir('*.txt');
numfiles = length(inputFiles);
delim = ',';

for i=1:numfiles
    eval(['msgLatData' num2str(i) ' = importdata(inputFiles(i).name)']);
end

for i = 1:numfiles
    dataSize = eval(['size(msgLatData', num2str(i), '.data, 1)']);
    try
        msglatencystat(1,i) = eval(['median(msgLatData', num2str(i), '.data(1:dataSize,2))']);
        msglatencystat(2,i) = eval(['mean(msgLatData' num2str(i) '.data(1:dataSize,2))']);
        msglatencystat(3,i) = eval(['std(msgLatData' num2str(i) '.data(1:dataSize,2))']);
        msglatencystat(4,i) = eval(['mad(msgLatData' num2str(i) '.data(1:dataSize,2))']);
        msglatencystat(5,i) = eval(['max(msgLatData' num2str(i) '.data(1:dataSize,2))']);
        eval(['msglatency' num2str(i) ' = msgLatData' num2str(i) '.data(1:dataSize,2)']);
    catch err
        disp(['Can not load msglatency', num2str(i)]);
    end
    clear dataSize
end

if 1
extraDataPerImage = 2;
leg = cell(3, 1);
leg(:) = {'test'}; 
    
hFig = figure(1);set(hFig, 'Position', [100 100 1032 444]);
j = 1;

while j <= (numfiles)
    for k = 0:extraDataPerImage
         if ((j+k) <= numfiles)
            eval(['plot(msglatency' num2str(j+k) ')']);hold all;
            legVal = sprintf('Message Latency %d Users', (j+labelOffset+k));
            leg(k+1) = {legVal};
         end
    end 
    hold off;figure(gcf);
    legend(leg(1:(extraDataPerImage+1)));xlabel('Time (30s)');ylabel('Latency (ms)');
    outfile = sprintf('%s/msglatency-%d', outDir, j);
    % print(hFig,'-dpng',outfile);
    screen2jpeg(outfile);
    j = j + 2;
%     plot(time,'latency' num2str(j) ')';hold all;plot(time,latency1);plot(time,latency2);hold off;figure(gcf);legend('Latency 5 Users','Latency 10 Users','Latency 15 Users');xlabel('time (s)');ylabel('latency (ms)');
end
end